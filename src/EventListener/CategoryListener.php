<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @version
 * @todo
 */

namespace App\EventListener;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use App\Entity\Category;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\Bundle\DoctrineBundle\Attribute\AsEntityListener;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\ORM\Events;
use Overtrue\Pinyin\Pinyin;

#[AsEntityListener(event: Events::prePersist, entity: Category::class)]
// #[AsEntityListener(event: Events::postPersist, entity: Category::class)]
#[AsEntityListener(event: Events::preUpdate, entity: Category::class)]
class CategoryListener extends AbstractController
{
    public function prePersist(Category $category, LifecycleEventArgs $event): void
    {
        if(is_null($category->getLabel())){
            $label = Pinyin::permalink($category->getName(), '');
            $category->setLabel($label);
        }
    }

    public function preUpdate(Category $category, PreUpdateEventArgs $event): void
    {

        if (is_null($category->getLabel())) {
            $label = Pinyin::permalink($category->getName(), '');
            $category->setLabel($label);
        }
    }
}
