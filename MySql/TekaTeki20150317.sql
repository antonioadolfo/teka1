CREATE DATABASE  IF NOT EXISTS `tekateki` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `tekateki`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: tekateki
-- ------------------------------------------------------
-- Server version	5.6.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `jugada`
--

DROP TABLE IF EXISTS `jugada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jugada` (
  `id_jugada` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del registro',
  `id_usuario` int(11) DEFAULT NULL COMMENT 'identificador del jugador',
  `id_recuerdo` int(11) DEFAULT NULL COMMENT 'identificador del recuerdo',
  `fecha_juego` datetime DEFAULT NULL COMMENT 'fecha en que se jugo el recuerdo',
  `estrellas` int(11) DEFAULT NULL COMMENT 'cantidad de estrellas obtenidas',
  `puntos` int(11) DEFAULT NULL COMMENT 'cantidad de puntos',
  `tiempo` int(11) DEFAULT NULL COMMENT 'tiempo empleado en jugar el recuerdo',
  PRIMARY KEY (`id_jugada`),
  UNIQUE KEY `j_uk` (`id_usuario`,`id_recuerdo`),
  KEY `j_u_idx` (`id_usuario`),
  KEY `j_r_idx` (`id_recuerdo`),
  CONSTRAINT `j_r` FOREIGN KEY (`id_recuerdo`) REFERENCES `recuerdo` (`id_recuerdo`) ON UPDATE CASCADE,
  CONSTRAINT `j_u` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='jugadas relizadas por el jugador';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugada`
--

LOCK TABLES `jugada` WRITE;
/*!40000 ALTER TABLE `jugada` DISABLE KEYS */;
INSERT INTO `jugada` (`id_jugada`, `id_usuario`, `id_recuerdo`, `fecha_juego`, `estrellas`, `puntos`, `tiempo`) VALUES (56,1,1,'2015-03-11 14:33:25',3,1500,250),(57,1,2,'2015-03-11 14:33:25',3,1380,156),(58,1,3,'2015-03-11 14:33:25',2,1425,10),(59,1,4,'2015-03-11 14:33:25',2,1425,10),(60,1,5,'2015-03-11 14:33:25',2,1425,10),(61,1,6,'2015-03-11 14:33:25',2,1425,10),(62,1,7,'2015-03-11 14:33:26',2,1425,10),(63,1,8,'2015-03-11 14:33:26',2,1425,10);
/*!40000 ALTER TABLE `jugada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mundo`
--

DROP TABLE IF EXISTS `mundo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mundo` (
  `id_mundo` int(11) NOT NULL COMMENT 'Identificador del registro',
  `nombremundo` varchar(255) DEFAULT NULL COMMENT 'nombre del mundo',
  PRIMARY KEY (`id_mundo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='descripcion de los recuerdos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mundo`
--

LOCK TABLES `mundo` WRITE;
/*!40000 ALTER TABLE `mundo` DISABLE KEYS */;
INSERT INTO `mundo` (`id_mundo`, `nombremundo`) VALUES (1,'Pais');
/*!40000 ALTER TABLE `mundo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recuerdo`
--

DROP TABLE IF EXISTS `recuerdo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recuerdo` (
  `id_recuerdo` int(11) NOT NULL COMMENT 'identificacion de registro',
  `id_mundo` int(11) DEFAULT NULL COMMENT 'Identificador del mundo al que pertenece el recuerdo',
  `nombrerecuerdo` varchar(255) DEFAULT NULL COMMENT 'nombre del recuerdo',
  PRIMARY KEY (`id_recuerdo`),
  KEY `r_m_idx` (`id_mundo`),
  CONSTRAINT `re_mu` FOREIGN KEY (`id_mundo`) REFERENCES `mundo` (`id_mundo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='descripcion de los recuerdos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recuerdo`
--

LOCK TABLES `recuerdo` WRITE;
/*!40000 ALTER TABLE `recuerdo` DISABLE KEYS */;
INSERT INTO `recuerdo` (`id_recuerdo`, `id_mundo`, `nombrerecuerdo`) VALUES (1,1,'foto 1'),(2,1,'foto 2'),(3,1,'foto 3'),(4,1,'foto 4'),(5,1,'foto 5'),(6,1,'foto 6'),(7,1,'foto 7'),(8,1,'foto 8'),(9,1,'foto 9'),(10,1,'foto 10');
/*!40000 ALTER TABLE `recuerdo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de registro',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `nick` varchar(100) DEFAULT 'Null' COMMENT 'Nombre de usuario',
  `creacion` datetime DEFAULT NULL COMMENT 'Fecha de creacion',
  `ultimaconexion` datetime DEFAULT NULL COMMENT 'fecha de ultima conexion',
  `Poder_Muestra` int(11) DEFAULT '0' COMMENT 'cantidad de ayudas para mostrar imagen completa disponible',
  `Poder_QuitaCandado` int(11) DEFAULT '0' COMMENT '????',
  `Poder_MueveOscuros` int(11) DEFAULT '0' COMMENT '????',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `nick_UNIQUE` (`nick`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Jugador';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id_usuario`, `email`, `nick`, `creacion`, `ultimaconexion`, `Poder_Muestra`, `Poder_QuitaCandado`, `Poder_MueveOscuros`) VALUES (1,'sergioalgorry@hotmail.com','sergio','2015-03-10 12:00:00','2015-03-17 19:54:59',NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-17 20:01:07
