<?php

namespace OrangeHRM\Authentication\Controller;
use OrangeHRM\Authentication\Dto\AuthParams;
use OrangeHRM\Authentication\Dto\SignupCredential;
use OrangeHRM\Authentication\Dto\UserCredential;
use OrangeHRM\Authentication\Exception\AuthenticationException;
use OrangeHRM\Authentication\Service\LoginService;
use OrangeHRM\Authentication\Traits\CsrfTokenManagerTrait;
use OrangeHRM\Core\Authorization\Service\HomePageService;
use OrangeHRM\Core\Controller\AbstractController;
use OrangeHRM\Core\Controller\PublicControllerInterface;
use OrangeHRM\Core\Traits\Auth\AuthUserTrait;
use OrangeHRM\Core\Traits\ServiceContainerTrait;
use OrangeHRM\Framework\Http\RedirectResponse;
use OrangeHRM\Framework\Http\Request;
use OrangeHRM\Authentication\Service\SignUpService;
use OrangeHRM\Framework\Routing\UrlGenerator;
use OrangeHRM\Framework\Services;
use Throwable;
use OrangeHRM\Authentication\Auth\User as AuthUser;

class SignUpValidationController extends AbstractController implements
    PublicControllerInterface
{
    use AuthUserTrait;
    use ServiceContainerTrait;
    use CsrfTokenManagerTrait;

    public const PARAMETER_PASSWORD = 'password';
    public const PARAMETER_EMAIL = 'email';
    public const PARAMETER_FIRSTNAME = 'firstname';
    public const PARAMETER_LASTNAME = 'lastname';
    public const PARAMETER_ORGANIZATION_NAME = 'organizationName';

    /**
     * @var null|LoginService
     */
    protected ?LoginService $loginService = null;

    /**
     * @var HomePageService|null
     */
    protected ?HomePageService $homePageService = null;

    protected ?SignUpService $signUpService = null;

    public function getHomePageService(): HomePageService
    {
        if (!$this->homePageService instanceof HomePageService) {
            $this->homePageService = new HomePageService();
        }
        return $this->homePageService;
    }

    public function getSignupService(): SignUpService
    {
        if (is_null($this->signUpService)) {
            $this->signUpService = new SignUpService();
        }

        return $this->signUpService;
    }

    public function getLoginService(): LoginService
    {
        if (is_null($this->loginService)) {
            $this->loginService = new LoginService();
        }
        return $this->loginService;
    }

    public function handle(Request $request)
    {
        $email = $request->request->get(self::PARAMETER_EMAIL, '');
        $password = $request->request->get(self::PARAMETER_PASSWORD, '');
        $firstname = $request->request->get(self::PARAMETER_FIRSTNAME, '');
        $lastname = $request->request->get(self::PARAMETER_LASTNAME, '');
        $organizationName = $request->request->get(self::PARAMETER_ORGANIZATION_NAME,'');
        $credentials = new SignupCredential(
            $firstname,
            $lastname,
            $email,
            $organizationName,
            $password
        );

        $urlGenerator = $this->getContainer()->get(Services::URL_GENERATOR);
        $signupURL = $urlGenerator->generate(
            'auth_signup',
            [],
            UrlGenerator::ABSOLUTE_URL
        );

        $session = $this->getContainer()->get(Services::SESSION);
        $session->migrate(true);
        try {
            //dd($credentials);

            $result = $this->getSignupService()->saveSignDetails($credentials);
            $loginCredentials = new UserCredential($email, $password);
            if ($result) {
                $authProviderChain = $this->getContainer()->get(
                    Services::AUTH_PROVIDER_CHAIN
                );
                $success = $authProviderChain->authenticate(
                    new AuthParams($loginCredentials)
                );

                //dd($success);

                if (!$success) {
                    throw AuthenticationException::invalidCredentials();
                }

                $this->getAuthUser()->setIsAuthenticated($success);
                $this->getLoginService()->addLogin($loginCredentials);

                $homePagePath = $this->getHomePageService()->getHomePagePath();

                return $this->redirect($homePagePath);
            }

            return new RedirectResponse($signupURL);
        } catch (Throwable $e) {
           
            $this->getAuthUser()->addFlash(AuthUser::FLASH_SIGNUP_ERROR, [
                'error'=> AuthenticationException::UNEXPECT_ERROR,
                'message'=>$e->getMessage()
            ]);

            return new RedirectResponse($signupURL);
        }
    }
}
