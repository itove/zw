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
        $d = $this->data->getPageContent('contact', $locale);
        dump($d);
        
        $conf = $this->data->findConfByLocale($locale);
        $data = [
          'conf' => $conf,
        ];
        $data = array_merge($data, $d);
        dump($data);
        return $this->render('contact/index.html.twig', $data);
    }
}
