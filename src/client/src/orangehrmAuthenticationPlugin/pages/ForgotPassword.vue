<template>
  <login-layout>
    <oxd-text class="orangehrm-login-title" tag="h5">
      {{ $t('auth.forgot_password') }}
    </oxd-text>
    <oxd-text class="orangehrm-login-title" tag="p">
      {{ $t('auth.forgot_password_message') }}
    </oxd-text>
    <div class="orangehrm-login-form">
      <div class="orangehrm-login-error">
        <oxd-alert
          :show="error !== null"
          :message="error?.message || ''"
          type="error"
        ></oxd-alert>
        <oxd-sheet
          v-if="isDemoMode"
          type="gray-lighten-2"
          class="orangehrm-demo-credentials"
        >
          <oxd-text tag="p">Username : Admin</oxd-text>
        </oxd-sheet>
      </div>
      <oxd-form
        ref="forgotForm"
        method="post"
        :action="submitUrl"
        @submitValid="onSubmit"
      >
        <input name="_token" :value="token" type="hidden" />

        <oxd-form-row>
          <oxd-input-field
            v-model="username"
            name="username"
            :label="$t('general.email')"
            label-icon="person"
            :placeholder="$t('auth.email__')"
            :rules="rules.username"
            autofocus
          />
        </oxd-form-row>

        <oxd-form-actions class="orangehrm-login-action">
          <oxd-button
            class="orangehrm-login-button"
            display-type="main"
            :label="$t('auth.send_reset_password')"
            type="submit"
          />
        </oxd-form-actions>
        <div class="orangehrm-login-forgot center">
          <oxd-text class="orangehrm-login-forgot-header" @click="navigateUrl">
            <span class="orangehrm-color">
              Click here
            </span>
            {{ $t('auth.login_page') }}
          </oxd-text>
        </div>
      </oxd-form>
      <br />
    </div>
  </login-layout>
</template>

<script>
import {urlFor} from '@ohrm/core/util/helper/url';
import {required} from '@ohrm/core/util/validation/rules';
import {navigate, reloadPage} from '@ohrm/core/util/helper/navigation';
import LoginLayout from '../components/LoginLayout';
import Alert from '@ohrm/oxd/core/components/Alert/Alert';
import Sheet from '@ohrm/oxd/core/components/Sheet/Sheet';

export default {
  name: 'ForgotPassword',
  components: {
    'oxd-alert': Alert,
    'oxd-sheet': Sheet,
    'login-layout': LoginLayout,
  },

  props: {
    error: {
      type: Object,
      default: () => null,
    },
    token: {
      type: String,
      required: true,
    },
    showSocialMedia: {
      type: Boolean,
      default: true,
    },
    isDemoMode: {
      type: Boolean,
      default: false,
    },
  },

  data() {
    return {
      username: '',
      rules: {
        username: [required],
      },
    };
  },

  computed: {
    submitUrl() {
      return urlFor('/auth/requestResetPassword');
    },
  },

  beforeMount() {
    setTimeout(() => {
      reloadPage();
    }, 1200000); // 20 * 60 * 1000 (20 minutes);
  },

  methods: {
    onSubmit() {
      this.$refs.forgotForm.$el.submit();
    },
    navigateUrl() {
      navigate('/auth/login');
    },
  },
};
</script>

<style src="./login.scss" lang="scss" scoped></style>
