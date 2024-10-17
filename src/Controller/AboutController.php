<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;

class AboutController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    // #[Route('/about', name: 'app_about')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        $hero = $this->data->findNodeByRegionAndLocale('about-hero', $locale);
        $about = $this->data->findNodeByRegionAndLocale('about_dongfeng_orv', $locale);
        $service = $this->data->findNodeByRegionAndLocale('online_service', $locale);
        $spare = $this->data->findNodeByRegionAndLocale('spare_guarantee', $locale);
        $timeline = $this->data->findNodesByRegionAndLocale('timeline', $locale);
        $honors = $this->data->findNodeByRegion('honor');
        $news = $this->data->findNodeByRegion('news', 3);
        $conf = $this->data->findConfByLocale($locale);
        $beian = $this->data->findNodeByRegion('beian', 1)[0];
        $wechat = $this->data->findNodeByRegion('footer-wechatqr', 1)[0];
        $miniprog = $this->data->findNodeByRegion('footer-miniprogqr', 1)[0];
        $data = [
          'page_title' => $this->translator->trans('About Us'),
          'class' => 'page-about',
          'hero' => $hero,
          'about' => $about,
          'timeline' => $timeline,
          'service' => $service,
          'spare' => $spare,
          'honors' => $honors,
          'news' => $news,
          'conf' => $conf,
          'beian' => $beian,
          'wechat' => $wechat,
          'miniprog' => $miniprog,
        ];
        return $this->render('about/index.html.twig', $data);
    }
}
