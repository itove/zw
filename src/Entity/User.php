<?php

namespace App\Entity;

use App\Repository\UserRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;

#[ORM\Entity(repositoryClass: UserRepository::class)]
#[ORM\Table(name: '`user`')]
#[UniqueEntity('username')]
class User implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 180, unique: true)]
    private ?string $username = null;

    #[ORM\Column]
    private array $roles = [];

    /**
     * @var string The hashed password
     */
    #[ORM\Column]
    private ?string $password = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $plainPassword = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $openid = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $name = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $phone = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $avatar = null;

    #[ORM\OneToMany(mappedBy: 'consumer', targetEntity: Order::class)]
    private Collection $orders;

    /**
     * @var Collection<int, Comment>
     */
    #[ORM\OneToMany(mappedBy: 'author', targetEntity: Comment::class, orphanRemoval: true)]
    private Collection $comments;

    /**
     * @var Collection<int, Node>
     */
    #[ORM\OneToMany(mappedBy: 'author', targetEntity: Node::class)]
    private Collection $nodes;

    /**
     * @var Collection<int, Fav>
     */
    #[ORM\OneToMany(mappedBy: 'u', targetEntity: Fav::class, orphanRemoval: true)]
    private Collection $favs;

    /**
     * @var Collection<int, Like>
     */
    #[ORM\OneToMany(mappedBy: 'u', targetEntity: Like::class, orphanRemoval: true)]
    private Collection $likes;

    /**
     * @var Collection<int, Up>
     */
    #[ORM\OneToMany(mappedBy: 'u', targetEntity: Up::class, orphanRemoval: true)]
    private Collection $ups;

    /**
     * @var Collection<int, Down>
     */
    #[ORM\OneToMany(mappedBy: 'u', targetEntity: Down::class, orphanRemoval: true)]
    private Collection $downs;

    /**
     * @var Collection<int, Rate>
     */
    #[ORM\OneToMany(mappedBy: 'u', targetEntity: Rate::class, orphanRemoval: true)]
    private Collection $rates;

    public function __construct()
    {
        $this->orders = new ArrayCollection();
        $this->comments = new ArrayCollection();
        $this->nodes = new ArrayCollection();
        $this->favs = new ArrayCollection();
        $this->likes = new ArrayCollection();
        $this->ups = new ArrayCollection();
        $this->downs = new ArrayCollection();
        $this->rates = new ArrayCollection();
    }
    
    public function __toString(): string
    {
        $s = $this->name;
        if (is_null($s)) {
            $s = $this->username;
        }

        return $s;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUsername(): ?string
    {
        return $this->username;
    }

    public function setUsername(string $username): static
    {
        $this->username = $username;

        return $this;
    }

    /**
     * A visual identifier that represents this user.
     *
     * @see UserInterface
     */
    public function getUserIdentifier(): string
    {
        return (string) $this->username;
    }

    /**
     * @see UserInterface
     */
    public function getRoles(): array
    {
        $roles = $this->roles;
        // guarantee every user at least has ROLE_USER
        $roles[] = 'ROLE_USER';

        return array_unique($roles);
    }

    public function setRoles(array $roles): static
    {
        $this->roles = $roles;

        return $this;
    }

    /**
     * @see PasswordAuthenticatedUserInterface
     */
    public function getPassword(): string
    {
        return $this->password;
    }

    public function setPassword(string $password): static
    {
        $this->password = $password;

        return $this;
    }

    /**
     * @see UserInterface
     */
    public function eraseCredentials(): void
    {
        // If you store any temporary, sensitive data on the user, clear it here
        $this->plainPassword = null;
    }

    public function getPlainPassword(): ?string
    {
        return $this->plainPassword;
    }

    public function setPlainPassword(?string $plainPassword): static
    {
        $this->plainPassword = $plainPassword;

        return $this;
    }

    public function getOpenid(): ?string
    {
        return $this->openid;
    }

    public function setOpenid(?string $openid): static
    {
        $this->openid = $openid;

        return $this;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(?string $name): static
    {
        $this->name = $name;

        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): static
    {
        $this->phone = $phone;

        return $this;
    }

    public function getAvatar(): ?string
    {
        return $this->avatar;
    }

    public function setAvatar(?string $avatar): static
    {
        $this->avatar = $avatar;

        return $this;
    }

    /**
     * @return Collection<int, Order>
     */
    public function getOrders(): Collection
    {
        return $this->orders;
    }

    public function addOrder(Order $order): static
    {
        if (!$this->orders->contains($order)) {
            $this->orders->add($order);
            $order->setConsumer($this);
        }

        return $this;
    }

    public function removeOrder(Order $order): static
    {
        if ($this->orders->removeElement($order)) {
            // set the owning side to null (unless already changed)
            if ($order->getConsumer() === $this) {
                $order->setConsumer(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Comment>
     */
    public function getComments(): Collection
    {
        return $this->comments;
    }

    public function addComment(Comment $comment): static
    {
        if (!$this->comments->contains($comment)) {
            $this->comments->add($comment);
            $comment->setAuthor($this);
        }

        return $this;
    }

    public function removeComment(Comment $comment): static
    {
        if ($this->comments->removeElement($comment)) {
            // set the owning side to null (unless already changed)
            if ($comment->getAuthor() === $this) {
                $comment->setAuthor(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Node>
     */
    public function getNodes(): Collection
    {
        return $this->nodes;
    }

    public function addNode(Node $node): static
    {
        if (!$this->nodes->contains($node)) {
            $this->nodes->add($node);
            $node->setAuthor($this);
        }

        return $this;
    }

    public function removeNode(Node $node): static
    {
        if ($this->nodes->removeElement($node)) {
            // set the owning side to null (unless already changed)
            if ($node->getAuthor() === $this) {
                $node->setAuthor(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Fav>
     */
    public function getFavs(): Collection
    {
        return $this->favs;
    }

    public function addFav(Fav $fav): static
    {
        if (!$this->favs->contains($fav)) {
            $this->favs->add($fav);
            $fav->setU($this);
        }

        return $this;
    }

    public function removeFav(Fav $fav): static
    {
        if ($this->favs->removeElement($fav)) {
            // set the owning side to null (unless already changed)
            if ($fav->getU() === $this) {
                $fav->setU(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Like>
     */
    public function getLikes(): Collection
    {
        return $this->likes;
    }

    public function addLike(Like $like): static
    {
        if (!$this->likes->contains($like)) {
            $this->likes->add($like);
            $like->setU($this);
        }

        return $this;
    }

    public function removeLike(Like $like): static
    {
        if ($this->likes->removeElement($like)) {
            // set the owning side to null (unless already changed)
            if ($like->getU() === $this) {
                $like->setU(null);
            }
        }

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
            $up->setU($this);
        }

        return $this;
    }

    public function removeUp(Up $up): static
    {
        if ($this->ups->removeElement($up)) {
            // set the owning side to null (unless already changed)
            if ($up->getU() === $this) {
                $up->setU(null);
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
            $down->setU($this);
        }

        return $this;
    }

    public function removeDown(Down $down): static
    {
        if ($this->downs->removeElement($down)) {
            // set the owning side to null (unless already changed)
            if ($down->getU() === $this) {
                $down->setU(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Rate>
     */
    public function getRates(): Collection
    {
        return $this->rates;
    }

    public function addRate(Rate $rate): static
    {
        if (!$this->rates->contains($rate)) {
            $this->rates->add($rate);
            $rate->setU($this);
        }

        return $this;
    }

    public function removeRate(Rate $rate): static
    {
        if ($this->rates->removeElement($rate)) {
            // set the owning side to null (unless already changed)
            if ($rate->getU() === $this) {
                $rate->setU(null);
            }
        }

        return $this;
    }
}
