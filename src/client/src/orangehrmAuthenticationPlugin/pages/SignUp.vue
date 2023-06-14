<template>
  <login-layout>
    <oxd-text class="orangehrm-login-title" tag="h5">
      {{ $t('general.signup') }}
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
          <oxd-text tag="p">Password : admin123</oxd-text>
        </oxd-sheet>
      </div>
      <oxd-form
        ref="loginForm"
        method="post"
        :action="submitUrl"
        @submitValid="onSubmit"
      >
        <input name="_token" :value="token" type="hidden" />

        <oxd-form-row>
          <oxd-input-field
            v-model="firstName"
            name="firstname"
            :label="$t('general.first_name')"
            label-icon="person"
            :placeholder="$t('general.first_name')"
            :rules="rules.required"
            autofocus
          />
        </oxd-form-row>

        <oxd-form-row>
          <oxd-input-field
            v-model="lastName"
            name="lastname"
            :label="$t('general.last_name')"
            label-icon="person"
            :placeholder="$t('general.last_name')"
            :rules="rules.required"
            autofocus
          />
        </oxd-form-row>

        <oxd-form-row>
          <oxd-input-field
            v-model="organizationName"
            name="organizationName"
            :label="$t('admin.organization_name')"
            label-icon="person"
            :placeholder="$t('admin.organization_name')"
            :rules="rules.required"
            autofocus
          />
        </oxd-form-row>

        <oxd-form-row>
          <oxd-input-field
            v-model="email"
            name="email"
            :label="$t('general.email')"
            label-icon="person"
            :placeholder="$t('general.email')"
            :rules="rules.required"
            autofocus
          />
        </oxd-form-row>

        <oxd-form-row v-if="!show" class="relative">
          <oxd-input-group label-icon="eye" class="pos" @click="toggleShow"></oxd-input-group>
          <oxd-input-field v-model="password" name="password" :label="$t('general.password')" label-icon="key" :placeholder="$t('auth.password')" type="password" :rules="rules.required" />
          <oxd-text class="orangehrm-input-hint" tag="p">
            {{ $t('general.password_strength_message') }}
          </oxd-text>
        </oxd-form-row>
        <oxd-form-row v-else class="relative">
          <oxd-input-group label-icon="key" class="pos" @click="toggleShow" ></oxd-input-group>
          <oxd-input-field v-model="password" name="password" :label="$t('general.password')" label-icon="key" :placeholder="$t('auth.password')" :rules="rules.required" />
          <oxd-text class="orangehrm-input-hint" tag="p">
            {{ $t('general.password_strength_message') }}
          </oxd-text>
        </oxd-form-row>

        <oxd-form-row v-if="!show" class="relative">
          <oxd-input-group label-icon="eye" class="pos" @click="toggleShow"></oxd-input-group>
            <oxd-input-field v-model="confirmPassword" name="confirm_password" :label="$t('general.confirm_password')" label-icon="key" :placeholder="$t('general.confirm_password')" type="password" :rules="rules.required" />
        </oxd-form-row>
        <oxd-form-row v-else class="relative">
          <oxd-input-group label-icon="key" class="pos" @click="toggleShow"></oxd-input-group>
            <oxd-input-field v-model="confirmPassword" name="confirm_password" :label="$t('general.confirm_password')" label-icon="key" :placeholder="$t('general.confirm_password')" :rules="rules.required" />
        </oxd-form-row>

        <oxd-form-actions class="orangehrm-login-action">
          <oxd-button
            class="orangehrm-login-button"
            display-type="main"
            :label="$t('auth.signup')"
            type="submit"
          />
        </oxd-form-actions>
        <div class="orangehrm-login-center">
          <oxd-text class="orangehrm-login-forgot-header" @click="navigateUrl">
            {{ $t('general.have_an_account') }}?
            <span class="orangehrm-color">
              {{ $t('auth.login') }}
            </span>
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
// import Icon from '@ohrm/oxd/core/components/Icon/Icon.vue';
import Sheet from '@ohrm/oxd/core/components/Sheet/Sheet';

export default {
  components: {
    // 'oxd-icon': Icon,
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
    }
  },

  data() {
    return {
      firstName: '',
      lastName: '',
      organizationName: '',
      email: '',
      password: '',
      confirmPassword: '',
      rules: {
        required: [required]
      },
      show: false,
    };
  },

  computed: {
    submitUrl() {
      return urlFor('/auth/signupValidate');
    },
  },

  beforeMount() {
    setTimeout(() => {
      reloadPage();
    }, 1200000); // 20 * 60 * 1000 (20 minutes);
  },

  methods: {
    onSubmit() {
      this.$refs.loginForm.$el.submit();
    },
    navigateUrl() {
      navigate('/auth/login');
    },
    toggleShow() {
      this.show = !this.show
    }
  },
};
</script>

<style src="./login.scss" lang="scss" scoped></style>
