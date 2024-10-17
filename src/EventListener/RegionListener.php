<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @version
 * @todo
 */

namespace App\EventListener;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use App\Entity\Region;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\Bundle\DoctrineBundle\Attribute\AsEntityListener;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\ORM\Events;
use Overtrue\Pinyin\Pinyin;

#[AsEntityListener(event: Events::prePersist, entity: Region::class)]
// #[AsEntityListener(event: Events::postPersist, entity: Region::class)]
#[AsEntityListener(event: Events::preUpdate, entity: Region::class)]
class RegionListener extends AbstractController
{
    public function prePersist(Region $region, LifecycleEventArgs $event): void
    {
        if(is_null($region->getLabel())){
            $label = Pinyin::permalink($region->getName(), '');
            $region->setLabel($label);
        }
    }

    public function preUpdate(Region $region, PreUpdateEventArgs $event): void
    {

        if (is_null($region->getLabel())) {
            $label = Pinyin::permalink($region->getName(), '');
            $region->setLabel($label);
        }
    }
}
