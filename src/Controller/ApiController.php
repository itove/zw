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
]
';
        $resp = new Response($data);
        $resp->headers->set('Content-Type', 'text/strings');
        return $resp;
    }
    
    #[Route('/get_gouzai', methods: ['GET'])]
    public function m4(Request $request): Response
    {
        $data = '
{
    "id": 11,
    "mid": 8,
    "picurl": "\/uploads\/images\/20220228\/1646028239NU7mBtQsnt6867.png",
    "classid": 104,
    "parentstr": ",0,101,",
    "maintitle": "<p>土家腊肉<br\/><\/p>",
    "subtitle": "<p><span style=\"color: rgb(51, 51, 51); font-family: \">腊肉是湖北特产，也是土家族过年必备食物，其制法已有几千年的历史。<span style=\"color: rgb(51, 51, 51); font-family: \">每年腊月，家家户户准备年货，将吃不完的鲜猪肉用食盐配以一定比例的花椒、香叶、茴香、八角、桂皮等香料，腌制七到十五天，<span style=\"color: rgb(51, 51, 51); font-family: \">然后<span style=\"color: rgb(51, 51, 51); font-family: \">挂在烧柴火的灶头顶上，或吊于烧柴火的烤火炉上，<\/span>利用烟火慢慢熏干。也有专门<\/span>选用松柏枝<\/span><span style=\"color: rgb(51, 51, 51); font-family: \">、桔树皮或柴草慢慢熏烤的。熏后的<span style=\"color: rgb(51, 51, 51); font-family: \">腊肉色泽鲜明，呈暗红色，肉质透明、干爽、富有弹性，别具腌腊风味。<\/span><\/span><\/span><\/p>",
    "score": 0,
    "orderid": null,
    "color": "",
    "picurlm": "",
    "picurls": ""
}
';
        $resp = new Response($data);
        $resp->headers->set('Content-Type', 'text/strings');
        return $resp;
    }
    
    #[Route('/get_chizai', methods: ['GET'])]
    public function m5(Request $request): Response
    {
        $data = '
{
    "id": 11,
    "mid": 8,
    "picurl": "\/uploads\/images\/20220228\/1646028239NU7mBtQsnt6867.png",
    "classid": 104,
    "parentstr": ",0,101,",
    "maintitle": "<p>土家腊肉<br\/><\/p>",
    "subtitle": "<p><span style=\"color: rgb(51, 51, 51); font-family: \">腊肉是湖北特产，也是土家族过年必备食物，其制法已有几千年的历史。<span style=\"color: rgb(51, 51, 51); font-family: \">每年腊月，家家户户准备年货，将吃不完的鲜猪肉用食盐配以一定比例的花椒、香叶、茴香、八角、桂皮等香料，腌制七到十五天，<span style=\"color: rgb(51, 51, 51); font-family: \">然后<span style=\"color: rgb(51, 51, 51); font-family: \">挂在烧柴火的灶头顶上，或吊于烧柴火的烤火炉上，<\/span>利用烟火慢慢熏干。也有专门<\/span>选用松柏枝<\/span><span style=\"color: rgb(51, 51, 51); font-family: \">、桔树皮或柴草慢慢熏烤的。熏后的<span style=\"color: rgb(51, 51, 51); font-family: \">腊肉色泽鲜明，呈暗红色，肉质透明、干爽、富有弹性，别具腌腊风味。<\/span><\/span><\/span><\/p>",
    "score": 0,
    "orderid": null,
    "color": "",
    "picurlm": "",
    "picurls": ""
}
';
        $resp = new Response($data);
        $resp->headers->set('Content-Type', 'text/strings');
        return $resp;
    }
}
