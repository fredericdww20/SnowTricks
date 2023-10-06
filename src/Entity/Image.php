<?php

namespace App\Entity;

use App\Repository\ImageRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\HttpFoundation\File\UploadedFile;

#[ORM\Entity(repositoryClass: ImageRepository::class)]
class Image
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $filename = null;

    #[ORM\ManyToOne(inversedBy: 'image')]
    private ?Figure $figure = null;

    private ?UploadedFile $file = null;


    public function __construct() {
        $this->file = null;

    }
    public function getFile(): ?UploadedFile {
        return $this->file;
    }

    public function setFile(?UploadedFile $file): self {
        $this->file = $file;
        if($file) {
            // It's a file upload, so we generate a unique filename
            $this->filename = md5(uniqid()).'.'.$file->guessExtension();
        }
        return $this;
    }


    public function getId(): ?int
    {
        return $this->id;
    }

    public function getFilename(): ?string
    {
        return $this->filename;
    }

    public function setFilename(?string $filename): static
    {
        $this->filename = $filename;

        return $this;
    }

    public function getFigure(): ?Figure
    {
        return $this->figure;
    }

    public function setFigure(?Figure $figure): static
    {
        $this->figure = $figure;

        return $this;
    }
}
