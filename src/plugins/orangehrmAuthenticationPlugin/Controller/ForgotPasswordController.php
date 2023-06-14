<?php

namespace OrangeHRM\Authentication\Controller;

use OrangeHRM\Authentication\Auth\User as AuthUser;
use OrangeHRM\Authentication\Traits\CsrfTokenManagerTrait;
use OrangeHRM\Config\Config;
use OrangeHRM\Core\Controller\AbstractVueController;
use OrangeHRM\Core\Controller\PublicControllerInterface;
use OrangeHRM\Core\Traits\Auth\AuthUserTrait;
use OrangeHRM\Core\Traits\EventDispatcherTrait;
use OrangeHRM\Core\Vue\Component;
use OrangeHRM\Core\Vue\Prop;
use OrangeHRM\CorporateBranding\Traits\ThemeServiceTrait;
use OrangeHRM\Framework\Http\Request;

class ForgotPasswordController extends AbstractVueController implements PublicControllerInterface
{
    use AuthUserTrait;
    use EventDispatcherTrait;
    use ThemeServiceTrait;
    use CsrfTokenManagerTrait;

    /**
     * @inheritDoc
     */
    public function preRender(Request $request): void
    {
        $component = new Component('forgot-password');
        
        if ($this->getAuthUser()->hasFlash(AuthUser::FLASH_LOGIN_ERROR)) {
            $error = $this->getAuthUser()->getFlash(AuthUser::FLASH_LOGIN_ERROR);
            $component->addProp(
                new Prop(
                    'error',
                    Prop::TYPE_OBJECT,
                    $error[0] ?? []
                )
            );
        }

        $component->addProp(
            new Prop(
                'token',
                Prop::TYPE_STRING,
                $this->getCsrfTokenManager()->getToken('forgot-password')->getValue()
            )
        );

        $component->addProp(
            new Prop('login-logo-src', Prop::TYPE_STRING, $request->getBasePath() . '/images/ohrm_logo.svg')
        );

        $assetsVersion = Config::get(Config::VUE_BUILD_TIMESTAMP);
        $loginBannerUrl = $request->getBasePath()
            . "/images/ohrm_branding.svg?$assetsVersion";
        if (!is_null($this->getThemeService()->getImageETag('login_banner'))) {
            $loginBannerUrl = $request->getBaseUrl()
                . "/admin/theme/image/loginBanner?$assetsVersion";
        }
        
        $component->addProp(
            new Prop('login-banner-src', Prop::TYPE_STRING, $loginBannerUrl)
        );

        $component->addProp(
            new Prop('show-social-media', Prop::TYPE_BOOLEAN, $this->getThemeService()->showSocialMediaImages())
        );

        $component->addProp(new Prop('is-demo-mode', Prop::TYPE_BOOLEAN, Config::PRODUCT_MODE === Config::MODE_DEMO));
       
        $this->setTemplate('no_header.html.twig');
        $this->setComponent($component);
    }
}
