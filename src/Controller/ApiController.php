<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;
use App\Entity\Feedback;
use App\Entity\User;

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
            $user->setAvatar('images/' . $newName);
            $em->flush();
        }
        return $this->json(['url' => '/images/' . $newName]);
    }
    
    #[Route('/nodes/{id}', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function getNode(int $id): Response
    {
        $n = $this->data->getNode($id);
        $conf = $this->data->findConfByLocale(null);
        $tags = [];
        foreach ($n->getTags() as $t) {
            array_push($tags, $t->getName());
        }
        $data = [
            'id' => $n->getId(),
            'title' => $n->getTitle(),
            'summary' => $n->getSummary(),
            'tags' => $tags,
            'body' => $n->getBody(),
            'image' => $n->getImage(),
            'audio' => $n->getAudio(),
            'qr' => $n->getQr(),
            'specs' => $n->getSpecs(),
            'address' => $conf->getAddress(),
            'phone' => $conf->getPhone(),
        ];
        
        $children = [];
        foreach ($n->getChildren() as $k => $v) {
            $children[$k]['title'] = $v->getTitle();
            $children[$k]['summary'] = $v->getSummary();
            $children[$k]['images'] = $v->getImages();
            $tags = [];
            foreach ($v->getTags() as $t) {
                array_push($tags, $t->getName());
            }
            $children[$k]['tags'] = $tags;

            $images = [];
            foreach ($v->getImages() as $i) {
                array_push($images, $i->getImage());
            }
            $children[$k]['images'] = $images;
        }
        $data['children'] = $children;

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
        $nodes = $this->data->findNodesByRegionLabel($regionLabel, null, 10);
        $region = $this->data->getRegionByLabel($regionLabel);
        $i = 0;
        $data['region'] = $region->getName();
        $data['nodes'] = [];
        foreach ($nodes as $n) {
            $data['nodes'][$i]['title'] = $n->getTitle();
            $data['nodes'][$i]['summary'] = $n->getSummary();
            $data['nodes'][$i]['image'] = $n->getImage();
            $data['nodes'][$i]['id'] = $n->getId();
            $i++;
        }

        return $this->json($data);
    }

    #[Route('/fav', methods: ['GET'])]
    public function getUserFav(Request $request): Response
    {
        $regionLabel = $request->query->get('region');
        $uid = $request->query->get('uid');

        $em = $this->data->getEntityManager();
        $user = $em->getRepository(User::class)->find($uid);
        $fav = $user->getFav();
        $region = $this->data->getRegionByLabel($regionLabel);
        
        $i = 0;
        $data['region'] = $region->getName();
        $data['nodes'] = [];
        foreach ($fav as $n) {
            if ($n->getRegions()->contains($region)) {
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
        $list = ['slider', 'youzai', 'zhuzai', 'chizai', 'gouzai', 'tongzhi', 'location', 'jianjie', 'hongsetext', 'historytext'];

        foreach ($list as $l) {
            $nodes = $this->data->findNodesByRegionLabel($l, null, 5);
            $i = 0;
            $a = [];
            foreach ($nodes as $n) {
                $a[$i]['title'] = $n->getTitle();
                $a[$i]['summary'] = $n->getSummary();
                $a[$i]['image'] = $n->getImage();
                $a[$i]['id'] = $n->getId();
                $i++;
            }
            $data[$l] = $a;
        }

        return $this->json($data);
    }

    #[Route('/wx/leyou', methods: ['GET'])]
    public function wxLeyou(): Response
    {
        $list = ['youzai', 'zhuzai', 'chizai', 'gouzai'];

        foreach ($list as $l) {
            $nodes = $this->data->findNodesByRegionLabel($l, null, 5);
            $i = 0;
            $a = [];
            foreach ($nodes as $n) {
                $a[$i]['title'] = $n->getTitle();
                $a[$i]['summary'] = $n->getSummary();
                $a[$i]['image'] = $n->getImage();
                $a[$i]['id'] = $n->getId();
                $i++;
            }
            $data[$l] = $a;
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

        $isFav = false;
        if ($user->getFav()->contains($node)) {
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
        
        $user->addFav($node);
        
        $em->flush();

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
        
        $user->removeFav($node);

        $em->flush();

        return $this->json(['isFav' => true]);
    }
}
