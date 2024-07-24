import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Login from '../views/Login.vue';
import Register from '../views/Register.vue';
import RecreationReservations from '../views/RecreationReservations.vue';
import WorkReservations from '../views/WorkReservations.vue';
import store from '../store';

const routes = [
  { path: '/', component: Login, name: 'Login' }, // Añadido el nombre 'Login'
  { path: '/home', component: Home, name: 'Home', meta: { requiresAuth: true } },
  { path: '/register', component: Register, name: 'Register' },
  { path: '/recreation-reservations', component: RecreationReservations, name: 'RecreationReservations', meta: { requiresAuth: true } },
  { path: '/work-reservations', component: WorkReservations, name: 'WorkReservations', meta: { requiresAuth: true } }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

router.beforeEach((to, from, next) => {
  const isAuthenticated = store.getters.isAuthenticated;

  if (to.matched.some(record => record.meta.requiresAuth) && !isAuthenticated) {
    next({ name: 'Login' });
  } else {
    next();
  }
});

export default router;