<?php

namespace App\Controller;

use App\Entity\Commentaire;
use App\Entity\Figure;
use App\Form\CommentaireType;
use App\Form\FigureFormType;
use App\Service\TrickManager;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\ORM\EntityManagerInterface;

class IndexController extends AbstractController
{
    private EntityManagerInterface $entityManager;
    private $trickManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    #[Route('', name: 'app_index')]
    public function index(): Response
    {
        $user = $this->getUser();

        $figures = $this->entityManager->getRepository(Figure::class)->findAll(['user' => $user]);

        return $this->render('index/index.html.twig', [
            'figures' => $figures
        ]);
    }

    #[Route('/figure/{id}', name: 'figure_show', methods: ['GET', 'POST'])]
    public function show(Figure $figure, Request $request, EntityManagerInterface $entityManager): Response
    {
        $commentaire = new Commentaire();
        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $commentaire->setFigure($figure);

            $commentaire->setAuthor($this->getUser());
            $entityManager->persist($commentaire);
            $entityManager->flush();

            return $this->redirectToRoute('figure_show', ['id' => $figure->getId()]);
        }

        return $this->render('figure/show.html.twig', [
            'figure' => $figure,
            'commentaireForm' => $form->createView(),
        ]);
    }

    #[Route('/figure/{id}/delete', name: 'figure_delete', methods: ['GET', 'POST'])]
    public function delete(Figure $figure, EntityManagerInterface $entityManager, Request $request): Response
    {
//        $this->denyAccessUnlessGranted('CAN_DELETE', $figure);

        if ($this->isCsrfTokenValid('delete' . $figure->getId(), $request->request->get('_token'))) {
            $entityManager->remove($figure);
            $entityManager->flush();
        }

        return $this->redirectToRoute('app_index');
    }

    #[Route('/figure/{id}/edit', name: 'figure_edit', methods: ['GET', 'POST'])]
    public function edit(TrickManager $manager,Request $request, Figure $figure): Response {
        $form = $this->createForm(FigureFormType::class, $figure);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $figure->setUpdatedAt(new \DateTimeImmutable());
            $manager->updateImages($form->get('image'), $figure);
            $this->entityManager->flush();

            return $this->redirectToRoute('figure_show', ['id' => $figure->getId()]);
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

            return $this->redirectToRoute('figure_show', ['id' => $commentaire->getFigure()->getId()]);
        }

        return $this->render('commentaire/edit.html.twig', [
            'commentaire' => $commentaire,
            'form' => $form->createView(),
        ]);
    }
}
