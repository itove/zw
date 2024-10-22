<?php

namespace App\Entity;

use App\Repository\DownRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: DownRepository::class)]
class Down
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'downs')]
    private ?Node $node = null;

    #[ORM\ManyToOne(inversedBy: 'downs')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $u = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $createdAt = null;

    #[ORM\ManyToOne(inversedBy: 'downs')]
    private ?Comment $comment = null;

    public function __construct()
    {
        $this->createdAt = new \DateTimeImmutable();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNode(): ?Node
    {
        return $this->node;
    }

    public function setNode(?Node $node): static
    {
        $this->node = $node;

        return $this;
    }

    public function getU(): ?User
    {
        return $this->u;
    }

    public function setU(?User $u): static
    {
        $this->u = $u;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeImmutable
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeImmutable $createdAt): static
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getComment(): ?Comment
    {
        return $this->comment;
    }

    public function setComment(?Comment $comment): static
    {
        $this->comment = $comment;

        return $this;
    }
}
