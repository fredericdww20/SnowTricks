<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\RegistrationFormType;
use App\Repository\UserRepository;
use App\Security\EmailVerifier;
use App\Security\UserAuthenticator;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mime\Address;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\UserAuthenticatorInterface;
use Symfony\Contracts\Translation\TranslatorInterface;
use SymfonyCasts\Bundle\VerifyEmail\Exception\VerifyEmailExceptionInterface;
use Symfony\Component\Mailer\MailerInterface;


class RegistrationController extends AbstractController
{
    private EmailVerifier $emailVerifier;

    public function __construct(EmailVerifier $emailVerifier)
    {
        $this->emailVerifier = $emailVerifier;
    }

    #[Route('/register', name: 'app_register')]
    public function register(Request $request, UserPasswordHasherInterface $userPasswordHasher, UserAuthenticatorInterface $userAuthenticator, UserAuthenticator $authenticator, EntityManagerInterface $entityManager, MailerInterface $mailer): Response
    {
        $user = new User();
        $form = $this->createForm(RegistrationFormType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Encode the plain password
            $user->setPassword(
                $userPasswordHasher->hashPassword(
                    $user,
                    $form->get('plainPassword')->getData()
                )
            );

            // Générer le token de validation
            $token = bin2hex(random_bytes(32));
            $user->setValidationToken($token);

            $entityManager->persist($user);
            $entityManager->flush();

            // Envoi de l'email de confirmation avec le token de validation
            $email = (new TemplatedEmail())
                ->from(new Address('contact@snowtricks.fportemer.fr', 'Confirmation de votre compte'))
                ->to($user->getEmail())
                ->subject('Merci de confirmer votre compte !')
                ->htmlTemplate('registration/confirmation_email.html.twig')
                ->context(['validation_token' => $token]);

            $mailer->send($email);

            // Redirection vers l'accueil sans connexion
            return $this->redirectToRoute('app_index');
        }

        return $this->render('registration/register.html.twig', [
            'registrationForm' => $form->createView(),
        ]);
    }


//    #[Route('/register', name: 'app_register')]
//    public function register(Request $request, UserPasswordHasherInterface $userPasswordHasher, UserAuthenticatorInterface $userAuthenticator, UserAuthenticator $authenticator, EntityManagerInterface $entityManager): Response
//    {
//        $user = new User();
//        $form = $this->createForm(RegistrationFormType::class, $user);
//        $form->handleRequest($request);
//
//        if ($form->isSubmitted() && $form->isValid()) {
//            // encode the plain password
//            $user->setPassword(
//                $userPasswordHasher->hashPassword(
//                    $user,
//                    $form->get('plainPassword')->getData()
//                )
//            );
//
//            $entityManager->persist($user);
//            $entityManager->flush();
//
//            $this->emailVerifier->sendEmailConfirmation('app_verify_email', $user,
//                (new TemplatedEmail())
//                    ->from(new Address('contact@snowtricks.fportemer.fr', 'Confirmation de votre compte'))
//                    ->to($user->getEmail())
//                    ->subject('Merci de confirmer votre compte !')
//                    ->htmlTemplate('registration/confirmation_email.html.twig')
//            );
//            // do anything else you need here, like send an email
//
//            return $userAuthenticator->authenticateUser(
//                $user,
//                $authenticator,
//                $request
//            );
//        }
//
//        return $this->render('registration/register.html.twig', [
//            'registrationForm' => $form->createView(),
//        ]);
//    }

    #[Route('/verify/email', name: 'app_verify_email')]
    public function verifyUserEmail(Request $request, TranslatorInterface $translator, UserRepository $userRepository, EntityManagerInterface $entityManager): Response
    {
        $token = $request->query->get('token');

        if (null === $token) {
            return $this->redirectToRoute('app_register');
        }

        $user = $userRepository->findOneBy(['validationToken' => $token]);

        if (null === $user) {
            $this->addFlash('verify_email_error', 'Le lien de vérification est pas valide ou a expiré . ');
            return $this->redirectToRoute('app_register');
        }


        $user->setIsVerified(true);
        $user->setValidationToken(null);
        $entityManager->persist($user);
        $entityManager->flush();

        $this->addFlash('success', 'Votre email a bien été vérifié . ');

        return $this->redirectToRoute('app_login');
    }

}
