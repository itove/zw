<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @version
 * @todo
 */

namespace App\EventListener;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use App\Entity\Page;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\Bundle\DoctrineBundle\Attribute\AsEntityListener;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\ORM\Events;
use Overtrue\Pinyin\Pinyin;

#[AsEntityListener(event: Events::prePersist, entity: Page::class)]
// #[AsEntityListener(event: Events::postPersist, entity: Page::class)]
#[AsEntityListener(event: Events::preUpdate, entity: Page::class)]
class PageListener extends AbstractController
{
    public function prePersist(Page $page, LifecycleEventArgs $event): void
    {
        if(is_null($page->getLabel())){
            $label = Pinyin::permalink($page->getName(), '');
            $page->setLabel($label);
        }
    }

    public function preUpdate(Page $page, PreUpdateEventArgs $event): void
    {

        if (is_null($page->getLabel())) {
            $label = Pinyin::permalink($page->getName(), '');
            $page->setLabel($label);
        }
    }
}
