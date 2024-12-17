<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;
use App\Entity\Feedback;
use App\Entity\User;
use App\Entity\Node;
use App\Entity\Order;
use App\Entity\Check;
use App\Entity\Refund;
use App\Entity\Fav;
use App\Entity\Like;
use App\Entity\Up;
use App\Entity\Down;
use App\Entity\Rate;
use App\Entity\Plan;
use App\Entity\Step;
use App\Entity\Category;
use App\Entity\Region;
use App\Entity\Area;
use App\Entity\Image;
use App\Entity\Comment;
use App\Service\WxPay;
use App\Service\Wx;

#[Route('/api')]
class ApiController extends AbstractController
{
    private $data;

    public function __construct(Data $data)
    {
        $this->data = $data;
    }

    #[Route('/media_objects', methods: ['POST'])]
    public function upload(Request $request): Response
    {
        $uid = $request->request->get('uid');
        $file = $request->files->get('upload');
        $newName = uniqid() . '-' .  $file->getClientOriginalName();
        // copy($file->getPathname(), 'images/' . $newName);
        $file->move('images/', $newName);
        if ($uid !== null) {
            $em = $this->data->getEntityManager();
            $user = $em->getRepository(User::class)->find($uid);
            $user->setAvatar($newName);
            $em->flush();
        }

        return $this->json(['url' => '/images/' . $newName]);
    }
    
    #[Route('/nodes/{id}', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function getNode(int $id): Response
    {
        $node = $this->data->getNode($id);
        $data = $this->data->formatNode($node);

        return $this->json($data);
    }

    #[Route('/users/{id}', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function _getUser(int $id): Response
    {
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($id);
        $data = [
            'id' => $user->getId(),
            'name' => $user->getName(),
            'phone' => $user->getPhone(),
            'avatar' => $user->getAvatar(),
            'roles' => $user->getRoles(),
            'favCount' => count($user->getFavs()),
            'youCount' => count($user->getNodes()),
            'planCount' => count($user->getPlans()),
        ];
        return $this->json($data);
    }

    #[Route('/users/{id}', requirements: ['id' => '\d+'], methods: ['PATCH'])]
    public function _updateUser(int $id, Request $request): Response
    {
        $arr = $request->toArray();
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($id);
        
        foreach($arr as $k => $v) {
            $setter = 'set' . ucwords($k);
            $user->$setter($v);
        }
        $em->flush();
        
        $data = [
            'id' => $user->getId(),
            'name' => $user->getName(),
            'phone' => $user->getPhone(),
            'avatar' => $user->getAvatar(),
        ];
        return $this->json($data);
    }

    #[Route('/nodes/{regionLabel}', methods: ['GET'])]
    public function getNodesByRegion(string $regionLabel, Request $request): Response
    {
        // $nodes = $this->data->findNodesByRegionLabel($regionLabel, null);
        $order = $request->query->get('order');
        $cate = $request->query->get('cate');
        $area = $request->query->get('area');
        $criteria = [];

        if (null !== $cate) {
            $criteria['category'] = $cate;
        }
        if (null !== $area) {
            $criteria['area'] = $area;
        }

        $nodes = $this->data->findByRegionLabelAndCriteria($regionLabel, $criteria, null, null, null, $order);
        $region = $this->data->getRegionByLabel($regionLabel);

        $i = 0;
        $data['region'] = $region->getName();
        $data['nodes'] = [];
        foreach ($nodes as $n) {
            $data['nodes'][$i] = $this->data->formatNode($n);
            $i++;
        }

        return $this->json($data);
    }

    #[Route('/feedback', methods: ['GET'])]
    public function getUserFeedback(Request $request): Response
    {
        $uid = $request->query->get('uid');
        $em = $this->data->getEntityManager();
        // $user = $em->getRepository(User::class)->find($uid);

        $criteria = [];
        if (null !== $uid) {
            $criteria = ['u' => $uid];
        }
        
        $data = [];
        $feedback = $em->getRepository(Feedback::class)->findBy($criteria, ['id' => 'DESC']);
        foreach($feedback as $i){
            array_push($data, $this->data->formatFeedback($i));
        }

        return $this->json($data);
    }

    #[Route('/feedback', methods: ['POST'])]
    public function feedback(Request $request): Response
    {
        $params = $request->toArray();

        $uid = isset($params['uid']) ? $params['uid'] : null;
        $title = isset($params['title']) ? $params['title'] : null;
        $body = $params['body'];

        $em = $this->data->getEntityManager();

        $f = new Feedback();
        if (null !== $title) {
            $f->setTitle($title);
        }
        if (null !== $uid) {
            $user = $em->getRepository(User::class)->find($uid);
            if (null !== $user){
                $f->setU($user);
            }
        }
        $f->setBody($body);
        $em->persist($f);
        $em->flush();

        $data = [
            'code' => 0,
            'msg' => 'ok',
        ];

        return $this->json($data);
    }

    #[Route('/fav', methods: ['GET'])]
    public function getUserFav(Request $request): Response
    {
        // $regionLabel = $request->query->get('region');
        $uid = $request->query->get('uid');

        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $favs = $user->getFavs();
        // $region = $this->data->getRegionByLabel($regionLabel);

        $i = 0;
        // $data['region'] = $region->getName();
        $data['nodes'] = [];
        foreach ($favs as $f) {
            // if ($f->getNode()->getRegions()->contains($region)) {
                $data['nodes'][$i]['title'] = $f->getNode()->getTitle();
                $data['nodes'][$i]['summary'] = $f->getNode()->getSummary();
                $data['nodes'][$i]['image'] = $f->getNode()->getImage();
                $data['nodes'][$i]['id'] = $f->getNode()->getId();
                $i++;
            // }
        }

        return $this->json($data);
    }

    #[Route('/wx/home', methods: ['GET'])]
    public function wxHome(): Response
    {
        $list = ['jing', 'zhu', 'shi', 'dong', 'wen', 'yi', 'gou', 'wan'];

        foreach ($list as $l) {
            $nodes = $this->data->findNodesByRegionLabel($l, null, 5);
            $i = 0;
            $a = [];
            foreach ($nodes as $n) {
                $a[$i] = $this->data->formatNode($n);
                $i++;
            }
            $data[$l] = $a;
        }

        return $this->json($data);
    }

    #[Route('/wx/wan', methods: ['GET'])]
    public function wxWan(): Response
    {
        $list = ['wan', 'youji', 'lu'];

        foreach ($list as $l) {
            $nodes = $this->data->findNodesByRegionLabel($l, null, 5);
            $i = 0;
            $a = [];
            foreach ($nodes as $n) {
                $a[$i] = $this->data->formatNode($n);
                $i++;
            }
            $data[$l] = $a;
        }

        return $this->json($data);
    }

    #[Route('/wx/explore', methods: ['GET'])]
    public function wxPageExplore(): Response
    {
        $conf = $this->data->findConfByLocale(null);
        $list = ['jing', 'zhu', 'shi', 'gou'];

        foreach ($list as $l) {
            $nodes = $this->data->findNodesByRegionLabel($l, null, 5);
            $i = 0;
            $a = [];
            foreach ($nodes as $n) {
                $tags = [];
                foreach ($n->getTags() as $t) {
                    array_push($tags, $t->getName());
                }

                // mv important_tags to first
                $important_tags = ['民宿', '农家乐'];
                foreach ($important_tags as $it) {
                    $index = array_search($it, $tags);
                    if ($index !== false) {
                        unset($tags[$index]);
                        array_unshift($tags, $it);
                    }
                }

                $a[$i]['title'] = $n->getTitle();
                $a[$i]['summary'] = $n->getSummary();
                $a[$i]['image'] = $n->getImage();
                $a[$i]['id'] = $n->getId();
                $a[$i]['phone'] = $n->getPhone() ? $n->getPhone() : $conf->getPhone();
                $a[$i]['tags'] = $tags;
                $i++;
            }
            $data[$l] = $a;
        }

        return $this->json($data);
    }

    #[Route(path: '/wx/getphone', name: 'api_wx_getphone', methods: ['POST'])]
    public function wxLogin(Request $request)
    {
        $data = json_decode($request->getContent());
        $code = $data->code;
        $resp = $this->wx->getPhoneNumber($code);
        return $this->json($resp);
    }

    #[Route('/isfav', methods: ['GET'])]
    public function getIsFav(Request $request): Response
    {
        $nid = $request->query->get('nid');
        $uid = $request->query->get('uid');

        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $this->data->getNode($nid);

        $fav = $em->getRepository(Fav::class)->findOneBy(['u' => $user, 'node' => $node]);
        $isFav = false;
        if (null !== $fav) {
            $isFav = true;
        }

        return $this->json(['isFav' => $isFav]);
    }

    #[Route('/fav/add', methods: ['POST'])]
    public function addFav(Request $request): Response
    {
        $data = $request->toArray();
        $nid = $data['nid'];
        $uid = $data['uid'];

        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $this->data->getNode($nid);
        $fav = $em->getRepository(Fav::class)->findOneBy(['u' => $user, 'node' => $node]);
        if (null === $fav) {
            $fav = new Fav();
            $fav->setU($user);
            $fav->setNode($node);

            $em->persist($fav);

            $em->flush();
        }

        return $this->json(['isFav' => true]);
    }

    #[Route('/fav/remove', methods: ['POST'])]
    public function removeFav(Request $request): Response
    {
        $data = $request->toArray();
        $nid = $data['nid'];
        $uid = $data['uid'];

        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $this->data->getNode($nid);
        $fav = $em->getRepository(Fav::class)->findOneBy(['u' => $user, 'node' => $node]);
        if (null !== $fav) {
            $em->remove($fav);
            $em->flush();
        }

        $favs = $user->getFavs();

        $i = 0;
        $data['isFav'] = false;
        $data['nodes'] = [];
        foreach ($favs as $f) {
            $data['nodes'][$i]['title'] = $f->getNode()->getTitle();
            $data['nodes'][$i]['summary'] = $f->getNode()->getSummary();
            $data['nodes'][$i]['image'] = $f->getNode()->getImage();
            $data['nodes'][$i]['id'] = $f->getNode()->getId();
            $i++;
        }


        return $this->json($data);
    }

    #[Route('/fav/toggle', methods: ['POST'])]
    public function toggleFav(Request $request): Response
    {
        $data = $request->toArray();
        $nid = $data['nid'];
        $uid = $data['uid'];

        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $this->data->getNode($nid);
        $fav = $em->getRepository(Fav::class)->findOneBy(['u' => $user, 'node' => $node]);

        if (null === $fav) {
            $fav = new Fav();
            $fav->setU($user);
            $fav->setNode($node);

            $em->persist($fav);
            $isFav = true;
        } else {
            $em->remove($fav);
            $isFav = false;
        }

        $em->flush();

        return $this->json(['isFav' => $isFav, 'node' => $this->data->formatNode($node)]);
    }

    #[Route('/map/markers', methods: ['GET'])]
    public function getMapMarkers(): Response
    {
        $em = $this->data->getEntityManager();
        $nodes = $em->getRepository(Node::class)->findHaveLatLong();
        $data = [];
        foreach($nodes as $n) {
            array_push($data, $this->data->formatNode($n));
        }

        return $this->json($data);
    }

    #[Route('/wx/feedback', methods: ['GET'])]
    public function getWxFeedback(): Response
    {
        $nodes = $this->data->findNodesByRegionLabel('feedback', null);
        $node = $this->data->formatNode($nodes[0]);

        return $this->json($node);
    }

    #[Route('/search', methods: ['GET'])]
    public function search(Request $request): Response
    {
        $q = $request->query->get('q');

        $em = $this->data->getEntityManager();
        $nodes = $em->getRepository(Node::class)->findByKeyword($q);

        $data['nodes'] = [];
        $i = 0;
        foreach ($nodes as $n) {
            $data['nodes'][$i]['title'] = $n->getTitle();
            $data['nodes'][$i]['summary'] = $n->getSummary();
            $data['nodes'][$i]['address'] = $n->getAddress();
            $data['nodes'][$i]['image'] = $n->getImage();
            $data['nodes'][$i]['id'] = $n->getId();
            $data['nodes'][$i]['latitude'] = $n->getLatitude();
            $data['nodes'][$i]['longitude'] = $n->getLongitude();

            if (!empty($n->getRegions())) {
                $data['nodes'][$i]['region'] = [
                    'id' => $n->getRegions()[0]->getId(),
                    'name' => $n->getRegions()[0]->getName(),
                    'label' => $n->getRegions()[0]->getLabel(),
                ];
            }
            $i++;
        }
        
        return $this->json($data);
    }

    #[Route('/comments/{nid}', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function getNodeComments(int $nid): Response
    {
        $em = $this->data->getEntityManager();
        $node = $em->getRepository(Node::class)->find($nid);
        $comments = $this->data->getNodeComments($node);

        return $this->json($comments);
    }

    #[Route('/comments', methods: ['POST'])]
    public function newComments(Request $request): Response
    {
        $params = $request->toArray();
        $uid = $params['uid'];
        $nid = $params['nid'];
        $body = $params['body'];
        
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $em->getRepository(Node::class)->find($nid);

        $c = new Comment();
        $c->setBody($body);
        $c->setAuthor($user);
        $c->setNode($node);
        $em->persist($c);
        $em->flush();

        $data = [
            'code' => 0,
            'msg' => 'ok',
            'comments' => $this->data->getNodeComments($node),
        ];


        return $this->json($data);
    }

    #[Route('/like', methods: ['POST'])]
    public function like(Request $request): Response
    {
        $params = $request->toArray();
        $uid = $params['uid'];
        $nid = $params['nid'];
        
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $em->getRepository(Node::class)->find($nid);
        $like = $em->getRepository(Like::class)->findOneBy(['u' => $user, 'node' => $node]);

        if (null === $like) {
            $l = new Like();
            $l->setU($user);
            $l->setNode($node);
            $em->persist($l);
            $em->flush();
        }

        $data = [
            'code' => 0,
            'msg' => 'ok',
            'liked' => true,
            'count' => count($node->getLikes()),
        ];

        return $this->json($data);
    }

    #[Route('/up', methods: ['POST'])]
    public function up(Request $request): Response
    {
        $params = $request->toArray();
        $uid = $params['uid'];
        // $nid = $params['nid'];
        $cid = $params['cid'];
        
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        // $node = $em->getRepository(Node::class)->find($nid);
        $comment = $em->getRepository(Comment::class)->find($cid);
        $up = $em->getRepository(Up::class)->findOneBy(['u' => $user, 'comment' => $comment]);

        if (null === $up) {
            $u = new Up();
            $u->setU($user);
            $u->setComment($comment);
            $em->persist($u);
            $em->flush();
        }

        $data = [
            'code' => 0,
            'msg' => 'ok',
            'upped' => true,
            'count' => count($comment->getUps()),
            'comments' => $this->data->getNodeComments($comment->getNode()),
        ];

        return $this->json($data);
    }

    #[Route('/rates', methods: ['POST'])]
    public function rate(Request $request): Response
    {
        $params = $request->toArray();
        $uid = $params['uid'];
        $v = $params['rate'];
        $nid = $params['nid'];
        
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $em->getRepository(Node::class)->find($nid);
        $rate = $em->getRepository(Rate::class)->findOneBy(['u' => $user, 'node' => $node]);

        if (null === $rate) {
            $r = new Rate();
            $r->setU($user);
            $r->setNode($node);
            $r->setRate($v);
            $em->persist($r);
            $em->flush();
        }

        $data = [
            'code' => 0,
            'msg' => 'ok',
            'rate' => [],
        ];

        return $this->json($data);
    }

    #[Route('/rates/node/{nid}', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function getNodeRates(int $nid): Response
    {
        $node = $this->data->getNode($nid);
        $rates = $node->getRates();
        
        $data = [];
        foreach($rates as $r) {
            array_push($data, $this->data->formatRate($r));
        }

        return $this->json($data);
    }

    #[Route('/plans', methods: ['POST'])]
    public function plan(Request $request): Response
    {
        $params = $request->toArray();
        $title = $params['title'];
        $summary = isset($params['summary']) ? $params['summary'] : null;
        $body = isset($params['body']) ? $params['body'] : null;
        $uid = $params['uid'];
        $nid = isset($params['nid']) ? $params['nid'] : null;
        $days = isset($params['days']) ? $params['days'] : null;
        $cost = isset($params['cost']) ? $params['cost'] : null;
        $who = isset($params['who']) ? $params['who'] : null;
        $images = isset($params['images']) ? $params['images'] : null;
        $steps = isset($params['steps']) ? $params['steps'] : null;
        
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        if (null !== $nid) {
            $node = $this->data->getNode($nid);
        } else {
            $node = null;
        }

        $plan = $em->getRepository(Plan::class)->findOneBy(['u' => $user, 'node' => $node]);
        if ((null === $plan && null !== $node) || null === $node) {
            $plan = new Plan();
            $plan->setTitle($title);
            $plan->setSummary($summary);
            $plan->setBody($body);
            $plan->setU($user);
            $plan->setNode($node);
            $plan->setDays($days);
            $plan->setCost($cost);
            $plan->setWho($who);
            // $plan->setImages($images);
            // $plan->setSteps($steps);

            $em->persist($plan);

            // $node = new Node();
            // $node->setTitle($title);
            // $node->setSummary($summary);
            // $node->setBody($body);
            // $node->setAuthor($user);
            // $node->setMonth($days);
            // $node->setPrice($cost);
            // $node->setNote($who);
            // $em->persist($node);

            $em->flush();
        }

        $data = [
            'code' => 0,
            'msg' => 'ok',
        ];

        return $this->json($data);
    }

    #[Route('/youji', methods: ['GET'])]
    public function listYouji(Request $request): Response
    {
        $uid = $request->query->get('uid');
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $nodes = $em->getRepository(Node::class)->findBy(['author' => $user, 'deleted' => false], ['id' => 'DESC']);
        $data = [[], []];
        foreach ($nodes as $n) {
            if ($n->isPublished()) {
                array_push($data[0],  $this->data->formatNode($n));
            } else {
                array_push($data[1],  $this->data->formatNode($n));
            }
        }

        return $this->json($data);
    }

    #[Route('/youji/{nid}', requirements: ['nid' => '\d+'],  methods: ['GET'])]
    public function getYouji(int $nid, Request $request): Response
    {
        $em = $this->data->getEntityManager();
        $node = $em->getRepository(Node::class)->find($nid);
        $data = $this->data->formatNode($node);
        $plan = $node->getPlan();
        $steps = [];
        foreach($plan->getSteps() as $s){
            array_push($steps, ['body' => $s->getBody(), 'startAt' => $s->getStartAt()]);
        }
        $images = [];
        foreach($node->getImages() as $i){
            array_push($images, ['image' => $i->getImage(), 'title' => $i->getTitle()]);
        }
        $data['plan'] = [
            'title' => $plan->getTitle(),
            'days' => $plan->getDays(),
            'cost' => $plan->getCost(),
            'who' => $plan->getWho(),
            'startAt' => $plan->getStartAt(),
            'steps' => $steps,
            'images' => $images,
        ];

        return $this->json($data);
    }

    #[Route('/youji/{nid}', requirements: ['nid' => '\d+'], methods: ['DELETE'])]
    public function delYouji(int $nid, Request $request): Response
    {
        $params = $request->toArray();
        $uid = $params['uid'];

        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $em->getRepository(Node::class)->find($nid);

        if ($node->getAuthor() === $user) {
            $node->setDeleted(true);
            $em->flush();
        }

        $nodes = $em->getRepository(Node::class)->findBy(['author' => $user, 'deleted' => false], ['id' => 'DESC']);
        $data = [[], []];
        foreach ($nodes as $n) {
            if ($n->isPublished()) {
                array_push($data[0],  $this->data->formatNode($n));
            } else {
                array_push($data[1],  $this->data->formatNode($n));
            }
        }

        return $this->json($data);
    }

    #[Route('/youji/{nid}', requirements: ['nid' => '\d+'], methods: ['PATCH'])]
    public function updateYouji(int $nid, Request $request): Response
    {
        $params = $request->toArray();
        $title = $params['title'];
        $summary = isset($params['summary']) ? $params['summary'] : null;
        $body = isset($params['body']) ? $params['body'] : null;
        $uid = $params['uid'];
        $planDate = isset($params['planDate']) ? $params['planDate'] : null;
        $days = isset($params['days']) ? $params['days'] : null;
        $cost = isset($params['cost']) ? $params['cost'] : null;
        $who = isset($params['who']) ? $params['who'] : null;
        $images = isset($params['images']) ? $params['images'] : null;
        $steps = isset($params['steps']) ? $params['steps'] : null;
        $published = isset($params['published']) ? $params['published'] : null;
        
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $node = $this->data->getNode($nid);
        $plan = $em->getRepository(Plan::class)->findOneBy(['u' => $user, 'node' => $node]);
        $plan->setTitle($title);
        $plan->setSummary($summary);
        $plan->setBody($body);
        $plan->setU($user);
        // $plan->setNode($node);
        $plan->setStartAt(new \DateTimeImmutable($planDate));
        $plan->setDays($days);
        $plan->setCost($cost);
        $plan->setWho($who);
        foreach($plan->getSteps() as $s){
            $plan->removeStep($s);
        }
        foreach($steps as $s){
            $step = new Step();
            $step->setStartAt(new \DateTimeImmutable($s['date']));
            $step->setBody($s['body']);
            $step->setPlan($plan);
            $em->persist($step);
        }
        $node->setTitle($title);
        $node->setSummary($summary);
        $node->setBody($body);
        $node->setPublished($published);
        $node->setAuthor($user);
        $node->setPlan($plan);
        $region = $em->getRepository(Region::class)->findOneBy(['label' => 'youji']);
        $node->addRegion($region);
        $node->setImage($images[0]);
        foreach($node->getImages() as $i){
            $node->removeImage($i);
        }
        foreach($images as $i){
            $image = new Image();
            $image->setImage($i);
            $em->persist($image);
            $node->addImage($image);
        }
        $em->flush();

        $data = [
            'code' => 0,
            'msg' => 'ok',
        ];

        return $this->json($data);
    }

    #[Route('/youji', methods: ['POST'])]
    public function createYouji(Request $request): Response
    {
        $params = $request->toArray();
        $title = $params['title'];
        $summary = isset($params['summary']) ? $params['summary'] : null;
        $body = isset($params['body']) ? $params['body'] : null;
        $uid = $params['uid'];
        $nid = isset($params['nid']) ? $params['nid'] : null;
        $planDate = isset($params['planDate']) ? $params['planDate'] : null;
        $days = isset($params['days']) ? $params['days'] : null;
        $cost = isset($params['cost']) ? $params['cost'] : null;
        $who = isset($params['who']) ? $params['who'] : null;
        $images = isset($params['images']) ? $params['images'] : null;
        $steps = isset($params['steps']) ? $params['steps'] : null;
        $published = isset($params['published']) ? $params['published'] : null;
        
        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        if (null !== $nid) {
            $node = $this->data->getNode($nid);
        } else {
            $node = null;
        }

        $plan = $em->getRepository(Plan::class)->findOneBy(['u' => $user, 'node' => $node]);
        if ((null === $plan && null !== $node) || null === $node) {
            $plan = new Plan();
            $plan->setTitle($title);
            $plan->setSummary($summary);
            $plan->setBody($body);
            $plan->setU($user);
            // $plan->setNode($node);
            $plan->setStartAt(new \DateTimeImmutable($planDate));
            $plan->setDays($days);
            $plan->setCost($cost);
            $plan->setWho($who);
            // $plan->setImages($images);
            // $plan->setSteps($steps);

            $em->persist($plan);

            foreach($steps as $s){
                $step = new Step();
                $step->setStartAt(new \DateTimeImmutable($s['date']));
                $step->setBody($s['body']);
                $step->setPlan($plan);
                $em->persist($step);
            }

            $node = new Node();
            $node->setTitle($title);
            $node->setSummary($summary);
            $node->setBody($body);
            $node->setPublished($published);
            $node->setAuthor($user);
            $node->setPlan($plan);
            $region = $em->getRepository(Region::class)->findOneBy(['label' => 'youji']);
            $node->addRegion($region);
            $node->setImage($images[0]);
            foreach($images as $i){
                $image = new Image();
                $image->setImage($i);
                $em->persist($image);
                $node->addImage($image);
            }
            $em->persist($node);

            $em->flush();
        }

        $data = [
            'code' => 0,
            'msg' => 'ok',
        ];

        return $this->json($data);
    }

    #[Route('/taxons', methods: ['GET'])]
    public function getTaxons(): Response
    {
        $em = $this->data->getEntityManager();

        $cates = $em->getRepository(Category::class)->findAll();
        $areas = $em->getRepository(Area::class)->findAll();
        
        $data['categories'] = [];
        foreach($cates as $i){
            array_push($data['categories'], [
                'id' => $i->getId(),
                'label' => $i->getLabel(),
                'name' => $i->getName(),
            ]);
        }
        $data['areas'] = [];
        foreach($areas as $i){
            array_push($data['areas'], [
                'id' => $i->getId(),
                'label' => $i->getLabel(),
                'name' => $i->getName(),
            ]);
        }

        return $this->json($data);
    }
}
