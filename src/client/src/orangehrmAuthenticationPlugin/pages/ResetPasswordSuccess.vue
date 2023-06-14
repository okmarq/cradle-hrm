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

<!-- <template>
  <login-layout>
    <div class="orangehrm-forgot-password-container">
      <div class="orangehrm-forgot-password-wrapper">
        <div class="orangehrm-card-container">
          <oxd-text tag="h5" class="orangehrm-forgot-password-title">
            {{ $t('auth.reset_password_link_sent_successfully') }}
          </oxd-text>
          <oxd-divider />
          <card-note
            :note-text="$t('auth.reset_password_link_via_email')"
            class="orangehrm-forgot-password-card-note"
          />
          <card-note
            :note-text="$t('auth.follow_link_to_select_password')"
            class="orangehrm-forgot-password-card-note"
          />
          <card-note
            :note-text="$t('auth.email_not_receive_note')"
            class="orangehrm-forgot-password-card-note"
            hasnote
          />
        </div>
      </div>
      <slot name="footer"></slot>
    </div>
  </login-layout>
</template> -->

<template>
  <login-layout>
    <oxd-text class="orangehrm-login-title" tag="h5">
      {{ $t('auth.reset_password_link_sent_successfully') }}
    </oxd-text>

    <oxd-text class="orangehrm-login-title" tag="p">
      {{ $t('auth.reset_password_link_via_email') }}
    </oxd-text>

    <div class="center">
      <oxd-button
        class="orangehrm-login-button"
        display-type="main"
        :label="$t('auth.login')"
        @click="navigateLogin"
      />
    </div>

    <div class="orangehrm-login-forgot center" style="justify-content: center;">
      <oxd-text class="orangehrm-login-forgot-header" @click="navigateUrl">
        {{ $t('auth.email_not_receive_note') }}
        <span class="orangehrm-color">
          Resend
        </span>
      </oxd-text>
    </div>

  </login-layout>
</template>

<script>
// import CardNote from '../components/CardNote';
import LoginLayout from '../components/LoginLayout';
import {navigate} from '@ohrm/core/util/helper/navigation';

export default {
  name: 'ResetPasswordSuccess',
  components: {
    // 'card-note': CardNote,
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
    navigateLogin() {
      navigate('/auth/login');
    },
  },
};
</script>

<style src="./login.scss" lang="scss" scoped></style>
