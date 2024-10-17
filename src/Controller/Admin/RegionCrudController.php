<?php

namespace App\Controller\Admin;

use App\Entity\Region;
use App\Entity\Node;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\BooleanField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ChoiceField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateTimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ArrayField;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use App\Service\Data;

use EasyCorp\Bundle\EasyAdminBundle\Config\Crud;

class RegionCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Region::class;
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
        yield AssociationField::new('page')
            ->setDisabled($disabled)
        ;
        if ($this->isGranted('ROLE_SUPER_ADMIN')) {
            yield IntegerField::new('weight');
        }
        yield TextField::new('name');
        yield TextField::new('label')
            ->setDisabled($disabled)
            ->setRequired(false)
        ;
        yield TextField::new('icon');
        yield TextField::new('description');
        yield ChoiceField::new('fields')->setChoices(Data::GetProperties(new Node()))->allowMultipleChoices();
        yield IntegerField::new('count');
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
            ->setDefaultSort(['page' => 'ASC', 'weight' => 'ASC', 'id' => 'DESC'])
        ;
    }
}
