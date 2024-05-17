<?php

namespace App\Controller\Admin;

use App\Entity\Tag;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

class TagCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Tag::class;
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
            $disabled = true;
        }

        yield TextField::new('name');
        yield TextField::new('label')->setDisabled($disabled);
    }
}
