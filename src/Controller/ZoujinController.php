<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;

class ZoujinController extends AbstractController
{
    private $data;
    
    public function __construct(Data $data)
    {
        $this->data = $data;
    }
    
    #[Route('/zoujin', name: 'app_zoujin')]
    public function index(Request $request): Response
    {
        $data = $this->data->getPageContent('zoujin', $request->getLocale());

        return $this->render('zoujin/index.html.twig', $data);
    }
}
