<?php

namespace App\Controller\Admin;

use App\Entity\Node;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ChoiceField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateTimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ArrayField;
use App\Admin\Field\VichImageField;
use EasyCorp\Bundle\EasyAdminBundle\Dto\SearchDto;
use EasyCorp\Bundle\EasyAdminBundle\Dto\EntityDto;
use EasyCorp\Bundle\EasyAdminBundle\Orm\EntityRepository;
use EasyCorp\Bundle\EasyAdminBundle\Collection\FieldCollection;
use EasyCorp\Bundle\EasyAdminBundle\Collection\FilterCollection;
use Doctrine\ORM\QueryBuilder;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\RequestStack;
use App\Entity\Region;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Config\Crud;
use EasyCorp\Bundle\EasyAdminBundle\Router\AdminUrlGenerator;
use EasyCorp\Bundle\EasyAdminBundle\Config\Assets;
use EasyCorp\Bundle\EasyAdminBundle\Config\Asset;

class NodeCrudController extends AbstractCrudController
{
    private $region;
    private $query;
    private $adminUrlGenerator;

    public function __construct(ManagerRegistry $doctrine, RequestStack $requestStack, AdminUrlGenerator $adminUrlGenerator)
    {
        $this->query = $requestStack->getCurrentRequest()->query;
        $region_label = $this->query->get('region');
        if (!is_null($region_label)) {
            $this->region = $doctrine->getRepository(Region::class)->findOneBy(['label' => $region_label]);
        }
        $this->adminUrlGenerator = $adminUrlGenerator;
    }
    
    public static function getEntityFqcn(): string
    {
        return Node::class;
    }
    
    public function createIndexQueryBuilder(SearchDto $searchDto, EntityDto $entityDto, FieldCollection $fields, FilterCollection $filters): QueryBuilder
    {
        $response = $this->container->get(EntityRepository::class)->createQueryBuilder($searchDto, $entityDto, $fields, $filters);
        if (!is_null($this->region)) {
            $id = $this->region->getId();
            $response->andWhere("entity.region = $id");
        }
        return $response;
    }
    
    public function createEntity(string $entityFqcn)
    {
        $node = new Node();
        if (!is_null($this->region)) {
            $node->setRegion($this->region);
        }
        return $node;
    }

    public function configureActions(Actions $actions): Actions
    {
        $newFn = fn (Action $action) => $action->linkToUrl(
            fn () => $this->adminUrlGenerator
                          ->setAction('new')
                          ->generateUrl()
        );
        $editFn = fn (Action $action) => $action->linkToUrl(
            fn (Node $entity) => $this->adminUrlGenerator
                          ->setAction('edit')
                          ->set('entityId', $entity->getId())
                          ->generateUrl()
        );
        
        return $actions
            ->update('index', 'new', $newFn)
            ->update('index', 'edit', $editFn)
            ->update('detail', 'edit', $editFn)
        ;
    }
    
    public function configureAssets(Assets $assets): Assets
    {
        return $assets
            ->addJsFile(
                Asset::new('/js/ckeditor.js')
                    ->onlyOnForms()
            )
            ->addJsFile(
                Asset::new('/js/initCKEditor.js')
                    ->defer()
                    ->onlyOnForms()
            )
        ;
    }
    
    public function configureCrud(Crud $crud): Crud
    {
        if (!is_null($this->region)) {
            return $crud
                ->setPageTitle('index', $this->region)
            ;
        } else {
            return $crud;
        }
    }

    public function configureFields(string $pageName): iterable
    {
        if ($this->isGranted('ROLE_SUPER_ADMIN') && is_null($this->region)) {
            yield IdField::new('id')
                ->onlyOnIndex()
            ;
            yield AssociationField::new('region');
            yield ArrayField::new('tag')
                ->hideOnForm()
            ;
            yield AssociationField::new('tag')
                ->onlyOnForms()
                ->setRequired(true)
            ;
            yield TextareaField::new('body')
                ->onlyOnForms()
            ;
            yield DateTimeField::new('createdAt')
                ->onlyOnIndex()
            ;
        }
        
        yield TextField::new('title');
        if (!is_null($this->query->get('img'))) {
            yield ImageField::new('img')
                ->onlyOnIndex()
                ->setBasePath('img/')
                ->setUploadDir('public/img/')
            ;
            yield VichImageField::new('imageFile', 'Img')
                ->hideOnIndex()
            ;
        }
        if (!is_null($this->query->get('tag'))) {
            yield ArrayField::new('tag')
                ->hideOnForm()
            ;
            if ($this->query->get('tag') === 'nodash') {
                $where = "not like '%-%'";
            } else {
                $where = "like '{$this->query->get('tag')}-%'";
            }
            yield AssociationField::new('tag')
                ->onlyOnForms()
                ->setRequired(true)
                ->setQueryBuilder(
                    fn (QueryBuilder $qb) => $qb
                        ->andWhere("entity.label {$where}")
                )
            ;
        }
        $summary_label = null;
        if (!is_null($this->query->get('summary'))) {
            $summary_label = $this->query->get('summary');
        }
        yield TextareaField::new('summary', $summary_label)
            // ->setMaxLength(15)
        ;
        if (!is_null($this->query->get('body'))) {
            yield TextareaField::new('body', $this->query->get('body'))
                ->onlyOnForms()
            ;
            yield DateTimeField::new('createdAt')
                ->onlyOnIndex()
            ;
        }
        yield AssociationField::new('language');
    }
}
