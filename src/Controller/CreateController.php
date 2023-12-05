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
            $this->addFlash('success', 'Votre figure a bien été ajoutée !');
            return $this->redirectToRoute('app_index');
        }

        return $this->render('add_figure/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/figure/{slug}', name: 'figure_show', methods: ['GET', 'POST'])]
    public function show(string $slug, Request $request, TrickManager $manager): Response
    {

        $figure = $this->entityManager->getRepository(Figure::class)->findOneBy(['slug' => $slug]);

        if (!$figure) {
            throw $this->createNotFoundException('La figure demandée n\'a pas été trouvée.');
        }

        $commentaire = new Commentaire();
        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $manager->addComment($form, $figure);
            // Rediriger en utilisant le slug
            return $this->redirectToRoute('figure_show', ['slug' => $figure->getSlug()]);
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

        $entityManager->remove($figure);
        $entityManager->flush();

        $this->addFlash('success', 'Figure supprimée avec succès !');

        return $this->redirectToRoute('app_index');
    }

    #[Route('/figure/{id}/deletecomment', name: 'figure_delete_comment', methods: ['GET', 'POST'])]
    public function deletecomment(Commentaire $commentaire, EntityManagerInterface $entityManager, AuthorizationCheckerInterface $authorizationChecker): Response
    {
        if (!$authorizationChecker->isGranted('COMMENT_DELETE', $commentaire)) {
            $this->addFlash('error', 'Vous ne pouvez pas supprimer cette figure.');
            return $this->redirectToRoute('app_index');
        }

        $entityManager->remove($commentaire);
        $entityManager->flush();

        $this->addFlash('success', 'Commentaire supprimé avec succès !');

        return $this->redirectToRoute('figure_show', ['slug' => $commentaire->getFigure()->getSlug()]);
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
            return $this->redirectToRoute('figure_show', ['slug' => $figure->getSlug()]);
        }

        return $this->render('figure/edit.html.twig', [
            'figure' => $figure,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/figure/{id}/editcomment', name: 'figure_edit_comment', methods: ['GET', 'POST'])]
    public function editcomment(Request $request, Commentaire $commentaire, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($commentaire);
            $entityManager->flush();

            return $this->redirectToRoute('figure_show', ['slug' => $commentaire->getFigure()->getSlug()]);
        }
        // Message d'alerte
        return $this->render('commentaire/edit.html.twig', [
            'commentaire' => $commentaire,
            'form' => $form->createView(),
        ]);
    }

    private function getRepository(string $class)
    {
    }
}
