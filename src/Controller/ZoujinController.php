<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ZoujinController extends AbstractController
{
    #[Route('/zoujin', name: 'app_zoujin')]
    public function index(): Response
    {
        return $this->render('zoujin/index.html.twig', [
            'controller_name' => 'ZoujinController',
        ]);
    }
}
