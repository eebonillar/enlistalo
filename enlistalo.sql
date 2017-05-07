-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-05-2017 a las 13:11:00
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `enlistalo`
--
CREATE DATABASE IF NOT EXISTS `enlistalo` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `enlistalo`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

DROP TABLE IF EXISTS `articulo`;
CREATE TABLE IF NOT EXISTS `articulo` (
  `id_articulo` int(11) NOT NULL AUTO_INCREMENT,
  `nom_articulo` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `desc_articulo` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cant_articulo` int(11) NOT NULL,
  `urlejemplo_articulo` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_articulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listas`
--

DROP TABLE IF EXISTS `listas`;
CREATE TABLE IF NOT EXISTS `listas` (
  `id_lista` int(11) NOT NULL AUTO_INCREMENT,
  `nom_lista` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `desc_lista` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_lista` int(11) NOT NULL,
  `creador_lista` int(11) NOT NULL,
  PRIMARY KEY (`id_lista`),
  KEY `tipo_lista` (`tipo_lista`),
  KEY `creador_lista` (`creador_lista`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `listas`
--

INSERT INTO `listas` (`id_lista`, `nom_lista`, `desc_lista`, `tipo_lista`, `creador_lista`) VALUES
(5, 'asa', 'asa', 1, 54);

--
-- Disparadores `listas`
--
DROP TRIGGER IF EXISTS `AI_LISTAS`;
DELIMITER $$
CREATE TRIGGER `AI_LISTAS` AFTER INSERT ON `listas` FOR EACH ROW BEGIN
INSERT INTO notificaciones VALUES (NULL,'1','nuevo',new.id_lista);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_articulo`
--

DROP TABLE IF EXISTS `lista_articulo`;
CREATE TABLE IF NOT EXISTS `lista_articulo` (
  `id_lista` int(11) NOT NULL,
  `id_user_comprador` int(11) DEFAULT NULL,
  `id_articulo` int(11) NOT NULL,
  PRIMARY KEY (`id_lista`,`id_articulo`),
  KEY `id_articulo` (`id_articulo`),
  KEY `id_user` (`id_user_comprador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Disparadores `lista_articulo`
--
DROP TRIGGER IF EXISTS `AD_lista_articulo`;
DELIMITER $$
CREATE TRIGGER `AD_lista_articulo` AFTER DELETE ON `lista_articulo` FOR EACH ROW BEGIN
	DELETE FROM articulo WHERE id_articulo = OLD.id_articulo;
	INSERT INTO notificaciones VALUES (NULL,'1','eliminar',OLD.id_lista);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `AU_lista_articulo`;
DELIMITER $$
CREATE TRIGGER `AU_lista_articulo` AFTER UPDATE ON `lista_articulo` FOR EACH ROW BEGIN
IF (OLD.id_user_comprador IS NULL) THEN
	IF (SELECT id_lista FROM notificaciones WHERE id_lista = NEW.id_lista AND tipo='compra') THEN
    	UPDATE notificaciones SET cantidad = cantidad + 1
        					  WHERE notificaciones.id_lista = NEW.id_lista;
    ELSE
   		INSERT INTO notificaciones VALUES (NULL,'1','compra',new.id_lista);
	END IF;
ELSEIF (NEW.id_user_comprador IS NULL) THEN
	IF (SELECT id_lista FROM notificaciones WHERE id_lista = NEW.id_lista AND tipo='nocompra') THEN
    	UPDATE notificaciones SET cantidad = cantidad + 1
        					  WHERE notificaciones.id_lista = NEW.id_lista;
    ELSE
   		INSERT INTO notificaciones VALUES (NULL,'1','nocompra',new.id_lista);
	END IF;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_invitado`
--

DROP TABLE IF EXISTS `lista_invitado`;
CREATE TABLE IF NOT EXISTS `lista_invitado` (
  `id_lista` int(11) NOT NULL,
  `id_invitado` int(11) NOT NULL,
  PRIMARY KEY (`id_invitado`,`id_lista`),
  KEY `lista_invitado_ibfk_1` (`id_lista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_procontra`
--

DROP TABLE IF EXISTS `lista_procontra`;
CREATE TABLE IF NOT EXISTS `lista_procontra` (
  `id_lista` int(11) NOT NULL,
  `pro` text COLLATE utf8_spanish_ci NOT NULL,
  `contra` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_lista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
CREATE TABLE IF NOT EXISTS `notificaciones` (
  `id_notificacion` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` smallint(6) NOT NULL,
  `tipo` enum('nuevo','compra','eliminar','nocompra') COLLATE utf8_spanish_ci NOT NULL,
  `id_lista` int(11) NOT NULL,
  PRIMARY KEY (`id_notificacion`),
  KEY `IDUsuario` (`cantidad`),
  KEY `IDLista` (`id_lista`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id_notificacion`, `cantidad`, `tipo`, `id_lista`) VALUES
(6, 1, 'nuevo', 5),
(7, 1, 'eliminar', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_lista`
--

DROP TABLE IF EXISTS `tipo_lista`;
CREATE TABLE IF NOT EXISTS `tipo_lista` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_lista`
--

INSERT INTO `tipo_lista` (`id_tipo`, `nombre_tipo`) VALUES
(1, 'pro_contra'),
(2, 'articulos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_user` int(10) NOT NULL AUTO_INCREMENT,
  `username_user` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `email_user` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `contr_user` varchar(135) COLLATE utf8_spanish_ci NOT NULL,
  `user_activo` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_user`, `username_user`, `email_user`, `contr_user`, `user_activo`) VALUES
(54, 'enrique', 'enriquen7@hotmail.com', '3cf3d96ef23780663565536bc3c187b0', 0),
(55, 'asd', 'asd', '7815696ecbf1c96e6894b779456d330e', 0);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `listas`
--
ALTER TABLE `listas`
  ADD CONSTRAINT `listas_ibfk_1` FOREIGN KEY (`creador_lista`) REFERENCES `usuarios` (`id_user`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `lista_articulo`
--
ALTER TABLE `lista_articulo`
  ADD CONSTRAINT `lista_articulo_ibfk_1` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`id_lista`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lista_articulo_ibfk_2` FOREIGN KEY (`id_articulo`) REFERENCES `articulo` (`id_articulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lista_articulo_ibfk_3` FOREIGN KEY (`id_user_comprador`) REFERENCES `usuarios` (`id_user`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `lista_invitado`
--
ALTER TABLE `lista_invitado`
  ADD CONSTRAINT `lista_invitado_ibfk_1` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`id_lista`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lista_invitado_ibfk_2` FOREIGN KEY (`id_invitado`) REFERENCES `usuarios` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `lista_procontra`
--
ALTER TABLE `lista_procontra`
  ADD CONSTRAINT `lista_procontra_ibfk_1` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`id_lista`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_lista`) REFERENCES `listas` (`id_lista`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
