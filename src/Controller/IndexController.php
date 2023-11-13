<?php

namespace App\Controller;

use App\Entity\Categories;
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

class IndexController extends AbstractController
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    #[Route('', name: 'app_index')]
    public function index(Request $request): Response
    {
        $page = $request->query->getInt('page', 1);
        $limit = 4;
        $totalFigures = $this->entityManager->getRepository(Figure::class)->count([]);
        $totalPages = ceil($totalFigures / $limit);

        $figures = $this->entityManager->getRepository(Figure::class)
            ->findBy([], null, $limit, ($page - 1) * $limit);

        // Récupérez les catégories ici
        $categories = $this->entityManager->getRepository(Categories::class)->findAll();

        return $this->render('index/index.html.twig', [
            'figures' => $figures,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'categories' => $categories, // Ajoutez les catégories au tableau de paramètres
        ]);
    }

}