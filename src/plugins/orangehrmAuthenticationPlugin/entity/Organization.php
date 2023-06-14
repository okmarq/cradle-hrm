<?php 

namespace OrangeHRM\Entity;

use DateTime;
use Doctrine\ORM\Mapping as ORM;

class Organization
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private int $id;

     /**
     * @var string
     *
     * @ORM\Column(name="first_name", type="string", length=60)
     */
    private string $firstName;

     /**
     * @var string
     *
     * @ORM\Column(name="last_name", type="string", length=60)
     */
    private string $lastName;

     /**
     * @var string
     *
     * @ORM\Column(name="organization_name", type="string", length=60)
     */
    private string $organizationName;

     /**
     * @var string
     *
     * @ORM\Column(name="email", type="string", length=60)
     */
    private string $email;


    /**
     * @var DateTime
     *
     * @ORM\Column(name="created_at", type="datetime")
     */
    private DateTime $created_at;

    /**
     * @var DateTime
     *
     * @ORM\Column(name="updated_at", type="datetime")
     */
    private DateTime $updated_at;

     /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }

    /**
     * @param int $id
     */
    public function setId(int $id): void
    {
        $this->id = $id;
    }


     /**
     * @return string
     */
    public function getfirstName():string
    {
        return $this->firstName;
    }

     /**
     * @param string $firstName
     */
    public function setFirstName(string $firstName):void
    {
        $this->firstName = $firstName;
    }

     /**
     * @return string
     */
    public function getLastName():string
    {
        return $this->lastName;
    }
    
    /**
     * @param string $lastName
     */
    public function setLastName(string $lastName):void
    {
        $this->lastName = $lastName;
    }

    public function getOrganizationName():string
    {
        return $this->organizationName;
    }

    public function setOrganizationName(string $organizationName):void
    {
       $this->organizationName = $organizationName;
    }

    public function getEmail():string
    {
        return $this->email;
    }

    public function setEmail(string $email):void
    {
        $this->email = $email;
    }

    public function getCreatedAt():DateTime
    {
        return $this->created_at;
    }

    public function setCreatedAt(DateTime $created_at):void
    {
        $this->created_at = $created_at;
    }

    
}