<?php

namespace App\Controller\Admin;

use App\Entity\Category;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;

class CategoryCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Category::class;
    }
    
    /**
    public function configureActions(Actions $actions): Actions
    {
        // IDs less than 100 are reserved for system use
        return $actions
            ->update('index', 'delete', 
            fn (Action $action) => $action
                ->displayIf(fn ($entity) => $entity->getId() >= 100))
            ;
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
