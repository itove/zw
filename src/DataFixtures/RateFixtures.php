<?php

namespace App\DataFixtures;

use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use App\Entity\Rate;
use App\Entity\Node;
use App\Entity\User;
use Doctrine\Bundle\FixturesBundle\FixtureGroupInterface;

class RateFixtures extends Fixture implements FixtureGroupInterface
{
    public function load(ObjectManager $manager): void
    {
        $nodes = $manager->getRepository(Node::class)->findAll();
        $user = $manager->getRepository(User::class)->find(1);

        foreach($nodes as $n){
            $r = new Rate();
            $r->setNode($n);
            $r->setU($user);
            $r->setRate(rand(45,50) / 10);
            $manager->persist($r);
        }

        $manager->flush();
    }

    public static function getGroups(): array
    {
        return ['rate'];
    }
}
