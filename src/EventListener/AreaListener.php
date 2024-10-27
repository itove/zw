<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @version
 * @todo
 */

namespace App\EventListener;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use App\Entity\Area;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\Bundle\DoctrineBundle\Attribute\AsEntityListener;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\ORM\Events;
use Overtrue\Pinyin\Pinyin;

#[AsEntityListener(event: Events::prePersist, entity: Area::class)]
// #[AsEntityListener(event: Events::postPersist, entity: Area::class)]
#[AsEntityListener(event: Events::preUpdate, entity: Area::class)]
class AreaListener extends AbstractController
{
    public function prePersist(Area $area, LifecycleEventArgs $event): void
    {
        if(is_null($area->getLabel())){
            $label = Pinyin::permalink($area->getName(), '');
            $area->setLabel($label);
        }
    }

    public function preUpdate(Area $area, PreUpdateEventArgs $event): void
    {

        if (is_null($area->getLabel())) {
            $label = Pinyin::permalink($area->getName(), '');
            $area->setLabel($label);
        }
    }
}
