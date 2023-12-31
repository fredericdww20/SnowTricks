<?php

namespace App\Service;

use App\Entity\Figure;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\HttpFoundation\File\UploadedFile;

class TrickManager
{

    public function __construct(
        private readonly EntityManagerInterface $entityManager,
        private readonly ParameterBagInterface $parameterBag,
        private readonly Security $security
    ) {
    }

    public function create(FormInterface $images, Figure $figure): void
    {
        foreach ($images as $upload) {
            $this->uploadImage($upload);
        }

        $figure->setUser($this->security->getUser());

        foreach ($figure->getVideos() as $video) {
            $video->setFigure($figure);
        }

        $this->entityManager->persist($figure);
        $this->entityManager->flush();
    }

    private function uploadImage(FormInterface $image): void
    {
        $model = $image->getData();
        $uploadedImage = $image->get('filename')->getData();
        if ($uploadedImage instanceof UploadedFile) {
            $fileName = md5(uniqid()).'.'.$uploadedImage->getClientOriginalExtension();

            $model->setFilename($fileName);
            $uploadedImage->move($this->parameterBag->get('images_directory'), $fileName);
        }
    }

    /*
     * Mise a jour d'une image
     */
    public function updateImages(FormInterface $images, Figure $figure): void
    {
        foreach ($images as $upload) {
            $this->uploadImage($upload);
        }

        $this->entityManager->persist($figure);
        $this->entityManager->flush();
    }
    /*
     * Mise a jour d'une figure
     */
    public function update(FormInterface $images, Figure $figure): void {
        $figure->setUpdatedAt(new \DateTimeImmutable());
        $this->updateImages($images, $figure);
        $this->entityManager->flush();
    }

    public function addComment(FormInterface $form, Figure $figure): void {
        $commentaire = $form->getData();
        $commentaire->setFigure($figure);
        $commentaire->setAuthor($this->security->getUser());

        $this->entityManager->persist($commentaire);
        $this->entityManager->flush();
    }
}