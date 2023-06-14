<template>
  <login-layout>
    <div class="orangehrm-forgot-password-container">
      <div class="orangehrm-forgot-password-wrapper">
        <div class="orangehrm-card-container">
          <oxd-form
            ref="resetForm"
            method="post"
            :action="submitUrl"
            @submitValid="onSubmit"
          >
            <oxd-text class="orangehrm-login-title" tag="h5">
              {{ $t('auth.reset_password') }}
            </oxd-text>
            <oxd-divider />
            
            <input name="_token" :value="token" type="hidden" />
            <input name="_reset" :value="reset" type="hidden" />
            
            <oxd-form-row v-if="!show" class="relative">
              <oxd-input-group label-icon="eye" class="pos" @click="toggleShow"></oxd-input-group>
              <oxd-input-field v-model="newPassword" name="password" :label="$t('general.password')" label-icon="key" :placeholder="$t('auth.password')" type="password" :rules="rules.newPassword" />
            </oxd-form-row>
            
            <oxd-form-row v-else class="relative">
              <oxd-input-group label-icon="key" class="pos" @click="toggleShow"></oxd-input-group>
                <oxd-input-field v-model="newPassword" name="password" :label="$t('general.password')" label-icon="key" :placeholder="$t('auth.password')" :rules="rules.newPassword" />
            </oxd-form-row>
    
            <oxd-form-row v-if="!show" class="relative">
              <oxd-input-group label-icon="eye" class="pos" @click="toggleShow"></oxd-input-group>
                <oxd-input-field v-model="confirmPassword" name="confirmPassword" :label="$t('general.confirm_password')" label-icon="key" :placeholder="$t('general.confirm_password')" type="password" :rules="rules.confirmPassword" />
            </oxd-form-row>

            <oxd-form-row v-else class="relative">
              <oxd-input-group label-icon="key" class="pos" @click="toggleShow"></oxd-input-group>
                <oxd-input-field v-model="confirmPassword" name="confirmPassword" :label="$t('general.confirm_password')" label-icon="key" :placeholder="$t('general.confirm_password')" :rules="rules.confirmPassword" />
            </oxd-form-row>

            <oxd-divider />
            <div class="orangehrm-forgot-password-buttons">
              <oxd-button
                class="orangehrm-login-button"
                display-type="main"
                size="large"
                :label="$t('auth.reset_password_button')"
                type="submit"
              />
            </div>

          </oxd-form>
        </div>
      </div>
      <slot name="footer"></slot>
    </div>
  </login-layout>
</template>

<script>
import {checkPassword} from '@ohrm/core/util/helper/password';
import {
  required,
  shouldNotExceedCharLength,
} from '@ohrm/core/util/validation/rules';
import {urlFor} from '@/core/util/helper/url';
import LoginLayout from '../components/LoginLayout';

export default {
  name: 'ResetPassword',
  components: {
    'login-layout': LoginLayout,
  },
  props: {
    token: {
      type: String,
      required: true,
    },
    reset: {
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
      newPassword: '',
      confirmPassword: '',
      rules: {
        newPassword: [required, shouldNotExceedCharLength(20), checkPassword],
        confirmPassword: [
          required,
          shouldNotExceedCharLength(20),
          v => (!!v && v === this.newPassword) || 'Passwords do not match',
        ],
      },
      show: false,
    };
  },
  computed: {
    submitUrl() {
      return urlFor('/auth/resetPassword');
    },
  },
  methods: {
    onSubmit() {
      this.$refs.resetForm.$el.submit();
    },
    toggleShow() {
      this.show = !this.show
    },
  },
};
</script>

<style src="./login.scss" lang="scss" scoped></style>
