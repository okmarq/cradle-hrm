<?php 

namespace OrangeHRM\Authentication\Dto;

class SignupCredential implements SignupCredentialInterface
{
    private ?string $firstname = null;
    private ?string $lastname = null;

    private ?string $organizationName = null;

    private ?string $email = null;

    private ?string $password = null;


    public function __construct(?string $firstname = null, ?string $lastname = null, ?string $email =null , ?string $organizationName = null, ?string $password = null )
    
    {
        $this->firstname = $firstname;
        $this->lastname = $lastname;
        $this->organizationName = $organizationName;
        $this->password = $password;
        $this->email = $email;    
    }

    public function getFirstName(): ?string
    {
        return $this->firstname;
    }

    public function setFirstName(?string $firstname):void
    {
        $this->firstname = $firstname;
    }

    public function getLastName(): ?string
    {
        return $this->lastname;
    }

    public function setLastName(?string $lastname):void
    {
        $this->lastname = $lastname;
    }

    public function getOrganizationName(): ?string
    {
        return $this->organizationName;
    }

    public function setOrganizationName(?string $organizationName): void
    {
        $this->organizationName = $organizationName;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(?string $email): void 
    {
         $this->email = $email;
    }

    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function setPassword(?string $password):void
    {
        $this->password = $password;
    }

}