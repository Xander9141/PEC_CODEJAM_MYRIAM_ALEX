<template>
  <div class="flex h-screen bg-gray-100">
    <!-- Login Section -->
    <div class="w-full md:w-1/2 bg-white flex items-center justify-center p-12">
      <div class="w-full max-w-md">
        <div class="text-center mb-8">
          <img src="../assets/logo_r.jpg" alt="Logo" class="w-16 h-16 mx-auto mb-4"/>
          <h1 class="text-3xl font-bold text-gray-800">ReserFast</h1>
          <p class="text-gray-600">Reserva a un click!</p>
        </div>
        <form @submit.prevent="handleLogin" class="space-y-6">
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
            <input
              type="email"
              id="email"
              v-model="email"
              class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-teal-500 focus:border-teal-500"
              required
            />
            <span v-if="emailError" class="text-red-500 text-sm">{{ emailError }}</span>
          </div>
          <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Contraseña</label>
            <input
              type="password"
              id="password"
              v-model="password"
              class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-teal-500 focus:border-teal-500"
              required
            />
            <span v-if="passwordError" class="text-red-500 text-sm">{{ passwordError }}</span>
          </div>
          <div>
            <button
              type="submit"
              class="w-full flex items-center justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-teal-600 hover:bg-teal-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-teal-500"
            >
              Iniciar Sesión
              <svg class="ml-2 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
              </svg>
            </button>
          </div>
        </form>
        <div class="mt-6 flex flex-col space-y-2 text-sm text-center">
          <a @click="redirectToRegister" class="font-medium text-teal-600 hover:text-teal-500 cursor-pointer">
            Registrarse
          </a>
          <a href="#" class="font-medium text-teal-600 hover:text-teal-500">
            Olvidé mi contraseña
          </a>
        </div>
      </div>
    </div>
    <!-- Welcome Section -->
    <div class="w-full md:w-1/2 bg-gradient-to-br from-teal-400 via-yellow-300 to-red-400 flex items-center justify-center">
      <div class="text-white text-center p-8">
        <h2 class="text-4xl font-bold mb-4">Bienvenido a ReserFast</h2>
        <p class="text-xl">Tu plataforma de reservas rápidas y sencillas.</p>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  data() {
    return {
      email: '',
      password: '',
      emailError: '',
      passwordError: ''
    };
  },
  computed: {
    ...mapGetters(['isAuthenticated']),
  },
  methods: {
    handleLogin() {
      // Reset errors
      this.emailError = '';
      this.passwordError = '';

      // Basic validation
      if (!this.email) {
        this.emailError = 'El email es requerido';
        return;
      }
      if (!this.password) {
        this.passwordError = 'La contraseña es requerida';
        return;
      }

      // Add your login logic here
      console.log('Login attempted with:', this.email, this.password);

      // Simulate authentication
      this.$router.push({ name: 'Home' });
    },
    redirectToRegister() {
      this.$router.push({ name: 'Register' });
    }
  },
  watch: {
    isAuthenticated(value) {
      if (value) {
        this.$router.push({ name: 'Home' });
      }
    }
  }
};
</script>

<style scoped>
/* Scoped styles to improve layout */
.hidden {
  display: none;
}
@media (min-width: 768px) {
  .hidden {
    display: block;
  }
}
</style>
