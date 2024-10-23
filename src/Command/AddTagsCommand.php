<?php

namespace App\Command;

use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use App\Entity\Tag;
use App\Entity\Node;
use Doctrine\ORM\EntityManagerInterface;

#[AsCommand(
    name: 'addTags',
    description: 'Add random tags to all node.',
)]
class AddTagsCommand extends Command
{
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            // ->addArgument('username', InputArgument::REQUIRED, 'Username')
            // ->addArgument('password', InputArgument::REQUIRED, 'Password')
            // ->addOption('super', 's', InputOption::VALUE_NONE, 'Is super')
            // ->addOption('admin', 'a', InputOption::VALUE_NONE, 'Is admin')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        
        $nodes = $this->em->getRepository(Node::class)->findAll();
        $tags = $this->em->getRepository(Tag::class)->findAll();
        // dump($nodes);
        
        foreach($nodes as $n) {
            foreach($n->getTags() as $t) {
                $n->removeTag($t);
            }

            shuffle($tags);
            for ($i = 0; $i < 5; $i++) {
                $n->addTag($tags[$i]);
            }
        }

        $this->em->flush();

        return Command::SUCCESS;
    }
}
