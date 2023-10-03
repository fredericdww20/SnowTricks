<?php

namespace App\Entity;

use App\Repository\CategoriesRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CategoriesRepository::class)]
class Categories
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\OneToMany(mappedBy: 'categories', targetEntity: Figure::class, orphanRemoval: true)]
    private Collection $figure;

    public function __construct()
    {
        $this->figure = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): static
    {
        $this->name = $name;

        return $this;
    }

    /**
     * @return Collection<int, Figure>
     */
    public function getFigure(): Collection
    {
        return $this->figure;
    }

    public function addFigure(Figure $figure): static
    {
        if (!$this->figure->contains($figure)) {
            $this->figure->add($figure);
            $figure->setCategories($this);
        }

        return $this;
    }

    public function removeFigure(Figure $figure): static
    {
        if ($this->figure->removeElement($figure)) {
            // set the owning side to null (unless already changed)
            if ($figure->getCategories() === $this) {
                $figure->setCategories(null);
            }
        }

        return $this;
    }

    public function __toString() {
        return $this->name;
    }
}
