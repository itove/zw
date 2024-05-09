<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;

#[Route('/api')]
class ApiController extends AbstractController
{
    #[Route('/media_objects', methods: ['POST'])]
    public function upload(Request $request): Response
    {
        $file = $request->files->get('upload');
        $newName = uniqid() . '-' .  $file->getClientOriginalName();
        // copy($file->getPathname(), 'images/' . $newName);
        $file->move('images/', $newName);
        return $this->json(['url' => '/images/' . $newName]);
    }
    
    #[Route('/get_jiudian', methods: ['GET'])]
    public function m1(Request $request): Response
    {
        $data = '
[
    {
        "id": 24,
        "cname": "灯影峡宾馆",
        "ename": "DENGYINGXIA",
        "desc": "东沟位于茅箭区茅塔乡东沟村，东沟村是革命老区，曾经历过血与火的洗礼。 经过20多年的持续打造，东沟景区目前重要景点:中原突围鄂东沟位于茅箭区茅塔乡东沟村，东沟村是革命老区，曾经历过血与火的洗礼。 经过20多年的持续打造，东沟景区目前重要景点:中原突围鄂",
        "pics": [
            "\/images\/zoujin_slider_1.jpg",
            "\/images\/zoujin_slider_1.jpg",
            "\/images\/zoujin_slider_1.jpg",
            "\/images\/zoujin_slider_1.jpg",
            "\/images\/zoujin_slider_1.jpg"
        ]
    }
]
';
        $resp = new Response($data);
        $resp->headers->set('Content-Type', 'text/strings');
        return $resp;
    }
    
    #[Route('/get_yule', methods: ['GET'])]
    public function m2(Request $request): Response
    {
        return $this->json([]);
    }
    
    #[Route('/get_sheyinzuopin', methods: ['GET'])]
    public function m3(Request $request): Response
    {
        $data = '
[
    {
        "id": 86,
        "path": "/images/leyou_slider_1.jpg",
        "info": {
            "name": "蓝色幽梦",
            "author": "秦炎",
            "address": "三峡人家",
            "time": "2020-05"
        }
    },
    {
        "id": 87,
        "path": "/images/leyou_slider_1.jpg",
        "info": {
            "name": "峡江之光",
            "author": "王松",
            "address": "三峡人家",
            "time": "2020-05"
        }
    },
    {
        "id": 88,
        "path": "/images/leyou_slider_1.jpg",
        "info": {
            "name": "灯影婆娑四人行",
            "author": "望开喜",
            "address": "三峡人家",
            "time": "2020-06"
        }
    }
';
        $resp = new Response($data);
        $resp->headers->set('Content-Type', 'text/strings');
        return $resp;
    }
}
