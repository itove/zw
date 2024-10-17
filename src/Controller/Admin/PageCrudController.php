<?php

namespace App\Controller\Admin;

use App\Entity\Page;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;

use EasyCorp\Bundle\EasyAdminBundle\Config\Crud;

// use EasyCorp\Bundle\EasyAdminBundle\Dto\SearchDto;
// use EasyCorp\Bundle\EasyAdminBundle\Dto\EntityDto;
// use EasyCorp\Bundle\EasyAdminBundle\Orm\EntityRepository;
// use EasyCorp\Bundle\EasyAdminBundle\Collection\FieldCollection;
// use EasyCorp\Bundle\EasyAdminBundle\Collection\FilterCollection;
// use Doctrine\ORM\QueryBuilder;

class PageCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Page::class;
    }

    public function configureFields(string $pageName): iterable
    {
        $disabled = false;
        if ($pageName == 'edit') {
            // if ($_ENV['APP_ENV'] === 'prod') {
            if (!$this->isGranted('ROLE_SUPER_ADMIN')) {
                $disabled = true;
            }
        }

        yield IdField::new('id')->onlyOnIndex();
        if ($this->isGranted('ROLE_SUPER_ADMIN')) {
            yield IntegerField::new('weight');
        }

        yield TextField::new('name');
        yield TextField::new('label')
            ->setDisabled($disabled)
            ->setRequired(false)
        ;
        yield AssociationField::new('regions')->setDisabled($disabled);
    }

    public function configureActions(Actions $actions): Actions
    {
        if ($_ENV['APP_ENV'] === 'prod') {
            $actions->disable('delete');
        }

        return $actions;
    }
    
    public function configureCrud(Crud $crud): Crud
    {
        return $crud
            ->setDefaultSort(['weight' => 'ASC', 'id' => 'DESC'])
        ;
    }
    
    // public function createIndexQueryBuilder(SearchDto $searchDto, EntityDto $entityDto, FieldCollection $fields, FilterCollection $filters): QueryBuilder
    // {
    //     $qb = $this->container->get(EntityRepository::class)->createQueryBuilder($searchDto, $entityDto, $fields, $filters);
    //     
    //     $qb
    //         ->orderBy('entity.weight', 'ASC')
    //         ->addOrderBy('entity.id', 'DESC')
    //     ;

    //     return $qb;
    // }
}
