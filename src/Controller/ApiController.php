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
    
    #[Route('/nodes/{id}', methods: ['GET'])]
    public function getNode(int $id): Response
    {
        $n = $this->data->getNode($id);
        $data = [
          'title' => $n->getTitle(),
          'summary' => $n->getSummary(),
          'content' => $n->getBody(),
        ];
        return $this->json($data);
    }

    #[Route('/wx/home', methods: ['GET'])]
    public function wxHome(): Response
    {
        $list = ['slider', 'youzai', 'zhuzai', 'chizai', 'gouzai', 'notice'];

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

        // dump($data);

        return $this->json($data);
    }
}
