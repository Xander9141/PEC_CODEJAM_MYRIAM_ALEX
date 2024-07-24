<template>
    <div>
      <h1>Reservas de Áreas de Trabajo</h1>
      <!-- Usa los componentes ReservationForm y ReservationList aquí -->
      <reservation-form @add-reservation="addReservation"></reservation-form>
      <reservation-list :reservations="reservations" @cancel-reservation="cancelReservation"></reservation-list>
    </div>
  </template>
  
  <script>
  import ReservationForm from '@/views/ReservationForm.vue';
  import ReservationList from '@/views/ReservationList.vue';
  
  export default {
    components: {
      ReservationForm,
      ReservationList
    },
    data() {
      return {
        reservations: []
      };
    },
    methods: {
      addReservation(reservation) {
        this.reservations.push({ ...reservation, id: Date.now() });
      },
      cancelReservation(id) {
        this.reservations = this.reservations.filter(reservation => reservation.id !== id);
      }
    }
  };
  </script>
  
  <style scoped>
  /* Agrega tus estilos aquí */
  </style>
  