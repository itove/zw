<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ProductsController extends AbstractController
{
    #[Route('/products', name: 'app_products')]
    public function index(): Response
    {
        $data = [
          'class' => 'position-absolute',
          'sitename' => 'test',
        ];
        return $this->render('products/index.html.twig', $data);
    }
}
