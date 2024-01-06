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
        $data = [
          'class' => 'page-products position-absolute',
          'page_title' => $this->translator->trans('Products'),
          'request' => $request,
        ];
        return $this->render('products/index.html.twig', $data);
    }
}
