<?php

namespace App\Service;

use App\Entity\Figure;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\File\Exception\FileException;

class TrickManager
{
    public function __construct(
        private readonly EntityManagerInterface $entityManager,
        private readonly ParameterBagInterface $parameterBag,
        private readonly Security $security
    ) {
    }

    /*
     * Création d'une figure
     */
    public function create(FormInterface $images, Figure $figure): void
    {
        try {
            foreach ($images as $upload) {
                $this->uploadImage($upload);
            }

            $figure->setUser($this->security->getUser());

            foreach ($figure->getVideos() as $video) {
                $video->setFigure($figure);
            }

            $this->entityManager->persist($figure);
            $this->entityManager->flush();
        } catch (\Exception $e) {
            // Gérer les exceptions

        }
    }

    /*
     * Upload d'une image
     */
    private function uploadImage(FormInterface $image): void
    {
        $model = $image->getData();
        $uploadedImage = $image->get('filename')->getData();

        if ($uploadedImage instanceof UploadedFile) {
            $fileName = md5(uniqid()).'.'.$uploadedImage->getClientOriginalExtension();

            try {
                $model->setFilename($fileName);
                $uploadedImage->move($this->parameterBag->get('images_directory'), $fileName);
            } catch (FileException $e) {
                // Gérer les erreurs liées au déplacement du fichier
                throw new \RuntimeException('Impossible de déplacer le fichier téléchargé');
            }
        }
    }

    /*
     * Mise à jour des images
     */
    public function updateImages(FormInterface $images, Figure $figure): void
    {
        try {
            foreach ($images as $upload) {
                $this->uploadImage($upload);
            }

            $this->entityManager->persist($figure);
            $this->entityManager->flush();
        } catch (\Exception $e) {
            // Gérer les exceptions
        }
    }

    /*
     * Mise à jour d'une figure
     */
    public function update(FormInterface $images, Figure $figure): void
    {
        try {
            $figure->setUpdatedAt(new \DateTimeImmutable());
            $this->updateImages($images, $figure);
            $this->entityManager->flush();
        } catch (\Exception $e) {
            // Gérer les exceptions
        }
    }

    /*
     * Ajout d'un commentaire
     */
    public function addComment(FormInterface $form, Figure $figure): void
    {
        try {
            $commentaire = $form->getData();
            $commentaire->setFigure($figure);
            $commentaire->setAuthor($this->security->getUser());

            $this->entityManager->persist($commentaire);
            $this->entityManager->flush();
        } catch (\Exception $e) {
            // Gérer les exceptions
        }
    }

    /*
     * Méthode de validation des images (optionnelle)
     */
    private function isValidImage(UploadedFile $uploadedFile): bool
    {

        $validMimeTypes = ['image/jpeg', 'image/png', 'image/gif'];
        $maxFileSize = 2000000; // 2MB

        return in_array($uploadedFile->getClientMimeType(), $validMimeTypes) && $uploadedFile->getSize() <= $maxFileSize;
    }
}
