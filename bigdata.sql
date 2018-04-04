-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  lun. 15 jan. 2018 à 15:55
-- Version du serveur :  5.7.19
-- Version de PHP :  5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `bigdata`
--

-- --------------------------------------------------------

--
-- Structure de la table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `name_department` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `department`
--

INSERT INTO `department` (`id`, `department_id`, `name_department`) VALUES
(1, 69, 'Rhône'),
(2, 70113, 'toto'),
(3, 85796, '85796'),
(4, 54895, '54895');

-- --------------------------------------------------------

--
-- Structure de la table `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(150) NOT NULL,
  `zip_code` int(11) NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `link` text NOT NULL,
  `department_id` int(11) NOT NULL,
  `type_id` tinyint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `department_id` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `location`
--

INSERT INTO `location` (`id`, `name`, `address`, `zip_code`, `longitude`, `latitude`, `link`, `department_id`, `type_id`) VALUES
(3, 'saint andre', '', 0, 4.4352354000000105, 45.8956644, '', 70113, 1);

-- --------------------------------------------------------

--
-- Structure de la table `table 4`
--

DROP TABLE IF EXISTS `table 4`;
CREATE TABLE IF NOT EXISTS `table 4` (
  `numero_uai` varchar(10) DEFAULT NULL,
  `appellation_officielle` varchar(159) DEFAULT NULL,
  `denomination_principale` varchar(48) DEFAULT NULL,
  `patronyme_uai` varchar(41) DEFAULT NULL,
  `secteur_public_prive_libe` varchar(36) DEFAULT NULL,
  `adresse_uai` varchar(36) DEFAULT NULL,
  `lieu_dit_uai` varchar(24) DEFAULT NULL,
  `boite_postale_uai` varchar(26) DEFAULT NULL,
  `code_postal_uai` varchar(26) DEFAULT NULL,
  `localite_acheminement_uai` varchar(26) DEFAULT NULL,
  `coordonnee_x` varchar(17) DEFAULT NULL,
  `coordonnee_y` varchar(23) DEFAULT NULL,
  `appariement` varchar(32) DEFAULT NULL,
  `localisation` varchar(52) DEFAULT NULL,
  `nature_uai` varchar(52) DEFAULT NULL,
  `nature_uai_libe` varchar(52) DEFAULT NULL,
  `etat_etablissement` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `table 5`
--

DROP TABLE IF EXISTS `table 5`;
CREATE TABLE IF NOT EXISTS `table 5` (
  `numero_uai` varchar(10) DEFAULT NULL,
  `appellation_officielle` varchar(159) DEFAULT NULL,
  `denomination_principale` varchar(48) DEFAULT NULL,
  `patronyme_uai` varchar(41) DEFAULT NULL,
  `secteur_public_prive_libe` varchar(36) DEFAULT NULL,
  `adresse_uai` varchar(36) DEFAULT NULL,
  `lieu_dit_uai` varchar(24) DEFAULT NULL,
  `boite_postale_uai` varchar(26) DEFAULT NULL,
  `code_postal_uai` varchar(26) DEFAULT NULL,
  `localite_acheminement_uai` varchar(26) DEFAULT NULL,
  `coordonnee_x` varchar(17) DEFAULT NULL,
  `coordonnee_y` varchar(23) DEFAULT NULL,
  `appariement` varchar(32) DEFAULT NULL,
  `localisation` varchar(52) DEFAULT NULL,
  `nature_uai` varchar(52) DEFAULT NULL,
  `nature_uai_libe` varchar(52) DEFAULT NULL,
  `etat_etablissement` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` tinyint(1) NOT NULL,
  `description` varchar(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`id`, `type_id`, `description`) VALUES
(1, 0, 'public'),
(2, 1, 'private');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type` (`type_id`),
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
