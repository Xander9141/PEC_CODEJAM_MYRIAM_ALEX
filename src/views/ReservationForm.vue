<template>
    <div>
        <h2>Reservar Área de Recreación</h2>
        <form @submit.prevent="submitReservation">
            <div>
                <label for="area">Área:</label>
                <select v-model="reservation.area" id="area">
                    <option value="video-games">Sector de Videojuegos</option>
                    <option value="ludoteca">Mesas de Ludoteca</option>
                    <option value="sillones">Sillones de Descanso</option>
                    <option value="cabinas">Cabinas Telefónicas</option>
                </select>
            </div>
            <div>
                <label for="date">Fecha:</label>
                <input type="date" v-model="reservation.date" id="date" />
            </div>
            <div>
                <label for="time">Hora:</label>
                <input type="time" v-model="reservation.time" id="time" />
            </div>
            <div>
                <label for="duration">Duración (horas):</label>
                <input type="number" v-model="reservation.duration" id="duration" min="1" max="4" />
            </div>
            <button type="submit">Reservar</button>
        </form>
    </div>
</template>

<script>
export default {
    data() {
        return {
            reservation: {
                area: 'video-games',
                date: '',
                time: '',
                duration: 1
            }
        };
    },
    methods: {
        submitReservation() {
            const newReservation = {
                ...this.reservation,
                id: Date.now() // Genera un ID único para la reserva
            };
            this.$store.dispatch('addReservation', newReservation);
        }
    }
};
</script>