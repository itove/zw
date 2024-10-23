<?php

namespace App\DataFixtures;

use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
Use App\Entity\Node;
use Doctrine\Bundle\FixturesBundle\FixtureGroupInterface;

class PriceFixtures extends Fixture implements FixtureGroupInterface
{
    public function load(ObjectManager $manager): void
    {
        $nodes = $manager->getRepository(Node::class)->findAll();

        foreach($nodes as $n){
            $n->setPrice(rand(49, 200));
        }

        $manager->flush();
    }

    public static function getGroups(): array
    {
        return ['price'];
    }
}
