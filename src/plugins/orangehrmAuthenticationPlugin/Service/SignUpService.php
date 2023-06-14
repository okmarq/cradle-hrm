<?php

namespace OrangeHRM\Authentication\Service;

use OrangeHRM\Admin\Traits\Service\UserServiceTrait;
use OrangeHRM\Authentication\Dto\SignupCredential;
use OrangeHRM\Core\Traits\ControllerTrait;
use OrangeHRM\Core\Traits\ORM\EntityManagerHelperTrait;
use OrangeHRM\Core\Traits\Service\DateTimeHelperTrait;
use OrangeHRM\Core\Utility\PasswordHash;
use OrangeHRM\Installer\Util\Connection;
use DateTime;
use Doctrine\DBAL\Types\Types;
use OrangeHRM\Authentication\Exception\AuthenticationException;
use CradleHRM\Services\MailService;

class SignUpService
{
    use DateTimeHelperTrait;
    use EntityManagerHelperTrait;
    use ControllerTrait;
    use UserServiceTrait;

    public function saveSignDetails(SignupCredential $credential): bool
    {
        $success = false;

        $email = $credential->getEmail();
        $name = $credential->getOrganizationName();
        $firstname = $credential->getFirstName();
        $lastname = $credential->getLastName();
        $password = $credential->getPassword();

        $checkOrganization = $this->getOrganizationByEmail($email, $name);

        if ($checkOrganization) {
            
            throw AuthenticationException::organizationExist();
        }

        $checkUser = $this->checkUserExist($email);
        
        if($checkUser){
           
            throw AuthenticationException::organizationExist();
        }

        $empId = $this->generateEmployeeId();

        $this->insertOrganizationInfo($name, $email);
        
        $this->insertSubunitOrganizationName($name,$email);
        $this->insertAdminEmployee($empId, $firstname, $lastname, $email, $name);
        $result = $this->storeUserDetails($empId, $email, $password,$name);

        if ($result == false) {
            // throw exception
            return $success;
        }

        $mailer = new MailService();
        // set the mail body before send
        $mailer->subject = 'Welcome to Cradle!';
        $mailer->body = '<p><b>Welcome to CradleHRM</b></p>';
        $mailer->body .= '<p>Thank you for signing up on Cradle! HR processes and Employee Data management made easy.</p>';
        $mailer->body .= '<p>The next step is to set up your account.</p>';
        $mailer->body .= '<p><b>SIGN IN TO YOUR NEW ACCOUNT</b></p>';
        $mailer->body .= '<p><a href="http://cradletalent.com/web/index.php/auth/login">Sign in</a></p>';
        $mailer->body .= '<p><b>We are here to help!</b><br>Email us at <a href="mailto:hello@cradletalent.com">hello@cradletalent.com</a></p>';
        $mailer->altBody = <<<'EOT'
        Welcome to CradleHRM

        Thank you for signing up on Cradle! HR processes and Employee Data management made easy.

        The next step is to set up your account.

        LOG IN TO YOUR NEW ACCOUNT


        We are here to help!
        Email us at hello@cradletalent.com
        EOT;

        $mailer->sendEmail($email, $name);

        return $success = true;
    }

    public function getOrganizationByEmail(string $email, string $name)
    {
        return Connection::getConnection()
            ->createQueryBuilder()
            ->select('organization.id')
            ->from('ohrm_organization_gen_info', 'organization')
            ->where('organization.email = :email')
            ->orWhere('organization.name = :name')
            ->setParameter('email', $email)
            ->setParameter('name', $name)
            ->setMaxResults(1)
            ->fetchOne();
        // dd($result);
    }


    public function checkUserExist(string $email)
    {
        return Connection::getConnection()->createQueryBuilder()->select('user.id')->from('ohrm_user', 'user')->where('user.user_name = :email')->setParameter('email', $email)->setMaxResults(1)
        ->fetchOne();
    }

    private function insertAdminEmployee(
        string $empId,
        string $firstName,
        string $lastName,
        string $email,
        string $name
    ): void {
        $organizationId = $this->getOrganizationByEmail($email,$name);
        //$empId = $this->generateEmployeeId();
        Connection::getConnection()
            ->createQueryBuilder()
            ->insert('hs_hr_employee')
            ->values([
                'employee_id' => ':employeeId',
                'emp_lastname' => ':lastName',
                'emp_firstName' => ':firstName',
                'emp_work_email' => ':email',
                'organizationId' => ':organizationId',
            ])
            ->setParameter('employeeId', $empId)
            ->setParameter('firstName', $firstName)
            ->setParameter('lastName', $lastName)
            ->setParameter('email', $email)
            ->setParameter('organizationId', $organizationId)
            ->executeQuery();
    }

    private function generateEmployeeId($length = 8): string
    {
        $characters =
            '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $randomString = '';

        for ($i = 0; $i < $length; $i++) {
            $index = rand(0, strlen($characters) - 1);
            $randomString .= $characters[$index];
        }

        return $randomString;
    }

    private function insertOrganizationInfo(
        string $organizationName,
        string $email
    ):void {
         Connection::getConnection()
            ->createQueryBuilder()
            ->insert('ohrm_organization_gen_info')
            ->values([
                'name' => ':name',
                'email' => ':email',
            ])
            ->setParameter('name', $organizationName)
            ->setParameter('email', $email)
            ->executeQuery();
    }

    private function insertSubunitOrganizationName(
        string $organizationName,
        string $email
    ): void {
        $organizationId = $this->getOrganizationByEmail($email,$organizationName);
        Connection::getConnection()
            ->createQueryBuilder()
            ->insert('ohrm_subunit')
            ->values([
                'name' => ':name',
                'level' => ':level',
                'lft' => ':lft',
                'rgt' => ':rgt',
                'organizationId'=>':organizationId'
            ])
            ->setParameter('name', $organizationName)
            ->setParameter('level', 0)
            ->setParameter('lft', 1)
            ->setParameter('rgt', 2)
            ->setParameter('organizationId', $organizationId)
            ->executeQuery();
    }

    private function getAdminRole(string $role = 'Admin')
    {
        return Connection::getConnection()
            ->createQueryBuilder()
            ->select('userRole.id')
            ->from('ohrm_user_role', 'userRole')
            ->where('userRole.name = :userRoleName')
            ->setParameter('userRoleName', 'Admin')
            ->setMaxResults(1)
            ->fetchOne();
    }

    private function getEmployeeDetails(string $employeeId)
    {
        return Connection::getConnection()
            ->createQueryBuilder()
            ->select('employee.emp_number')
            ->from('hs_hr_employee', 'employee')
            ->where('employee.employee_id = :employeeId')
            ->setParameter('employeeId', $employeeId)
            ->setMaxResults(1)
            ->fetchOne();
    }

    private function storeUserDetails(
        string $employeeId,
        string $email,
        string $password,
        string $name
    ) {
        $organizationDetails = $this->getOrganizationByEmail($email, $name);

        $empNumber = $this->getEmployeeDetails($employeeId);
        $roleId = $this->getAdminRole('Admin');
        $passwordHasher = new PasswordHash();
        $hashedPassword = $passwordHasher->hash($password);
        $result = Connection::getConnection()
            ->createQueryBuilder()
            ->insert('ohrm_user')
            ->values([
                'user_role_id' => ':userRoleId',
                'emp_number' => ':empNumber',
                'organizationId' => ':organizationId',
                'user_name' => ':email',
                'user_password' => ':hashPassword',
                'date_entered' => ':created',
            ])
            ->setParameter('userRoleId', $roleId)
            ->setParameter('empNumber', $empNumber)
            ->setParameter('email', $email)
            ->setParameter('organizationId', $organizationDetails)
            ->setParameter('hashPassword', $hashedPassword)
            ->setParameter('created', new DateTime(), Types::DATETIME_MUTABLE)
            ->executeQuery();

        return $result;
    }
}
