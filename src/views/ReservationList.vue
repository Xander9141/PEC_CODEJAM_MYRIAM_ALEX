<template>
    <div>
        <h2>Lista de Reservas</h2>
        <ul>
            <li v-for="reservation in reservations" :key="reservation.id">
                {{ reservation.area }} - {{ reservation.date }} {{ reservation.time }} ({{ reservation.duration }}
                horas)
                <button @click="cancelReservation(reservation.id)">Cancelar</button>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    data() {
        return {};
    },
    computed: {
        reservations() {
            return this.$store.getters.getReservations;
        }
    },
    methods: {
        cancelReservation(id) {
            this.$store.dispatch('cancelReservation', id);
        }
    }
};
</script>