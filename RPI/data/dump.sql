-- MySQL dump 10.18  Distrib 10.3.27-MariaDB, for debian-linux-gnueabihf (armv8l)
--
-- Host: localhost    Database: TreinDB
-- ------------------------------------------------------
-- Server version	10.3.27-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tblRitten`
--

DROP TABLE IF EXISTS `tblRitten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblRitten` (
  `RitID` int(11) NOT NULL AUTO_INCREMENT,
  `Starttijd` datetime NOT NULL,
  `VerwachteAankomst` datetime NOT NULL,
  `EchteAankomst` datetime NOT NULL,
  `VertragingTypeID` int(11) DEFAULT NULL,
  `SpoorID` int(11) NOT NULL,
  PRIMARY KEY (`RitID`),
  KEY `fkType` (`VertragingTypeID`),
  KEY `fkSpoor` (`SpoorID`),
  CONSTRAINT `fkSpoor` FOREIGN KEY (`SpoorID`) REFERENCES `tblSpoor` (`SpoorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkType` FOREIGN KEY (`VertragingTypeID`) REFERENCES `tblVertragingType` (`TypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblRitten`
--

LOCK TABLES `tblRitten` WRITE;
/*!40000 ALTER TABLE `tblRitten` DISABLE KEYS */;
INSERT INTO `tblRitten` VALUES (1,'2021-05-24 06:00:00','2021-05-24 08:24:00','2021-05-24 08:24:00',NULL,1),(2,'2021-05-24 06:30:00','2021-05-24 08:54:00','2021-05-24 08:54:00',NULL,1),(3,'2021-05-24 07:00:00','2021-05-24 09:24:00','2021-05-24 09:24:00',NULL,1),(4,'2021-05-24 07:30:00','2021-05-24 09:54:00','2021-05-24 09:59:00',1,1),(5,'2021-05-24 08:00:00','2021-05-24 10:24:00','2021-05-24 10:24:00',NULL,1),(6,'2021-05-24 08:30:00','2021-05-24 10:54:00','2021-05-24 10:54:00',NULL,1),(7,'2021-05-24 09:00:00','2021-05-24 11:24:00','2021-05-24 11:24:00',NULL,1),(8,'2021-05-24 09:30:00','2021-05-24 11:54:00','2021-05-24 11:54:00',NULL,1),(9,'2021-05-24 10:00:00','2021-05-24 12:24:00','2021-05-24 12:24:00',1,1),(10,'2021-05-24 10:30:00','2021-05-24 12:54:00','2021-05-24 12:54:00',NULL,1),(11,'2021-05-24 11:00:00','2021-05-24 13:24:00','2021-05-24 13:24:00',NULL,1),(12,'2021-05-24 11:30:00','2021-05-24 13:54:00','2021-05-24 13:54:00',1,1),(13,'2021-05-24 12:00:00','2021-05-24 14:24:00','2021-05-24 14:24:00',NULL,1),(14,'2021-05-24 12:30:00','2021-05-24 14:54:00','2021-05-24 14:54:00',NULL,1),(15,'2021-05-24 13:00:00','2021-05-24 15:24:00','2021-05-24 15:24:00',3,1),(16,'2021-05-24 13:30:00','2021-05-24 15:54:00','2021-05-24 15:54:00',3,1),(17,'2021-05-24 14:00:00','2021-05-24 16:24:00','2021-05-24 16:24:00',1,1),(18,'2021-05-24 14:30:00','2021-05-24 16:54:00','2021-05-24 16:54:00',NULL,1),(19,'2021-05-24 15:00:00','2021-05-24 17:24:00','2021-05-24 17:24:00',NULL,1),(20,'2021-05-24 15:30:00','2021-05-24 17:54:00','2021-05-24 17:54:00',NULL,1),(21,'2021-05-24 16:00:00','2021-05-24 18:24:00','2021-05-24 18:24:00',2,1),(22,'2021-05-24 16:30:00','2021-05-24 18:54:00','2021-05-24 18:54:00',NULL,1),(23,'2021-05-24 17:00:00','2021-05-24 19:24:00','2021-05-24 19:24:00',1,1),(24,'2021-05-24 17:30:00','2021-05-24 19:54:00','2021-05-24 19:54:00',NULL,1),(25,'2021-05-24 18:00:00','2021-05-24 20:24:00','2021-05-24 20:24:00',NULL,1),(26,'2021-05-24 18:30:00','2021-05-24 20:54:00','2021-05-24 20:54:00',NULL,1),(27,'2021-05-24 19:00:00','2021-05-24 21:24:00','2021-05-24 21:24:00',NULL,1),(28,'2021-05-24 19:30:00','2021-05-24 21:54:00','2021-05-24 21:54:00',1,1),(29,'2021-05-24 20:00:00','2021-05-24 22:24:00','2021-05-24 22:24:00',NULL,1),(30,'2021-05-24 20:30:00','2021-05-24 22:54:00','2021-05-24 22:54:00',NULL,1),(31,'2021-05-24 21:00:00','2021-05-24 23:24:00','2021-05-24 23:24:00',NULL,1),(32,'2021-05-25 06:00:00','2021-05-25 08:24:00','2021-05-25 08:24:00',NULL,1),(33,'2021-05-25 06:30:00','2021-05-25 08:54:00','2021-05-25 08:54:00',1,1),(34,'2021-05-25 07:00:00','2021-05-25 09:24:00','2021-05-25 09:24:00',NULL,1),(35,'2021-05-25 07:30:00','2021-05-25 09:54:00','2021-05-25 09:54:00',NULL,1),(36,'2021-05-25 08:00:00','2021-05-25 10:24:00','2021-05-25 10:24:00',NULL,1),(37,'2021-05-25 08:30:00','2021-05-25 10:54:00','2021-05-25 10:54:00',NULL,1),(38,'2021-05-25 09:00:00','2021-05-25 11:24:00','2021-05-25 11:24:00',1,1),(39,'2021-05-25 09:30:00','2021-05-25 11:54:00','2021-05-25 11:54:00',NULL,1),(40,'2021-05-25 10:00:00','2021-05-25 12:24:00','2021-05-25 12:24:00',NULL,1),(41,'2021-05-25 10:30:00','2021-05-25 12:54:00','2021-05-25 12:54:00',NULL,1),(42,'2021-05-25 11:00:00','2021-05-25 13:24:00','2021-05-25 13:24:00',2,1),(43,'2021-05-25 11:30:00','2021-05-25 13:54:00','2021-05-25 13:54:00',2,1),(44,'2021-05-25 12:00:00','2021-05-25 14:24:00','2021-05-25 14:24:00',2,1),(45,'2021-05-25 12:30:00','2021-05-25 14:54:00','2021-05-25 14:54:00',NULL,1),(46,'2021-05-25 13:00:00','2021-05-25 15:24:00','2021-05-25 15:24:00',NULL,1),(47,'2021-05-25 13:30:00','2021-05-25 15:54:00','2021-05-25 15:54:00',NULL,1),(48,'2021-05-25 14:00:00','2021-05-25 16:24:00','2021-05-25 16:24:00',NULL,1),(49,'2021-05-25 14:30:00','2021-05-25 16:54:00','2021-05-25 16:54:00',NULL,1),(50,'2021-05-25 15:00:00','2021-05-25 17:24:00','2021-05-25 17:24:00',NULL,1),(51,'2021-05-25 15:30:00','2021-05-25 17:54:00','2021-05-25 17:54:00',NULL,1),(52,'2021-05-25 16:00:00','2021-05-25 18:24:00','2021-05-25 18:24:00',NULL,1),(53,'2021-05-25 16:30:00','2021-05-25 18:54:00','2021-05-25 18:54:00',NULL,1),(54,'2021-05-25 17:00:00','2021-05-25 19:24:00','2021-05-25 19:24:00',1,1),(55,'2021-05-25 17:30:00','2021-05-25 19:54:00','2021-05-25 19:54:00',NULL,1),(56,'2021-05-25 18:00:00','2021-05-25 20:24:00','2021-05-25 20:24:00',NULL,1),(57,'2021-05-25 18:30:00','2021-05-25 20:54:00','2021-05-25 20:54:00',NULL,1),(58,'2021-05-25 19:00:00','2021-05-25 21:24:00','2021-05-25 21:24:00',NULL,1),(59,'2021-05-25 19:30:00','2021-05-25 21:54:00','2021-05-25 21:54:00',NULL,1),(60,'2021-05-25 20:00:00','2021-05-25 22:24:00','2021-05-25 22:24:00',NULL,1),(61,'2021-05-25 20:30:00','2021-05-25 22:54:00','2021-05-25 22:54:00',1,1),(62,'2021-05-25 21:00:00','2021-05-25 23:24:00','2021-05-25 23:24:00',NULL,1);
/*!40000 ALTER TABLE `tblRitten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblSpoor`
--

DROP TABLE IF EXISTS `tblSpoor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblSpoor` (
  `SpoorID` int(11) NOT NULL AUTO_INCREMENT,
  `Spoor` int(11) NOT NULL,
  `Subspoor` varchar(1) NOT NULL,
  PRIMARY KEY (`SpoorID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblSpoor`
--

LOCK TABLES `tblSpoor` WRITE;
/*!40000 ALTER TABLE `tblSpoor` DISABLE KEYS */;
INSERT INTO `tblSpoor` VALUES (1,1,'A'),(2,1,'B'),(3,1,'C'),(4,2,'A'),(5,2,'B'),(6,2,'C');
/*!40000 ALTER TABLE `tblSpoor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblVertragingType`
--

DROP TABLE IF EXISTS `tblVertragingType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblVertragingType` (
  `TypeID` int(11) NOT NULL,
  `Beschrijving` varchar(150) NOT NULL,
  PRIMARY KEY (`TypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblVertragingType`
--

LOCK TABLES `tblVertragingType` WRITE;
/*!40000 ALTER TABLE `tblVertragingType` DISABLE KEYS */;
INSERT INTO `tblVertragingType` VALUES (1,'Te laat vertrokken'),(2,'Techniesch probleem'),(3,'Spoorloper'),(4,'Noodstop');
/*!40000 ALTER TABLE `tblVertragingType` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-28  9:14:58
