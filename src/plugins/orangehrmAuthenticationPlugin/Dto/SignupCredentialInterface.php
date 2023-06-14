<?php

namespace OrangeHRM\Authentication\Dto;

interface SignupCredentialInterface
{

    public function getFirstName(): ?string;

    public function getLastName(): ?string;

    public function getOrganizationName(): ?string;

    public function getEmail(): ?string;

    public function getPassword(): ?string;
}