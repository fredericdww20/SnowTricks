<?php

namespace App\Controller;

use App\Entity\Figure;
use App\Form\FigureFormType;
use App\Service\TrickManager;
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
    public function index(TrickManager $manager, Request $request): Response
    {
        $figure = new Figure();

        $form = $this->createForm(FigureFormType::class, $figure);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $manager->create($form->get('image'), $figure);

            $this->addFlash('success', 'Votre figure avec ses vidéos a bien été ajoutée !');
            return $this->redirectToRoute('app_add_figure');
        }

        return $this->render('add_figure/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }




}