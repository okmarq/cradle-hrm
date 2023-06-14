<?php

namespace CradleHRM\Services;

use OrangeHRM\Core\Traits\Auth\AuthUserTrait;
use OrangeHRM\Entity\User;
use OrangeHRM\Core\Traits\ORM\EntityManagerHelperTrait;

class AuthUserService {
    use AuthUserTrait;
    use EntityManagerHelperTrait;


    public function getOrganizationId(): int
    {
        $id = $this->getAuthUser()->getUserId();

        $q = $this->createQueryBuilder(User::class, 'user')
            ->andWhere('user.id = :id')
            ->setParameter('id', $id)
            ->getQuery()
            ->execute();

        return $q[0]->getOrganizationId();
    }
    
}