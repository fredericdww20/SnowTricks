<?php

namespace App\Security\Voter;

use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Authorization\Voter\Voter;
use Symfony\Component\Security\Core\User\UserInterface;

class FigureVoter extends Voter
{
    public const FIGURE_EDIT = 'FIGURE_EDIT';
    public const FIGURE_VIEW = 'FIGURE_VIEW';
    public const FIGURE_DELETE = 'FIGURE_DELETE';

    protected function supports(string $attribute, mixed $subject): bool
    {
        return in_array($attribute, [self::FIGURE_EDIT, self::FIGURE_VIEW, self::FIGURE_DELETE])
            && $subject instanceof \App\Entity\Figure;
    }

    protected function voteOnAttribute(string $attribute, mixed $subject, TokenInterface $token): bool
    {
        $user = $token->getUser();
        if (!$user instanceof UserInterface) {
            return false;
        }

        switch ($attribute) {
            case self::FIGURE_DELETE:
            case self::FIGURE_EDIT:
                return $subject->getUser() === $user;
                break;
            case self::FIGURE_VIEW:
                break;
        }
        return false;
    }
}
