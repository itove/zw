<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;
use App\Entity\Conf;

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
        dump($locale);
        $conf = $this->data->get(1, Conf::class);
        $data = [
          'class' => 'page-contact',
          'page_title' => $this->translator->trans('Contact Us'),
        ];
        return $this->render('contact/index.html.twig', $data);
    }
}
