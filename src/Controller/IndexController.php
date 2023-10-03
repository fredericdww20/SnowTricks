<?php

namespace App\Controller;

use App\Entity\Figure;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\ORM\EntityManagerInterface;

class IndexController extends AbstractController
{
    private EntityManagerInterface $entityManager;
    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    #[Route('', name: 'app_index')]
    public function index(): Response
    {
        $user = $this->getUser();

        $figures = $this->entityManager->getRepository(Figure::class)->findBy(['user' => $user]);
        
        return $this->render('index/index.html.twig', [
            'controller_name' => 'IndexController',
            'figures' => $figures
        ]);
    }
}
