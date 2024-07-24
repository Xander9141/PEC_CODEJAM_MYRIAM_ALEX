import { createStore } from 'vuex';
import axios from 'axios';

export default createStore({
  state: {
    user: JSON.parse(localStorage.getItem('user')) || null,
    reservations: []
  },
  mutations: {
    setUser(state, user) {
      state.user = user;
      localStorage.setItem('user', JSON.stringify(user)); // Guarda el usuario en localStorage
    },
    removeUser(state) {
      state.user = null;
      localStorage.removeItem('user'); // Elimina el usuario del localStorage
    },
    addReservation(state, reservation) {
      state.reservations.push(reservation);
    },
    cancelReservation(state, id) {
      state.reservations = state.reservations.filter(r => r.id !== id);
    }
  },
  actions: {
    async login({ commit }, credentials) {
      try {
        const response = await axios.post('http://localhost:3000/api/login', credentials);
        commit('setUser', response.data.user);
      } catch (error) {
        console.error('Error en la autenticación:', error);
        // Manejo de errores (puedes mostrar un mensaje al usuario)
      }
    },
    logout({ commit }) {
      commit('removeUser');
    },
    addReservation({ commit }, reservation) {
      commit('addReservation', reservation);
    },
    cancelReservation({ commit }, id) {
      commit('cancelReservation', id);
    }
  },
  getters: {
    getUser: state => state.user,
    getReservations: state => state.reservations,
    isAuthenticated: state => !!state.user // Devuelve true si hay un usuario autenticado
  }
});
