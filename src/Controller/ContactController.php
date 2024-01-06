<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;
use App\Entity\Conf;
use App\Entity\Region;
use App\Entity\Language;

class ContactController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    #[Route('/contact', name: 'app_contact')]
    public function index(Request $request): Response
    {
        $locale = $request->getLocale();
        $lang = $this->data->findOneBy(['locale' => $locale], Language::class);
        
        $conf = $this->data->findOneBy(['language' => $lang], Conf::class);
        $region = $this->data->findOneBy(['label' => 'contact-hero'], Region::class);
        $node = $this->data->findOneBy(['language' => $lang, 'region' => $region]);
        $data = [
          'class' => 'page-contact',
          'page_title' => $this->translator->trans('Contact Us'),
          'conf' => $conf,
          'node' => $node,
        ];
        return $this->render('contact/index.html.twig', $data);
    }
}
