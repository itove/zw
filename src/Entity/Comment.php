<?php

namespace App\Entity;

use App\Repository\CommentRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CommentRepository::class)]
class Comment
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'comments')]
    private ?Node $node = null;

    #[ORM\ManyToOne(inversedBy: 'comments')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $author = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $body = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $createdAt = null;

    #[ORM\Column(options: ["unsigned" => true, "default" => 0])]
    private ?int $up = 0;

    #[ORM\Column(options: ["unsigned" => true, "default" => 0])]
    private ?int $down = 0;

    #[ORM\Column]
    private ?bool $deleted = false;

    /**
     * @var Collection<int, Up>
     */
    #[ORM\OneToMany(mappedBy: 'comment', targetEntity: Up::class)]
    private Collection $ups;

    /**
     * @var Collection<int, Down>
     */
    #[ORM\OneToMany(mappedBy: 'comment', targetEntity: Down::class)]
    private Collection $downs;

    #[ORM\Column(nullable: true)]
    private ?bool $approved = false;

    public function __construct()
    {
        $this->createdAt = new \DateTimeImmutable();
        $this->ups = new ArrayCollection();
        $this->downs = new ArrayCollection();
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

    public function getAuthor(): ?User
    {
        return $this->author;
    }

    public function setAuthor(?User $author): static
    {
        $this->author = $author;

        return $this;
    }

    public function getBody(): ?string
    {
        return $this->body;
    }

    public function setBody(string $body): static
    {
        $this->body = $body;

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

    public function getUp(): ?int
    {
        return $this->up;
    }

    public function setUp(int $up): static
    {
        $this->up = $up;

        return $this;
    }

    public function getDown(): ?int
    {
        return $this->down;
    }

    public function setDown(int $down): static
    {
        $this->down = $down;

        return $this;
    }

    public function isDeleted(): ?bool
    {
        return $this->deleted;
    }

    public function setDeleted(bool $deleted): static
    {
        $this->deleted = $deleted;

        return $this;
    }

    /**
     * @return Collection<int, Up>
     */
    public function getUps(): Collection
    {
        return $this->ups;
    }

    public function addUp(Up $up): static
    {
        if (!$this->ups->contains($up)) {
            $this->ups->add($up);
            $up->setComment($this);
        }

        return $this;
    }

    public function removeUp(Up $up): static
    {
        if ($this->ups->removeElement($up)) {
            // set the owning side to null (unless already changed)
            if ($up->getComment() === $this) {
                $up->setComment(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Down>
     */
    public function getDowns(): Collection
    {
        return $this->downs;
    }

    public function addDown(Down $down): static
    {
        if (!$this->downs->contains($down)) {
            $this->downs->add($down);
            $down->setComment($this);
        }

        return $this;
    }

    public function removeDown(Down $down): static
    {
        if ($this->downs->removeElement($down)) {
            // set the owning side to null (unless already changed)
            if ($down->getComment() === $this) {
                $down->setComment(null);
            }
        }

        return $this;
    }

    public function isApproved(): ?bool
    {
        return $this->approved;
    }

    public function setApproved(?bool $approved): static
    {
        $this->approved = $approved;

        return $this;
    }
}
