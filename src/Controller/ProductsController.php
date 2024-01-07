<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\Translation\TranslatorInterface;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;

class ProductsController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    #[Route('/products', name: 'app_products')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        $request = $this->data->findNodeByRegionAndLocale('request', $locale);
        $hero = $this->data->findNodeByRegion('products-hero', 1)[0];
        $sliders1 = $this->data->findNodeByTag('products-slider-1', 3);
        $sliders2 = 1; 
        $sliders3 = 1; 
        $sliders4 = 1; 
        $sliders5 = 1; 
        $sliders6 = 1; 
        $spec = 1;
        $data = [
          'class' => 'page-products position-absolute',
          'page_title' => $this->translator->trans('Products'),
          'request' => $request,
          'hero' => $hero,
          'sliders1' => $sliders1,
          'sliders2' => $sliders2,
          'sliders3' => $sliders3,
          'sliders4' => $sliders4,
          'sliders5' => $sliders5,
          'sliders6' => $sliders6,
          'spec' => $spec,
        ];
        return $this->render('products/index.html.twig', $data);
    }
}
