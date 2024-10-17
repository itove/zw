<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @version
 * @todo
 */

namespace App\EventListener;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use App\Entity\Menu;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\Bundle\DoctrineBundle\Attribute\AsEntityListener;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\ORM\Events;
use Overtrue\Pinyin\Pinyin;

#[AsEntityListener(event: Events::prePersist, entity: Menu::class)]
// #[AsEntityListener(event: Events::postPersist, entity: Menu::class)]
#[AsEntityListener(event: Events::preUpdate, entity: Menu::class)]
class MenuListener extends AbstractController
{
    public function prePersist(Menu $menu, LifecycleEventArgs $event): void
    {
        if(is_null($menu->getLabel())){
            $label = Pinyin::permalink($menu->getName(), '');
            $menu->setLabel($label);
        }
    }

    public function preUpdate(Menu $menu, PreUpdateEventArgs $event): void
    {

        if (is_null($menu->getLabel())) {
            $label = Pinyin::permalink($menu->getName(), '');
            $menu->setLabel($label);
        }
    }
}
