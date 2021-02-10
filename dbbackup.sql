-- MySQL dump 10.13  Distrib 5.7.32, for Linux (x86_64)
--
-- Host: localhost    Database: designhouse
-- ------------------------------------------------------
-- Server version	5.7.32-0ubuntu0.18.04.1

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
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,'2020-10-31 01:07:21','2020-10-31 01:09:04'),(2,'2020-10-31 01:09:31','2020-10-31 01:10:24'),(3,'2020-10-31 01:10:12','2020-10-31 01:10:12');
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentable_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_commentable_type_commentable_id_index` (`commentable_type`,`commentable_id`),
  KEY `comments_user_id_index` (`user_id`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,'wow','App\\Models\\Design',2,'2020-10-31 01:00:12','2020-10-31 01:00:12'),(3,3,'Love love love','App\\Models\\Design',1,'2020-10-31 01:01:03','2020-10-31 01:01:03'),(4,3,'could have been better','App\\Models\\Design',2,'2020-10-31 01:01:25','2020-10-31 01:01:25'),(5,3,'nice','App\\Models\\Design',3,'2020-10-31 01:01:45','2020-10-31 01:01:45'),(6,2,'tooo good','App\\Models\\Design',3,'2020-10-31 01:02:30','2020-10-31 01:02:30'),(7,2,'what a pic','App\\Models\\Design',2,'2020-10-31 01:02:50','2020-10-31 01:02:50'),(8,2,'take a bow','App\\Models\\Design',1,'2020-10-31 01:03:05','2020-10-31 01:03:05'),(9,1,'finally its looking fab','App\\Models\\Design',1,'2021-01-01 01:45:05','2021-01-01 01:45:05');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designs`
--

DROP TABLE IF EXISTS `designs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `designs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_live` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `upload_successfull` tinyint(1) NOT NULL DEFAULT '0',
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `team_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `designs_user_id_foreign` (`user_id`),
  CONSTRAINT `designs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designs`
--

LOCK TABLES `designs` WRITE;
/*!40000 ALTER TABLE `designs` DISABLE KEYS */;
INSERT INTO `designs` VALUES (1,3,'1604124095_bir.jpeg','This is owner of s3 resource','Finally getting there','this-is-owner-of-s3-resource',1,'2020-10-31 00:31:35','2020-10-31 00:36:49',1,'s3',1),(2,3,'1604124462_245.jpg','This is jamie\'s design','In love with this set of pics','this-is-jamies-design',1,'2020-10-31 00:37:42','2020-10-31 00:42:19',1,'s3',1),(3,1,'1604124513_milk.jpg','This is saira\'s design','building everythiing from scratch','this-is-sairas-design',1,'2020-10-31 00:38:33','2020-10-31 00:39:44',1,'s3',1),(4,1,'1605092385_purple_sunset-wallpaper-1366x768.jpg','peaceful life','amazing evening spent','peaceful-life',1,'2020-11-11 05:29:46','2020-11-30 09:03:16',1,'s3',1),(5,1,'1605106295_qjh0oyo.jpg',NULL,NULL,NULL,0,'2020-11-11 09:21:35','2020-11-11 09:21:39',1,'public',NULL),(6,1,'1605106386_purple_sunset-wallpaper-1366x768.jpg',NULL,NULL,NULL,0,'2020-11-11 09:23:06','2020-11-11 09:23:07',1,'public',NULL),(7,1,'1605108011_qjh0oyo.jpg',NULL,NULL,NULL,0,'2020-11-11 09:50:11','2020-11-11 09:50:15',1,'public',NULL),(8,1,'1605111922_purple_sunset-wallpaper-1366x768.jpg',NULL,NULL,NULL,0,'2020-11-11 10:55:22','2020-11-11 10:55:26',1,'public',NULL),(9,1,'1605592222_qjh0oyo.jpg','this is locally stored','ssssssssssssssssssssssssssssssssssssssssssssssss','this-is-locally-stored',0,'2020-11-17 00:20:22','2020-12-03 01:33:47',1,'public',NULL),(10,1,'1606370636_qjh0oyo.jpg','ausumn nature','The kind of peace nature gives you is amazing','ausumn-nature',1,'2020-11-26 00:33:56','2020-11-26 00:35:52',1,'s3',3),(11,1,'1611558724_sdqwat.jpg','amazing','What a view this is.It just lifts your spirit up','amazing',1,'2021-01-25 01:42:04','2021-01-25 01:44:31',1,'s3',3);
/*!40000 ALTER TABLE `designs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `team_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned NOT NULL,
  `recipient_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invitations_team_id_foreign` (`team_id`),
  KEY `invitations_sender_id_foreign` (`sender_id`),
  KEY `invitations_recipient_email_index` (`recipient_email`),
  CONSTRAINT `invitations_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invitations_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitations`
--

LOCK TABLES `invitations` WRITE;
/*!40000 ALTER TABLE `invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `likeable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `likeable_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `likes_likeable_type_likeable_id_index` (`likeable_type`,`likeable_id`),
  KEY `likes_user_id_index` (`user_id`),
  CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,2,'App\\Models\\Design',1,'2020-10-31 00:57:53','2020-10-31 00:57:53'),(2,2,'App\\Models\\Design',2,'2020-10-31 00:58:02','2020-10-31 00:58:02'),(3,2,'App\\Models\\Design',3,'2020-10-31 00:58:09','2020-10-31 00:58:09'),(4,3,'App\\Models\\Design',3,'2020-10-31 00:58:41','2020-10-31 00:58:41'),(5,3,'App\\Models\\Design',1,'2020-10-31 00:58:50','2020-10-31 00:58:50'),(7,1,'App\\Models\\Design',2,'2020-10-31 00:59:28','2020-10-31 00:59:28'),(8,1,'App\\Models\\Design',11,'2021-01-25 01:44:50','2021-01-25 01:44:50');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_read` datetime DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,2,'can you add me to your team??','2020-10-31 06:45:05',NULL,'2020-10-31 01:07:21','2020-10-31 01:15:05'),(2,1,2,'can you add me to your team??','2020-10-31 06:45:05',NULL,'2020-10-31 01:07:53','2020-10-31 01:15:05'),(3,1,1,'will get back to u later??','2020-10-31 06:45:05',NULL,'2020-10-31 01:09:04','2020-10-31 01:15:05'),(4,2,1,'lets get together??','2020-10-31 06:44:04',NULL,'2020-10-31 01:09:31','2020-10-31 01:14:04'),(5,3,3,'wanna join me??',NULL,NULL,'2020-10-31 01:10:12','2020-10-31 01:10:12'),(6,2,3,'urgent??',NULL,NULL,'2020-10-31 01:10:24','2020-10-31 01:10:24');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2014_10_12_200000_add_two_factor_columns_to_users_table',1),(4,'2019_08_19_000000_create_failed_jobs_table',1),(5,'2019_12_14_000001_create_personal_access_tokens_table',1),(6,'2020_10_02_164702_create_sessions_table',1),(7,'2020_10_14_120648_create_designs_table',1),(8,'2020_10_16_062157_add_fields_to_designs',1),(9,'2020_10_16_174427_create_jobs_table',1),(10,'2020_10_18_142320_create_taggable_table',1),(11,'2020_10_20_053635_create_comments_table',1),(12,'2020_10_20_120405_create_likes_table',1),(13,'2020_10_26_103756_create_teams_table',1),(14,'2020_10_26_103853_create_team_user_table',1),(15,'2020_10_26_173317_add_team_id_to_designs',1),(16,'2020_10_27_054810_create_invitations_table',1),(17,'2020_10_28_093554_create_chats_table',1),(18,'2020_10_28_094214_create_messages_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participants`
--

DROP TABLE IF EXISTS `participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participants` (
  `chat_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  KEY `participants_user_id_foreign` (`user_id`),
  KEY `participants_chat_id_foreign` (`chat_id`),
  CONSTRAINT `participants_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participants`
--

LOCK TABLES `participants` WRITE;
/*!40000 ALTER TABLE `participants` DISABLE KEYS */;
INSERT INTO `participants` VALUES (1,2),(1,1),(2,1),(2,3),(3,3),(3,2);
/*!40000 ALTER TABLE `participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('3CLxncwKYHJlNtfZ7C24VEMz5ML72IQuUqqNggW1',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTU9CSGJ0b1RyWTZiSk1CM2NlMXZkcTJGbGt3Z0NzTDl5ZHBxUlFrRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9kZXNpZ25ob3VzZS50ZXN0OjgwMDAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1605106821),('cEdbkc5e6k9vuM5FGUdBAEA2YaAtRQPoHGoINvGO',1,'127.0.0.1','PostmanRuntime/7.1.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR3EwWXlOWENLeVF2aE1TdGRvcVNWeDhNVjk2YkRQM3RQUXpmaW1sQyI7czoxNzoicGFzc3dvcmRfaGFzaF9hcGkiO3M6NjA6IiQyeSQxMCRiaHVkVlZvc3VyZkd1MnR6TC9RM3llWTIxS0RRM1N5SkUwWlcvc21RVXZEckc0SThTeGQvaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1605114491),('d4aNUjo1qg8BsoWXXiZG6TbnYFNu3ptHShDaM3UB',NULL,'127.0.0.1','PostmanRuntime/7.1.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRHdMVXdKV2R3dFB6T1E1THBBdFdiUGJKOHJKU3o0SXJKaDk0UnZBYyI7czoxNzoicGFzc3dvcmRfaGFzaF9hcGkiO3M6NjA6IiQyeSQxMCRiaHVkVlZvc3VyZkd1MnR6TC9RM3llWTIxS0RRM1N5SkUwWlcvc21RVXZEckc0SThTeGQvaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1604125639),('LL66kShS5c0p7SPJ20Gw7VK5VU5S99Vak0elxQxm',3,'127.0.0.1','PostmanRuntime/7.1.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoieTFEWXZwMDFDb3YyazhmdFpNNk01MHdIcFpncEhuT1VaNjN4S3pWcCI7czoxNzoicGFzc3dvcmRfaGFzaF9hcGkiO3M6NjA6IiQyeSQxMCR3YlFONkRoWk9hQmNqdWRUMldTZVJlcUVzR1RCUVVOSmNRQVpBUFNKZmxoNHFJSlppMXBRSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1604147815),('POr0sxPaQroF4Vq5ksDVTQ92IJWP0UoCYAh5S0yt',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiR3d3bGFEZW1BSWxQMkMyYndoVG8wZkFXS1RQc2xkWTdLTWlScE81UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1604318522),('rp7Pu7LznkSXN2JrOFMYhaCcNrR0kD8HJ4H9MIMc',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZHIwT2x0TmkxS1dlRUNVS0MxbXh5NUNqdkhYeG9FMXBxWXpleGVSeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9kZXNpZ25ob3VzZS50ZXN0OjgwMDAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1605164388),('rZ4zHhEgAabLN68pTSvy4vZUQwlFe5TeP3dGTubD',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoidTFzRmszem5rblNHb0pyZGJDMGNVZWVaNURSQVlFVVdsV2dtV2FyZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly9kZXNpZ25ob3VzZS50ZXN0OjgwMDAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1604318616);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggable_taggables`
--

DROP TABLE IF EXISTS `taggable_taggables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggable_taggables` (
  `tag_id` bigint(20) unsigned NOT NULL,
  `taggable_id` bigint(20) unsigned NOT NULL,
  `taggable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `taggable_taggables_tag_id_taggable_id_taggable_type_unique` (`tag_id`,`taggable_id`,`taggable_type`),
  KEY `i_taggable_fwd` (`tag_id`,`taggable_id`),
  KEY `i_taggable_rev` (`taggable_id`,`tag_id`),
  KEY `i_taggable_type` (`taggable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggable_taggables`
--

LOCK TABLES `taggable_taggables` WRITE;
/*!40000 ALTER TABLE `taggable_taggables` DISABLE KEYS */;
INSERT INTO `taggable_taggables` VALUES (1,1,'App\\Models\\Design','2020-10-31 00:36:49','2020-10-31 00:36:49'),(1,2,'App\\Models\\Design','2020-10-31 00:42:19','2020-10-31 00:42:19'),(1,3,'App\\Models\\Design','2020-10-31 00:39:44','2020-10-31 00:39:44'),(1,11,'App\\Models\\Design','2021-01-25 01:44:31','2021-01-25 01:44:31'),(2,1,'App\\Models\\Design','2020-10-31 00:36:49','2020-10-31 00:36:49'),(2,3,'App\\Models\\Design','2020-10-31 00:39:44','2020-10-31 00:39:44'),(3,2,'App\\Models\\Design','2020-10-31 00:42:19','2020-10-31 00:42:19'),(4,4,'App\\Models\\Design','2020-11-30 09:03:16','2020-11-30 09:03:16'),(4,10,'App\\Models\\Design','2020-11-26 00:35:52','2020-11-26 00:35:52'),(5,4,'App\\Models\\Design','2020-11-30 09:03:16','2020-11-30 09:03:16'),(7,4,'App\\Models\\Design','2020-11-30 09:03:16','2020-11-30 09:03:16'),(7,10,'App\\Models\\Design','2020-11-26 00:35:52','2020-11-26 00:35:52'),(7,11,'App\\Models\\Design','2021-01-25 01:44:31','2021-01-25 01:44:31'),(8,9,'App\\Models\\Design','2020-12-03 01:33:48','2020-12-03 01:33:48'),(9,9,'App\\Models\\Design','2020-12-03 01:33:48','2020-12-03 01:33:48'),(10,10,'App\\Models\\Design','2020-11-26 00:35:52','2020-11-26 00:35:52');
/*!40000 ALTER TABLE `taggable_taggables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggable_tags`
--

DROP TABLE IF EXISTS `taggable_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggable_tags` (
  `tag_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `normalized` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `taggable_tags_normalized_unique` (`normalized`),
  KEY `taggable_tags_normalized_index` (`normalized`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggable_tags`
--

LOCK TABLES `taggable_tags` WRITE;
/*!40000 ALTER TABLE `taggable_tags` DISABLE KEYS */;
INSERT INTO `taggable_tags` VALUES (1,'PHOTOSHOP','photoshop','2020-10-31 00:36:49','2020-10-31 00:36:49'),(2,'food','food','2020-10-31 00:36:49','2020-10-31 00:36:49'),(3,'men','men','2020-10-31 00:42:19','2020-10-31 00:42:19'),(4,'peace','peace','2020-11-12 01:13:50','2020-11-12 01:13:50'),(5,'evening','evening','2020-11-12 01:13:50','2020-11-12 01:13:50'),(6,'photography','photography','2020-11-12 01:13:50','2020-11-12 01:13:50'),(7,'nature','nature','2020-11-12 01:13:50','2020-11-12 01:13:50'),(8,'local','local','2020-11-17 00:26:26','2020-11-17 00:26:26'),(9,'test','test','2020-11-17 00:26:26','2020-11-17 00:26:26'),(10,'heal','heal','2020-11-26 00:35:52','2020-11-26 00:35:52');
/*!40000 ALTER TABLE `taggable_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_user`
--

DROP TABLE IF EXISTS `team_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_user` (
  `team_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `team_user_team_id_foreign` (`team_id`),
  KEY `team_user_user_id_foreign` (`user_id`),
  CONSTRAINT `team_user_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `team_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_user`
--

LOCK TABLES `team_user` WRITE;
/*!40000 ALTER TABLE `team_user` DISABLE KEYS */;
INSERT INTO `team_user` VALUES (1,1,'2020-10-31 00:45:19','2020-10-31 00:45:19'),(1,3,'2020-10-31 00:50:30','2020-10-31 00:50:30'),(2,2,'2020-10-31 00:53:25','2020-10-31 00:53:25'),(3,1,'2020-11-11 10:39:34','2020-11-11 10:39:34');
/*!40000 ALTER TABLE `team_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teams_slug_unique` (`slug`),
  KEY `teams_owner_id_foreign` (`owner_id`),
  CONSTRAINT `teams_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (1,'plain-designs','plain designs',1,'2020-10-31 00:45:19','2020-10-31 00:45:19'),(2,'hazels-team','hazel\'s team',2,'2020-10-31 00:53:25','2020-10-31 00:53:25'),(3,'sairas-new-team','sairas new team',1,'2020-11-11 10:39:34','2020-11-11 10:39:34');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `tagline` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `about` text COLLATE utf8mb4_unicode_ci,
  `location` point DEFAULT NULL,
  `formatted_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `available_to_hire` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint(20) unsigned DEFAULT NULL,
  `profile_photo_path` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'saira','512saira','512saira@gmail.com','2020-10-30 03:59:40','$2y$10$bhudVVosurfGu2tzL/Q3yeY21KDQ3SyJE0ZW/smQUvDrG4I8Sxd/i',NULL,NULL,'Web developer','I am a full stack web developer',_binary '\0\0\0\0\0\0\0zSén]#@köwú¢ÆF@','26013 Crema, Province of Cremona, Italy',1,NULL,1,NULL,'2020-10-30 03:45:31','2020-12-03 01:23:22'),(2,'hazel babe','stranger','5hazel@gmail.com','2020-10-30 04:00:57','$2y$10$LN/WN5FzlA6wr8TfUBYRyegZf8fbqaR7Gl1Ks66kQW6wJ2ygHzMWW',NULL,NULL,'An artist','I am a free soul in search of myself',_binary '\0\0\0\0\0\0\0ˆ(\\è¬•W¿H\·zÆ\Á@@','huwai',1,NULL,NULL,NULL,'2020-10-30 03:49:57','2020-10-31 08:25:41'),(3,'Jamie James','jamjames','jamie@gmail.com','2020-10-30 04:01:40','$2y$10$wbQN6DhZOaBcjudT2WSeReqEsGTBQUNJcQAZAPSJflh4qIJZi1pQK',NULL,NULL,'Business woman','I am a determined woman',_binary '\0\0\0\0\0\0\0ÆG\·z.!@H\·zÆgG@','switzerland',1,NULL,NULL,NULL,'2020-10-30 03:50:31','2020-10-31 07:07:47'),(4,'annie','annfrank','afrank@gmail.com',NULL,'$2y$10$S1zYZQM6rSKPVWPBUquBX.ySVzthPEqymbyClo8VpUEKf5xvo2v4u',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2020-10-31 06:29:42','2020-10-31 06:29:42'),(5,'testing','dummy','dum@gmail.com',NULL,'$2y$10$x.3qvwB/YVo31DsUUsC9MOgffWL9G7EO5gVPqJSvcvQkQmkbfHA6y',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2020-11-01 04:14:14','2020-11-01 04:14:14'),(6,'miss developer','dev_girl','dev@gmail.com','2020-11-08 06:00:08','$2y$10$K4oJJQmzf0.rw2q3BEbCWexiyfJLgLX7aMBCeyMepZqwB55sOAoc2',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2020-11-07 00:45:44','2020-11-08 06:00:08'),(7,'dummy','dum123','dum123@gmail.com','2020-11-08 06:06:04','$2y$10$2G770E61PwTfKYjJ513X3Ol113tzRJbWAwnYm0WN/Z9Pa3zYSuK/y',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2020-11-08 06:05:46','2020-11-08 06:06:04'),(8,'razil','raz123','raz@gmail.com',NULL,'$2y$10$/MbE4Un7RMdm3qQ1puEmSuYJ9cJrEK5AISid8VpKrRSa1Ae7oLZc2',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2020-11-08 07:09:26','2020-11-08 07:09:37'),(9,'a1','a1','a1@gmail.com','2020-11-08 08:12:24','$2y$10$DeCflhS4w5tUNp4r0WPTG.DwkNgnZiaHH/txhV/GynlOdnlqd6dK.',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2020-11-08 07:12:53','2020-11-08 10:54:46'),(10,'pasta','pas','pas@gmail.com','2020-11-10 00:51:10','$2y$10$jKejd.9Wssdsbc7b5rNyj.hXM3QpbrOdjfZwEpbahogH0RLLqu/kO',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2020-11-10 00:45:53','2020-11-10 00:52:36'),(11,'fullstackdev','fsdev','full@gmail.com','2020-11-10 05:07:38','$2y$10$x9tyOSEvRCuPmqxdOfGto.CjutDhQJklu3KnVAlM02g/dklhfPLhS',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2020-11-10 05:07:17','2020-11-10 05:14:01');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-10 12:40:36
