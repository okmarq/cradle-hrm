<?php

namespace OrangeHRM\Authentication\Controller;

use OrangeHRM\Authentication\Traits\CsrfTokenManagerTrait;
use OrangeHRM\Config\Config;
use OrangeHRM\Core\Controller\AbstractVueController;
use OrangeHRM\Core\Controller\PublicControllerInterface;
use OrangeHRM\Core\Traits\EventDispatcherTrait;
use OrangeHRM\Core\Vue\Component;
use OrangeHRM\Core\Vue\Prop;
use OrangeHRM\CorporateBranding\Traits\ThemeServiceTrait;
use OrangeHRM\Framework\Http\Request;
use OrangeHRM\Authentication\Service\ResetPasswordService;

class ResetUserPasswordController extends AbstractVueController implements PublicControllerInterface
{
    use EventDispatcherTrait;
    use ThemeServiceTrait;
    use CsrfTokenManagerTrait;

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
     * @inheritDoc
     */
    public function preRender(Request $request): void
    {
        $resetCode = $request->attributes->get('resetCode');
        
        if (!$this->getResetPasswordService()->retrieveResetUser($resetCode)) {
            $component = new Component('reset-password-error');
        } else {
            $component = new Component('reset-user-password');

            $component->addProp(
                new Prop('reset', Prop::TYPE_STRING, $resetCode)
            );
    
            $component->addProp(
                new Prop(
                    'token',
                    Prop::TYPE_STRING,
                    $this->getCsrfTokenManager()->getToken('reset-user-password')->getValue()
                )
            );
        }

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

        $this->setComponent($component);
        $this->setTemplate('no_header.html.twig');
    }
}
