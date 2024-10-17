<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Entity\Feedback;
use App\Entity\Node;
use App\Service\Data;
use Doctrine\Persistence\ManagerRegistry;

#[Route('/feedback')]
class FeedbackController extends AbstractController
{
    private $doctrine;

    public function __construct(ManagerRegistry $doctrine, Data $data)
    {
        $this->doctrine = $doctrine;
        $this->data = $data;
    }

    #[Route('/', methods: ['get'], name: 'app_feedback')]
    public function index(Request $request): Response
    {
        $data = $this->data->getMisc($request->getLocale());
        $data['page'] = $this->data->getPageInfo('feedback');

        return $this->render('feedback.html.twig', $data);
    }
    
    #[Route('/new', methods: ['POST'], name: 'app_feedback_new')]
    public function new(Request $request): Response
    {
        $firstname = $request->request->get('firstname');
        $lastname = $request->request->get('lastname');
        $name = $request->request->get('name');
        $sex = $request->request->get('sex');
        $note = $request->request->get('note');
        $province = $request->request->get('province');
        $city = $request->request->get('city');
        $phone = $request->request->get('phone');
        $email = $request->request->get('email');
        $title = $request->request->get('title');
        $body = $request->request->get('body');
        $nid = $request->request->get('nid');
        $country = $request->request->get('country');
        $type = $request->request->get('type');
        
        // $node = $this->doctrine->getRepository(Node::class)->find($nid);
        
        $em = $this->doctrine->getManager();
        $f = new Feedback();
        $f->setFirstname($firstname);
        $f->setLastname($lastname);
        $f->setName($name);
        $f->setSex($sex);
        $f->setNote($note);
        $f->setProvince($province);
        $f->setCity($city);
        $f->setPhone($phone);
        $f->setEmail($email);
        $f->setTitle($title);
        $f->setBody($body);
        $f->setType($type);
        // $f->setNode($node);
        $f->setCountry($country);
        $em->persist($f);
        $em->flush();

        // $this->addFlash(
        //     'notice',
        //     '您的表单已成功提交！'
        // );
        
        return $this->json(["code" => 0, 'msg' => 'OK']);
        // return new RedirectResponse($this->generateUrl('app_contact'));
        // return new RedirectResponse($request->headers->get('referer') . '#feedback');
    }
}
