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
        // Vérifier si l'utilisateur est connecté
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        $figure = new Figure();

        // Vérifier si l'utilisateur a le droit de créer une figure
        $form = $this->createForm(FigureFormType::class, $figure);
        $form->handleRequest($request);

        // Vérifier si l'utilisateur a le droit de créer une figure
        if ($form->isSubmitted() && $form->isValid()) {
            $manager->create($form->get('image'), $figure);
            $this->addFlash('success', 'Votre figure a bien été ajoutée !');
            return $this->redirectToRoute('app_index');
        }

        // Afficher le formulaire
        return $this->render('add_figure/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/figure/{slug}', name: 'figure_show', methods: ['GET', 'POST'])]
    public function show(string $slug, Request $request, TrickManager $manager): Response
    {
        // Récupérer la figure
        $figure = $this->entityManager->getRepository(Figure::class)->findOneBy(['slug' => $slug]);

        // Vérifier si la figure existe
        if (!$figure) {
            throw $this->createNotFoundException('La figure demandée n\'a pas été trouvée.');
        }

        $commentaire = new Commentaire();
        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $manager->addComment($form, $figure);
            return $this->redirectToRoute('figure_show', ['slug' => $figure->getSlug()]);
        }

        // Afficher la figure
        return $this->render('figure/show.html.twig', [
            'figure' => $figure,
            'commentaireForm' => $form->createView(),
        ]);
    }

    #[Route('/figure/{id}/delete', name: 'figure_delete', methods: ['GET', 'POST'])]
    public function delete(Figure $figure, EntityManagerInterface $entityManager, Request $request, AuthorizationCheckerInterface $authorizationChecker): Response
    {
        // Vérifier si l'utilisateur a le droit de supprimer la figure
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
        // Vérifier si l'utilisateur a le droit de supprimer le commentaire
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
        // Vérifier si l'utilisateur a le droit de modifier la figure
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
        // Vérifier si le commentaire appartient à une figure
        $figure = $commentaire->getFigure();
        if (!$figure) {
            throw $this->createNotFoundException('Figure not found for this comment.');
        }

        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $figure = $commentaire->getFigure(); // Récupérer la figure après la soumission du formulaire
            if (!$figure) {
                throw new \Exception('La figure n\'a pas été trouvée pour ce commentaire.');
            }

            $entityManager->persist($commentaire);
            $entityManager->flush();

            return $this->redirectToRoute('figure_show', ['slug' => $figure->getSlug()]);
        }

        return $this->render('commentaire/edit.html.twig', [
            'commentaire' => $commentaire,
            'form' => $form->createView(),
        ]);
    }


    private function getRepository(string $class)
    {
    }
}
