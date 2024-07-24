<template>
  <nav>
    <router-link v-if="!isAuthenticated" to="/">Login</router-link> |
    <router-link v-if="isAuthenticated" to="/home">Home</router-link> |
    <router-link v-if="isAuthenticated" to="/recreation-reservations">Recreation Reservations</router-link> |
    <router-link v-if="isAuthenticated" to="/work-reservations">Work Reservations</router-link>
  </nav>
  <router-view/>
</template>

<script>
import { computed } from 'vue';
import { useStore } from 'vuex';

export default {
  setup() {
    const store = useStore();
    const isAuthenticated = computed(() => store.getters.isAuthenticated);

    return {
      isAuthenticated
    };
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
  margin-right: 10px;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>
