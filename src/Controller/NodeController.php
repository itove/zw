<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;

#[Route('/news')]
class NodeController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    #[Route('/', name: 'app_news_list')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        $region = 'news';
        $page = $request->query->get('p');
        $limit = 9;
        if (is_null($page) || empty($page)) {
          $page = 1;
        }
        $offset = $limit * ($page - 1);
        
        $nodes = $this->data->getNodeByRegion($region, $limit, $offset);
        $nodes_all = $this->data->getNodeByRegion($region);
        $tag = $this->data->getTagByLabel($region);

        $arr = $this->data->getSome();
        $arr['node'] = $tag;
        $arr['nodes'] = $nodes;
        $arr['page'] = $page;
        $arr['page_count'] = ceil(count($nodes_all) / $limit);
        $conf = $this->data->findConfByLocale($locale);
        $beian = $this->data->findNodeByRegion('beian', 1)[0];
        $wechat = $this->data->findNodeByRegion('footer-wechatqr', 1)[0];
        $miniprog = $this->data->findNodeByRegion('footer-miniprogqr', 1)[0];

        $data = [
          'nodes' => $nodes,
          'class' => 'page-news-list',
          'page_title' => $this->translator->trans('News'),
          'page' => $page,
          'page_count' => ceil(count($nodes_all) / $limit),
          'conf' => $conf,
          'beian' => $beian,
          'wechat' => $wechat,
          'miniprog' => $miniprog,
        ];
        return $this->render('node/index.html.twig', $data);
    }
    
    #[Route('/{nid}', requirements: ['nid' => '\d+'], name: 'app_news_show')]
    public function show(int $nid, Request $request): Response
    {
        $locale = $request->getLocale();
        $node = $this->data->get($nid);
        $conf = $this->data->findConfByLocale($locale);
        $beian = $this->data->findNodeByRegion('beian', 1)[0];
        $wechat = $this->data->findNodeByRegion('footer-wechatqr', 1)[0];
        $miniprog = $this->data->findNodeByRegion('footer-miniprogqr', 1)[0];
        $data = [
          'page_title' => $this->translator->trans('News'),
          'class' => 'page-news-show',
          'node' => $node,
          'conf' => $conf,
          'beian' => $beian,
          'wechat' => $wechat,
          'miniprog' => $miniprog,
        ];
        return $this->render('node/detail.html.twig', $data);
    }
}
