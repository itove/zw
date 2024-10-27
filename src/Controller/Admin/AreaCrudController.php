<?php

namespace App\Controller\Admin;

use App\Entity\Area;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;

class AreaCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Area::class;
    }

    /*
    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id'),
            TextField::new('title'),
            TextEditorField::new('description'),
        ];
    }
    */

    public function configureFields(string $pageName): iterable
    {
        $disabled = false;
        if ($pageName == 'edit') {
            // if ($_ENV['APP_ENV'] === 'prod') {
            if (!$this->isGranted('ROLE_SUPER_ADMIN')) {
                $disabled = true;
            }
        }

        yield TextField::new('name');
        yield TextField::new('label')
            ->setDisabled($disabled)
            ->setRequired(false)
        ;
    }
}
