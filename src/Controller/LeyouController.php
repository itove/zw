<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;

class LeyouController extends AbstractController
{
    private $data;
    
    public function __construct(Data $data)
    {
        $this->data = $data;
    }
    
    #[Route('/leyou', name: 'app_leyou')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        $data = $this->data->getPageContent('leyou', $request->getLocale());

        return $this->render('leyou/index.html.twig', $data);
    }
}
