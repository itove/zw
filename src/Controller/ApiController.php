<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;

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
        $file = $request->files->get('upload');
        $newName = uniqid() . '-' .  $file->getClientOriginalName();
        // copy($file->getPathname(), 'images/' . $newName);
        $file->move('images/', $newName);
        return $this->json(['url' => '/images/' . $newName]);
    }
    
    #[Route('/nodes/{id}', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function getNode(int $id): Response
    {
        $n = $this->data->getNode($id);
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
        ];
        return $this->json($data);
    }

    #[Route('/nodes/{regionLabel}', methods: ['GET'])]
    public function getNodesByRegion(string $regionLabel): Response
    {
        $nodes = $this->data->findNodesByRegionLabel($regionLabel, null, 10);
        $i = 0;
        $data = [];
        foreach ($nodes as $n) {
            $data[$i]['title'] = $n->getTitle();
            $data[$i]['summary'] = $n->getSummary();
            $data[$i]['image'] = $n->getImage();
            $data[$i]['id'] = $n->getId();
            $i++;
        }

        return $this->json($data);
    }

    #[Route('/wx/home', methods: ['GET'])]
    public function wxHome(): Response
    {
        $list = ['slider', 'youzai', 'zhuzai', 'chizai', 'gouzai', 'notice', 'location', 'jianjie'];

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
}
