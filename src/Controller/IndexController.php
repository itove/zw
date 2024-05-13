<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;

class IndexController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    #[Route('/', name: 'app_index')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        $page = $this->data->getPage('home');
        $regions = $page->getRegions();
        $d = [];
        foreach ($regions as $r) {
            $dataOfRegion = $this->data->findNodesByRegion($r, $locale);
            $d[$r->getLabel()] = $dataOfRegion;
        }
        $conf = $this->data->findConfByLocale($locale);
        $data = [
          'conf' => $conf,
        ];
        $data = array_merge($data, $d);
        dump($data);
        return $this->render('index/index.html.twig', $data);
    }
}
