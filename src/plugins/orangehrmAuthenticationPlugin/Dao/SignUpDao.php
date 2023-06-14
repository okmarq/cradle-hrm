<?php

use OrangeHRM\Core\Dao\BaseDao;
use OrangeHRM\Entity\Organization;

class SignUpDao extends BaseDao
{

    public function saveSignUpDetails(Organization $organization):Organization
    {
        $this->persist($organization);
        return $organization;
    }

    public function getOrganizationByEmail(string $email): ?Organization
    {
        $q = $this->createQueryBuilder(Organization::class, 'o');
        $q->andWhere('o.email =:email')
            ->setParameter('email', $email)
            ->orderBy('o.created_at', 'DESC')
            ->setMaxResults(1);
        return $q->getQuery()->getOneOrNullResult();
    }

    public function getOrganizationByName(string $name): ?Organization
    {
        $q = $this->createQueryBuilder(Organization::class, 'o');
        $q->andWhere('o.organization_name');
        $q->setParameter('organization_name', $name);
        return $q->getQuery()->getOneOrNullResult();
    }
}