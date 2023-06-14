<?php

namespace CradleHRM\Services;

use CradleHRM\Env;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

class MailService
{
    protected ?PHPMailer $mailer = null;

    protected ?string $host;
    protected ?string $username;
    protected ?string $password;
    protected ?int $port;

    protected ?bool $debug;

    public bool $isHTML = true;
    public string $subject = '';
    public string $body = '';
    public string $altBody = '';

    protected string $emailFrom;

    public function __construct()
    {
        new Env();

        $this->host = $_ENV['MAIL_HOST'];
        $this->username = $_ENV['MAIL_USERNAME'];
        $this->password = $_ENV['MAIL_PASSWORD'];
        $this->port = intval($_ENV['MAIL_PORT']);
        $this->debug = intval($_ENV['SMTPDEBUG']);
        $this->emailFrom = $_ENV['EMAIL_FROM'];
    }

    /**
     * @return PHPMailer
     */
    public function getMailer(): PHPMailer
    {
        if (!$this->mailer instanceof PHPMailer) {
            $this->mailer = new PHPMailer(true);
        }
        return $this->mailer;
    }

    public function content(
        PHPMailer $mail,
        string $subject,
        string $body,
        string $altBody = '',
        bool $isHtml = true,

    ) {
        $mail->isHTML($isHtml);
        $mail->Subject = $subject;
        $mail->Body = $body;
        $mail->AltBody = $altBody;
    }

    public function from(
        PHPMailer $mail,
        string $from_address,
        string $from_name
    ) {
        $mail->setFrom($from_address, $from_name);
    }

    public function sendEmail(string $email, ?string $name): void
    {
        //Create an instance; passing `true` enables exceptions
        $mail = $this->getMailer();

        try {

            $this->loadConfiguation($mail);

            //Recipients
            $mail->setFrom($this->emailFrom, 'CradleHRM');
            if (isset($name)) {
                $mail->addAddress($email, $name); //Add a recipient
            } else {
                $mail->addAddress($email); //Name is optional
            }
            // $mail->addAddress($email, $name); //Add a recipient
            // $mail->addAddress('james@thcohq.com'); //Name is optional
            // $mail->addReplyTo('adaobi@arcpartners.co', 'PM');
            // $mail->addCC('osaro@thcohq.com');
            // $mail->addBCC('David@thcohq.com');

            //Attachments
            // $mail->addAttachment('/var/tmp/file.tar.gz'); //Add attachments
            // $mail->addAttachment('/tmp/image.jpg', 'new.jpg'); //Optional name

            //Content
            $this->content(
                $mail,
                $this->subject,
                $this->body,
                $this->altBody,
                $this->isHTML
            );

            $mail->send();
            // echo 'Message has been sent';
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
            // send it to the log instead
            // dd($e);

        }
    }
    public function loadConfiguation(PHPMailer $mail)
    {
        //Server settings
        //$mail->SMTPDebug = SMTP::DEBUG_SERVER; //Enable verbose debug output
        $mail->isSMTP(); //Send using SMTP
        $mail->Host = $this->host; //Set the SMTP server to send through
        $mail->SMTPAuth = true; //Enable SMTP authentication
        $mail->Username = $this->username; //SMTP username
        $mail->Password = $this->password; //SMTP password
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; //Enable implicit TLS encryption
        $mail->Port = $this->port; //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`
        $mail->SMTPDebug = $this->debug;
    }

    public function sendLeaveRequestEmail(string $email, ?string $name, $subject, $body, $altBody = ''): void
    {
        $mail = $this->getMailer();

        try {
            $this->loadConfiguation($mail);

            $mail->setFrom($this->emailFrom, 'CradleHRM');

            if (isset($name)) {
                $mail->addAddress($email, $name);
            } else {
                $mail->addAddress($email);
            }

            $this->content(
                $mail,
                $subject,
                $body,
                $altBody,
                $this->isHTML
            );

            $mail->send();
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
        }
    }

    public function sendLeaveRequestEmailToSupervisors(array $supervisors, array $content): void
    {
        array_walk($supervisors, array($this, "emailSupervisors"), $content);
    }

    public function emailSupervisors($value, $key, $content)
    {
        $mail = $this->getMailer();

        try {
            $this->loadConfiguation($mail);

            $mail->setFrom($this->emailFrom, 'CradleHRM');
            $mail->clearAddresses();
            $mail->clearReplyTos();
            $mail->clearAllRecipients();

            $name = $value->getName();

            if (isset($name)) {
                $mail->addAddress($value->getEmailAddress(), $value->getName());
            } else {
                $mail->addAddress($value->getEmailAddress());
            }

            if (isset($content['name'])) {
                $mail->addReplyTo($content['workEmail'], $content['name']);
            } else {
                $mail->addReplyTo($content['workEmail']);
            }

            $body = "<p>Hi " . $value->getFirstName() . ",</p>
            <p>" . $content['name'] . " has applied for leave. The leave details:</p>
            <table style='text-align:left'>
                <thead>
                <tr>
                    <th style='padding-right:12px;'>Date(s)</th>
                    <th>Duration(Hours)</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style='padding-right:12px;'>" . $content['dateApplied'] . "</td>
                        <td>" . $content['numberOfHours'] . "</td>
                    </tr>
                </tbody>
            </table>
            <p>Leave type : " . $content['leaveType'] . "</p>
            <p>You received this email, as you are assigned as supervisor for " . $content['firstName'] . "</p>
            <p>Please login to cradleHRM, and either approve or reject from Leave List.</p>
            <p>Thank you.</p>
            <p>This is an automated notification.</p>";

            $this->altBody = "Hi " . $value->getFirstName() . ",
            " . $content['name'] . " has applied for leave. The leave details:
            Date(s) " . $content['dateApplied'] . "
            Duration(Hours) " . $content['numberOfHours'] . "
            Leave type : " . $content['leaveType'] . "
            You received this email, as you are assigned as supervisor for " . $content['firstName'] . "
            Please login to cradleHRM, and either approve or reject from Leave List.
            Thank you.
            This is an automated notification.";

            $this->content(
                $mail,
                $content['subject'],
                $body,
                $this->altBody,
                $this->isHTML
            );

            $mail->send();
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
        }
    }
}

// use CradleHRM\Services\MailService;

// $mailer = new MailService();
// set the mail body before send
// $mailer->sendEmail();


# reset password email write up
// $mailer = new MailService();
// // set the mail body before send
// $mailer->subject = 'Cradle - Password Reset';
// $mailer->body = '<p><b>Hello!</b></p>';
// $mailer->body .= '<p>You are receiving this email because we received a password reset request for your Cradle account.</p>';
// $mailer->body .= '<p><b>Reset Password</b></p>';
// $mailer->body .= "<p>If you didn't request a password reset, no further action is required.</p>";
// $mailer->body .= '<p>Regards,<br>Cradle Team</p>';
// $mailer->body .= "<p><b>If you are having trouble clicking the “Reset Password” button, copy and paste the URL below into your web browser:</br> <Insert URL></b></p>";
// $mailer->altBody = <<<'EOT'
// Hello!

// You are receiving this email because we received a password reset request for your Cradle account.

// Reset Password

// If you didn't request a password reset, no further action is required.

// Regards,
// Cradle Team

// If you are having trouble clicking the “Reset Password” button, copy and paste the URL below into your web browser: <Insert URL>
// EOT;

// $mailer->sendEmail($email);