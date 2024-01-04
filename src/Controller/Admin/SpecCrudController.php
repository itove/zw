<?php

namespace App\Controller\Admin;

use App\Entity\Spec;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

class SpecCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Spec::class;
    }

    public function configureFields(string $pageName): iterable
    {
        yield TextField::new('name', 'Spec Name');
        yield TextField::new('value', 'Spec Value');
    }
}
