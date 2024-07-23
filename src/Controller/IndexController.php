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
        // Pagination
        $page = $request->query->getInt('page', 1);
        // Nombre de figures par page
        $limit = 10;
        // Nombre total de figures
        $totalFigures = $this->entityManager->getRepository(Figure::class)->count([]);
        // Nombre total de pages
        $totalPages = ceil($totalFigures / $limit);
        // Obtenir tous les figures
        $figures = $this->entityManager->getRepository(Figure::class)
            ->findBy([], null, $limit, ($page - 1) * $limit);
        // Obtenir toutes les catégories
        $categories = $this->entityManager->getRepository(Categories::class)->findAll();
        // Rendu de la vue
        return $this->render('index/index.html.twig', [
            'figures' => $figures,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'categories' => $categories,
        ]);
    }

}