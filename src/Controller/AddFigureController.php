<?php

namespace App\Controller;

use App\Entity\Figure;
use App\Form\FigureFormType;
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


            foreach ($figure->getVideos() as $video) {

                $video->setFigure($figure);
            }
            $figure->setCreatedAt(new \DateTimeImmutable());
            $entityManager->persist($figure);
            $entityManager->flush();

            $this->addFlash('success', 'Votre figure avec ses vidéos a bien été ajoutée !');

            // Redirigez vers la page que vous souhaitez après l'ajout d'une figure
            return $this->redirectToRoute('app_add_figure');
        }

        return $this->render('add_figure/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}