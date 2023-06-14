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

use OrangeHRM\Core\Controller\AbstractVueController;
use OrangeHRM\Core\Controller\PublicControllerInterface;
use OrangeHRM\Core\Vue\Component;
use OrangeHRM\Framework\Http\Request;
use OrangeHRM\Core\Vue\Prop;
use OrangeHRM\Config\Config;
use OrangeHRM\CorporateBranding\Traits\ThemeServiceTrait;

class RequestPasswordSuccessController extends AbstractVueController implements PublicControllerInterface
{
    use ThemeServiceTrait;
    
    /**
     * @inheritDoc
     */
    public function preRender(Request $request): void
    {
        $component = new Component('reset-password-success');
      
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
