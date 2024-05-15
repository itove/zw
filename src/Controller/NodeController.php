<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;

class NodeController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    #[Route('news/{nid}', requirements: ['nid' => '\d+'], name: 'app_node_show')]
    #[Route('product/{nid}', requirements: ['nid' => '\d+'], name: 'app_product_show')]
    public function show(int $nid, Request $request): Response
    {
        // $route = $request->attributes->get('_route');
        $pageTitle = 'News';
        $locale = $request->getLocale();
        $node = $this->data->get($nid);
        $prev = $this->data->getPrev($node);
        $next = $this->data->getNext($node);
        $data = $this->data->getMisc($request->getLocale());
        $data1 = [
          'page_title' => $this->translator->trans($pageTitle),
          'path' => $node->getTitle(),
          'node' => $node,
          'prev' => $prev,
          'next' => $next,
        ];

        return $this->render('node/detail.html.twig', array_merge($data, $data1));
    }
    
    #[Route('/news', name: 'app_news_list')]
    #[Route('/news/{regionLabel?}', name: 'app_news_region_label')]
    public function index(string $regionLabel, Request $request): Response
    {
        $locale = $request->getLocale();
        $page = $request->query->get('p');
        $limit = 5;
        if (is_null($page) || empty($page)) {
          $page = 1;
        }
        $offset = $limit * ($page - 1);
        
        // $nodes = $this->data->getNodeByRegion($region, $limit, $offset);
        // $nodes_all = $this->data->getNodeByRegion($region);
        $region = $this->data->getRegionByLabel($regionLabel);
        if ($region == null) {
            // 404;
        }
        
        $nodes = $this->data->findNodesByRegion($region, $locale, $limit, $offset);
        $nodes_all = $this->data->findNodesByRegion($region, $locale);
        
        // $tag = $this->data->getTagByLabel($region);
        // $arr = $this->data->getSome();
        // $arr['node'] = $tag;
        // $arr['nodes'] = $nodes;
        // $arr['page'] = $page;
        // $arr['page_count'] = ceil(count($nodes_all) / $limit);

        $data = $this->data->getMisc($request->getLocale());
        $data1 = [
          'nodes' => $nodes,
          'path' => $region->getName(),
          'page_title' => $this->translator->trans('News'),
          'page' => $page,
          'page_count' => ceil(count($nodes_all) / $limit),
          'regionLabel' => $regionLabel,
        ];

        return $this->render('node/index.html.twig', array_merge($data, $data1));
    }
}
