<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class LeyouController extends AbstractController
{
    #[Route('/leyou', name: 'app_leyou')]
    public function index(): Response
    {
        return $this->render('leyou/index.html.twig', [
            'controller_name' => 'LeyouController',
        ]);
    }
}
