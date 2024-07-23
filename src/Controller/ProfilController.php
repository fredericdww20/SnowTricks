<?php

namespace App\Controller;

use App\Entity\Commentaire;
use App\Entity\Figure;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;
use App\Entity\User;
use App\Form\ProfilePictureType;

class ProfilController extends AbstractController
{

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    // Affiche le profil de l'utilisateur connecté
    #[Route('/profil', name: 'app_profil')]
    public function index(EntityManagerInterface $entityManager)
    {
        $user = $this->getUser();

        if (!$user) {
            throw $this->createNotFoundException('Utilisateur non trouvé.');
        }

        $figures = $entityManager->getRepository(Figure::class)->findBy(['user' => $user]);
        $figuresCount = $entityManager->getRepository(Figure::class)->count(['user' => $user]);
        $commentsCount = count($user->getCommentaires());

        return $this->render('profil/index.html.twig', [
            'user' => $user,
            'figuresCount' => $figuresCount,
            'commentsCount' => $commentsCount,
            'figures' => $figures
        ]);
    }


    // Permet de modifier le profil de l'utilisateur connecté
    #[Route('/profil/edit', name: 'profil_edit')]
    public function editProfile(Request $request, SluggerInterface $slugger, EntityManagerInterface $entityManager)
    {
        $user = $this->getUser();

        if (!$user) {
            throw $this->createNotFoundException('Utilisateur non trouvé.');
        }

        $form = $this->createForm(ProfilePictureType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            /** @var UploadedFile $file */
            $file = $form['profilePicture']->getData();

            // Cette condition est nécessaire car le champ IMAGE n\'est pas obligatoire
            if ($file) {
                // On supprime l'ancienne image
                $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
                // Ceci est nécessaire pour inclure en toute sécurité le nom du fichier dans l'URL
                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename . '-' . uniqid() . '.' . $file->guessExtension();

                // Déplacez le fichier dans le répertoire où sont stockées les images de profil
                try {
                    $file->move(
                        $this->getParameter('profile_pictures_directory'),
                        $newFilename
                    );
                } catch (FileException $e) {
                    // Gérer l'erreur de téléchargement de fichier si nécessaire
                }

                $user->setProfilePicture($newFilename);
            }


            $entityManager->persist($user);
            $entityManager->flush();

            $this->addFlash('success', 'Profil mis à jour avec succès');

            return $this->redirectToRoute('app_profil');
        }

        return $this->render('profil/edit.html.twig', [
            'form' => $form->createView(),
            'user' => $user,
        ]);
    }

    private function getDoctrine()
    {
    }
}
