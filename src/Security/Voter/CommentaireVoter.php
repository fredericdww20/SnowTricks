<?php

namespace App\Security\Voter;

use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Authorization\Voter\Voter;
use Symfony\Component\Security\Core\User\UserInterface;

class CommentaireVoter extends Voter
{
    public const COMMENT_EDIT = 'COMMENT_EDIT';
    public const COMMENT_VIEW = 'COMMENT_VIEW';
    public const COMMENT_DELETE = 'COMMENT_DELETE';

    protected function supports(string $attribute, mixed $subject): bool
    {
        return in_array($attribute, [self::COMMENT_EDIT, self::COMMENT_VIEW, self::COMMENT_DELETE])
            && $subject instanceof \App\Entity\Commentaire;
    }

    protected function voteOnAttribute(string $attribute, mixed $subject, TokenInterface $token): bool
    {
        $user = $token->getUser();
        if (!$user instanceof UserInterface) {
            return false;
        }

        switch ($attribute) {
            case self::COMMENT_EDIT:
                return $subject->getAuthor() === $user;
            case self::COMMENT_DELETE:
                return $subject->getAuthor() === $user;
                break;
            case self::COMMENT_VIEW:
                break;
        }

        return false;
    }
}
