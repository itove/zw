<?php

namespace App\DataFixtures;

use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use App\Entity\Tag;
use App\Entity\Node;
use Doctrine\Bundle\FixturesBundle\FixtureGroupInterface;

class TagFixtures extends Fixture implements FixtureGroupInterface
{
    public function load(ObjectManager $manager): void
    {
        $nodes = $manager->getRepository(Node::class)->findAll();
        $tags = $manager->getRepository(Tag::class)->findAll();
        
        foreach($nodes as $n) {
            foreach($n->getTags() as $t) {
                $n->removeTag($t);
            }

            shuffle($tags);
            for ($i = 0; $i < 5; $i++) {
                $n->addTag($tags[$i]);
            }
        }

        $manager->flush();
    }

    public static function getGroups(): array
    {
        return ['tag'];
    }
}
