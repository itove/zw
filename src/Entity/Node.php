<?php

namespace App\Entity;

use App\Repository\NodeRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use Vich\UploaderBundle\Mapping\Annotation as Vich;
use Symfony\Component\HttpFoundation\File\File;

#[Vich\Uploadable]
#[ORM\Entity(repositoryClass: NodeRepository::class)]
class Node
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $title = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $body = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $image = null;

    #[Vich\UploadableField(mapping: 'nodes', fileNameProperty: 'image')]
    #[Assert\Image(maxSize: '5024k', mimeTypes: ['image/jpeg', 'image/png'], mimeTypesMessage: 'Only jpg and png')]
    private ?File $imageFile = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $summary = null;

    #[ORM\ManyToMany(targetEntity: Region::class, inversedBy: 'nodes')]
    private Collection $regions;

    #[ORM\ManyToMany(targetEntity: Tag::class, inversedBy: 'nodes')]
    private Collection $tags;

    #[ORM\ManyToOne(inversedBy: 'nodes')]
    private ?Language $language = null;

    #[ORM\OneToMany(mappedBy: 'node', targetEntity: Spec::class, orphanRemoval: true, cascade: ["persist"])]
    private Collection $specs;

    #[ORM\OneToMany(mappedBy: 'node', targetEntity: Image::class, orphanRemoval: true, cascade: ["persist"])]
    private Collection $images;

    #[ORM\ManyToOne(inversedBy: 'nodes')]
    private ?Category $category = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $video = null;

    #[Vich\UploadableField(mapping: 'nodes', fileNameProperty: 'video')]
    #[Assert\File(maxSize: '524000k', extensions: ['mp4'], extensionsMessage: 'Only mp4')]
    private ?File $videoFile = null;

    #[ORM\ManyToOne(targetEntity: self::class, inversedBy: 'children')]
    private ?self $parent = null;

    #[ORM\OneToMany(mappedBy: 'parent', targetEntity: self::class)]
    private Collection $children;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $audio = null;

    #[Vich\UploadableField(mapping: 'nodes', fileNameProperty: 'audio')]
    #[Assert\File(maxSize: '524000k', extensions: ['mp3'], extensionsMessage: 'Only mp3')]
    private ?File $audioFile = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $qr = null;

    #[Vich\UploadableField(mapping: 'nodes', fileNameProperty: 'qr')]
    #[Assert\Image(maxSize: '5024k', mimeTypes: ['image/jpeg', 'image/png'], mimeTypesMessage: 'Only jpg and png')]
    private ?File $qrFile = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $phone = null;

    #[ORM\Column(nullable: true)]
    #[Assert\Range(min: -90, max: 90)]
    private ?float $latitude = null;

    #[ORM\Column(nullable: true)]
    #[Assert\Range(min: -180, max: 180)]
    private ?float $longitude = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $address = null;

    #[ORM\Column(nullable: true)]
    private ?int $price = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $createdAt = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $updatedAt = null;

    /**
     * @var Collection<int, Comment>
     */
    #[ORM\OneToMany(mappedBy: 'node', targetEntity: Comment::class)]
    #[ORM\OrderBy(["id" => "DESC"])]
    private Collection $comments;

    #[ORM\ManyToOne(inversedBy: 'nodes')]
    private ?User $author = null;

    #[ORM\Column(nullable: true)]
    private ?bool $deleted = false;

    /**
     * @var Collection<int, Fav>
     */
    #[ORM\OneToMany(mappedBy: 'node', targetEntity: Fav::class, orphanRemoval: true)]
    private Collection $favs;

    /**
     * @var Collection<int, Like>
     */
    #[ORM\OneToMany(mappedBy: 'node', targetEntity: Like::class, orphanRemoval: true)]
    private Collection $likes;

    /**
     * @var Collection<int, Up>
     */
    #[ORM\OneToMany(mappedBy: 'node', targetEntity: Up::class, orphanRemoval: true)]
    private Collection $ups;

    /**
     * @var Collection<int, Down>
     */
    #[ORM\OneToMany(mappedBy: 'node', targetEntity: Down::class, orphanRemoval: true)]
    private Collection $downs;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $marker = null;

    #[Vich\UploadableField(mapping: 'nodes', fileNameProperty: 'marker')]
    #[Assert\Image(maxSize: '5024k', mimeTypes: ['image/jpeg', 'image/png'], mimeTypesMessage: 'Only jpg and png')]
    private ?File $markerFile = null;

    /**
     * @var Collection<int, Rate>
     */
    #[ORM\OneToMany(mappedBy: 'node', targetEntity: Rate::class, orphanRemoval: true)]
    private Collection $rates;

    #[ORM\Column(nullable: true)]
    private ?\DateTimeImmutable $startAt = null;

    #[ORM\Column(nullable: true)]
    private ?\DateTimeImmutable $endAt = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $note = null;

    #[ORM\ManyToOne(inversedBy: 'nodes')]
    private ?Area $area = null;

    #[ORM\OneToOne(mappedBy: 'node', cascade: ['persist', 'remove'])]
    private ?Plan $plan = null;

    #[ORM\Column(nullable: true)]
    private ?bool $published = null;

    #[ORM\Column(type: Types::SMALLINT, nullable: true)]
    private ?int $weight = 0;

    public function __construct()
    {
        $this->regions = new ArrayCollection();
        $this->tags = new ArrayCollection();
        $this->createdAt = new \DateTimeImmutable();
        $this->updatedAt = new \DateTimeImmutable();
        $this->specs = new ArrayCollection();
        $this->images = new ArrayCollection();
        $this->children = new ArrayCollection();
        $this->comments = new ArrayCollection();
        $this->favs = new ArrayCollection();
        $this->likes = new ArrayCollection();
        $this->ups = new ArrayCollection();
        $this->downs = new ArrayCollection();
        $this->rates = new ArrayCollection();
    }

    public function __toString()
    {
        return $this->title;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): static
    {
        $this->title = $title;

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

    public function getBody(): ?string
    {
        return $this->body;
    }

    public function setBody(?string $body): static
    {
        $this->body = $body;

        return $this;
    }

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(?string $image): static
    {
        $this->image = $image;

        return $this;
    }

    public function getSummary(): ?string
    {
        return $this->summary;
    }

    public function setSummary(?string $summary): static
    {
        $this->summary = $summary;

        return $this;
    }

    /**
     * @return Collection<int, Region>
     */
    public function getRegions(): Collection
    {
        return $this->regions;
    }

    public function addRegion(Region $region): static
    {
        if (!$this->regions->contains($region)) {
            $this->regions->add($region);
        }

        return $this;
    }

    public function removeRegion(Region $region): static
    {
        $this->regions->removeElement($region);

        return $this;
    }

    /**
     * @return Collection<int, Tag>
     */
    public function getTags(): Collection
    {
        return $this->tags;
    }

    public function addTag(Tag $tag): static
    {
        if (!$this->tags->contains($tag)) {
            $this->tags->add($tag);
        }

        return $this;
    }

    public function removeTag(Tag $tag): static
    {
        $this->tags->removeElement($tag);

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeImmutable
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeImmutable $updatedAt): static
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getLanguage(): ?Language
    {
        return $this->language;
    }

    public function setLanguage(?Language $language): static
    {
        $this->language = $language;

        return $this;
    }
    
    public function setImageFile(?File $imageFile = null): void
    {
        $this->imageFile = $imageFile;

        if (null !== $imageFile) {
            // It is required that at least one field changes if you are using doctrine
            // otherwise the event listeners won't be called and the file is lost
            $this->updatedAt = new \DateTimeImmutable();
        }
    }

    public function getImageFile(): ?File
    {
        return $this->imageFile;
    }

    public function setVideoFile(?File $videoFile = null): void
    {
        $this->videoFile = $videoFile;

        if (null !== $videoFile) {
            // It is required that at least one field changes if you are using doctrine
            // otherwise the event listeners won't be called and the file is lost
            $this->updatedAt = new \DateTimeImmutable();
        }
    }

    public function getVideoFile(): ?File
    {
        return $this->videoFile;
    }

    public function setAudioFile(?File $audioFile = null): void
    {
        $this->audioFile = $audioFile;

        if (null !== $audioFile) {
            // It is required that at least one field changes if you are using doctrine
            // otherwise the event listeners won't be called and the file is lost
            $this->updatedAt = new \DateTimeImmutable();
        }
    }

    public function getAudioFile(): ?File
    {
        return $this->audioFile;
    }

    /**
     * @return Collection<int, Spec>
     */
    public function getSpecs(): Collection
    {
        return $this->specs;
    }

    public function addSpec(Spec $spec): static
    {
        if (!$this->specs->contains($spec)) {
            $this->specs->add($spec);
            $spec->setNode($this);
        }

        return $this;
    }

    public function removeSpec(Spec $spec): static
    {
        if ($this->specs->removeElement($spec)) {
            // set the owning side to null (unless already changed)
            if ($spec->getNode() === $this) {
                $spec->setNode(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Image>
     */
    public function getImages(): Collection
    {
        return $this->images;
    }

    public function addImage(Image $image): static
    {
        if (!$this->images->contains($image)) {
            $this->images->add($image);
            $image->setNode($this);
        }

        return $this;
    }

    public function removeImage(Image $image): static
    {
        if ($this->images->removeElement($image)) {
            // set the owning side to null (unless already changed)
            if ($image->getNode() === $this) {
                $image->setNode(null);
            }
        }

        return $this;
    }

    public function getCategory(): ?Category
    {
        return $this->category;
    }

    public function setCategory(?Category $category): static
    {
        $this->category = $category;

        return $this;
    }

    public function getVideo(): ?string
    {
        return $this->video;
    }

    public function setVideo(?string $video): static
    {
        $this->video = $video;

        return $this;
    }

    public function getParent(): ?self
    {
        return $this->parent;
    }

    public function setParent(?self $parent): static
    {
        $this->parent = $parent;

        return $this;
    }

    /**
     * @return Collection<int, self>
     */
    public function getChildren(): Collection
    {
        return $this->children;
    }

    public function addChild(self $child): static
    {
        if (!$this->children->contains($child)) {
            $this->children->add($child);
            $child->setParent($this);
        }

        return $this;
    }

    public function removeChild(self $child): static
    {
        if ($this->children->removeElement($child)) {
            // set the owning side to null (unless already changed)
            if ($child->getParent() === $this) {
                $child->setParent(null);
            }
        }

        return $this;
    }

    public function getAudio(): ?string
    {
        return $this->audio;
    }

    public function setAudio(?string $audio): static
    {
        $this->audio = $audio;

        return $this;
    }

    public function getQr(): ?string
    {
        return $this->qr;
    }

    public function setQr(?string $qr): static
    {
        $this->qr = $qr;

        return $this;
    }
    
    public function setQrFile(?File $qrFile = null): void
    {
        $this->qrFile = $qrFile;

        if (null !== $qrFile) {
            // It is required that at least one field changes if you are using doctrine
            // otherwise the event listeners won't be called and the file is lost
            $this->updatedAt = new \DateTimeImmutable();
        }
    }

    public function getQrFile(): ?File
    {
        return $this->qrFile;
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

    public function getLatitude(): ?float
    {
        return $this->latitude;
    }

    public function setLatitude(?float $latitude): static
    {
        $this->latitude = $latitude;

        return $this;
    }

    public function getLongitude(): ?float
    {
        return $this->longitude;
    }

    public function setLongitude(?float $longitude): static
    {
        $this->longitude = $longitude;

        return $this;
    }

    public function getCoord(): ?array
    {
        return [$this->latitude, $this->longitude];
    }

    public function getAddress(): ?string
    {
        return $this->address;
    }

    public function setAddress(?string $address): static
    {
        $this->address = $address;

        return $this;
    }

    public function getPrice(): ?int
    {
        return $this->price;
    }

    public function setPrice(?int $price): static
    {
        $this->price = $price;

        return $this;
    }

    /**
     * @return Collection<int, Comment>
     */
    public function getComments(): Collection
    {
        return $this->comments
            ->filter(function($c) {
                return $c->isApproved();
            })
        ;
    }

    public function addComment(Comment $comment): static
    {
        if (!$this->comments->contains($comment)) {
            $this->comments->add($comment);
            $comment->setNode($this);
        }

        return $this;
    }

    public function removeComment(Comment $comment): static
    {
        if ($this->comments->removeElement($comment)) {
            // set the owning side to null (unless already changed)
            if ($comment->getNode() === $this) {
                $comment->setNode(null);
            }
        }

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

    public function isDeleted(): ?bool
    {
        return $this->deleted;
    }

    public function setDeleted(?bool $deleted): static
    {
        $this->deleted = $deleted;

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
            $fav->setNode($this);
        }

        return $this;
    }

    public function removeFav(Fav $fav): static
    {
        if ($this->favs->removeElement($fav)) {
            // set the owning side to null (unless already changed)
            if ($fav->getNode() === $this) {
                $fav->setNode(null);
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
            $like->setNode($this);
        }

        return $this;
    }

    public function removeLike(Like $like): static
    {
        if ($this->likes->removeElement($like)) {
            // set the owning side to null (unless already changed)
            if ($like->getNode() === $this) {
                $like->setNode(null);
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
            $up->setNode($this);
        }

        return $this;
    }

    public function removeUp(Up $up): static
    {
        if ($this->ups->removeElement($up)) {
            // set the owning side to null (unless already changed)
            if ($up->getNode() === $this) {
                $up->setNode(null);
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
            $down->setNode($this);
        }

        return $this;
    }

    public function removeDown(Down $down): static
    {
        if ($this->downs->removeElement($down)) {
            // set the owning side to null (unless already changed)
            if ($down->getNode() === $this) {
                $down->setNode(null);
            }
        }

        return $this;
    }

    public function getMarker(): ?string
    {
        return $this->marker;
    }

    public function setMarker(?string $marker): static
    {
        $this->marker = $marker;

        return $this;
    }
    
    public function setMarkerFile(?File $markerFile = null): void
    {
        $this->markerFile = $markerFile;

        if (null !== $markerFile) {
            // It is required that at least one field changes if you are using doctrine
            // otherwise the event listeners won't be called and the file is lost
            $this->updatedAt = new \DateTimeImmutable();
        }
    }

    public function getMarkerFile(): ?File
    {
        return $this->markerFile;
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
            $rate->setNode($this);
        }

        return $this;
    }

    public function removeRate(Rate $rate): static
    {
        if ($this->rates->removeElement($rate)) {
            // set the owning side to null (unless already changed)
            if ($rate->getNode() === $this) {
                $rate->setNode(null);
            }
        }

        return $this;
    }

    public function getStartAt(): ?\DateTimeImmutable
    {
        return $this->startAt;
    }

    public function setStartAt(?\DateTimeImmutable $startAt): static
    {
        $this->startAt = $startAt;

        return $this;
    }

    public function getEndAt(): ?\DateTimeImmutable
    {
        return $this->endAt;
    }

    public function setEndAt(?\DateTimeImmutable $endAt): static
    {
        $this->endAt = $endAt;

        return $this;
    }

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): static
    {
        $this->note = $note;

        return $this;
    }

    public function getArea(): ?Area
    {
        return $this->area;
    }

    public function setArea(?Area $area): static
    {
        $this->area = $area;

        return $this;
    }

    public function getPlan(): ?Plan
    {
        return $this->plan;
    }

    public function setPlan(?Plan $plan): static
    {
        // unset the owning side of the relation if necessary
        if ($plan === null && $this->plan !== null) {
            $this->plan->setNode(null);
        }

        // set the owning side of the relation if necessary
        if ($plan !== null && $plan->getNode() !== $this) {
            $plan->setNode($this);
        }

        $this->plan = $plan;

        return $this;
    }

    public function isPublished(): ?bool
    {
        return $this->published;
    }

    public function setPublished(?bool $published): static
    {
        $this->published = $published;

        return $this;
    }

    public function getWeight(): ?int
    {
        return $this->weight;
    }

    public function setWeight(?int $weight): static
    {
        $this->weight = $weight;

        return $this;
    }
}
