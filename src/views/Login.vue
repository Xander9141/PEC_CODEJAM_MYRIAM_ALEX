<template>
  <div class="login-container">
    <h1>Iniciar Sesión</h1>
    <form @submit.prevent="login">
      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" v-model="email" id="email" required />
      </div>
      <div class="form-group">
        <label for="password">Contraseña:</label>
        <input type="password" v-model="password" id="password" required />
      </div>
      <button type="submit" class="btn">Login</button>
    </form>
    <router-link to="/register">Registrarse</router-link>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: '',
      password: ''
    };
  },
  methods: {
    async login() {
      try {
        // Aquí iría la lógica para autenticar al usuario.
        // Puedes hacer una llamada a una API o utilizar un servicio local.

        // Simulando una autenticación exitosa
        const user = { email: this.email }; // Datos del usuario autenticado

        // Guardar la información del usuario en el estado global si estás usando Vuex
        this.$store.commit('setUser', user);

        // Redirigir al usuario a la página principal
        this.$router.push('/');
      } catch (error) {
        // Manejar errores de autenticación
        alert('Error de autenticación');
      }
    }
  }
};
</script>

<style scoped>
.login-container {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
  background: #f9f9f9;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
}

.form-group input {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}

.btn {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  border: none;
  color: white;
  font-size: 16px;
  cursor: pointer;
}

.btn:hover {
  background-color: #0056b3;
}

router-link {
  display: block;
  margin-top: 10px;
  text-align: center;
}
</style>
