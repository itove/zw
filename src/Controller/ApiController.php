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
    public function getNodesByRegion(string $regionLabel): Response
    {
        $nodes = $this->data->findNodesByRegionLabel($regionLabel, null);
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

    #[Route('/feedback', methods: ['POST'])]
    public function feedback(Request $request): Response
    {
        $params = $request->toArray();
        $firstname = $params['firstname'];
        // $lastname = $params['lastname'];
        $phone = $params['phone'];
        $email = $params['email'];
        $title = $params['title'];
        $body = $params['body'];
        // $country = $params['country'];
        
        $em = $this->data->getEntityManager();
        $f = new Feedback();
        $f->setFirstname($firstname);
        // $f->setLastname($lastname);
        $f->setPhone($phone);
        $f->setEmail($email);
        $f->setTitle($title);
        $f->setBody($body);
        // $f->setCountry($country);
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
        $regionLabel = $request->query->get('region');
        $uid = $request->query->get('uid');

        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $favs = $user->getFavs();
        $region = $this->data->getRegionByLabel($regionLabel);

        $i = 0;
        $data['region'] = $region->getName();
        $data['nodes'] = [];
        foreach ($favs as $f) {
            if ($f->getNode()->getRegions()->contains($region)) {
                $data['nodes'][$i]['title'] = $n->getTitle();
                $data['nodes'][$i]['summary'] = $n->getSummary();
                $data['nodes'][$i]['image'] = $n->getImage();
                $data['nodes'][$i]['id'] = $n->getId();
                $i++;
            }
        }

        return $this->json($data);
    }

    #[Route('/wx/home', methods: ['GET'])]
    public function wxHome(): Response
    {
        $list = ['slider', 'jing', 'zhu', 'shi', 'dong', 'gou', 'yi', 'wen', 'wan'];

        foreach ($list as $l) {
            $nodes = $this->data->findNodesByRegionLabel($l, null, 5);
            $i = 0;
            $a = [];
            foreach ($nodes as $n) {
                $a[$i]['title'] = $n->getTitle();
                $a[$i]['summary'] = $n->getSummary();
                $a[$i]['image'] = $n->getImage();
                $a[$i]['id'] = $n->getId();

                $a[$i]['favs'] = [];
                foreach($n->getFavs() as $f) {
                    array_push($a[$i]['favs'], $f->getU()->getId());
                }

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
        }

        $em->flush();

        return $this->json(['isFav' => false]);
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

        return $this->json(['isFav' => $isFav]);
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
        dump($q);

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

    // #[Route('/comments', methods: ['GET'])]
    public function getComments(Node $node)
    {
        $data = [];
        foreach($node->getComments() as $c){
            array_push($data, $this->data->formatComment($c));
        }

        return $data;
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
            'comments' => self::getComments($node),
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
            'comments' => self::getComments($comment->getNode()),
        ];

        return $this->json($data);
    }
}
