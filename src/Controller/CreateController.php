<?php

namespace App\Controller;

use App\Entity\Commentaire;
use App\Entity\Figure;
use App\Entity\Image;
use App\Form\CommentaireType;
use App\Form\FigureFormType;
use App\Service\TrickManager;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface;
use Symfony\Component\Routing\Annotation\Route;


class CreateController extends AbstractController
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    #[Route('/add/figure', name: 'app_add_figure')]
    public function index(TrickManager $manager, Request $request, AuthorizationCheckerInterface $authorizationChecker): Response
    {
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        $figure = new Figure();

        $form = $this->createForm(FigureFormType::class, $figure);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $manager->create($form->get('image'), $figure);
            $this->addFlash('success', 'Votre figure avec ses vidéos a bien été ajoutée !');
            return $this->redirectToRoute('app_index');
        }

        return $this->render('add_figure/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/figure/{id}', name: 'figure_show', methods: ['GET', 'POST'])]
    public function show(Figure $figure, Request $request, TrickManager $manager): Response
    {
        $commentaire = new Commentaire();
        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $manager->addComment($form, $figure);
            return $this->redirectToRoute('figure_show', ['id' => $figure->getId()]);
        }

        return $this->render('figure/show.html.twig', [
            'figure' => $figure,
            'commentaireForm' => $form->createView(),
        ]);
    }

    #[Route('/figure/{id}/delete', name: 'figure_delete', methods: ['GET', 'POST'])]
    public function delete(Figure $figure, EntityManagerInterface $entityManager, Request $request, AuthorizationCheckerInterface $authorizationChecker): Response
    {
        if (!$authorizationChecker->isGranted('FIGURE_DELETE', $figure)) {
            $this->addFlash('error', 'Vous ne pouvez pas supprimer cette figure.');
            return $this->redirectToRoute('app_index');
        }

        // Suppression de la figure sans vérifier le CSRF token
        $entityManager->remove($figure);
        $entityManager->flush();

        $this->addFlash('success', 'Figure supprimée avec succès !');

        return $this->redirectToRoute('app_index');
    }

    #[Route('/figure/{id}/edit', name: 'figure_edit', methods: ['GET', 'POST'])]
    public function edit(TrickManager $manager, Request $request, Figure $figure, AuthorizationCheckerInterface $authorizationChecker): Response
    {
        if (!$authorizationChecker->isGranted('FIGURE_EDIT', $figure)) {
            $this->addFlash('error', 'Vous ne pouvez pas modifier cette figure.');
            return $this->redirectToRoute('app_index');
        }

        $form = $this->createForm(FigureFormType::class, $figure);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $manager->update($form->get('image'), $figure);
            $this->addFlash('success', 'Votre figure a bien été modifiée !');
            return $this->redirectToRoute('figure_show', ['id' => $figure->getId()]);
        }

        return $this->render('figure/edit.html.twig', [
            'figure' => $figure,
            'form' => $form->createView(),
        ]);
    }

//    #[Route('/figure/{figureId}/edit/image/{imageId}/delete', name: 'delete_image', methods: ['POST'])]
//    public function deleteImage($figureId, $imageId, EntityManagerInterface $entityManager): JsonResponse {
//        $image = $entityManager->getRepository(Image::class)->find($imageId);
//
//        if (!$image) {
//            return new JsonResponse(['status' => 'error', 'message' => 'Image non trouvée']);
//        }
//
//        try {
//            // Supprimez physiquement le fichier image
//            $fileSystem = new Filesystem();
//            $fileToBeDeleted = $this->getParameter('images_directory').'/'.$image->getFilename();
//            if ($fileSystem->exists($fileToBeDeleted)) {
//                $fileSystem->remove($fileToBeDeleted);
//            }
//
//            $entityManager->remove($image);
//            $entityManager->flush();
//
//            return new JsonResponse(['status' => 'success', 'message' => 'Image supprimée avec succès']);
//        }
//        catch (\Exception $e) {
//            return new JsonResponse(['status' => 'error', 'message' => 'Erreur lors de la suppression de l\'image: '.$e->getMessage()]);
//        }
//    }

    #[Route('/figure/{id}/editcomment', name: 'figure_edit_comment', methods: ['GET', 'POST'])]
    public function editcomment(Request $request, Commentaire $commentaire, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($commentaire);
            $entityManager->flush();

            return $this->redirectToRoute('figure_show', ['id' => $commentaire->getFigure()->getId()]);
        }

        return $this->render('commentaire/edit.html.twig', [
            'commentaire' => $commentaire,
            'form' => $form->createView(),
        ]);
    }
}
