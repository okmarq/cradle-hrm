<?php
/**
 * OrangeHRM is a comprehensive Human Resource Management (HRM) System that captures
 * all the essential functionalities required for any enterprise.
 * Copyright (C) 2006 OrangeHRM Inc., http://www.orangehrm.com
 *
 * OrangeHRM is free software; you can redistribute it and/or modify it under the terms of
 * the GNU General Public License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * OrangeHRM is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program;
 * if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA  02110-1301, USA
 */

namespace OrangeHRM\Authentication\Controller;

use OrangeHRM\Authentication\Exception\AuthenticationException;
use OrangeHRM\Authentication\Service\ResetPasswordService;
use OrangeHRM\Authentication\Traits\CsrfTokenManagerTrait;
use OrangeHRM\Core\Controller\AbstractController;
use OrangeHRM\Core\Controller\PublicControllerInterface;
use OrangeHRM\Entity\User;
use OrangeHRM\Framework\Http\RedirectResponse;
use OrangeHRM\Framework\Http\Request;
use OrangeHRM\Framework\Http\Response;
use OrangeHRM\Authentication\Auth\User as AuthUser;
use OrangeHRM\Core\Traits\Auth\AuthUserTrait;
use CradleHRM\Services\MailService;
use CradleHRM\Env;

class RequestResetPasswordController extends AbstractController implements PublicControllerInterface
{
    use CsrfTokenManagerTrait;
    use AuthUserTrait;

    protected ?string $resetURL;

    public function __construct()
    {
        new Env();
        $this->resetURL = $_ENV['PASSWORD_RESET_LINK'];

    }
    protected ?ResetPasswordService $resetPasswordService = null;

    /**
     * @return ResetPasswordService
     */
    public function getResetPasswordService(): ResetPasswordService
    {
        if (!$this->resetPasswordService instanceof ResetPasswordService) {
            $this->resetPasswordService = new ResetPasswordService();
        }
        return $this->resetPasswordService;
    }

    /**
     * @param Request $request
     * @return Response|RedirectResponse
     */
    public function handle(Request $request): RedirectResponse
    {
       
        $token = $request->request->get('_token');

        if (!$this->getCsrfTokenManager()->isValid('forgot-password', $token)) {
            throw AuthenticationException::invalidCsrfToken();
        }

        $username = $request->request->get('username');
       
        if (($user = $this->getResetPasswordService()->searchForUsername($username)) instanceof User) {

            $resetCode = $this->getResetPasswordService()->generateResetCode();
            $this->getResetPasswordService()->storeResetUser($username, $resetCode);

            $url = $this->resetURL.$resetCode;
            

            # reset password email write up
            $mailer = new MailService();
            
            // set the mail body before send
            $mailer->subject = 'Cradle - Password Reset';
            $mailer->body = '<p><b>Hello!</b></p>';
            $mailer->body .= '<p>You are receiving this email because we received a password reset request for your Cradle account.</p>';
            // $mailer->body .= '<p><b>CLICK THIS <a href='.$url.' target="_blank">link</a></b></p>';
            $mailer->body .= '<button type="button" style="padding: 1rem 1rem; font-size: 14px; background-color: #f05d5e; font-weight: 600; border: 0; border-radius: 3em; cursor: pointer; display: inline-block; line-height: 1;"><a style="color: #ffffff; text-decoration: none;" href='.$url.' target="_blank">Reset Password</a></button>';
            $mailer->body .= "<p>If you didn't request a password reset, no further action is required.</p>";
            $mailer->body .= '<p>Regards,<br>Cradle Team</p>';
            $mailer->body .= '<p><b>If you are having trouble clicking the “Reset Password” button, copy and paste the URL below into your web browser:</br>'.$url.'</b></p>';
            
            // $mailer->altBody = <<<'EOT'
            // Hello!

            // // You are receiving this email because we received a password reset request for your Cradle account.

            // // Reset Password

            // // If you didn't request a password reset, no further action is required.

            // // Regards,
            // // Cradle Team

            // // If you are having trouble clicking the “Reset Password” button, copy and paste the URL below into your web browser: `http://localhost/cradle-hrm/web/index.php/auth/resetUserPassword/resetCode/${$resetCode}`
            // EOT;

            $mailer->sendEmail($username, $user->getEmployee()->getFirstName());

            return $this->redirect('auth/sendPasswordReset');
        } else {
            $this->getAuthUser()->addFlash(
                AuthUser::FLASH_LOGIN_ERROR,
                [
                    'error' => AuthenticationException::UNEXPECT_ERROR,
                    'message' => 'This email does not exist',
                ]
            );

            return $this->redirect('auth/forgotPassword');
        }
    }
}
