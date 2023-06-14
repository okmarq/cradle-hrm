<template>
  <login-layout>
    <oxd-text class="orangehrm-login-title" tag="h5">
      {{ $t('auth.reset_password_successfull_title') }}
    </oxd-text>
    <oxd-text class="orangehrm-login-title" tag="p">
      {{ $t('auth.reset_password_successfull_message') }}
    </oxd-text>
    <div class="center">
      <!-- <oxd-text class="orangehrm-login-forgot-header" @click="navigateUrl">
        {{ $t('auth.email_not_receive_note') }}
      </oxd-text> -->
      <oxd-button
        class="orangehrm-login-button"
        display-type="main"
        :label="$t('auth.login')"
        @click="navigateUrl"
      />
    </div>
    <br />
  </login-layout>
</template>

<script>
import LoginLayout from '../components/LoginLayout';
import {navigate} from '@ohrm/core/util/helper/navigation';

export default {
  name: 'ResetUserSuccess',
  components: {
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
      navigate('/auth/login');
    },
  },
};
</script>

<style src="./login.scss" lang="scss" scoped></style>
