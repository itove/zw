<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;

#[Route('/news')]
class NewsController extends AbstractController
{
    private $data;
    
    public function __construct(Data $data)
    {
        $this->data = $data;
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

        $arr = $this->data->get();
        $arr['node'] = $tag;
        $arr['nodes'] = $nodes;
        $arr['page'] = $page;
        $arr['page_count'] = ceil(count($nodes_all) / $limit);

        $data = [
          'nodes' => $nodes,
          'class' => 'page-news-list',
          'sitename' => 'test',
          'page' => $page,
          'page_count' => ceil(count($nodes_all) / $limit),
        ];
        dump($data);
        return $this->render('news/index.html.twig', $data);
    }
    
    #[Route('/{nid}', name: 'app_news_show')]
    public function show($nid): Response
    {
        $data = [
          'class' => 'page-news-show',
          'sitename' => 'test',
        ];
        return $this->render('news/detail.html.twig', $data);
    }
}
