-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-07-2024 a las 18:51:24
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `reserva_espacios_comunes`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `espacios_comunes`
--

CREATE TABLE `espacios_comunes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `tipo` enum('puesto','sala_reunion','bano','cocina','casino','videojuegos','ludoteca','sillon','cabina_telefonica') NOT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `espacios_comunes`
--

INSERT INTO `espacios_comunes` (`id`, `nombre`, `tipo`, `capacidad`, `descripcion`) VALUES
(1, 'Sala de Videojuegos', 'videojuegos', 10, 'Sala equipada con consolas y juegos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inhabilitaciones`
--

CREATE TABLE `inhabilitaciones` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas_espacios_comunes`
--

CREATE TABLE `reservas_espacios_comunes` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `espacio_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `participantes` int(11) DEFAULT 1,
  `estado` enum('reservado','anulado','completado') DEFAULT 'reservado'
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `rol` enum('empleado','admin') NOT NULL
) ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `contraseña`, `rol`) VALUES
(1, 'Juan Pérez', 'juan.perez@example.com', 'hashed_password', 'empleado');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `espacios_comunes`
--
ALTER TABLE `espacios_comunes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tipo` (`tipo`),
  ADD KEY `idx_nombre` (`nombre`);

--
-- Indices de la tabla `inhabilitaciones`
--
ALTER TABLE `inhabilitaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_usuario_inhabilitacion` (`usuario_id`),
  ADD KEY `idx_fecha_inicio` (`fecha_inicio`),
  ADD KEY `idx_fecha_fin` (`fecha_fin`);

--
-- Indices de la tabla `reservas_espacios_comunes`
--
ALTER TABLE `reservas_espacios_comunes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fecha` (`fecha`),
  ADD KEY `idx_usuario` (`usuario_id`),
  ADD KEY `idx_espacio` (`espacio_id`),
  ADD KEY `idx_estado` (`estado`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `espacios_comunes`
--
ALTER TABLE `espacios_comunes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inhabilitaciones`
--
ALTER TABLE `inhabilitaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservas_espacios_comunes`
--
ALTER TABLE `reservas_espacios_comunes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inhabilitaciones`
--
ALTER TABLE `inhabilitaciones`
  ADD CONSTRAINT `inhabilitaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reservas_espacios_comunes`
--
ALTER TABLE `reservas_espacios_comunes`
  ADD CONSTRAINT `reservas_espacios_comunes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservas_espacios_comunes_ibfk_2` FOREIGN KEY (`espacio_id`) REFERENCES `espacios_comunes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
