<?php

namespace App\Controller\Admin;

use App\Entity\Page;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;

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
            if ($_ENV['APP_ENV'] === 'prod') {
                $disabled = true;
            }
        }

        yield TextField::new('name');
        yield TextField::new('label')->setDisabled($disabled);
        yield AssociationField::new('regions')->setDisabled($disabled);
    }

    public function configureActions(Actions $actions): Actions
    {
        if ($_ENV['APP_ENV'] === 'prod') {
            $actions->disable('delete');
        }

        return $actions;
    }
}
