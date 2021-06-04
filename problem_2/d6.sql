-- Adminer 4.8.1 MySQL 5.7.24-log dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address_type_id` bigint(20) NOT NULL,
  `street_pobox` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `suburb` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_id` int(11) NOT NULL,
  `code` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `address_type_id` (`address_type_id`),
  KEY `province_id` (`province_id`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`address_type_id`) REFERENCES `address_types` (`id`),
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `addresses` (`id`, `address_type_id`, `street_pobox`, `suburb`, `city`, `province_id`, `code`, `is_primary`) VALUES
(2,	1,	'617 Boeing street',	'Elarduspark',	'Pretoria',	1,	'0181',	1);

DROP TABLE IF EXISTS `address_types`;
CREATE TABLE `address_types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `address_types` (`id`, `name`) VALUES
(1,	'Physical'),
(2,	'Postal');

DROP TABLE IF EXISTS `admissions`;
CREATE TABLE `admissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) NOT NULL,
  `admission_date` datetime NOT NULL,
  `discharge_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `admissions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `admissions` (`id`, `patient_id`, `admission_date`, `discharge_date`) VALUES
(2,	12345,	'2008-07-14 00:00:00',	'2008-07-17 00:00:00');

DROP TABLE IF EXISTS `cost_centers`;
CREATE TABLE `cost_centers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_name` (`code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `cost_centers` (`id`, `code`, `name`) VALUES
(1,	'100',	'Room & Board'),
(2,	'110',	'Laboratory'),
(3,	'125',	'Radiology');

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cost_center_id` bigint(20) DEFAULT NULL,
  `code` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cost_center_id_code_name` (`cost_center_id`,`code`,`name`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`cost_center_id`) REFERENCES `cost_centers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `items` (`id`, `cost_center_id`, `code`, `name`) VALUES
(1,	1,	'2000',	'Semiprv room'),
(2,	1,	'2005',	'Television'),
(3,	2,	'1580',	'Glucose'),
(4,	2,	'1585',	'Culture'),
(5,	3,	'3010',	'Xray chest');

DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `patients` (`id`, `first_name`, `last_name`) VALUES
(12345,	'Mary',	'Baker'),
(12346,	'Eddie',	'Brock');

DROP TABLE IF EXISTS `patient_addresses`;
CREATE TABLE `patient_addresses` (
  `patient_id` bigint(20) NOT NULL,
  `address_id` bigint(20) NOT NULL,
  UNIQUE KEY `patient_id_address_id` (`patient_id`,`address_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `patient_addresses_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`),
  CONSTRAINT `patient_addresses_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `provinces`;
CREATE TABLE `provinces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `provinces` (`id`, `name`) VALUES
(1,	'Gauteng');

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `transaction_date` datetime NOT NULL,
  `patient_id` bigint(20) NOT NULL,
  `cost_center_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `amount` double(14,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_date_patient_id_item_id` (`transaction_date`,`patient_id`,`item_id`),
  KEY `patient_id` (`patient_id`),
  KEY `cost_center_id` (`cost_center_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`cost_center_id`) REFERENCES `cost_centers` (`id`),
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `transactions` (`id`, `transaction_date`, `patient_id`, `cost_center_id`, `item_id`, `amount`) VALUES
(1,	'2008-07-14 00:00:00',	12345,	1,	1,	200.33),
(2,	'2008-08-06 00:00:00',	12346,	2,	1,	456.33),
(3,	'2008-09-09 00:00:00',	12345,	2,	4,	555.33);

-- 2021-06-03 16:20:18
