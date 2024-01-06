<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;

class AboutController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    #[Route('/about', name: 'app_about')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        $node = $this->data->findNodeByRegionAndLocale('about-hero', $locale);
        $data = [
          'page_title' => $this->translator->trans('About Us'),
          'class' => 'page-about',
        ];
        return $this->render('about/index.html.twig', $data);
    }
}
