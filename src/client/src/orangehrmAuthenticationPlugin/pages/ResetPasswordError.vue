<!--
  - OrangeHRM is a comprehensive Human Resource Management (HRM) System that captures
  - all the essential functionalities required for any enterprise.
  - Copyright (C) 2006 OrangeHRM Inc., http://www.orangehrm.com
  -
  - OrangeHRM is free software; you can redistribute it and/or modify it under the terms of
  - the GNU General Public License as published by the Free Software Foundation; either
  - version 2 of the License, or (at your option) any later version.
  -
  - OrangeHRM is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
  - without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  - See the GNU General Public License for more details.
  -
  - You should have received a copy of the GNU General Public License along with this program;
  - if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
  - Boston, MA  02110-1301, USA
  -->
<template>
  <login-layout>
    <div class="orangehrm-forgot-password-container">
      <div class="orangehrm-forgot-password-wrapper">
        <div class="orangehrm-card-container">
          <oxd-text tag="h6" class="orangehrm-forgot-password-title">
            {{ $t('auth.reset_password') }}
          </oxd-text>
          <oxd-divider />
          <card-note
            :note-text="$t('auth.reset_password_token_expired_note')"
            class="orangehrm-forgot-password-card-note"
            has-note-icon
          />
          <oxd-text class="orangehrm-forgot-password-reset">
            <oxd-text
              tag="span"
              class="orangehrm-forgot-password-reset--link"
              @click="navigateUrl"
            >
              {{ $t('general.click_here') }}
            </oxd-text>
            {{ $t('auth.request_new_password_token') }}
          </oxd-text>
        </div>
      </div>
      <slot name="footer"></slot>
    </div>
  </login-layout>
</template>

<script>
import CardNote from '../components/CardNote';
import {navigate} from '@/core/util/helper/navigation';
import LoginLayout from '../components/LoginLayout';

export default {
  name: 'ResetPasswordError',
  components: {
    'card-note': CardNote,
    'login-layout': LoginLayout,
  },
  props: {
    showSocialMedia: {
      type: Boolean,
      default: true,
    },
    isDemoMode: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    navigateUrl() {
      navigate('/auth/forgotPassword');
    },
  },
};
</script>
<style src="./login.scss" lang="scss" scoped></style>
