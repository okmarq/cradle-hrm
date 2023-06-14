<?php

namespace OrangeHRM\Authentication\Controller;

use OrangeHRM\Core\Controller\AbstractVueController;
use OrangeHRM\Core\Controller\PublicControllerInterface;
use OrangeHRM\Core\Vue\Component;
use OrangeHRM\Framework\Http\Request;
use OrangeHRM\Core\Vue\Prop;
use OrangeHRM\Config\Config;
use OrangeHRM\CorporateBranding\Traits\ThemeServiceTrait;

class ResetUserSuccessController extends AbstractVueController implements PublicControllerInterface
{
    use ThemeServiceTrait;
    
    /**
     * @inheritDoc
     */
    public function preRender(Request $request): void
    {
        $component = new Component('reset-user-success');
      
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
