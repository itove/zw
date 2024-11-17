<?php

namespace App\Controller\Admin;

use App\Entity\Comment;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DatetimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\BooleanField;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;

class CommentCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Comment::class;
    }

    public function configureFields(string $pageName): iterable
    {
        $disabled = false;
        if ($pageName == 'edit') {
            if (!$this->isGranted('ROLE_SUPER_ADMIN') || $_ENV['APP_ENV'] === 'prod') {
                $disabled = true;
            }
        }

        yield IdField::new('id')->onlyOnIndex();
        if ($this->isGranted('ROLE_SUPER_ADMIN')) {
            // yield IntegerField::new('weight');
        }

        yield AssociationField::new('author')->setDisabled($disabled);
        yield AssociationField::new('node')->setDisabled($disabled);
        yield TextareaField::new('body')->setDisabled($disabled);
        yield DatetimeField::new('createdAt')->setDisabled($disabled);
        yield BooleanField::new('approved');
    }

    public function configureActions(Actions $actions): Actions
    {
        if ($_ENV['APP_ENV'] === 'prod' || !$this->isGranted('ROLE_SUPER_ADMIN')) {
            $actions->disable('delete');
        }

        return $actions
            ->disable('new')
            ->add('index', 'detail')
            ->remove('index', 'edit')
        ;
    }
}
