<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @version
 * @todo
 */

namespace App\EventListener;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use App\Entity\Tag;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\Bundle\DoctrineBundle\Attribute\AsEntityListener;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\ORM\Events;
use Overtrue\Pinyin\Pinyin;

#[AsEntityListener(event: Events::prePersist, entity: Tag::class)]
// #[AsEntityListener(event: Events::postPersist, entity: Tag::class)]
#[AsEntityListener(event: Events::preUpdate, entity: Tag::class)]
class TagListener extends AbstractController
{
    public function prePersist(Tag $tag, LifecycleEventArgs $event): void
    {
        if(is_null($tag->getLabel())){
            $label = Pinyin::permalink($tag->getName(), '');
            $tag->setLabel($label);
        }
    }

    public function preUpdate(Tag $tag, PreUpdateEventArgs $event): void
    {

        if (is_null($tag->getLabel())) {
            $label = Pinyin::permalink($tag->getName(), '');
            $tag->setLabel($label);
        }
    }
}
