import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Login from '../views/Login.vue';
import RecreationReservations from '../views/RecreationReservations.vue';
import WorkReservations from '../views/WorkReservations.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/login', component: Login },
  { path: '/recreation-reservations', component: RecreationReservations },
  { path: '/work-reservations', component: WorkReservations }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
