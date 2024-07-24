<template>
    <div>
        <h1>Reservas de Áreas de Recreación</h1>
        <ReservationForm />
        <ReservationList />
    </div>
</template>

<script>
import ReservationForm from '@/components/ReservationForm.vue';
import ReservationList from '@/components/ReservationList.vue';

export default {
    components: {
        ReservationForm,
        ReservationList
    }
};
</script>