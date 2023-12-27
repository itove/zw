<?php

namespace App\Controller\Admin;

use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use EasyCorp\Bundle\EasyAdminBundle\Router\AdminUrlGenerator;
use EasyCorp\Bundle\EasyAdminBundle\Config\Crud;
use App\Entity\Post;
use App\Entity\Region;
use App\Entity\Tag;
use App\Entity\User;
use App\Entity\Conf;
use Doctrine\Persistence\ManagerRegistry;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;

class DashboardController extends AbstractDashboardController
{
    private $doctrine;
    private $posts;
    private $conf;

    public function __construct(ManagerRegistry $doctrine)
    {
      $this->doctrine = $doctrine;
      $this->posts = $doctrine->getRepository(Post::class);
      $this->conf = $doctrine->getRepository(Conf::class)->find(1);
    }
    
    #[Route('/admin', name: 'admin')]
    public function index(): Response
    {
        $adminUrlGenerator = $this->container->get(AdminUrlGenerator::class);
        return $this->redirect($adminUrlGenerator
                    ->setController(PostCrudController::class)
                    ->set('region', 'news_list')
                    ->set('img', '1')
                    ->set('body', 'Body')
                    ->set('tag', 'nodash')
                    // ->setAction('detail')
                    // ->setEntityId(1)
                    ->generateUrl()
        );
    }

    public function configureDashboard(): Dashboard
    {
        if ($this->conf) {
            $title = $this->conf->getSitename();
        } else {
            $title = 'Sitename';
        }
        return Dashboard::new()
            ->setTitle($title);
    }
    
    public function configureCrud(): Crud
    {
        return Crud::new()
            ->showEntityActionsInlined()
            ->setTimezone('Asia/Shanghai')
            ->setDateTimeFormat('yyyy/MM/dd HH:mm')
            ->setDefaultSort(['id' => 'DESC'])
        ;
    }

    public function configureActions(): Actions
    {
        return Actions::new()
            // ->disable('delete')
            ->add('detail', 'edit')
            ->add('index', 'edit')
            ->add('index', 'new')
            ->add('index', 'delete')
            ->add(Crud::PAGE_NEW, Action::SAVE_AND_RETURN)
            ->add(Crud::PAGE_EDIT, Action::SAVE_AND_RETURN)
            ->add(Crud::PAGE_EDIT, Action::SAVE_AND_CONTINUE)
        ;
    }

    public function configureMenuItems(): iterable
    {
        $regions = $this->doctrine->getRepository(Region::class);
        yield MenuItem::linkToDashboard('Dashboard', 'fa fa-home');
    }
}
