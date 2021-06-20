-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for brp
CREATE DATABASE IF NOT EXISTS `brp` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `brp`;

-- Dumping structure for table brp.apartments
CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table brp.apartments: ~0 rows (approximately)
/*!40000 ALTER TABLE `apartments` DISABLE KEYS */;
INSERT IGNORE INTO `apartments` (`id`, `name`, `type`, `label`, `citizenid`) VALUES
	(1, 'apartment22994', 'apartment2', 'Morningwood Blvd 2994', 'RPH12999');
/*!40000 ALTER TABLE `apartments` ENABLE KEYS */;

-- Dumping structure for table brp.api_tokens
CREATE TABLE IF NOT EXISTS `api_tokens` (
  `token` varchar(255) NOT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `time` int(25) DEFAULT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.api_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `api_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_tokens` ENABLE KEYS */;

-- Dumping structure for table brp.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.bans: ~0 rows (approximately)
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Dumping structure for table brp.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.bills: ~0 rows (approximately)
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;

-- Dumping structure for table brp.companies
CREATE TABLE IF NOT EXISTS `companies` (
  `name` tinytext DEFAULT NULL,
  `label` tinytext DEFAULT NULL,
  `owner` tinytext DEFAULT NULL,
  `employees` tinytext DEFAULT NULL,
  `money` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.companies: ~0 rows (approximately)
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;

-- Dumping structure for table brp.crypto
CREATE TABLE IF NOT EXISTS `crypto` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.crypto: ~0 rows (approximately)
/*!40000 ALTER TABLE `crypto` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto` ENABLE KEYS */;

-- Dumping structure for table brp.crypto_transactions
CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.crypto_transactions: ~0 rows (approximately)
/*!40000 ALTER TABLE `crypto_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto_transactions` ENABLE KEYS */;

-- Dumping structure for table brp.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`#`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.dealers: ~0 rows (approximately)
/*!40000 ALTER TABLE `dealers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dealers` ENABLE KEYS */;

-- Dumping structure for table brp.dpkeybinds
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.dpkeybinds: ~0 rows (approximately)
/*!40000 ALTER TABLE `dpkeybinds` DISABLE KEYS */;
INSERT IGNORE INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:110000134b1e3f1', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
/*!40000 ALTER TABLE `dpkeybinds` ENABLE KEYS */;

-- Dumping structure for table brp.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table brp.fine_types: ~89 rows (approximately)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT IGNORE INTO `fine_types` (`id`, `label`, `amount`, `category`, `jailtime`) VALUES
	(1, 'Murder', 25000, 0, 0),
	(2, 'Involuntary Manslaughter', 10000, 0, 120),
	(3, 'Vehicular Manslaughter', 7500, 0, 100),
	(4, 'Attempted Murder on LEO', 1500, 0, 60),
	(5, 'Attempted Murder', 1000, 0, 50),
	(6, 'Assault w/ Deadly Weapon on LEO', 700, 0, 45),
	(7, 'Assault w/ Deadly Weapon', 350, 0, 30),
	(8, 'Assault on LEO', 150, 0, 15),
	(9, 'Assault', 100, 0, 10),
	(10, 'Kidnapping of an LEO', 400, 0, 40),
	(11, 'Kidnapping / Hostage Taking', 200, 0, 20),
	(12, 'Bank Robbery', 800, 0, 50),
	(13, 'Armored Truck Robbery', 650, 0, 40),
	(14, 'Jewelery Store Robbery ', 500, 0, 30),
	(15, 'Store Robbery', 150, 0, 15),
	(16, 'House Robbery', 100, 0, 10),
	(17, 'Corruption', 10000, 0, 650),
	(18, 'Felony Driving Under the Influence', 300, 0, 30),
	(19, 'Grand Theft Auto', 300, 0, 20),
	(20, 'Evading Arrest', 200, 0, 20),
	(21, 'Driving Under the Influence', 150, 0, 15),
	(22, 'Hit and Run', 150, 0, 15),
	(23, 'Operating a Motor Vehicle without a License', 100, 0, 10),
	(24, 'Criminal Speeding', 300, 0, 10),
	(25, 'Excessive Speeding 4', 250, 0, 0),
	(26, 'Excessive Speeding 3', 200, 0, 0),
	(27, 'Excessive Speeding 2', 150, 0, 0),
	(28, 'Excessive Speeding', 100, 0, 0),
	(29, 'Operating an Unregisted Motor Vehicle', 100, 0, 5),
	(30, 'Reckless Endangerment', 150, 0, 5),
	(31, 'Careless Driving', 100, 0, 0),
	(32, 'Operating a Non-Street Legal Vehicle', 200, 0, 5),
	(33, 'Failure to Stop', 100, 0, 0),
	(34, 'Obstructing Traffic', 150, 0, 0),
	(35, 'Illegal Lane Change', 100, 0, 0),
	(36, 'Failure to Yield to an Emergency Vehicle', 150, 0, 0),
	(37, 'Illegal Parking', 100, 0, 0),
	(38, 'Excessive Vehicle Noise', 100, 0, 0),
	(39, 'Driving without Proper Use of Headlights', 100, 0, 0),
	(40, 'Illegal U-Turn', 100, 0, 0),
	(41, 'Drug Manufacturing/Cultivation', 550, 0, 40),
	(42, 'Possession of Schedule 1 Drug', 150, 0, 15),
	(43, 'Possession of Schedule 2 Drug', 250, 0, 20),
	(44, 'Sale/Distribution of Schedule 1 Drug', 250, 0, 20),
	(45, 'Sale/Distribution of Schedule 2 Drug', 400, 0, 30),
	(46, 'Drug Trafficking', 500, 0, 40),
	(47, 'Weapons Caching of Class 2s', 2500, 0, 120),
	(48, 'Weapons Caching of Class 1s', 1250, 0, 60),
	(49, 'Weapons Trafficking of Class 2s', 1700, 0, 80),
	(50, 'Weapons Trafficking of Class 1s', 800, 0, 45),
	(51, 'Possession of a Class 2 Firearm', 800, 0, 40),
	(52, 'Possession of a Class 1 Firearm', 150, 0, 15),
	(53, 'Brandishing a Firearm', 100, 0, 5),
	(54, 'Unlawful discharge of a firearm', 150, 0, 10),
	(55, 'Perjury', 1000, 0, 60),
	(56, 'Arson', 500, 0, 30),
	(57, 'False Impersonation of a Government Official', 200, 0, 25),
	(58, 'Possession of Dirty Money', 200, 0, 25),
	(59, 'Possession of Stolen Goods', 100, 0, 15),
	(60, 'Unlawful Solicitation', 150, 0, 20),
	(61, 'Larceny', 150, 0, 20),
	(62, 'Felony Attempted Commision of an Offence/Crime', 350, 0, 20),
	(63, 'Tampering With Evidence', 200, 0, 20),
	(64, 'Illegal Gambling', 200, 0, 20),
	(65, 'Bribery', 200, 0, 20),
	(66, 'Stalking', 350, 0, 20),
	(67, 'Organizing an illegal event', 150, 0, 15),
	(68, 'Participating in an illegal event', 50, 0, 5),
	(69, 'Criminal Mischief', 100, 0, 15),
	(70, 'Prostitution', 250, 0, 15),
	(71, 'Failure to Identify', 150, 0, 15),
	(72, 'Obstruction of Justice', 150, 0, 15),
	(73, 'Resisting Arrest', 100, 0, 10),
	(74, 'Disturbing the Peace', 100, 0, 10),
	(75, 'Threat to do Bodily Harm', 100, 0, 10),
	(76, 'Terroristic Threat', 150, 0, 10),
	(77, 'Damage to Government Property', 150, 0, 10),
	(78, 'Contempt of Court', 250, 0, 10),
	(79, 'Failure to Obey a Lawful Order', 150, 0, 10),
	(80, 'False Report', 100, 0, 10),
	(81, 'Trespassing', 100, 0, 10),
	(82, 'Loitering', 100, 0, 0),
	(83, 'Public Intoxication', 100, 0, 0),
	(84, 'Indecent Exposure', 100, 0, 0),
	(85, 'Verbal Harassment ', 100, 0, 0),
	(86, 'Aiding and Abetting', 100, 0, 0),
	(87, 'Incident Report', 0, 0, 0),
	(88, 'Written Citation', 0, 0, 0),
	(89, 'Verbal Warning', 0, 0, 0);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping structure for table brp.gangs
CREATE TABLE IF NOT EXISTS `gangs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `grades` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.gangs: ~0 rows (approximately)
/*!40000 ALTER TABLE `gangs` DISABLE KEYS */;
/*!40000 ALTER TABLE `gangs` ENABLE KEYS */;

-- Dumping structure for table brp.gang_territoriums
CREATE TABLE IF NOT EXISTS `gang_territoriums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang` varchar(50) DEFAULT NULL,
  `points` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.gang_territoriums: ~0 rows (approximately)
/*!40000 ALTER TABLE `gang_territoriums` DISABLE KEYS */;
/*!40000 ALTER TABLE `gang_territoriums` ENABLE KEYS */;

-- Dumping structure for table brp.gloveboxitems
CREATE TABLE IF NOT EXISTS `gloveboxitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `info` text DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.gloveboxitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `gloveboxitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `gloveboxitems` ENABLE KEYS */;

-- Dumping structure for table brp.gloveboxitemsnew
CREATE TABLE IF NOT EXISTS `gloveboxitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.gloveboxitemsnew: ~0 rows (approximately)
/*!40000 ALTER TABLE `gloveboxitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `gloveboxitemsnew` ENABLE KEYS */;

-- Dumping structure for table brp.houselocations
CREATE TABLE IF NOT EXISTS `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(2) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table brp.houselocations: ~4 rows (approximately)
/*!40000 ALTER TABLE `houselocations` DISABLE KEYS */;
INSERT IGNORE INTO `houselocations` (`id`, `name`, `label`, `coords`, `owned`, `price`, `tier`, `garage`) VALUES
	(1, 'jamestown st1', 'Jamestown St 1', '{"enter":{"h":275.31494140625,"x":514.312255859375,"y":-1780.7127685546876,"z":28.913972854614259},"cam":{"yaw":-10.0,"h":275.31494140625,"x":514.312255859375,"y":-1780.7127685546876,"z":28.913972854614259}}', 1, 100, 1, NULL),
	(2, 'route 681', 'Route 68 1', '{"cam":{"x":1064.8043212890626,"yaw":-10.0,"z":41.26227569580078,"y":3066.050537109375,"h":260.467041015625},"enter":{"z":41.26227569580078,"y":3066.050537109375,"x":1064.8043212890626,"h":260.467041015625}}', 1, 10, 1, NULL),
	(3, 'route 682', 'Route 68 2', '{"cam":{"x":1068.4716796875,"yaw":-10.0,"z":41.0790901184082,"y":3070.9404296875,"h":279.6314697265625},"enter":{"z":41.0790901184082,"y":3070.9404296875,"x":1068.4716796875,"h":279.6314697265625}}', 1, 1, 1, NULL),
	(4, 'strawberry ave1', 'Strawberry Ave 1', '{"cam":{"z":30.68684959411621,"y":-1556.910400390625,"x":-24.7157974243164,"h":234.947021484375,"yaw":-10.0},"enter":{"y":-1556.910400390625,"x":-24.7157974243164,"h":234.947021484375,"z":30.68684959411621}}', 0, 10, 1, NULL),
	(5, 'route 683', 'Route 68 3', '{"cam":{"yaw":-10.0,"z":40.49644470214844,"x":1159.010009765625,"y":3118.09521484375,"h":24.18169403076172},"enter":{"h":24.18169403076172,"y":3118.09521484375,"z":40.49644470214844,"x":1159.010009765625}}', 1, 1, 7, NULL);
/*!40000 ALTER TABLE `houselocations` ENABLE KEYS */;

-- Dumping structure for table brp.house_plants
CREATE TABLE IF NOT EXISTS `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building` (`building`),
  KEY `plantid` (`plantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.house_plants: ~0 rows (approximately)
/*!40000 ALTER TABLE `house_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_plants` ENABLE KEYS */;

-- Dumping structure for table brp.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `grades` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table brp.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.lapraces: ~0 rows (approximately)
/*!40000 ALTER TABLE `lapraces` DISABLE KEYS */;
/*!40000 ALTER TABLE `lapraces` ENABLE KEYS */;

-- Dumping structure for table brp.mdt_reports
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` varchar(48) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `incident` longtext DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.mdt_reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_reports` ENABLE KEYS */;

-- Dumping structure for table brp.mdt_warrants
CREATE TABLE IF NOT EXISTS `mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `char_id` varchar(48) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.mdt_warrants: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_warrants` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_warrants` ENABLE KEYS */;

-- Dumping structure for table brp.memberships
CREATE TABLE IF NOT EXISTS `memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `givenby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.memberships: ~0 rows (approximately)
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
/*!40000 ALTER TABLE `memberships` ENABLE KEYS */;

-- Dumping structure for table brp.moneysafes
CREATE TABLE IF NOT EXISTS `moneysafes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `safe` varchar(50) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT 0,
  `transactions` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.moneysafes: ~0 rows (approximately)
/*!40000 ALTER TABLE `moneysafes` DISABLE KEYS */;
/*!40000 ALTER TABLE `moneysafes` ENABLE KEYS */;

-- Dumping structure for table brp.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.occasion_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `occasion_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `occasion_vehicles` ENABLE KEYS */;

-- Dumping structure for table brp.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=latin1;

-- Dumping data for table brp.permissions: ~1 rows (approximately)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT IGNORE INTO `permissions` (`id`, `name`, `steam`, `license`, `permission`) VALUES
	(151, 'ANoXShadow', 'steam:110000134b1e3f1', 'license:de2e7dd2d4d9cbd66cdc5473a06c6d4f19f3a7f2', 'god');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table brp.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` longtext DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `invoiceid` longtext DEFAULT NULL,
  `sender` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  PRIMARY KEY (`#`) USING BTREE,
  KEY `citizenid` (`citizenid`(768)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.phone_invoices: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_invoices` ENABLE KEYS */;

-- Dumping structure for table brp.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.phone_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table brp.phone_tweets
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.phone_tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_tweets` ENABLE KEYS */;

-- Dumping structure for table brp.playerammo
CREATE TABLE IF NOT EXISTS `playerammo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `ammo` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.playerammo: ~0 rows (approximately)
/*!40000 ALTER TABLE `playerammo` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerammo` ENABLE KEYS */;

-- Dumping structure for table brp.playeritems
CREATE TABLE IF NOT EXISTS `playeritems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.playeritems: ~0 rows (approximately)
/*!40000 ALTER TABLE `playeritems` DISABLE KEYS */;
/*!40000 ALTER TABLE `playeritems` ENABLE KEYS */;

-- Dumping structure for table brp.players
CREATE TABLE IF NOT EXISTS `players` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `tattoos` longtext DEFAULT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pet` varchar(50) NOT NULL,
  PRIMARY KEY (`#`),
  KEY `citizenid` (`citizenid`),
  KEY `last_updated` (`last_updated`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table brp.players: ~1 rows (approximately)
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT IGNORE INTO `players` (`#`, `citizenid`, `cid`, `steam`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `tattoos`, `metadata`, `inventory`, `last_updated`, `pet`) VALUES
	(1, 'RPH12999', 1, 'steam:110000134b1e3f1', 'license:de2e7dd2d4d9cbd66cdc5473a06c6d4f19f3a7f2', 'ANoXShadow', '{"bank":853.0,"crypto":0,"cash":1000003330.0}', '{"birthdate":"1999-03-21","lastname":"Shadow","account":"NL02QBUS7594575292","nationality":"Pakistan","phone":"0616767035","firstname":"ANoX","cid":"1","gender":0,"backstory":"placeholder backstory"}', '{"label":"Trucker","payment":80,"name":"trucker","onduty":true,"grade":{"level":0,"name":"Employee"},"isboss":false}', '{"label":"The Family","name":"thefamily"}', '{"y":4493.158203125,"x":2621.069091796875,"a":277.89215087890627,"z":342.3479309082031}', NULL, '{"inlaststand":false,"bloodtype":"B+","thirst":88.60000000000001,"criminalrecord":{"hasRecord":false},"isdead":false,"status":[],"inside":{"apartment":[]},"phone":{"profilepicture":"https://cdn.discordapp.com/avatars/687469571526885376/60f7c1ed3d533b3196db5c5d5d73b882.png?size=256","background":"default-qbus"},"dealerrep":0,"armor":75,"fitbit":[],"callsign":"NO CALLSIGN","ishandcuffed":false,"walletid":"QB-68874782","commandbinds":[],"hunger":95.8,"licences":{"driver":true,"business":false},"injail":0,"jailitems":[],"jobrep":{"tow":0,"taxi":0,"trucker":0,"hotdog":0},"attachmentcraftingrep":0,"stress":100,"tracker":false,"fingerprint":"Wv045e73TOv5483","currentapartment":"apartment22994","craftingrep":0,"phonedata":{"SerialNumber":94181315,"InstalledApps":[]}}', '[{"slot":1,"info":{"firstname":"ANoX","type":"A1-A2-A | AM-B | C1-C-CE","birthdate":"1999-03-21","lastname":"Shadow"},"amount":1,"type":"item","name":"driver_license"},{"slot":2,"info":{"nationality":"Pakistan","birthdate":"1999-03-21","firstname":"ANoX","citizenid":"RPH12999","gender":0,"lastname":"Shadow"},"amount":1,"type":"item","name":"id_card"},{"slot":3,"info":[],"amount":1,"type":"item","name":"trojan_usb"},{"slot":4,"info":[],"amount":1,"type":"item","name":"thermite"},{"slot":5,"info":[],"amount":1,"type":"item","name":"lighter"},{"slot":6,"info":[],"amount":1,"type":"item","name":"drill"},{"slot":7,"info":[],"amount":1,"type":"item","name":"phone"},{"slot":8,"info":[],"amount":1,"type":"item","name":"electronickit"}]', '2021-05-11 21:27:39', '');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;

-- Dumping structure for table brp.playerskins
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table brp.playerskins: ~1 rows (approximately)
/*!40000 ALTER TABLE `playerskins` DISABLE KEYS */;
INSERT IGNORE INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
	(6, 'RPH12999', '1885233650', '{"torso2":{"defaultItem":0,"texture":0,"item":220,"defaultTexture":0},"ear":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"bag":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"pants":{"defaultItem":0,"texture":0,"item":31,"defaultTexture":0},"lipstick":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"vest":{"defaultItem":0,"texture":0,"item":2,"defaultTexture":0},"glass":{"defaultItem":0,"texture":1,"item":21,"defaultTexture":0},"blush":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"makeup":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"hair":{"defaultItem":0,"texture":0,"item":32,"defaultTexture":0},"face":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"hat":{"defaultItem":-1,"texture":0,"item":75,"defaultTexture":0},"t-shirt":{"defaultItem":1,"texture":0,"item":15,"defaultTexture":0},"ageing":{"defaultItem":-1,"texture":0,"item":2,"defaultTexture":0},"eyebrows":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"bracelet":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0},"accessory":{"defaultItem":0,"texture":0,"item":6,"defaultTexture":0},"shoes":{"defaultItem":1,"texture":0,"item":25,"defaultTexture":0},"mask":{"defaultItem":0,"texture":1,"item":56,"defaultTexture":0},"decals":{"defaultItem":0,"texture":0,"item":0,"defaultTexture":0},"arms":{"defaultItem":0,"texture":0,"item":17,"defaultTexture":0},"beard":{"defaultItem":-1,"texture":1,"item":-1,"defaultTexture":1},"watch":{"defaultItem":-1,"texture":0,"item":-1,"defaultTexture":0}}', 1);
/*!40000 ALTER TABLE `playerskins` ENABLE KEYS */;

-- Dumping structure for table brp.player_boats
CREATE TABLE IF NOT EXISTS `player_boats` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `boathouse` varchar(50) DEFAULT NULL,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `state` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`#`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.player_boats: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_boats` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_boats` ENABLE KEYS */;

-- Dumping structure for table brp.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.player_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_contacts` ENABLE KEYS */;

-- Dumping structure for table brp.player_houses
CREATE TABLE IF NOT EXISTS `player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `cupboard` mediumtext DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `house` (`house`),
  KEY `citizenid` (`citizenid`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.player_houses: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_houses` DISABLE KEYS */;
INSERT IGNORE INTO `player_houses` (`id`, `house`, `identifier`, `citizenid`, `keyholders`, `decorations`, `stash`, `cupboard`, `outfit`, `logout`) VALUES
	(1, 'route 683', 'steam:110000134b1e3f1', 'RPH12999', 'null', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `player_houses` ENABLE KEYS */;

-- Dumping structure for table brp.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.player_mails: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_mails` DISABLE KEYS */;
INSERT IGNORE INTO `player_mails` (`id`, `citizenid`, `sender`, `subject`, `message`, `read`, `mailid`, `date`, `button`) VALUES
	(1, 'RPH12999', 'ANoX Shadow', 'Bill', 'You have been sent a bill for, <br>Amount: <br> $10 for testing<br><br> press the button below to accept the bill', 0, 293050, '2021-05-11 21:33:41', '{"enabled":true,"buttonData":[10,"RPH12999"],"buttonEvent":"billing:client:AcceptBill"}');
/*!40000 ALTER TABLE `player_mails` ENABLE KEYS */;

-- Dumping structure for table brp.player_outfits
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `skin` text DEFAULT NULL,
  `outfitId` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `outfitId` (`outfitId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.player_outfits: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_outfits` DISABLE KEYS */;
INSERT IGNORE INTO `player_outfits` (`id`, `citizenid`, `outfitname`, `model`, `skin`, `outfitId`) VALUES
	(1, 'RPH12999', 'Shadow', '1885233650', '{"vest":{"defaultItem":0,"item":2,"defaultTexture":0,"texture":0},"glass":{"defaultItem":0,"item":21,"defaultTexture":0,"texture":1},"eyebrows":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"ear":{"defaultItem":-1,"item":-1,"defaultTexture":0,"texture":0},"beard":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"pants":{"defaultItem":0,"item":31,"defaultTexture":0,"texture":0},"lipstick":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"accessory":{"defaultItem":0,"item":6,"defaultTexture":0,"texture":0},"hair":{"defaultItem":0,"item":32,"defaultTexture":0,"texture":0},"ageing":{"defaultItem":-1,"item":2,"defaultTexture":0,"texture":0},"bag":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"hat":{"defaultItem":-1,"item":75,"defaultTexture":0,"texture":0},"shoes":{"defaultItem":1,"item":25,"defaultTexture":0,"texture":0},"t-shirt":{"defaultItem":1,"item":15,"defaultTexture":0,"texture":0},"blush":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"makeup":{"defaultItem":-1,"item":-1,"defaultTexture":1,"texture":1},"watch":{"defaultItem":-1,"item":-1,"defaultTexture":0,"texture":0},"face":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"arms":{"defaultItem":0,"item":17,"defaultTexture":0,"texture":0},"mask":{"defaultItem":0,"item":56,"defaultTexture":0,"texture":1},"bracelet":{"defaultItem":-1,"item":-1,"defaultTexture":0,"texture":0},"decals":{"defaultItem":0,"item":0,"defaultTexture":0,"texture":0},"torso2":{"defaultItem":0,"item":220,"defaultTexture":0,"texture":0}}', 'outfit-9-2735');
/*!40000 ALTER TABLE `player_outfits` ENABLE KEYS */;

-- Dumping structure for table brp.player_vehicles
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  PRIMARY KEY (`#`),
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  KEY `steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.player_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_vehicles` DISABLE KEYS */;
INSERT IGNORE INTO `player_vehicles` (`#`, `steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `fakeplate`, `garage`, `fuel`, `engine`, `body`, `state`, `depotprice`, `drivingdistance`, `status`) VALUES
	(1, 'steam:110000134b1e3f1', 'RPH12999', 'futo', '2016857647', '{}', '6BG700VD', NULL, 'sapcounsel', 100, 1000, 1000, 1, 0, NULL, NULL);
/*!40000 ALTER TABLE `player_vehicles` ENABLE KEYS */;

-- Dumping structure for table brp.player_warns
CREATE TABLE IF NOT EXISTS `player_warns` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.player_warns: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_warns` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_warns` ENABLE KEYS */;

-- Dumping structure for table brp.queue
CREATE TABLE IF NOT EXISTS `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.queue: ~0 rows (approximately)
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;

-- Dumping structure for table brp.society
CREATE TABLE IF NOT EXISTS `society` (
  `name` longtext DEFAULT NULL,
  `money` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.society: ~0 rows (approximately)
/*!40000 ALTER TABLE `society` DISABLE KEYS */;
/*!40000 ALTER TABLE `society` ENABLE KEYS */;

-- Dumping structure for table brp.stashitems
CREATE TABLE IF NOT EXISTS `stashitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.stashitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `stashitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `stashitems` ENABLE KEYS */;

-- Dumping structure for table brp.stashitemsnew
CREATE TABLE IF NOT EXISTS `stashitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stash` (`stash`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table brp.stashitemsnew: ~7 rows (approximately)
/*!40000 ALTER TABLE `stashitemsnew` DISABLE KEYS */;
INSERT IGNORE INTO `stashitemsnew` (`id`, `stash`, `items`) VALUES
	(1, 'Gun Dealer', '[]'),
	(2, 'ballasstash', '[]'),
	(3, 'boss_gundealer', '[]'),
	(4, 'Hardware Dealer', '[]'),
	(5, 'vagosstash', '[]'),
	(6, 'thefamilystash', '[]'),
	(7, 'starbuckstash', '[]');
/*!40000 ALTER TABLE `stashitemsnew` ENABLE KEYS */;

-- Dumping structure for table brp.trunkitems
CREATE TABLE IF NOT EXISTS `trunkitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `info` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.trunkitems: ~0 rows (approximately)
/*!40000 ALTER TABLE `trunkitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitems` ENABLE KEYS */;

-- Dumping structure for table brp.trunkitemsnew
CREATE TABLE IF NOT EXISTS `trunkitemsnew` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.trunkitemsnew: ~0 rows (approximately)
/*!40000 ALTER TABLE `trunkitemsnew` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunkitemsnew` ENABLE KEYS */;

-- Dumping structure for table brp.user_convictions
CREATE TABLE IF NOT EXISTS `user_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` varchar(48) DEFAULT NULL,
  `offense` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.user_convictions: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_convictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_convictions` ENABLE KEYS */;

-- Dumping structure for table brp.user_mdt
CREATE TABLE IF NOT EXISTS `user_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` varchar(48) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `mugshot_url` varchar(255) DEFAULT NULL,
  `fingerprint` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.user_mdt: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_mdt` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_mdt` ENABLE KEYS */;

-- Dumping structure for table brp.weed
CREATE TABLE IF NOT EXISTS `weed` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Spot` int(10) NOT NULL,
  `Timer` int(10) NOT NULL,
  `Status` int(10) NOT NULL,
  `Ready` int(10) NOT NULL,
  `Water` int(10) NOT NULL,
  `Fertilizer` int(10) NOT NULL,
  `Quality` int(10) NOT NULL,
  `QualityCounter` int(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.weed: ~0 rows (approximately)
/*!40000 ALTER TABLE `weed` DISABLE KEYS */;
/*!40000 ALTER TABLE `weed` ENABLE KEYS */;

-- Dumping structure for table brp.weed_plants
CREATE TABLE IF NOT EXISTS `weed_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `properties` text NOT NULL,
  `plantid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table brp.weed_plants: ~0 rows (approximately)
/*!40000 ALTER TABLE `weed_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `weed_plants` ENABLE KEYS */;

-- Dumping structure for table brp.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `steam` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`steam`),
  UNIQUE KEY `identifier` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brp.whitelist: ~0 rows (approximately)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
