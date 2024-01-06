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
        // $arr = $this->data->get();
        // $arr['slides'] = $this->data->getNodeByTag('carousel', 6);
        $data = [
          'path' => '',
          'class' => 'page-home position-absolute',
          'page_title' => $this->translator->trans('Home'),
        ];
        return $this->render('index/index.html.twig', $data);
    }
}
