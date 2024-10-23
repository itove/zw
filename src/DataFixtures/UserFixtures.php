<?php

namespace App\DataFixtures;

use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use App\Entity\User;

class UserFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $root = new User();
        $root->setUsername('root');
        $root->setPlainPassword('111');
        $root->setRoles(["ROLE_SUPER_ADMIN"]);
        $manager->persist($root);

        $admin = new User();
        $admin->setUsername('admin');
        $admin->setPlainPassword('111');
        $admin->setRoles(["ROLE_ADMIN"]);
        $manager->persist($admin);

        $u = new User();
        $u->setUsername('al');
        $u->setPlainPassword('111');
        $u->setRoles(["ROLE_SUPER_ADMIN"]);
        $u->persist($u);

        $manager->flush();
    }
}
