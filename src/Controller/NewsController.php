<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;

#[Route('/news')]
class NewsController extends AbstractController
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
        $region = 'news';
        $page = $request->query->get('p');
        $limit = 12;
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

        $data = [
          'nodes' => $nodes,
          'class' => 'page-news-list',
          'page_title' => $this->translator->trans('News'),
          'sitename' => 'test',
          'page' => $page,
          'page_count' => ceil(count($nodes_all) / $limit),
        ];
        return $this->render('news/index.html.twig', $data);
    }
    
    #[Route('/{nid}', requirements: ['nid' => '\d+'], name: 'app_news_show')]
    public function show(int $nid): Response
    {
        $node = $this->data->get($nid);
        $data = [
          'page_title' => $this->translator->trans('News'),
          'class' => 'page-news-show',
          'node' => $node,
        ];
        return $this->render('news/detail.html.twig', $data);
    }
}
