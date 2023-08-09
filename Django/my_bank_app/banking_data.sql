-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for banking
CREATE DATABASE IF NOT EXISTS `banking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `banking`;

-- Dumping structure for table banking.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.auth_group: ~0 rows (approximately)

-- Dumping structure for table banking.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.auth_group_permissions: ~0 rows (approximately)

-- Dumping structure for table banking.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.auth_permission: ~52 rows (approximately)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add account details', 7, 'add_accountdetails'),
	(26, 'Can change account details', 7, 'change_accountdetails'),
	(27, 'Can delete account details', 7, 'delete_accountdetails'),
	(28, 'Can view account details', 7, 'view_accountdetails'),
	(29, 'Can add uid', 8, 'add_uid'),
	(30, 'Can change uid', 8, 'change_uid'),
	(31, 'Can delete uid', 8, 'delete_uid'),
	(32, 'Can view uid', 8, 'view_uid'),
	(33, 'Can add transaction', 9, 'add_transaction'),
	(34, 'Can change transaction', 9, 'change_transaction'),
	(35, 'Can delete transaction', 9, 'delete_transaction'),
	(36, 'Can view transaction', 9, 'view_transaction'),
	(37, 'Can add tokens', 10, 'add_tokens'),
	(38, 'Can change tokens', 10, 'change_tokens'),
	(39, 'Can delete tokens', 10, 'delete_tokens'),
	(40, 'Can view tokens', 10, 'view_tokens'),
	(41, 'Can add balance', 11, 'add_balance'),
	(42, 'Can change balance', 11, 'change_balance'),
	(43, 'Can delete balance', 11, 'delete_balance'),
	(44, 'Can view balance', 11, 'view_balance'),
	(45, 'Can add authentication', 12, 'add_authentication'),
	(46, 'Can change authentication', 12, 'change_authentication'),
	(47, 'Can delete authentication', 12, 'delete_authentication'),
	(48, 'Can view authentication', 12, 'view_authentication'),
	(49, 'Can add authenticate transaction', 13, 'add_authenticatetransaction'),
	(50, 'Can change authenticate transaction', 13, 'change_authenticatetransaction'),
	(51, 'Can delete authenticate transaction', 13, 'delete_authenticatetransaction'),
	(52, 'Can view authenticate transaction', 13, 'view_authenticatetransaction'),
	(53, 'Can add password reset', 14, 'add_passwordreset'),
	(54, 'Can change password reset', 14, 'change_passwordreset'),
	(55, 'Can delete password reset', 14, 'delete_passwordreset'),
	(56, 'Can view password reset', 14, 'view_passwordreset');

-- Dumping structure for table banking.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.auth_user: ~1 rows (approximately)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$600000$nb7mEyRkOSloAbezDO1AOP$atM8FMliR314KzA0Tswf6AVSRHsScFQYecfGcaym/OE=', '2023-08-04 13:59:04.813594', 1, 'kishan', '', '', 'narasimhakishan392@gmail.com', 1, 1, '2023-08-04 13:58:46.625296');

-- Dumping structure for table banking.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.auth_user_groups: ~0 rows (approximately)

-- Dumping structure for table banking.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.auth_user_user_permissions: ~0 rows (approximately)

-- Dumping structure for table banking.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.django_admin_log: ~2 rows (approximately)
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2023-08-04 14:01:58.489801', '1', 'Tokens object (1)', 1, '[{"added": {}}]', 10, 1),
	(2, '2023-08-08 08:15:01.398845', '2', 'Tokens object (2)', 1, '[{"added": {}}]', 10, 1),
	(3, '2023-08-09 05:55:29.527928', '3', 'Tokens object (3)', 1, '[{"added": {}}]', 10, 1);

-- Dumping structure for table banking.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.django_content_type: ~13 rows (approximately)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(7, 'mybank', 'accountdetails'),
	(13, 'mybank', 'authenticatetransaction'),
	(12, 'mybank', 'authentication'),
	(11, 'mybank', 'balance'),
	(14, 'mybank', 'passwordreset'),
	(10, 'mybank', 'tokens'),
	(9, 'mybank', 'transaction'),
	(8, 'mybank', 'uid'),
	(6, 'sessions', 'session');

-- Dumping structure for table banking.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.django_migrations: ~21 rows (approximately)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2023-08-04 11:21:18.971614'),
	(2, 'auth', '0001_initial', '2023-08-04 11:21:19.269919'),
	(3, 'admin', '0001_initial', '2023-08-04 11:21:19.348444'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2023-08-04 11:21:19.364106'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-08-04 11:21:19.379694'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2023-08-04 11:21:19.426569'),
	(7, 'auth', '0002_alter_permission_name_max_length', '2023-08-04 11:21:19.458223'),
	(8, 'auth', '0003_alter_user_email_max_length', '2023-08-04 11:21:19.473848'),
	(9, 'auth', '0004_alter_user_username_opts', '2023-08-04 11:21:19.489477'),
	(10, 'auth', '0005_alter_user_last_login_null', '2023-08-04 11:21:19.552842'),
	(11, 'auth', '0006_require_contenttypes_0002', '2023-08-04 11:21:19.552842'),
	(12, 'auth', '0007_alter_validators_add_error_messages', '2023-08-04 11:21:19.568317'),
	(13, 'auth', '0008_alter_user_username_max_length', '2023-08-04 11:21:19.631241'),
	(14, 'auth', '0009_alter_user_last_name_max_length', '2023-08-04 11:21:19.678125'),
	(15, 'auth', '0010_alter_group_name_max_length', '2023-08-04 11:21:19.693751'),
	(16, 'auth', '0011_update_proxy_permissions', '2023-08-04 11:21:19.693751'),
	(17, 'auth', '0012_alter_user_first_name_max_length', '2023-08-04 11:21:19.741291'),
	(18, 'mybank', '0001_initial', '2023-08-04 11:21:19.992379'),
	(19, 'sessions', '0001_initial', '2023-08-04 11:21:20.023627'),
	(20, 'mybank', '0002_authenticatetransaction', '2023-08-05 06:09:52.529030'),
	(21, 'mybank', '0003_transaction_transactionamount', '2023-08-08 13:56:27.262506'),
	(22, 'mybank', '0004_passwordreset', '2023-08-09 06:34:42.284268');

-- Dumping structure for table banking.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.django_session: ~1 rows (approximately)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('enfv4tjxzywwjuccnzpb7bllk1hccfxx', '.eJxtkMlOwzAQhl8F5VxFxM7aY1Uh9cAJOFuT8SQxTeziBZAQ745TinARN8_3LzPyRyYg-EkER1YomW2zItukrAc8kl4F-Qx6NDka7a3q89WSX1SX3xtJ8-7ivSqYwE1rumiwHuqGeFvd4oDQsIZJDqwE7IkXZVlLQAKGXVdWWEssGC94V_WsZhzaWDopKUnHrkcbKM70rpx34i9W-hVmJYU3xzO-g9mtfL3msBffqYSfwLk3Y6Ww9CIGUDPJRP1pm82o9H-pRbkFPE6J9nTYx6lhXXwDognaa5Nti5K35SbTsFCUH3wA62921sD6Y06NOpzO-5MmS1JZQn-FBksuXRdPM-HX8vkFqIiaDQ:1qTczI:OvqkbVnoTtuPZ2hQxJ6CgqXYLBne34jqaO8CPF5YKWY', '2023-08-23 06:48:08.618063');

-- Dumping structure for table banking.mybank_accountdetails
CREATE TABLE IF NOT EXISTS `mybank_accountdetails` (
  `AccountNumber` int NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `address` varchar(1048) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`AccountNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.mybank_accountdetails: ~12 rows (approximately)
INSERT INTO `mybank_accountdetails` (`AccountNumber`, `firstname`, `lastname`, `address`, `email`) VALUES
	(14382, 'Steve', 'Bennet', 'To be Updated', 'Steve.Ben@hotmail.com'),
	(14383, 'Mathew', 'Cooper', 'To be Updated', 'Mathew.Coo@hotmail.com'),
	(14384, 'Stuart', 'Broad', 'To be Updated', 'Stuart.Bro@hotmail.com'),
	(14385, 'Lee', 'Softer', 'To be Updated', 'Lee.Sof@hotmail.com'),
	(14386, 'Leonard', 'Long', 'To be Updated', 'Leonard.Lon@hotmail.com'),
	(14387, 'Aston', 'Debby', 'To be Updated', 'Aston.Deb@hotmail.com'),
	(14388, 'Nord', 'Santos', 'To be Updated', 'Nord.San@hotmail.com'),
	(14389, 'Bradd', 'Jolly', 'To be Updated', 'Bradd.Jol@hotmail.com'),
	(14390, 'Lina', 'Smith', 'To be Updated', 'Lina.Smi@hotmail.com'),
	(14391, 'Robert', 'Label', 'To be Updated', 'Robert.Lab@hotmail.com'),
	(14392, 'Jack', 'Hunter', 'To be Updated', 'Jack.Hun@hotmail.com'),
	(14393, 'John', 'Bober', 'To be Updated', 'John.Bob@hotmail.com');

-- Dumping structure for table banking.mybank_authenticatetransaction
CREATE TABLE IF NOT EXISTS `mybank_authenticatetransaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `trans_password` varchar(128) NOT NULL,
  `userID_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mybank_authenticatet_userID_id_f63a0d4c_fk_mybank_ui` (`userID_id`),
  CONSTRAINT `mybank_authenticatet_userID_id_f63a0d4c_fk_mybank_ui` FOREIGN KEY (`userID_id`) REFERENCES `mybank_uid` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.mybank_authenticatetransaction: ~2 rows (approximately)
INSERT INTO `mybank_authenticatetransaction` (`id`, `trans_password`, `userID_id`) VALUES
	(5, '2dbd23b43399314ccb8889885ff11e7da0e4720bfbe14137b9ec76153fad21a1', 727),
	(6, 'c843e991977d695921bf7700bd94212828bb554569aa8777a1153492d23cbc0c', 728);

-- Dumping structure for table banking.mybank_authentication
CREATE TABLE IF NOT EXISTS `mybank_authentication` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `userID_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mybank_authentication_userID_id_6dcaa6ff_fk_mybank_uid_userID` (`userID_id`),
  CONSTRAINT `mybank_authentication_userID_id_6dcaa6ff_fk_mybank_uid_userID` FOREIGN KEY (`userID_id`) REFERENCES `mybank_uid` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.mybank_authentication: ~2 rows (approximately)
INSERT INTO `mybank_authentication` (`id`, `password`, `userID_id`) VALUES
	(3, '2dbd23b43399314ccb8889885ff11e7da0e4720bfbe14137b9ec76153fad21a1', 727),
	(5, 'c843e991977d695921bf7700bd94212828bb554569aa8777a1153492d23cbc0c', 728),
	(6, '6ec4b0b4d4b59641bc9a3187a522ae04fe82c7671cbbe88a399cd182b64d40e7', 729);

-- Dumping structure for table banking.mybank_balance
CREATE TABLE IF NOT EXISTS `mybank_balance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` int NOT NULL,
  `AccountNumber_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mybank_balance_AccountNumber_id_8e1f80e9_fk_mybank_ac` (`AccountNumber_id`),
  CONSTRAINT `mybank_balance_AccountNumber_id_8e1f80e9_fk_mybank_ac` FOREIGN KEY (`AccountNumber_id`) REFERENCES `mybank_accountdetails` (`AccountNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.mybank_balance: ~12 rows (approximately)
INSERT INTO `mybank_balance` (`id`, `balance`, `AccountNumber_id`) VALUES
	(1, 1536, 14382),
	(2, 4515, 14383),
	(3, 7326, 14384),
	(4, 4741, 14385),
	(5, 7694, 14386),
	(6, 7496, 14387),
	(7, 3201, 14388),
	(8, 8171, 14389),
	(9, 8118, 14390),
	(10, 2570, 14391),
	(11, 7616, 14392),
	(12, 4387, 14393);

-- Dumping structure for table banking.mybank_passwordreset
CREATE TABLE IF NOT EXISTS `mybank_passwordreset` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `resetToken` varchar(255) NOT NULL,
  `userID_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mybank_passwordreset_userID_id_6e11e11e_fk_mybank_uid_userID` (`userID_id`),
  CONSTRAINT `mybank_passwordreset_userID_id_6e11e11e_fk_mybank_uid_userID` FOREIGN KEY (`userID_id`) REFERENCES `mybank_uid` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.mybank_passwordreset: ~0 rows (approximately)

-- Dumping structure for table banking.mybank_tokens
CREATE TABLE IF NOT EXISTS `mybank_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `userID_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mybank_tokens_userID_id_5a00dc4b_fk_mybank_uid_userID` (`userID_id`),
  CONSTRAINT `mybank_tokens_userID_id_5a00dc4b_fk_mybank_uid_userID` FOREIGN KEY (`userID_id`) REFERENCES `mybank_uid` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.mybank_tokens: ~2 rows (approximately)
INSERT INTO `mybank_tokens` (`id`, `token`, `userID_id`) VALUES
	(1, 'S9HF2QDN', 727),
	(2, 'D62BGHU9', 728),
	(3, 'HS77YU84', 729);

-- Dumping structure for table banking.mybank_transaction
CREATE TABLE IF NOT EXISTS `mybank_transaction` (
  `ReferenceNum` varchar(255) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `senderBalance` int NOT NULL,
  `recieverBalance` int NOT NULL,
  `reciever_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `transactionAmount` int NOT NULL,
  PRIMARY KEY (`ReferenceNum`),
  KEY `mybank_transaction_reciever_id_a52b705f_fk_mybank_ac` (`reciever_id`),
  KEY `mybank_transaction_sender_id_a3c09f8a_fk_mybank_ac` (`sender_id`),
  CONSTRAINT `mybank_transaction_reciever_id_a52b705f_fk_mybank_ac` FOREIGN KEY (`reciever_id`) REFERENCES `mybank_accountdetails` (`AccountNumber`),
  CONSTRAINT `mybank_transaction_sender_id_a3c09f8a_fk_mybank_ac` FOREIGN KEY (`sender_id`) REFERENCES `mybank_accountdetails` (`AccountNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.mybank_transaction: ~0 rows (approximately)
INSERT INTO `mybank_transaction` (`ReferenceNum`, `timestamp`, `senderBalance`, `recieverBalance`, `reciever_id`, `sender_id`, `transactionAmount`) VALUES
	('2FC3326DA880', '2023-08-08 14:10:53.782253', 1536, 4515, 14383, 14382, 200),
	('48154609618E', '2023-08-08 15:08:59.989673', 4515, 1536, 14382, 14383, 600),
	('6000511D6ECD', '2023-08-08 15:08:11.873823', 936, 5115, 14383, 14382, 300),
	('939470363201', '2023-08-08 15:07:48.007050', 1236, 4815, 14383, 14382, 300);

-- Dumping structure for table banking.mybank_uid
CREATE TABLE IF NOT EXISTS `mybank_uid` (
  `userID` int NOT NULL,
  `AccountNumber_id` int NOT NULL,
  PRIMARY KEY (`userID`),
  KEY `mybank_uid_AccountNumber_id_431f5a46_fk_mybank_ac` (`AccountNumber_id`),
  CONSTRAINT `mybank_uid_AccountNumber_id_431f5a46_fk_mybank_ac` FOREIGN KEY (`AccountNumber_id`) REFERENCES `mybank_accountdetails` (`AccountNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table banking.mybank_uid: ~12 rows (approximately)
INSERT INTO `mybank_uid` (`userID`, `AccountNumber_id`) VALUES
	(727, 14382),
	(728, 14383),
	(729, 14384),
	(730, 14385),
	(731, 14386),
	(732, 14387),
	(733, 14388),
	(734, 14389),
	(735, 14390),
	(736, 14391),
	(737, 14392),
	(738, 14393);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
