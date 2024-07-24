<template>
  <div>
    <h1>Bienvenido a la App de Reservas de la Oficina</h1>
    <p>Utilice esta aplicación para gestionar sus reservas de áreas de trabajo y recreación.</p>
    <nav>
      <ul>
        <li>
          <router-link to="/work-reservations">Reservas de Áreas de Trabajo</router-link>
        </li>
        <li>
          <router-link to="/recreation-reservations">Reservas de Áreas de Recreación</router-link>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
export default {
};
</script>

<style scoped>
nav ul {
  list-style: none;
  padding: 0;
}

nav ul li {
  display: inline;
  margin-right: 10px;
}

h1 {
  color: #333;
}

p {
  font-size: 1.2em;
  color: #666;
}
</style>
