<template>
    <div class="flex h-screen bg-gray-100">
        <!-- Registration Section -->
        <div class="w-full md:w-1/2 bg-white flex items-center justify-center p-12">
            <div class="w-full max-w-md">
                <div class="text-center mb-8">
                    <img src="@/assets/logo_r.jpg" alt="Logo" class="w-16 h-16 mx-auto mb-4"/>
                    <h1 class="text-3xl font-bold text-gray-800">Registrarse en ReserFast</h1>
                    <p class="text-gray-600">Completa el formulario para crear una cuenta.</p>
                </div>
                <form @submit.prevent="handleRegister" class="space-y-6">
                    <div>
                        <label for="nombre" class="block text-sm font-medium text-gray-700">Nombre</label>
                        <input type="text" id="nombre" v-model="nombre"
                            class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-teal-500 focus:border-teal-500"
                            required />
                    </div>
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                        <input type="email" id="email" v-model="email"
                            class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-teal-500 focus:border-teal-500"
                            required />
                        <span v-if="emailError" class="text-red-500 text-sm">{{ emailError }}</span>
                    </div>
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700">Contraseña</label>
                        <input type="password" id="password" v-model="password"
                            class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-teal-500 focus:border-teal-500"
                            required />
                        <span v-if="passwordError" class="text-red-500 text-sm">{{ passwordError }}</span>
                    </div>
                    <div>
                        <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirmar Contraseña</label>
                        <input type="password" id="confirmPassword" v-model="confirmPassword"
                            class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-teal-500 focus:border-teal-500"
                            required />
                        <span v-if="confirmPasswordError" class="text-red-500 text-sm">{{ confirmPasswordError }}</span>
                    </div>
                    <div>
                        <label for="rol" class="block text-sm font-medium text-gray-700">Rol</label>
                        <select id="rol" v-model="rol"
                            class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-teal-500 focus:border-teal-500"
                            required>
                            <option value="empleado">Empleado</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div v-if="generalError" class="text-red-500 text-sm">{{ generalError }}</div>
                    <div v-if="successMessage" class="text-green-500 text-sm">{{ successMessage }}</div>
                    <div>
                        <button type="submit"
                            class="w-full flex items-center justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-teal-600 hover:bg-teal-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-teal-500">
                            Registrarse
                            <svg class="ml-2 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7">
                                </path>
                            </svg>
                        </button>
                    </div>
                </form>
                <div class="mt-6 flex flex-col space-y-2 text-sm text-center">
                    <a @click="redirectToLogin" class="font-medium text-teal-600 hover:text-teal-500 cursor-pointer">
                        Ya tengo cuenta
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
import axios from 'axios';

export default {
    data() {
        return {
            nombre: '',
            email: '',
            password: '',
            confirmPassword: '',
            rol: 'empleado',
            emailError: '',
            passwordError: '',
            confirmPasswordError: '',
            generalError: '',
            successMessage: ''
        };
    },
    methods: {
        async handleRegister() {
            // Reset messages
            this.emailError = '';
            this.passwordError = '';
            this.confirmPasswordError = '';
            this.generalError = '';
            this.successMessage = '';

            // Basic validation
            if (!this.nombre) {
                this.generalError = 'El nombre es requerido';
                return;
            }
            if (!this.email) {
                this.emailError = 'El email es requerido';
                return;
            }
            if (!this.password) {
                this.passwordError = 'La contraseña es requerida';
                return;
            }
            if (this.password !== this.confirmPassword) {
                this.confirmPasswordError = 'Las contraseñas no coinciden';
                return;
            }

            try {
                console.log('Enviando solicitud de registro:', { nombre: this.nombre, email: this.email, rol: this.rol });
                const response = await axios.post('http://localhost:3000/api/register', {
                    nombre: this.nombre,
                    email: this.email,
                    password: this.password,
                    rol: this.rol
                });

                console.log('Respuesta del servidor:', response.data);

                if (response.data.success) {
                    this.successMessage = 'Usuario registrado exitosamente. Redirigiendo al login...';
                    console.log('Usuario registrado exitosamente');
                    
                    // Esperar 2 segundos antes de redirigir
                    setTimeout(() => {
                        this.$router.push({ name: 'Login' });
                    }, 2000);
                } else {
                    this.generalError = response.data.message || 'Error en el registro';
                }
            } catch (error) {
                console.error('Error en el registro:', error.response?.data || error);
                this.generalError = error.response?.data?.message || 'Error en el registro. Por favor, intente nuevamente.';
            }
        },
        redirectToLogin() {
            this.$router.push({ name: 'Login' });
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