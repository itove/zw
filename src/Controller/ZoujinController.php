<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;

class ZoujinController extends AbstractController
{
    private $data;
    
    public function __construct(Data $data)
    {
        $this->data = $data;
    }
    
    #[Route('/zoujin', name: 'app_zoujin')]
    public function index(Request $request): Response
    {
        
        $slider2 = [
          [
            'title' => '云上牡丹园',
            'summary' => '东沟·云上牡丹园地处于十堰市茅箭区茅塔乡东沟村二组，平均 海拔600米，建设2020年，共计栽植观赏牡丹二十余个...',
            'img' => 'zoujin_slider2_1.jpg'
          ],
          [
            'title' => '念情谷—猕猴园',
            'summary' => '东沟念情谷猕猴园位于东沟景区境内，占地面积约1.2平方公里， 园内有登山游步道、猕猴互动平台、观景亭、景观桥等设...',
            'img' => 'zoujin_slider2_2.jpg'
          ],
          [
            'title' => '杜鹃岭',
            'summary' => '杜鹃岭位于东沟村二组小沟处共栽植利用面积达100亩，杜鹃路 杜鹃总计有4万余棵，其中有2万余株粉色杜鹃和红色杜鹃...',
            'img' => 'zoujin_slider2_3.jpg'
          ],
        ];
        $slider3 = [
          [
            'title' => '云上牡丹园',
            'summary' => '东沟·云上牡丹园地处于十堰市茅箭区茅塔乡东沟村二组，平均 海拔600米，建设2020年，共计栽植观赏牡丹二十余个...',
            'img' => 'zoujin_slider3_1.jpg'
          ],
          [
            'title' => '念情谷—猕猴园',
            'summary' => '东沟念情谷猕猴园位于东沟景区境内，占地面积约1.2平方公里， 园内有登山游步道、猕猴互动平台、观景亭、景观桥等设...',
            'img' => 'zoujin_slider3_2.jpg'
          ],
          [
            'title' => '杜鹃岭',
            'summary' => '杜鹃岭位于东沟村二组小沟处共栽植利用面积达100亩，杜鹃路 杜鹃总计有4万余棵，其中有2万余株粉色杜鹃和红色杜鹃...',
            'img' => 'zoujin_slider3_3.jpg'
          ],
        ];
        $honor = [
          ['title' => '子矜染坊草木蓝染', 'img' => 'honor_1.jpg'],
          ['title' => '东沟干货', 'img' => 'honor_2.jpg'],
          ['title' => '贺大姐麻豆、腐乳', 'img' => 'honor_3.jpg'],
          ['title' => '陶艺体验及成品', 'img' => 'honor_4.jpg'],
        ];
        $data = [
            'slider2' => $slider2,
            'slider3' => $slider3,
            'honor' => $honor,
        ];

        $data = $this->data->getPageContent('zoujin', $request->getLocale());
        dump($data);
        return $this->render('zoujin/index.html.twig', $data);
    }
}
