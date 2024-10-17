<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;
use App\Entity\Taxon;
use App\Entity\Category;

class NodeController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    // #[Route('news/{nid}', requirements: ['nid' => '\d+'], name: 'app_node_show')]
    // #[Route('product/{nid}', requirements: ['nid' => '\d+'], name: 'app_product_show')]
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

        return $this->render('node/show.html.twig', array_merge($data, $data1));
    }

    #[Route('/news', name: 'app_news_index')]
    public function listNodes(Request $request): Response
    {
        $regionLabel = 'meeting';
        $pageLabel = 'news';
        $locale = $request->getLocale();
        $p = $request->query->get('p');
        $limit = 15;
        if (is_null($p) || empty($p)) {
          $p = 1;
        }
        $offset = $limit * ($p - 1);

        $region = $this->data->getRegionByLabel($regionLabel);
        if ($region == null) {
            // 404;
        }

        $nodes = $this->data->findNodesByRegion($region, $locale, $limit, $offset);
        $nodes_all = $this->data->findNodesByRegion($region, $locale);

        $data = $this->data->getMisc($pageLabel);
        $data['page'] = $this->data->getPageInfo($pageLabel);
        $data['page']['intro'] = '怀抱“经世济民，天下大同”的美好愿景，大同经纪在荆楚大地播下了希望的种子。在精彩的绽放中实现华丽转身，独树一帜，引领风潮。';
        $data['nodes'] = $nodes;
        $data['p'] = $p;
        $data['page_count'] = ceil(count($nodes_all) / $limit);

        return $this->render('news/index.html.twig', array_merge($data));
    }

    #[Route('news/{nid}', requirements: ['nid' => '\d+'], name: 'app_node_show')]
    public function showNews(int $nid, Request $request): Response
    {
        $data = $this->data->getMisc($request->getLocale());
        $data['page'] = $this->data->getPageInfo('news');
        $data['page']['intro'] = '怀抱“经世济民，天下大同”的美好愿景，大同经纪在荆楚大地播下了希望的种子。在精彩的绽放中实现华丽转身，独树一帜，引领风潮。';
        $data['node'] = $this->data->getNode($nid);

        return $this->render('node/show.html.twig', $data);
    }
    
    #[Route('/news/{regionLabel?}', name: 'app_news_region')]
    public function listRegionNodes(string $regionLabel, Request $request): Response
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

    #[Route('/about', name: 'app_about')]
    public function aboutUs(Request $request): Response
    {
        $data = $this->data->getPageContent('about', $request->getLocale());
        $data['page']['intro'] = '怀抱“经世济民，天下大同”的美好愿景，大同经纪在荆楚大地播下了希望的种子。在精彩的绽放中实现华丽转身，独树一帜，引领风潮。';

        return $this->render('about.html.twig', $data);
    }

    #[Route('/topic', name: 'app_topic')]
    public function topic(Request $request): Response
    {
        $data = $this->data->getMisc($request->getLocale());

        return $this->render('topic/index.html.twig', $data);
    }

    #[Route('topic/{type}', requirements: ['type' => '\w+'], name: 'app_topic_show')]
    public function showTopic(string $type, Request $request): Response
    {
        $region_label = 'topic_' . $type;
        $data = $this->data->getMisc($request->getLocale());
        $data['node'] = $this->data->findNodesByRegionLabel($region_label)[0];

        return $this->render('node/show.html.twig', $data);
    }

    #[Route('/products', name: 'app_products')]
    public function listProducts(Request $request): Response
    {
        $data = $this->data->getMisc($request->getLocale());

        $cate = $request->query->get('c');
        $drive_type = $request->query->get('d');
        $ton = $request->query->get('t');
        if (is_null($cate) || empty($cate)) {
          $cate = 1;
        }
        if (is_null($drive_type) || empty($drive_type)) {
          $drive_type = 0;
        }
        if (is_null($ton) || empty($ton)) {
          $ton = 0;
        }

        $regionLabel = 'products';
        $region = $this->data->getRegionByLabel($regionLabel);
        $locale = $request->getLocale();
        $page = $request->query->get('p');
        $limit = 15;
        if (is_null($page) || empty($page)) {
          $page = 1;
        }
        $offset = $limit * ($page - 1);
        
        $criteria = [
          'category' => $cate,
          'address' => $drive_type,
          'phone' => $ton,
        ];

        $nodes = $this->data->findByRegionLabelAndCriteria($regionLabel, $criteria, $locale, $limit, $offset);
        $nodes_all = $this->data->findByRegionLabelAndCriteria($regionLabel, $criteria, $locale);

        $data['nodes'] = $nodes;
        $data['path'] = $region->getName();
        $data['page_title'] = $this->translator->trans('Products');
        $data['page'] = $page;
        $data['page_count'] = ceil(count($nodes_all) / $limit);
        $data['regionLabel'] = $regionLabel;
        $data['drive_types'] = Taxon::DRIVE_TYPES;
        $data['tons'] = Taxon::TON;
        $data['cates'] = $this->data->findAll([], Category::class);
        $data['drive_type'] = $drive_type;
        $data['ton'] = $ton;
        $data['cate'] = $cate;
        
        return $this->render('products/index.html.twig', $data);
    }

    #[Route('/products/{nid}', requirements: ['nid' => '\d+'], name: 'app_product_show')]
    public function showProduct(int $nid, Request $request): Response
    {
        $data = $this->data->getMisc($request->getLocale());
        $node = $this->data->getNode(1);
        $data['node'] = $node;

        return $this->render('products/show.html.twig', $data);
    }

    #[Route('/services', name: 'app_services')]
    public function services(Request $request): Response
    {
        $data = $this->data->getPageContent('services', $request->getLocale());
        $data['page']['intro'] = '怀抱“经世济民，天下大同”的美好愿景，大同经纪在荆楚大地播下了希望的种子。在精彩的绽放中实现华丽转身，独树一帜，引领风潮。';

        return $this->render('services.html.twig', $data);
    }

    #[Route('/contact', name: 'app_contact')]
    public function contact(Request $request): Response
    {
        $data = $this->data->getPageContent('contact', $request->getLocale());
        $data['page']['label'] = 'Contact Us';
        $data['page']['intro'] = '大同已根植湖并走向全国：下辖28家机构，其中湖北省内分公司18家，省外分公司6家，省内营业部 4 家。';

        return $this->render('contact.html.twig', $data);
    }

    #[Route('/hire', name: 'app_hire')]
    public function hire(Request $request): Response
    {
        $data = $this->data->getPageContent('hire', $request->getLocale());
        $data['page']['label'] = 'Join Us';
        $data['page']['intro'] = '大同经纪对行业风险管理服务体系建设有着自己独特的推广方式和管理经验，并集合了一大批有经验的保险经纪和风险管理专业人员。';

        return $this->render('hire.html.twig', $data);
    }

    #[Route('/info', name: 'app_info')]
    public function info(Request $request): Response
    {
        $data = $this->data->getPageContent('information', $request->getLocale());
        $data['page']['intro'] = '怀抱“经世济民，天下大同”的美好愿景，大同经纪在荆楚大地播下了希望的种子。在精彩的绽放中实现华丽转身，独树一帜，引领风潮。';

        return $this->render('info.html.twig', $data);
    }
}
