<?php

namespace App\Controller;

use App\Entity\Figure;
use App\Form\FigureFormType;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AddFigureController extends AbstractController
{

    #[Route('/add/figure', name: 'app_add_figure')]
    public function index(EntityManagerInterface $entityManager, Request $request): Response
    {
        $figure = new Figure();

        $form = $this->createForm(FigureFormType::class, $figure);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $images = $form['image']->getData();
            foreach ($images as $uploadedImage) {
                $file = $uploadedImage->getFile();
                if ($file instanceof UploadedFile) {
                    try {
                        $uploadedImage->move(
                            $this->getParameter('images_directory'),
                            $uploadedImage->getFilename()  // We use the filename that we set in the entity
                        );
                    } catch (FileException $e) {
                        $this->addFlash('error', 'Une erreur est survenue lors du téléchargement de l\'image: ' . $e->getMessage());
                    }
                }
            }

            $figure->setUser($this->getUser());

            foreach ($figure->getVideos() as $video) {
                $video->setFigure($figure);
            }

            $figure->setCreatedAt(new \DateTimeImmutable());
            $entityManager->persist($figure);
            $entityManager->flush();

            $this->addFlash('success', 'Votre figure avec ses vidéos a bien été ajoutée !');
            return $this->redirectToRoute('app_add_figure');

        }

        return $this->render('add_figure/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }

}