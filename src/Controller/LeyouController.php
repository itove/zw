<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;

class LeyouController extends AbstractController
{
    private $data;
    
    public function __construct(Data $data)
    {
        $this->data = $data;
    }
    
    #[Route('/leyou', name: 'app_leyou')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        $conf = $this->data->findConfByLocale($locale);
        $slider1 = [
          ['title' => '景点：中原突围部西北历史纪念馆1', 'img' => 'home_jingqu_bg.jpg'],
          ['title' => '景点：中原突围部西北历史纪念馆2', 'img' => 'leyou_slider_1.jpg'],
          ['title' => '景点：中原突围部西北历史纪念馆3', 'img' => 'home_jingqu_bg.jpg'],
        ];
        $slider2 = [
          [
            'title' => '云上牡丹园',
            'summary' => '东沟·云上牡丹园地处于十堰市茅箭区茅塔乡东沟村二组，平均 海拔600米，建设2020年，共计栽植观赏牡丹二十余个...',
            'img' => 'leyou_slider2_1.jpg'
          ],
          [
            'title' => '念情谷—猕猴园',
            'summary' => '东沟念情谷猕猴园位于东沟景区境内，占地面积约1.2平方公里， 园内有登山游步道、猕猴互动平台、观景亭、景观桥等设...',
            'img' => 'leyou_slider2_2.jpg'
          ],
          [
            'title' => '杜鹃岭',
            'summary' => '杜鹃岭位于东沟村二组小沟处共栽植利用面积达100亩，杜鹃路 杜鹃总计有4万余棵，其中有2万余株粉色杜鹃和红色杜鹃...',
            'img' => 'leyou_slider2_3.jpg'
          ],
        ];
        $slider3 = [
          [
            'title' => '蛙声十里',
            'phone' => '景区电话：0719-8457770',
            'summary' => '蛙声十里位于东沟村二组对面则是荷塘月色，这里远离喧嚣...',
            'img' => 'leyou_slider3_1.jpg'
          ],
          [
            'title' => '桃源人家',
            'phone' => '电话：0719-8457770',
            'summary' => '桃源人家位于茅箭区茅塔乡东沟村，提供餐饮及住宿。可同时...',
            'img' => 'leyou_slider3_2.jpg'
          ],
          [
            'title' => '山顶美宿',
            'phone' => '电话：0719-8457770',
            'summary' => '山顶美宿位于东沟景区境内，藏于一片山野之中，附近有茶园...',
            'img' => 'leyou_slider3_3.jpg'
          ],
        ];
        $chizai = [
          ['title' => '野生猕猴桃', 'img' => 'chizai_1.jpg'],
          ['title' => '野生猕猴桃', 'img' => 'chizai_2.jpg'],
          ['title' => '野生猕猴桃', 'img' => 'chizai_3.jpg'],
          ['title' => '野生猕猴桃', 'img' => 'chizai_4.jpg'],
          ['title' => '野生猕猴桃', 'img' => 'chizai_5.jpg'],
          ['title' => '野生猕猴桃', 'img' => 'chizai_6.jpg'],
          ['title' => '野生猕猴桃', 'img' => 'chizai_7.jpg'],
          ['title' => '野生猕猴桃', 'img' => 'chizai_8.jpg'],
        ];
        $slider4 = [
          [
            'title' => '子矜染坊草木蓝染',
            'summary' => '东沟子矜染坊草木蓝染采用纯天然植物提取染料， 通过非遗传承的工艺，手工制作而成，带着...',
            'img' => 'leyou_slider4_1.jpg'
          ],
          [
            'title' => '东沟干货',
            'summary' => '东沟干货，来自于农户手工制作的干笋、红薯干、 果干、干菜等，来自于淳朴的大地来自于...',
            'img' => 'leyou_slider4_2.jpg'
          ],
          [
            'title' => '贺大姐麻豆、腐乳',
            'summary' => '贺大姐麻豆、腐乳是东沟村的特产。它制作精细， 具有细、黄、软特色，五味调和，滋味香酥...',
            'img' => 'leyou_slider4_3.jpg'
          ],
          [
            'title' => '陶艺体验及成品',
            'summary' => '东沟陶艺陶艺坊，是一个充满温馨和爱心的大家庭。 我们的陶艺作品都是手工捏制，没有任何机器...',
            'img' => 'leyou_slider4_4.jpg'
          ],
        ];
        $data = [
            'conf' => $conf,
            'slider1' => $slider1,
            'slider2' => $slider2,
            'slider3' => $slider3,
            'chizai' => $chizai,
            'slider4' => $slider4,
        ];
        return $this->render('leyou/index.html.twig', $data);
    }
}
