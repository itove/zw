<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Service\Data;

class IndexController extends AbstractController
{
    private $data;
    
    public function __construct(Data $data)
    {
        $this->data = $data;
    }

    #[Route('/', name: 'app_index')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        dump($locale);
        // $arr = $this->data->get();
        // $arr['slides'] = $this->data->getNodeByTag('carousel', 6);
        $data = ['sitename' => 'test'];
        return $this->render('index/index.html.twig', $data);
    }
}
