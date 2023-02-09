-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 09, 2021 at 11:34 AM
-- Server version: 5.7.32-0ubuntu0.18.04.1
-- PHP Version: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `primus_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `parent` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activity` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `parent`, `parent_id`, `type`, `activity`) VALUES
(93, '2021-03-09 22:20:37', '2021-03-09 22:20:37', NULL, 109, 'job-recommendation', 40, 'job-recommendation', 'sent'),
(94, '2021-03-09 22:20:55', '2021-03-09 22:20:55', NULL, 109, 'job-recommendation', 40, 'job-recommendation', 'accepted'),
(95, '2021-03-09 22:24:52', '2021-03-09 22:24:52', NULL, 1, 'job-worker-recommendation', 3, 'job-worker-recommendation', 'sent'),
(96, '2021-03-10 00:56:43', '2021-03-10 00:56:43', NULL, 79, 'job-recommendation', 41, 'job-recommendation', 'sent'),
(97, '2021-03-12 15:30:01', '2021-03-12 15:30:01', NULL, 40, 'job-recommendation', 42, 'job-recommendation', 'sent'),
(98, '2021-03-12 15:34:44', '2021-03-12 15:34:44', NULL, 40, 'job-recommendation', 42, 'job-recommendation', 'accepted'),
(99, '2021-03-15 14:02:22', '2021-03-15 14:02:22', NULL, 141, 'job-recommendation', 43, 'job-recommendation', 'sent'),
(100, '2021-03-15 14:11:51', '2021-03-15 14:11:51', NULL, 141, 'job-recommendation', 43, 'job-recommendation', 'accepted'),
(101, '2021-03-15 14:12:32', '2021-03-15 14:12:32', NULL, 5, 'job-worker-recommendation', 4, 'job-worker-recommendation', 'sent'),
(102, '2021-03-15 14:14:36', '2021-03-15 14:14:36', NULL, 144, 'job-worker-recommendation', 4, 'job-worker-recommendation', 'accepted'),
(103, '2021-03-30 08:13:16', '2021-03-30 08:13:16', NULL, 150, 'job-recommendation', 44, 'job-recommendation', 'sent'),
(104, '2021-05-07 20:36:35', '2021-05-07 20:36:35', NULL, 170, 'job-recommendation', 45, 'job-recommendation', 'sent'),
(105, '2021-05-07 20:39:41', '2021-05-07 20:39:41', NULL, 170, 'job-recommendation', 45, 'job-recommendation', 'accepted'),
(106, '2021-05-07 20:41:50', '2021-05-07 20:41:50', NULL, 1, 'job-worker-recommendation', 5, 'job-worker-recommendation', 'sent'),
(107, '2021-05-07 20:42:56', '2021-05-07 20:42:56', NULL, 171, 'job-worker-recommendation', 5, 'job-worker-recommendation', 'accepted'),
(108, '2021-08-04 23:36:37', '2021-08-04 23:36:37', NULL, 195, 'job-recommendation', 46, 'job-recommendation', 'sent'),
(109, '2021-08-04 23:41:19', '2021-08-04 23:41:19', NULL, 195, 'job-recommendation', 46, 'job-recommendation', 'accepted'),
(110, '2021-08-04 23:44:20', '2021-08-04 23:44:20', NULL, 1, 'job-worker-recommendation', 6, 'job-worker-recommendation', 'sent'),
(111, '2021-08-04 23:46:27', '2021-08-04 23:46:27', NULL, 196, 'job-worker-recommendation', 6, 'job-worker-recommendation', 'accepted'),
(112, '2021-08-31 17:26:04', '2021-08-31 17:26:04', NULL, 108, 'job-recommendation', 47, 'job-recommendation', 'sent'),
(113, '2021-08-31 17:26:04', '2021-08-31 17:26:04', NULL, 182, 'job-recommendation', 48, 'job-recommendation', 'sent');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_medias` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`, `email`, `address`, `phone`, `social_medias`, `description`) VALUES
(4, '2020-12-14 17:46:18', '2020-12-14 17:46:18', NULL, 'Primus', 'hr@primusworkforce.com', NULL, NULL, NULL, ''),
(6, '2020-12-15 18:39:13', '2020-12-15 18:39:13', NULL, 'PW', 'usamaschaudhry@gmail.com', NULL, '7808851373', NULL, ''),
(7, '2020-12-16 18:03:27', '2020-12-16 18:03:27', NULL, 'PRIMUS WORKFORCE LTD.', 'admin', NULL, NULL, NULL, ''),
(8, '2020-12-18 12:31:12', '2020-12-18 12:31:12', NULL, 'Orion', 'manno.notermans@gmail.com', NULL, '+31646337290', NULL, ''),
(10, '2020-12-29 21:29:29', '2021-03-08 18:20:07', NULL, 'OUTORIGIN', 'developer@outorigin.com', NULL, '+3098898432', NULL, ''),
(22, '2021-02-26 16:50:07', '2021-03-09 22:24:10', NULL, 'AMRIC', 'amric@outorigin.com', 'gulshan', NULL, NULL, 'software company'),
(30, '2021-03-05 18:10:24', '2021-03-05 18:10:24', NULL, 'Amric', 'amric@amazonebcexperts.com', NULL, '03082766829', NULL, ''),
(31, '2021-03-09 21:31:55', '2021-03-09 21:31:55', NULL, 'Paranoidapparels', 'khanjeeaaish8903@gmail.com', NULL, NULL, NULL, ''),
(32, '2021-03-15 13:46:47', '2021-03-15 13:46:47', NULL, 'Think Tester', 'lisa02@thinkorion.com', NULL, NULL, NULL, ''),
(33, '2021-03-15 13:55:36', '2021-03-15 13:55:36', NULL, 'Think Tester', 'lisa3@thinkorion.com', NULL, NULL, NULL, ''),
(34, '2021-03-15 14:20:37', '2021-03-15 14:20:37', NULL, 'Casuals', 'lisa4@thinkorion.com', NULL, '+31646337290', NULL, ''),
(36, '2021-04-05 08:33:54', '2021-04-05 08:33:54', NULL, 'GrowthGecko', 'lisa5@thinkorion.com', NULL, NULL, NULL, ''),
(37, '2021-05-07 20:18:20', '2021-05-07 20:18:20', NULL, 'Megan Employer', 'testmachine020@thinkorion.com', NULL, NULL, NULL, ''),
(38, '2021-08-04 23:12:45', '2021-08-04 23:12:45', NULL, 'Think Orion - Test', 'testmachine002@thinkorion.com', NULL, '+12892424097', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `company_employees`
--

CREATE TABLE `company_employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `job_post_id` bigint(20) DEFAULT NULL,
  `status` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `company_employees`
--

INSERT INTO `company_employees` (`id`, `created_at`, `updated_at`, `deleted_at`, `company_id`, `user_id`, `job_post_id`, `status`) VALUES
(1, '2021-03-15 14:14:36', '2021-03-15 14:14:36', NULL, 33, 141, 86, 'active'),
(2, '2021-05-07 20:42:56', '2021-05-07 20:42:56', NULL, 37, 170, 88, 'active'),
(3, '2021-08-04 23:46:27', '2021-08-04 23:46:27', NULL, 38, 195, 91, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_categories`
--

CREATE TABLE `job_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_categories`
--

INSERT INTO `job_categories` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`) VALUES
(1, '2021-03-04 21:18:50', '2021-03-04 21:18:50', NULL, 'Oil & Gas'),
(2, '2021-03-04 21:19:08', '2021-03-04 21:19:08', NULL, 'Construction'),
(3, '2021-03-04 21:19:43', '2021-03-04 21:19:43', NULL, 'Renewables'),
(4, '2021-03-04 21:20:26', '2021-03-04 21:20:26', NULL, 'Environmental');

-- --------------------------------------------------------

--
-- Table structure for table `job_posts`
--

CREATE TABLE `job_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `personnel_request_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `min_hourly_rate` decimal(10,2) DEFAULT NULL,
  `max_hourly_rate` decimal(10,2) DEFAULT NULL,
  `minimum_salary` decimal(10,2) DEFAULT NULL,
  `maximum_salary` decimal(10,2) DEFAULT NULL,
  `external_link` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_posts`
--

INSERT INTO `job_posts` (`id`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `company_id`, `personnel_request_id`, `title`, `location`, `type`, `is_public`, `description`, `start_date`, `end_date`, `min_hourly_rate`, `max_hourly_rate`, `minimum_salary`, `maximum_salary`, `external_link`) VALUES
(78, '2021-03-09 21:44:31', '2021-04-15 09:09:14', NULL, 1, 0, 0, 'hello world', 'hi', '', 0, '<p>hello world</p>', NULL, NULL, '5.00', '10.00', '500.00', '1000.00', NULL),
(79, '2021-03-09 22:16:22', '2021-04-15 09:09:14', NULL, 1, 0, 0, 'title', 'karachi', '', 0, '<p>hello world</p>', NULL, NULL, '2.00', '10.00', '200.00', '1000.00', NULL),
(80, '2021-03-09 22:53:32', '2021-03-15 13:52:13', NULL, 1, 6, 0, 'yello', NULL, '', 0, '<p>hello world</p>', NULL, NULL, '5.00', '10.00', '100.00', '1000.00', NULL),
(81, '2021-03-10 00:33:24', '2021-03-15 19:24:56', NULL, 1, 31, 47, 'SALESAMAN', 'AAS', '', 0, '<p>SADSAD</p>', NULL, NULL, '23.00', '453.00', '23.00', '43.00', NULL),
(82, '2021-03-10 01:05:43', '2021-04-15 09:09:16', NULL, 1, 31, 47, 'WWW', 'WWWW', '', 0, '<p>EEWE</p>', NULL, NULL, '234.00', '4234.00', '123.00', '1234.00', NULL),
(83, '2021-03-10 01:22:10', '2021-04-15 09:09:18', NULL, 1, 4, 47, 'hello world', 'karach', '', 0, '<p>hello world</p>', NULL, NULL, '5.00', '10.00', '1000.00', '5000.00', NULL),
(84, '2021-03-12 15:29:34', '2021-04-15 09:09:19', NULL, 5, 22, 46, 'CEO', 'NESDAG', '', 0, '<p>Gekke Henkie</p>', NULL, NULL, '1.00', '12.00', '12.00', '123.00', NULL),
(85, '2021-03-12 15:31:06', '2021-03-12 15:31:06', NULL, 5, 31, 0, 'CEO', 'CEO', '', 0, '<p>YTEGS</p>', NULL, NULL, '1.00', '12.00', '1.00', '12.00', NULL),
(86, '2021-03-15 14:01:53', '2021-08-20 18:16:00', NULL, 5, 33, 48, 'GEKKIE', 'GEKKIE', '', 0, '<p>Gsfgsfg</p>', NULL, NULL, '1.00', '12.00', '12.00', '134.00', NULL),
(87, '2021-04-15 09:10:33', '2021-08-20 18:15:03', NULL, 5, 36, 53, 'CEO', 'Alberta', '', 0, '<p>A beautiful job at a scenic place.&nbsp;</p>', NULL, NULL, '1.00', '12.00', '1.00', '12.00', NULL),
(88, '2021-05-07 20:33:59', '2021-09-06 07:00:15', NULL, 1, 37, 61, 'Nitrogen Truck Driver', 'Edmonton', '', 0, '<p>TEst</p>', NULL, NULL, '15.00', '25.00', NULL, NULL, NULL),
(89, '2021-07-13 22:39:40', '2021-09-06 07:00:14', NULL, 2, 37, 61, 'abc', 'edmonton', '', 0, '<p><br></p>', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(90, '2021-08-04 22:26:50', '2021-09-06 07:00:12', NULL, 2, 4, 0, 'Oilfield Labourers- Confined Space Entry / Tank Cleaner / Vac laborers', 'All over Alberta', '', 0, '<p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Here at&nbsp;<b style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif !important;\">Primus Workforce&nbsp;</b>we provide safety- minded, experienced personnel support throughout the oil &amp; gas, construction and technical trades sectors to our clients\' long-term and short-term personnel needs. We are a growing and dynamic company to work with providing you the key to your future success.</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\"><b style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif !important;\">We are currently seeking to fill;</b></p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\"><b style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif !important;\">**&nbsp;<i style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif !important;\">High Pressure Confined Space Entry Laborers For Work Around Alberta</i></b></p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">The High Pressure position involves the safe operation of a high-pressure (10,000 PSI) truck for washing of heavy equipment and various industrial related projects throughout the site.</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Operators should be mechanically inclined and physically fit to work in all kinds of weather.</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\"><b style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif !important;\">Duties and Responsibilities:</b></p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Entering confined spaces and completing high pressure cleaning activities as requested. may need to go under air sometimes.</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Completion of daily documentation including but not limited to paper or electronic log books, customer work orders, field level risk assessment, job safety analysis, pre/post trip inspections</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Follow instructions for tasks assigned by dispatch or supervisor</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Complete daily housekeeping of assigned truck to ensure maintenance of company image.</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Attend daily tool box and safety meetings as scheduled and adhere to corporate and site safety regulations and procedures.</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\"><b style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif !important;\">Requirements:</b></p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Clear verbal and written English</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Standard First Aid, H2S Alive, Confined Space, Fall Arrest/Protection, CSTS and CSO.</p><p style=\"font-family: &quot;Noto Sans&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Liberation Sans&quot;, Roboto, Noto, sans-serif; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding: 0px; font-size: 14px; line-height: 1.5; color: rgb(45, 45, 45);\">Thank you to all those that apply. Only those that meet the specific job requirements for this position will be contacted. You are encouraged to apply for various future positions we may have.</p>', NULL, NULL, '20.00', '24.00', NULL, NULL, NULL),
(91, '2021-08-04 23:35:54', '2021-09-06 07:00:12', NULL, 1, 38, 62, 'Rayed Test Job', 'Edmonton', '', 0, '<p>Oil And Gas Test</p>', NULL, NULL, '5.00', '10.00', NULL, NULL, NULL),
(92, '2021-09-07 16:37:26', '2021-09-07 16:37:26', NULL, 2, 38, 62, 'Vessel entry labors', NULL, 'Laborer', 0, '<p>enter vessels and do high pressure washing</p>', '2021-09-08 00:00:00', '2021-09-15 00:00:00', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `job_post_applications`
--

CREATE TABLE `job_post_applications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `job_post_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin_notified` tinyint(1) DEFAULT '0',
  `is_employer_notified` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_post_applications`
--

INSERT INTO `job_post_applications` (`id`, `created_at`, `updated_at`, `deleted_at`, `job_post_id`, `user_id`, `status`, `message`, `is_admin_notified`, `is_employer_notified`) VALUES
(7, '2021-03-09 22:20:55', '2021-03-09 22:20:55', NULL, 79, 109, 'pending', '', 0, 0),
(8, '2021-03-12 15:34:44', '2021-03-12 15:34:44', NULL, 84, 40, 'pending', '', 0, 0),
(9, '2021-03-15 13:42:11', '2021-03-15 13:42:22', NULL, 79, 141, 'deleted', 'Hey I would really like to have this job?', 0, 0),
(10, '2021-03-15 13:43:32', '2021-03-15 13:43:32', NULL, 80, 141, 'pending', 'I would love to have this job', 0, 0),
(11, '2021-03-15 14:11:51', '2021-03-15 14:11:51', NULL, 86, 141, 'pending', '', 0, 0),
(12, '2021-03-18 13:49:50', '2021-03-18 13:49:55', NULL, 79, 143, 'deleted', 'Thanks', 0, 0),
(14, '2021-03-30 07:40:57', '2021-03-30 07:49:06', '2021-03-30 07:49:06', 82, 150, 'pending', 'hello', 0, 0),
(15, '2021-03-30 07:49:31', '2021-03-30 07:49:34', '2021-03-30 07:49:34', 84, 150, 'pending', 'hello', 0, 0),
(16, '2021-04-01 02:06:16', '2021-04-01 02:06:16', NULL, 79, 150, 'pending', 'hello', 0, 0),
(17, '2021-05-07 20:15:49', '2021-05-07 20:15:49', NULL, 87, 170, 'pending', 'test', 0, 0),
(18, '2021-05-07 20:39:41', '2021-05-07 20:39:41', NULL, 88, 170, 'pending', '', 0, 0),
(19, '2021-06-23 07:28:23', '2021-06-23 07:28:23', NULL, 81, 179, 'pending', 'I am writing in response to your advertisement for want SALESMAN . I am therefore enclosing my resume in hopes that your company may \nassist me in locating this vacant position as SALESMAN\nI am very much interested in obtaining this position in your company.\n I hold a first degree in Quantity Surveying and Construction Economics from Kwame \nNkrumah University of Science and Technology and Diploma in Civil Engineering (HND Civil \nEngineering) from Takoradi Technical University. I', 0, 0),
(20, '2021-08-04 23:41:19', '2021-08-04 23:41:19', NULL, 91, 195, 'pending', '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `job_post_categories`
--

CREATE TABLE `job_post_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `job_post_id` bigint(20) UNSIGNED NOT NULL,
  `job_category_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_post_categories`
--

INSERT INTO `job_post_categories` (`id`, `created_at`, `updated_at`, `deleted_at`, `job_post_id`, `job_category_id`) VALUES
(20, '2021-03-09 21:44:31', '2021-03-09 22:09:16', NULL, 78, 1),
(21, '2021-03-09 22:16:22', '2021-03-09 22:24:44', NULL, 79, 1),
(22, '2021-03-09 22:53:32', '2021-03-09 23:18:06', NULL, 80, 2),
(23, '2021-03-10 00:33:24', '2021-03-10 00:33:24', NULL, 81, 4),
(24, '2021-03-10 01:05:43', '2021-03-10 01:05:43', NULL, 82, 1),
(25, '2021-03-10 01:22:10', '2021-03-10 01:40:11', NULL, 83, 1),
(26, '2021-03-10 01:36:14', '2021-03-10 01:40:11', NULL, 83, 2),
(27, '2021-03-12 15:29:34', '2021-03-12 15:29:34', NULL, 84, 1),
(28, '2021-03-12 15:31:06', '2021-03-12 15:31:06', NULL, 85, 3),
(29, '2021-03-15 14:01:53', '2021-03-15 14:01:53', NULL, 86, 2),
(30, '2021-04-15 09:10:33', '2021-05-07 20:30:44', NULL, 87, 1),
(31, '2021-05-07 20:33:59', '2021-05-07 20:33:59', NULL, 88, 1),
(32, '2021-08-04 22:26:50', '2021-08-04 22:26:50', NULL, 90, 1),
(33, '2021-08-04 23:35:54', '2021-08-04 23:35:54', NULL, 91, 1),
(34, '2021-09-07 16:37:27', '2021-09-07 16:37:27', NULL, 92, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job_post_recommendations`
--

CREATE TABLE `job_post_recommendations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `job_post_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_post_recommendations`
--

INSERT INTO `job_post_recommendations` (`id`, `created_at`, `updated_at`, `deleted_at`, `job_post_id`, `user_id`, `token`, `status`, `message`) VALUES
(40, '2021-03-09 22:20:37', '2021-03-09 22:20:55', NULL, 79, 109, 'rcmd-befc40e4-f9d1-4b77-b5e8-a7bf1c748751', 'accepted', ''),
(41, '2021-03-10 00:56:43', '2021-03-10 00:57:02', NULL, 81, 79, 'rcmd-f1f9b7e5-dfde-4106-b82c-20dfaf3124d3', 'sent', ''),
(42, '2021-03-12 15:30:01', '2021-03-12 15:34:44', NULL, 84, 40, 'rcmd-10787620-89c1-4bcc-a28d-5405aeebe252', 'accepted', ''),
(43, '2021-03-15 14:02:22', '2021-03-15 14:11:51', NULL, 86, 141, 'rcmd-7b40cba7-b48e-4326-b889-06238bd4cb63', 'accepted', ''),
(44, '2021-03-30 08:13:16', '2021-03-30 08:14:02', NULL, 79, 150, 'rcmd-c8872470-ddea-47bf-80d1-c9bac9bd3eb4', 'sent', ''),
(45, '2021-05-07 20:36:35', '2021-05-07 20:39:41', NULL, 88, 170, 'rcmd-a3a9e47c-d5a6-4444-8752-7afeb01d46b9', 'accepted', ''),
(46, '2021-08-04 23:36:37', '2021-08-04 23:41:19', NULL, 91, 195, 'rcmd-a832ea83-21b9-47ca-9163-c3a05f242bd9', 'accepted', ''),
(47, '2021-08-31 17:26:04', '2021-08-31 17:26:04', NULL, 90, 108, 'rcmd-328d3e35-2111-4777-8100-a8b7660ded8c', 'sent', ''),
(48, '2021-08-31 17:26:04', '2021-08-31 17:26:05', NULL, 90, 182, 'rcmd-881b3232-19b6-4728-a645-e85a08a0fa17', 'sent', '');

-- --------------------------------------------------------

--
-- Table structure for table `job_post_skills`
--

CREATE TABLE `job_post_skills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `job_post_id` bigint(20) UNSIGNED NOT NULL,
  `job_subcategory_item_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_post_skills`
--

INSERT INTO `job_post_skills` (`id`, `created_at`, `updated_at`, `deleted_at`, `job_post_id`, `job_subcategory_item_id`) VALUES
(41, '2021-03-09 21:44:31', '2021-03-09 22:09:16', '2021-03-09 22:09:16', 78, 224),
(42, '2021-03-09 21:44:31', '2021-03-09 22:09:16', '2021-03-09 22:09:16', 78, 219),
(43, '2021-03-09 22:09:16', '2021-03-09 22:09:16', NULL, 78, 282),
(44, '2021-03-09 22:16:22', '2021-03-09 22:16:22', NULL, 79, 219),
(45, '2021-03-09 22:53:32', '2021-03-09 22:53:32', NULL, 80, 219),
(46, '2021-03-10 00:33:24', '2021-03-10 00:33:24', NULL, 81, 279),
(47, '2021-03-10 01:05:43', '2021-03-10 01:05:43', NULL, 82, 219),
(48, '2021-03-10 01:05:43', '2021-03-10 01:05:43', NULL, 82, 220),
(49, '2021-03-10 01:22:10', '2021-03-10 01:22:10', NULL, 83, 219),
(50, '2021-03-12 15:29:34', '2021-03-12 15:29:34', NULL, 84, 219),
(51, '2021-03-12 15:31:06', '2021-03-12 15:31:06', NULL, 85, 220),
(52, '2021-03-15 14:01:53', '2021-03-15 14:01:53', NULL, 86, 219),
(53, '2021-04-15 09:10:33', '2021-04-15 09:10:33', NULL, 87, 277),
(54, '2021-04-15 09:10:33', '2021-04-15 09:10:33', NULL, 87, 219),
(55, '2021-05-07 20:33:59', '2021-05-07 20:33:59', NULL, 88, 219),
(56, '2021-07-13 22:39:40', '2021-07-13 22:39:40', NULL, 89, 219),
(57, '2021-07-13 22:39:40', '2021-07-13 22:39:40', NULL, 89, 277),
(58, '2021-08-04 22:26:50', '2021-08-04 22:26:50', NULL, 90, 277),
(59, '2021-08-04 22:26:50', '2021-08-04 22:26:50', NULL, 90, 278),
(60, '2021-08-04 22:26:50', '2021-08-04 22:26:50', NULL, 90, 279),
(61, '2021-08-04 22:26:50', '2021-08-04 22:26:50', NULL, 90, 281),
(62, '2021-08-04 22:26:50', '2021-08-04 22:26:50', NULL, 90, 282),
(63, '2021-08-04 22:26:50', '2021-08-04 22:26:50', NULL, 90, 219),
(64, '2021-08-04 22:26:50', '2021-08-04 22:26:50', NULL, 90, 287),
(65, '2021-08-04 23:35:54', '2021-08-04 23:35:54', NULL, 91, 233),
(66, '2021-09-07 16:37:26', '2021-09-07 16:37:26', NULL, 92, 277);

-- --------------------------------------------------------

--
-- Table structure for table `job_subcategories`
--

CREATE TABLE `job_subcategories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `job_category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_subcategories`
--

INSERT INTO `job_subcategories` (`id`, `created_at`, `updated_at`, `deleted_at`, `job_category_id`, `name`) VALUES
(15, '2021-03-04 21:38:28', '2021-03-04 21:40:37', NULL, 2, 'Class 1 / 3 – Drivers / Operators'),
(16, '2021-03-04 21:39:41', '2021-03-04 21:39:41', NULL, 2, 'Trades'),
(17, '2021-03-04 21:40:25', '2021-03-04 21:41:34', NULL, 2, 'Heavy equipment operators'),
(18, '2021-03-04 21:41:57', '2021-03-04 21:41:57', NULL, 1, 'General Oilfield'),
(19, '2021-03-04 21:42:12', '2021-03-04 21:42:12', NULL, 2, 'General Construction');

-- --------------------------------------------------------

--
-- Table structure for table `job_subcategory_items`
--

CREATE TABLE `job_subcategory_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `job_subcategory_id` bigint(20) UNSIGNED NOT NULL,
  `job_type_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_subcategory_items`
--

INSERT INTO `job_subcategory_items` (`id`, `created_at`, `updated_at`, `deleted_at`, `job_subcategory_id`, `job_type_id`) VALUES
(219, '2021-03-04 21:48:43', '2021-03-04 21:48:43', NULL, 15, 46),
(220, '2021-03-04 21:48:43', '2021-03-04 21:48:43', NULL, 15, 50),
(221, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 54),
(222, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 43),
(223, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 44),
(224, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 53),
(225, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 56),
(226, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 40),
(227, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 45),
(228, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 52),
(229, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 51),
(230, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 58),
(231, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 49),
(232, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 42),
(233, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 59),
(234, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 48),
(235, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 55),
(236, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 41),
(237, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 57),
(238, '2021-03-04 21:48:44', '2021-03-04 21:48:44', NULL, 15, 47),
(239, '2021-03-04 21:53:21', '2021-03-04 21:53:21', NULL, 16, 60),
(240, '2021-03-04 21:53:21', '2021-03-04 21:53:21', NULL, 16, 61),
(241, '2021-03-04 21:53:21', '2021-03-04 21:53:21', NULL, 16, 62),
(242, '2021-03-04 21:53:21', '2021-03-04 21:53:21', NULL, 16, 63),
(243, '2021-03-04 21:53:21', '2021-03-04 21:53:21', NULL, 16, 64),
(244, '2021-03-04 21:53:21', '2021-03-04 21:53:21', NULL, 16, 65),
(245, '2021-03-04 21:56:59', '2021-03-04 21:56:59', '2021-03-04 21:56:59', 17, 66),
(246, '2021-03-04 21:56:59', '2021-03-04 21:56:59', '2021-03-04 21:56:59', 17, 67),
(247, '2021-03-04 21:56:59', '2021-03-04 21:56:59', '2021-03-04 21:56:59', 17, 69),
(248, '2021-03-04 21:56:59', '2021-03-04 21:56:59', '2021-03-04 21:56:59', 17, 75),
(249, '2021-03-04 21:56:59', '2021-03-04 21:56:59', '2021-03-04 21:56:59', 17, 76),
(250, '2021-03-04 21:56:59', '2021-03-04 21:56:59', '2021-03-04 21:56:59', 17, 72),
(251, '2021-03-04 21:56:59', '2021-03-04 22:00:49', '2021-03-04 22:00:49', 17, 66),
(252, '2021-03-04 21:56:59', '2021-03-04 22:00:49', '2021-03-04 22:00:49', 17, 67),
(253, '2021-03-04 21:56:59', '2021-03-04 22:00:49', '2021-03-04 22:00:49', 17, 69),
(254, '2021-03-04 21:56:59', '2021-03-04 22:00:49', '2021-03-04 22:00:49', 17, 75),
(255, '2021-03-04 21:56:59', '2021-03-04 22:00:49', '2021-03-04 22:00:49', 17, 76),
(256, '2021-03-04 21:56:59', '2021-03-04 22:00:49', '2021-03-04 22:00:49', 17, 72),
(257, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 66),
(258, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 67),
(259, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 69),
(260, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 75),
(261, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 76),
(262, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 72),
(263, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 68),
(264, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 74),
(265, '2021-03-04 22:00:49', '2021-03-04 22:01:45', '2021-03-04 22:01:45', 17, 70),
(266, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 66),
(267, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 67),
(268, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 69),
(269, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 75),
(270, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 76),
(271, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 72),
(272, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 68),
(273, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 74),
(274, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 70),
(275, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 71),
(276, '2021-03-04 22:01:45', '2021-03-04 22:01:45', NULL, 17, 73),
(277, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 77),
(278, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 78),
(279, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 79),
(280, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 80),
(281, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 81),
(282, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 82),
(283, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 83),
(284, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 86),
(285, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 84),
(286, '2021-03-04 22:08:18', '2021-03-04 22:08:18', NULL, 18, 85),
(287, '2021-03-04 22:09:51', '2021-03-04 22:09:51', NULL, 19, 88),
(288, '2021-03-04 22:09:51', '2021-03-04 22:09:51', NULL, 19, 87),
(289, '2021-03-04 22:09:51', '2021-03-04 22:09:51', NULL, 19, 89),
(290, '2021-03-04 22:09:51', '2021-03-04 22:09:51', NULL, 19, 90),
(291, '2021-03-04 22:09:51', '2021-03-04 22:09:51', NULL, 19, 91);

-- --------------------------------------------------------

--
-- Table structure for table `job_types`
--

CREATE TABLE `job_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_types`
--

INSERT INTO `job_types` (`id`, `created_at`, `updated_at`, `deleted_at`, `name`) VALUES
(39, '2021-03-04 21:44:27', '2021-03-04 21:45:16', '2021-03-04 21:45:16', 'Welder'),
(40, '2021-03-04 21:45:07', '2021-03-04 21:45:07', NULL, 'Vac truck'),
(41, '2021-03-04 21:45:22', '2021-03-04 21:45:22', NULL, 'Hydrovac'),
(42, '2021-03-04 21:45:30', '2021-03-04 21:45:30', NULL, 'Combo vac'),
(43, '2021-03-04 21:45:41', '2021-03-04 21:45:41', NULL, 'Semi-vac'),
(44, '2021-03-04 21:45:48', '2021-03-04 21:45:48', NULL, 'Steam truck'),
(45, '2021-03-04 21:45:55', '2021-03-04 21:45:55', NULL, 'Water truck'),
(46, '2021-03-04 21:46:05', '2021-03-04 21:46:05', NULL, 'Nitrogen truck'),
(47, '2021-03-04 21:46:12', '2021-03-04 21:46:12', NULL, 'Nitrogen bulker'),
(48, '2021-03-04 21:46:20', '2021-03-04 21:46:20', NULL, 'Frac truck'),
(49, '2021-03-04 21:46:27', '2021-03-04 21:46:27', NULL, 'Coil tubing unit'),
(50, '2021-03-04 21:46:39', '2021-03-04 21:46:39', NULL, 'Picker truck'),
(51, '2021-03-04 21:46:47', '2021-03-04 21:46:47', NULL, 'Bed truck'),
(52, '2021-03-04 21:46:53', '2021-03-04 21:46:53', NULL, 'Winch Truck'),
(53, '2021-03-04 21:47:00', '2021-03-04 21:47:00', NULL, 'Super B'),
(54, '2021-03-04 21:47:09', '2021-03-04 21:47:09', NULL, 'Pressure truck'),
(55, '2021-03-04 21:47:15', '2021-03-04 21:47:15', NULL, 'Hot oiler'),
(56, '2021-03-04 21:47:23', '2021-03-04 21:47:23', NULL, 'Tanker'),
(57, '2021-03-04 21:47:29', '2021-03-04 21:47:29', NULL, 'Long haul trucker'),
(58, '2021-03-04 21:47:35', '2021-03-04 21:47:35', NULL, 'Chemical circulation unit'),
(59, '2021-03-04 21:47:42', '2021-03-04 21:47:42', NULL, 'Dump truck'),
(60, '2021-03-04 21:50:48', '2021-03-04 21:50:48', NULL, 'Welder'),
(61, '2021-03-04 21:50:57', '2021-03-04 21:50:57', NULL, 'Pipefitter'),
(62, '2021-03-04 21:51:04', '2021-03-04 21:51:04', NULL, 'Scaffolder'),
(63, '2021-03-04 21:51:10', '2021-03-04 21:51:10', NULL, 'Insulator'),
(64, '2021-03-04 21:51:21', '2021-03-04 21:51:21', NULL, 'Millwright'),
(65, '2021-03-04 21:51:29', '2021-03-04 21:51:29', NULL, 'Crane operator'),
(66, '2021-03-04 21:53:55', '2021-03-04 21:53:55', NULL, 'Dozer'),
(67, '2021-03-04 21:54:02', '2021-03-04 21:54:02', NULL, 'Excavator'),
(68, '2021-03-04 21:54:09', '2021-03-04 21:54:09', NULL, 'Scrapper'),
(69, '2021-03-04 21:54:15', '2021-03-04 21:54:15', NULL, 'Grader'),
(70, '2021-03-04 21:54:21', '2021-03-04 21:54:21', NULL, 'Rock truck'),
(71, '2021-03-04 21:54:29', '2021-03-04 21:54:29', NULL, 'Packer'),
(72, '2021-03-04 21:54:36', '2021-03-04 21:54:36', NULL, 'Loader'),
(73, '2021-03-04 21:54:46', '2021-03-04 21:54:46', NULL, 'Crane'),
(74, '2021-03-04 21:55:02', '2021-03-04 21:55:02', NULL, 'Forklift / skid steer / telehandler'),
(75, '2021-03-04 21:55:09', '2021-03-04 21:55:09', NULL, 'Haul truck (large)'),
(76, '2021-03-04 21:55:17', '2021-03-04 21:55:17', NULL, 'Haul truck (small)'),
(77, '2021-03-04 22:05:25', '2021-03-04 22:05:25', NULL, 'General oilfield laborer'),
(78, '2021-03-04 22:05:29', '2021-03-04 22:05:29', NULL, 'High pressure Operator'),
(79, '2021-03-04 22:06:01', '2021-03-04 22:06:01', NULL, 'Confined space laborer'),
(80, '2021-03-04 22:06:14', '2021-03-04 22:06:14', NULL, 'Safety watch'),
(81, '2021-03-04 22:06:26', '2021-03-04 22:06:26', NULL, 'Roughneck'),
(82, '2021-03-04 22:06:32', '2021-03-04 22:06:32', NULL, 'Derrick hand'),
(83, '2021-03-04 22:06:40', '2021-03-04 22:06:40', NULL, 'TLE operator'),
(84, '2021-03-04 22:06:47', '2021-03-04 22:06:47', NULL, 'Chemical cleaning operator'),
(85, '2021-03-04 22:06:53', '2021-03-04 22:06:53', NULL, 'Chemical cleaning supervisor'),
(86, '2021-03-04 22:07:00', '2021-03-04 22:07:00', NULL, 'Chemical cleaning Lab Technician'),
(87, '2021-03-04 22:08:45', '2021-03-04 22:08:45', NULL, 'Pipe layer'),
(88, '2021-03-04 22:08:54', '2021-03-04 22:08:54', NULL, 'General construction laborer'),
(89, '2021-03-04 22:09:02', '2021-03-04 22:09:02', NULL, 'Pipe layer helper'),
(90, '2021-03-04 22:09:09', '2021-03-04 22:09:09', NULL, 'Flagger'),
(91, '2021-03-04 22:09:15', '2021-03-04 22:09:15', NULL, 'Fusion technician');

-- --------------------------------------------------------

--
-- Table structure for table `job_worker_recommendations`
--

CREATE TABLE `job_worker_recommendations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `job_post_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_worker_recommendations`
--

INSERT INTO `job_worker_recommendations` (`id`, `created_at`, `updated_at`, `deleted_at`, `job_post_id`, `user_id`, `status`, `message`) VALUES
(3, '2021-03-09 22:24:52', '2021-03-09 22:24:52', NULL, 79, 109, 'accepted', ''),
(4, '2021-03-15 14:12:32', '2021-03-15 14:14:36', NULL, 86, 141, 'accepted', ''),
(5, '2021-05-07 20:41:50', '2021-05-07 20:42:56', NULL, 88, 170, 'accepted', ''),
(6, '2021-08-04 23:44:20', '2021-08-04 23:46:27', NULL, 91, 195, 'accepted', '');

-- --------------------------------------------------------

--
-- Table structure for table `mails`
--

CREATE TABLE `mails` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `subject` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_email` tinyint(1) NOT NULL,
  `is_sms` tinyint(1) NOT NULL,
  `status` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `template` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'default',
  `sent_from_message_center` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mails`
--

INSERT INTO `mails` (`id`, `created_at`, `updated_at`, `deleted_at`, `subject`, `message`, `is_email`, `is_sms`, `status`, `template`, `sent_from_message_center`) VALUES
(18, '2021-05-07 20:46:08', '2021-05-07 20:47:03', NULL, 'Test', 'Teesttttt', 1, 1, 'sent', 'default', 1),
(19, '2021-08-04 23:02:32', '2021-08-04 23:03:02', NULL, 'Test', 'Hey - are yoiu available tomorrow?\n\nBest,\nRayed', 1, 0, 'sent', 'default', 0),
(20, '2021-08-04 23:03:45', '2021-08-04 23:04:02', NULL, 'DIRECT MESSAGE:', 'Hey buddy guy. You avaialble?', 0, 1, 'sent', 'default', 0),
(21, '2021-08-04 23:17:01', '2021-08-04 23:17:04', NULL, 'Primus Workforce Personnel Request Form', 'Click the link: <a href=\"http://dashboard.primusworkforce.com/personnels/requests\">Make a request</a>', 1, 1, 'sent', 'personnel-request', 0),
(22, '2021-08-04 23:17:51', '2021-08-04 23:18:04', NULL, 'Primus Workforce Personnel Request Form', 'Click the link: <a href=\"http://dashboard.primusworkforce.com/personnels/requests\">Make a request</a>', 1, 1, 'sent', 'personnel-request', 0),
(23, '2021-08-04 23:51:25', '2021-08-04 23:52:03', NULL, 'New Job Notification', '<p>Hey {First</p><p>Bus leaves from her eon location here&nbsp;</p><p>Looking forward to see oyu thing.&nbsp;</p><p><br></p><p>Please bring xyz</p>', 1, 1, 'sent', 'default', 1),
(24, '2021-08-11 15:32:00', '2021-08-11 15:32:03', NULL, 'DIRECT MESSAGE:', 'are you availabeve for work', 0, 1, 'sent', 'default', 0),
(25, '2021-08-11 15:38:41', '2021-08-11 15:39:03', NULL, 'DIRECT MESSAGE:', 'hello megan did you recieve this?', 0, 1, 'sent', 'default', 0);

-- --------------------------------------------------------

--
-- Table structure for table `mail_receivers`
--

CREATE TABLE `mail_receivers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `mail_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mail_receivers`
--

INSERT INTO `mail_receivers` (`id`, `created_at`, `updated_at`, `deleted_at`, `mail_id`, `user_id`, `status`) VALUES
(21, '2021-05-07 20:46:08', '2021-08-04 23:51:25', '2021-08-04 23:51:25', 18, 170, 'delivered'),
(22, '2021-08-04 23:02:32', '2021-08-04 23:03:02', NULL, 19, 195, 'delivered'),
(23, '2021-08-04 23:03:45', '2021-08-04 23:04:02', NULL, 20, 195, 'delivered'),
(24, '2021-08-04 23:17:01', '2021-08-04 23:51:25', '2021-08-04 23:51:25', 21, 196, 'delivered'),
(25, '2021-08-04 23:17:51', '2021-08-04 23:51:25', '2021-08-04 23:51:25', 22, 196, 'delivered'),
(26, '2021-08-04 23:51:25', '2021-08-04 23:52:03', NULL, 23, 195, 'delivered'),
(27, '2021-08-11 15:32:00', '2021-08-11 15:32:03', NULL, 24, 198, 'delivered'),
(28, '2021-08-11 15:38:41', '2021-08-11 15:39:03', NULL, 25, 194, 'delivered');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `important` tinyint(1) NOT NULL,
  `read` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message_logs`
--

CREATE TABLE `message_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message_replies`
--

CREATE TABLE `message_replies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `message_id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(3, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(4, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(5, '2016_06_01_000004_create_oauth_clients_table', 1),
(6, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(7, '2019_08_19_000000_create_failed_jobs_table', 1),
(8, '2020_08_29_040550_create_jobs_table', 1),
(9, '2020_09_02_083922_create_job_categories', 1),
(10, '2020_09_02_084017_create_job_subcategories', 1),
(11, '2020_09_02_084307_create_job_types', 1),
(12, '2020_09_07_162832_create_job_subcategories_items', 1),
(60, '2020_09_10_141923_create_user_resume_table', 2),
(61, '2020_09_10_142519_create_user_tickets_table', 2),
(62, '2020_09_10_142746_create_user_skills_table', 2),
(63, '2020_09_10_150041_create_user_files_table', 2),
(64, '2020_09_16_182529_create_job_posts_table', 2),
(65, '2020_09_17_144732_create_job_skills_table', 2),
(66, '2020_09_17_183040_create_job_post_recommendations_table', 2),
(70, '2020_09_16_083808_create_messages_table', 3),
(71, '2020_09_17_234138_create_message_replies', 3),
(72, '2020_09_21_142808_create_job_post_applications_table', 3),
(73, '2020_09_21_152910_create_job_worker_recommendations_table', 3),
(75, '2020_09_23_112555_create_job_post_categories_table', 4),
(76, '2020_09_24_100802_update_recommendations_table', 5),
(77, '2020_09_24_150653_update_users_table_add_klaviyo_status', 6),
(78, '2020_09_30_063458_user_employees', 7),
(79, '2020_10_12_134212_update_users_table_10_12_2020', 8),
(80, '2020_10_13_060855_add_note_to_users_table', 8),
(86, '2020_10_14_151325_create_mails_table', 9),
(87, '2020_10_14_151451_create_mail_receivers_table', 9),
(88, '2020_10_16_121344_create_companies_table', 9),
(89, '2020_10_20_094730_create_personnel_request_driver_requirements_table', 9),
(91, '2020_10_20_102305_create_personnel_request_drug_and_alcohol_test_table', 9),
(92, '2020_10_20_102414_create_personnel_request_required_personnels_table', 9),
(93, '2020_10_20_102649_create_personnel_request_required_tickets_table', 9),
(94, '2020_10_20_102305_create_personnel_request_drug_and_alcohol_tests_table', 10),
(95, '2020_10_26_052240_update_job_posts_table_2020_10_26', 11),
(96, '2020_10_26_072013_update_personnel_requests_table_2020_10_26', 12),
(97, '2020_10_27_061808_update_users_table_2020_10_27', 13),
(98, '2020_10_29_060353_create_message_logs_table', 14),
(99, '2020_10_29_064418_update_job_post_recommendations_table_2020_10_30', 14),
(100, '2020_10_29_090407_update_users_table_2020_10_29', 15),
(101, '2020_10_29_145626_create_activity_logs_table', 15),
(102, '2020_10_30_071556_update_personnel_requests_table_10_30_2020', 16),
(103, '2020_11_06_131357_update_mails_table_11_6_2020', 17),
(104, '2020_11_18_062336_update_companies_table_2020_11_18', 18),
(105, '2020_11_18_064207_create_notes_table', 18),
(106, '2020_11_18_064426_create_company_employees', 18),
(107, '2020_11_18_084015_update_users_table_add_company_admin', 18),
(108, '2021_02_23_172915_create_personnel_request_personnel_details_table', 19);

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `message`) VALUES
(1, '2021-08-04 23:05:47', '2021-08-04 23:05:47', NULL, 195, 'TEST');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('00a20485c5140822672996495ec50eab6b6f9acb18e0532e323739dd7bc39964ceb6a34f7350bb61', 176, 5, 'authToken', '[]', 0, '2021-05-27 04:10:34', '2021-05-27 04:10:34', '2022-05-27 04:10:34'),
('01d487a5a4d5bb76a5f516a8dcb10cd44b1621200910b2096f0552a7003c9be396238d616acc675f', 78, 3, 'authToken', '[]', 0, '2021-01-30 23:09:29', '2021-01-30 23:09:29', '2022-01-30 23:09:29'),
('03ea74bfced57b0de5d64d866e8e7c5e2c109f6ea7cbe53552b17e1c1855fd299e545dbc09b452ce', 1, 1, 'authToken', '[]', 1, '2020-11-10 14:14:34', '2020-11-10 14:14:34', '2021-11-10 14:14:34'),
('05161ef6b23288ae8536e2368323782e6204561e6348fb5cb7fc44ebf15790a01a2c5e55e1f6b4b7', 3, 3, 'authToken', '[]', 1, '2020-11-11 09:50:40', '2020-11-11 09:50:40', '2021-11-11 09:50:40'),
('05d3144c0cf5a8d0168ac7bc0821aeaddeffc275f358c0d3122ace838e8aa39b23348805a19ec52e', 100, 3, 'authToken', '[]', 1, '2021-02-13 19:27:45', '2021-02-13 19:27:45', '2022-02-13 19:27:45'),
('08cc2f0f387084ef632490a6ca43feed525b4e4ed6a84770c712e4ed13f4345f4061dd946c6c28c7', 150, 3, 'authToken', '[]', 0, '2021-03-24 23:55:23', '2021-03-24 23:55:23', '2022-03-24 23:55:23'),
('08d81f36cdcac39a98b15918ba440027f4d17579a14a5c257437cbdb3aaea4c1efdc0c6c3a5d9fc6', 1, 5, 'authToken', '[]', 1, '2021-04-14 13:37:27', '2021-04-14 13:37:27', '2022-04-14 13:37:27'),
('0986959f74ddeb5d8a6ca0275c0f7c0841ce7f5f3ba0d970cf96d0eda0167a9e42c6bf2627907f79', 66, 3, 'authToken', '[]', 0, '2021-01-13 14:20:20', '2021-01-13 14:20:20', '2022-01-13 14:20:20'),
('0b2b84dc2e57920e6ff61384b9036ac276d7a0572e9f65fae0562e76de9c62a1c335bf92d604a896', 112, 3, 'authToken', '[]', 0, '2021-02-18 09:39:53', '2021-02-18 09:39:53', '2022-02-18 09:39:53'),
('0b86296deea4f647401443924aed6db4a0075ed17df7f4165ed26f4a7729058acd0ee33df6030299', 154, 3, 'authToken', '[]', 0, '2021-04-05 08:34:31', '2021-04-05 08:34:31', '2022-04-05 08:34:31'),
('0ba824028fdbf73b20503dbd04a0aa049fa5af167272739e11bff94d95f571ed72b8e85ce6cfd928', 82, 3, 'authToken', '[]', 0, '2021-02-02 02:25:21', '2021-02-02 02:25:21', '2022-02-02 02:25:21'),
('0c11d2cc5173c73f66365ad8ed7cfa1fe36eece0bfaf3a2f3eece7ad345bc1c5e5c1ea972db4ef6a', 193, 5, 'authToken', '[]', 0, '2021-08-02 05:55:18', '2021-08-02 05:55:18', '2022-08-02 05:55:18'),
('0c8f256544d9b025ae3bd576a8a8e2e54213f59588388908f98d3dbdb13b41b7c1a81548f22e5003', 137, 3, 'authToken', '[]', 0, '2021-03-12 00:32:49', '2021-03-12 00:32:49', '2022-03-12 00:32:49'),
('0c96f82e1ed1c4f2948eed37138640114e7f90f43b863a28ebd13275bdba81f5e9187ca4d7515b1f', 171, 5, 'authToken', '[]', 1, '2021-08-31 19:18:32', '2021-08-31 19:18:32', '2022-08-31 19:18:32'),
('0c9f09611a44577d1ccee8ee86110837b873d17865f83be0f69429362fda18311bb23d3436bc3c75', 87, 3, 'authToken', '[]', 0, '2021-02-08 19:06:44', '2021-02-08 19:06:44', '2022-02-08 19:06:44'),
('0d883e41d3d81e91071a083af1ce6ca989c6c9cffb2884f4b6de43f2c36adaf4a49a01c6c20dbbd7', 1, 3, 'authToken', '[]', 0, '2021-04-05 08:30:36', '2021-04-05 08:30:36', '2022-04-05 08:30:36'),
('0e1b15ab1e3ba4b11ab7e824cde0eac42095b4e27fc33da7679cd6b6763b4ff97d2aec1d28c5231f', 3, 3, 'authToken', '[]', 1, '2020-12-09 21:09:32', '2020-12-09 21:09:32', '2021-12-09 21:09:32'),
('0e33044206098370909ccfac2ff13fd3650df86eb2b8295e9b67a8fca87be4222d1e86b7ff27407c', 60, 3, 'authToken', '[]', 0, '2021-01-09 17:23:54', '2021-01-09 17:23:54', '2022-01-09 17:23:54'),
('0e9781223aa99a1d314871a7b85d953c74e0b0e9a6b37b0c30c2345b919692257bcc8aef0a8877cd', 3, 3, 'authToken', '[]', 0, '2020-12-15 21:15:08', '2020-12-15 21:15:08', '2021-12-15 21:15:08'),
('0ec9db9435fb02fbd687068724b4f679f672879c9563c767551c6afbc8c7f196febd7e1e17138f1d', 114, 3, 'authToken', '[]', 0, '2021-02-21 19:03:20', '2021-02-21 19:03:20', '2022-02-21 19:03:20'),
('1020cb45d545d0b6f1017146d49dff614d37986ceac574e4df29338809786c996de65a3840aba9d9', 74, 3, 'authToken', '[]', 0, '2021-01-27 15:50:53', '2021-01-27 15:50:53', '2022-01-27 15:50:53'),
('10e4ff0011cea66d443a78284e7b06fbcc996d32709a7484150c580435e291dc16609a9dcfc5eb95', 59, 3, 'authToken', '[]', 0, '2021-01-09 07:08:30', '2021-01-09 07:08:30', '2022-01-09 07:08:30'),
('113c8131ad49dec1494a2134dc9bc412f1b5da0b8d209b645058b140f34d0c52f987c98d2f0f7e66', 15, 3, 'authToken', '[]', 1, '2020-12-08 12:50:24', '2020-12-08 12:50:24', '2021-12-08 12:50:24'),
('11e9da7fc0840142949b98da0d206d2527d5825e4c7f16e439d86884f01189d7d2d50b858ae87f2f', 1, 3, 'authToken', '[]', 1, '2021-01-12 21:52:36', '2021-01-12 21:52:36', '2022-01-12 21:52:36'),
('127b462d30555354044c7ed1e3a0cb1559d81f9a12f96a5a30d549402aa02dd56fbc0c47d5654a36', 103, 3, 'authToken', '[]', 0, '2021-02-14 10:28:10', '2021-02-14 10:28:10', '2022-02-14 10:28:10'),
('13a78b0232d2f50414a7aa858b99267a75d54e749903858771ccea4981854f3181f40e165e79aeac', 127, 3, 'authToken', '[]', 1, '2021-03-30 07:51:36', '2021-03-30 07:51:36', '2022-03-30 07:51:36'),
('13fa324b4019cbe876ca2f78cbc014050cc7965142541fb03cdcfda5404f89b1f2cfb7ee614474d1', 58, 3, 'authToken', '[]', 0, '2021-01-09 04:30:42', '2021-01-09 04:30:42', '2022-01-09 04:30:42'),
('1522de3854c00833e0062c5bc520527ca00ffbb160e43c1ed199b66c6a7802535f8ffa306b77aaa0', 85, 3, 'authToken', '[]', 0, '2021-02-05 04:08:16', '2021-02-05 04:08:16', '2022-02-05 04:08:16'),
('156402083149efeb9b0e65c5896ed53bab465b9461426ed0811ed7a2f5a3c5c85b0b3d88351b1f70', 170, 5, 'authToken', '[]', 1, '2021-05-07 20:09:19', '2021-05-07 20:09:19', '2022-05-07 20:09:19'),
('1595302cdeb7474d1686c153bab17d14b78de54945b5ba00c84b6717dac7677d7022045549329299', 195, 5, 'authToken', '[]', 1, '2021-08-04 23:40:51', '2021-08-04 23:40:51', '2022-08-04 23:40:51'),
('1664e2dd2ca52c47eef438e70dceb628dee323a1799b91ff9a7670caaeda652d551f1e8381926e40', 103, 3, 'authToken', '[]', 0, '2021-02-14 10:25:26', '2021-02-14 10:25:26', '2022-02-14 10:25:26'),
('17d3fda5479b24fd3ee364eb2da577ea2beafed20c07021e6bb56e7a9fc663e30a3a4461ff5eb613', 77, 3, 'authToken', '[]', 0, '2021-01-29 02:22:45', '2021-01-29 02:22:45', '2022-01-29 02:22:45'),
('18325bf2efec3c64036be88ae30e6424bd671957d32c565a7ef976be2246ff39e1156fef2cb83db3', 53, 3, 'authToken', '[]', 1, '2021-02-13 19:11:58', '2021-02-13 19:11:58', '2022-02-13 19:11:58'),
('18b994abca09cd1f328d88d05c81c3b6e258b5c8716dda46a5d8991e21e4e4f0880b9574d4325553', 164, 5, 'authToken', '[]', 0, '2021-04-25 20:54:22', '2021-04-25 20:54:22', '2022-04-25 20:54:22'),
('18e9cf523ebcfab5151cd962f3247c054ed30a9ebea60fc165188f6c66a194a0f6a0e51ea20a4a13', 109, 3, 'authToken', '[]', 0, '2021-03-01 17:04:46', '2021-03-01 17:04:46', '2022-03-01 17:04:46'),
('19f458655301f735b3a128b81c10f7a1a7eba03f5c44d09181c306fa5447e6dffd80049275af4e07', 57, 3, 'authToken', '[]', 0, '2021-01-08 18:48:32', '2021-01-08 18:48:32', '2022-01-08 18:48:32'),
('1a6e9bedb02288563cd242d590f0b44101924a012f9192246b0dadab54b9aeb62d84578fb83a4892', 84, 3, 'authToken', '[]', 0, '2021-02-04 02:11:55', '2021-02-04 02:11:55', '2022-02-04 02:11:55'),
('1af6f0af88cf9f394bf7190ff4aef6034746e6f21e2e53f9c5de3c565beda25e9f14781b3ed5cf9b', 75, 3, 'authToken', '[]', 0, '2021-01-27 23:47:30', '2021-01-27 23:47:30', '2022-01-27 23:47:30'),
('1b4e5582d6778a47ea38dae2c73a013293ec4cad92e8a1c1214b0cf37ff3500dd1be76035045bf6e', 5, 3, 'authToken', '[]', 1, '2020-12-14 16:45:53', '2020-12-14 16:45:53', '2021-12-14 16:45:53'),
('1bdcf58cf3fe373cf843d5eb1ee86d7b53ddc72343c84cb663c1102d4dce3ea6f0af6fa266cbb407', 33, 3, 'authToken', '[]', 0, '2020-12-15 16:43:39', '2020-12-15 16:43:39', '2021-12-15 16:43:39'),
('1d2ddf840ed00964c4de43a4e0293a2ec309266a2ff2614d8cd9de672496ac131503b8484006bd08', 110, 3, 'authToken', '[]', 0, '2021-02-16 05:59:20', '2021-02-16 05:59:20', '2022-02-16 05:59:20'),
('1d63e0f5e437931bfc30f105180f1de60823f7fe1f1db53494fccbb43839bbbade9456baecbfb2be', 2, 3, 'authToken', '[]', 0, '2020-11-13 13:18:50', '2020-11-13 13:18:50', '2021-11-13 13:18:50'),
('1dda37c031bab199745965442ffb95c0db8690e5d2da1e1070638d1b2bdaf27539b1263be65f504a', 185, 5, 'authToken', '[]', 0, '2021-07-17 17:47:36', '2021-07-17 17:47:36', '2022-07-17 17:47:36'),
('1e3bd720a46c21666c722e03d50016d95a16d7f139ccb97f4686a32b37656fd22fa629b14a8858d5', 121, 3, 'authToken', '[]', 0, '2021-03-03 20:10:10', '2021-03-03 20:10:10', '2022-03-03 20:10:10'),
('1e68246eb61a74ffe52f104298af0705646bf715a2c1aecea0ab0d784871f6eedda736a6ea6c5b9c', 146, 3, 'authToken', '[]', 0, '2021-03-15 18:36:32', '2021-03-15 18:36:32', '2022-03-15 18:36:32'),
('1ee41f35adfb55d685d920a635621ebb79867767891d508a96afaf84b5b4773cf2171c2e90ca3056', 160, 5, 'authToken', '[]', 0, '2021-04-17 18:25:26', '2021-04-17 18:25:26', '2022-04-17 18:25:26'),
('1f5c6ee0499fd3afd7a1972b8381647c47e2a08432823e4d201b1d9750d942dcd2b692cfe35209c8', 184, 5, 'authToken', '[]', 1, '2021-07-15 13:24:46', '2021-07-15 13:24:46', '2022-07-15 13:24:46'),
('1fe786ef0a0014ac55efb90da0467a1c066d22626714129a3c3d7ca0f8f7712fd9baa3c8b5a961d8', 160, 5, 'authToken', '[]', 0, '2021-04-17 19:09:09', '2021-04-17 19:09:09', '2022-04-17 19:09:09'),
('202fdd4b782d716739a8517de6d333769db1fe64750f966a78f49a47e4d5220b1dd1863ba498ca4d', 103, 3, 'authToken', '[]', 0, '2021-02-14 10:28:09', '2021-02-14 10:28:09', '2022-02-14 10:28:09'),
('20b6cdd6ca802f9ff861562293c27773231e0bce1584e1d09114ac216624872910046d75a9613f19', 171, 5, 'authToken', '[]', 1, '2021-08-31 17:27:25', '2021-08-31 17:27:25', '2022-08-31 17:27:25'),
('20c2fe1ad509cc80f6b38aac9ed537b108911cf3fbf4d66a075a016e148d215315e98459faae076f', 177, 5, 'authToken', '[]', 0, '2021-06-02 23:15:30', '2021-06-02 23:15:30', '2022-06-02 23:15:30'),
('20f30b599db4829a1663d2dfbffe460d443c9ebbceb0deb4f3c5f5604171f8990269780bcbe9ce14', 1, 5, 'authToken', '[]', 1, '2021-05-07 20:05:51', '2021-05-07 20:05:51', '2022-05-07 20:05:51'),
('232646bc384e59c88fc56af63d16f008618b376877e803db498bcd656935d8aae3a25a05fafd701b', 150, 3, 'authToken', '[]', 0, '2021-03-30 08:13:02', '2021-03-30 08:13:02', '2022-03-30 08:13:02'),
('234333c6ea1154a65e74f4a46c3d48b065ed18a1827c8647b7696842452cc2d1b9445e2cc4daa9ff', 75, 3, 'authToken', '[]', 0, '2021-01-27 23:48:26', '2021-01-27 23:48:26', '2022-01-27 23:48:26'),
('250ae485ecdc06f19d14b70c6553bbb8a70e9ac62e416217581153c09852e2fcc22ad25b2bbbbb85', 1, 3, 'authToken', '[]', 0, '2020-12-18 07:37:53', '2020-12-18 07:37:53', '2021-12-18 07:37:53'),
('25bd66c840ef6d6d91f1869d7ef62108650ee522a4cef4a4385e8f3cb97855881b49afc6e504f500', 197, 5, 'authToken', '[]', 0, '2021-08-05 07:43:25', '2021-08-05 07:43:25', '2022-08-05 07:43:25'),
('25f1dd2eee33972a9fc078c50ea6e790ee98ed4e23d55c0939be02019151acac3884f622a8558ece', 152, 3, 'authToken', '[]', 0, '2021-03-25 11:37:21', '2021-03-25 11:37:21', '2022-03-25 11:37:21'),
('272245f8ea90c6ab0b618869de914edb3019d2ef54b47547e0db67838b21928726b84ef6b9d06f2c', 81, 3, 'authToken', '[]', 1, '2021-02-02 01:38:19', '2021-02-02 01:38:19', '2022-02-02 01:38:19'),
('28b8d9401f2d967a57f4f65d2b6f6156c4f8d272d38e46fb57cf291a1d45ed5b1e9b7edb686976fb', 86, 3, 'authToken', '[]', 0, '2021-02-05 22:59:29', '2021-02-05 22:59:29', '2022-02-05 22:59:29'),
('2914ced017289510b58262a4b20d04512c8be12aaa60987efefe8ff2d72cb763c25fbf0dfb67f742', 59, 3, 'authToken', '[]', 1, '2021-01-09 07:09:05', '2021-01-09 07:09:05', '2022-01-09 07:09:05'),
('29cd2dbdf481f21ef12509353ead7461ed023a45d4d0be557d578990bb7d9be7706aeea6448429e2', 2, 5, 'authToken', '[]', 0, '2021-08-04 05:44:43', '2021-08-04 05:44:43', '2022-08-04 05:44:43'),
('2a07a7930681eef0651541a8f356908599a618a290de3e51e704e7fd6d9704d0e7c036587727763a', 34, 3, 'authToken', '[]', 0, '2020-12-15 16:55:04', '2020-12-15 16:55:04', '2021-12-15 16:55:04'),
('2a1c5ed4b4305127d0785b6f33531e0c70bf0c024ca5613c7edaedba1f63dd3e265e3e90d84c710e', 131, 3, 'authToken', '[]', 0, '2021-03-09 21:31:56', '2021-03-09 21:31:56', '2022-03-09 21:31:56'),
('2a392108b14ab6d123d91c9e4a3d6ae4a30e4fb444a4677531f98a73dc4b488ad68a33cd32a94e95', 15, 3, 'authToken', '[]', 0, '2020-12-08 16:17:40', '2020-12-08 16:17:40', '2021-12-08 16:17:40'),
('2b1053d93151b76e8727c91e7d4d309ba3eeb2da6707b1b620692b97b9ef5dea2c4c5219dc65df53', 113, 3, 'authToken', '[]', 0, '2021-02-20 15:07:12', '2021-02-20 15:07:12', '2022-02-20 15:07:12'),
('2bb54972541bd8425217e279dbab61ba0e0efe80e27dccd4f238e10258594c088f133e5acd58d55c', 55, 3, 'authToken', '[]', 0, '2021-01-05 20:21:08', '2021-01-05 20:21:08', '2022-01-05 20:21:08'),
('2c5a39560f8d4a36dca9b0cfa744ad73061866e95a5ba0353c502e26a5893cc97fcfcb9de392107f', 4, 3, 'authToken', '[]', 1, '2020-12-16 19:19:41', '2020-12-16 19:19:41', '2021-12-16 19:19:41'),
('2c8176a89e82230672b00e0597c6f0315babe83c50999c0d7bf70509c1cec77b0ec9c9980fb4de3d', 115, 3, 'authToken', '[]', 0, '2021-02-23 19:04:05', '2021-02-23 19:04:05', '2022-02-23 19:04:05'),
('2cd0f8f805c739eb8d3ea82f1d4629126122de4b77f9eb133671938145821d9a56b33ab3945e84e1', 205, 5, 'authToken', '[]', 0, '2021-09-07 16:33:08', '2021-09-07 16:33:08', '2022-09-07 16:33:08'),
('2d1960de5bd00093a0a9c7c049b780c0e0940e12beb65720f8a741d53cbb94d1e8d66487e656ac77', 3, 3, 'authToken', '[]', 1, '2020-12-08 11:23:14', '2020-12-08 11:23:14', '2021-12-08 11:23:14'),
('2db383ee0c74f9a8b4f330cd13b4eb5e9f4d56895813ea08c57f67cd4f5a0d3b0f91625e3c86de24', 99, 3, 'authToken', '[]', 0, '2021-02-13 19:05:32', '2021-02-13 19:05:32', '2022-02-13 19:05:32'),
('2df6d9cb77ac79a2772123d20a2874cd739b3f8a194cde41314090a4159584425587ae794efda84e', 187, 5, 'authToken', '[]', 0, '2021-07-20 20:33:59', '2021-07-20 20:33:59', '2022-07-20 20:33:59'),
('2e1091ac16d3b650e8c225284194f0d76364e76304c9cf9ad615ed6051fbde8677049de63ef708fb', 146, 3, 'authToken', '[]', 0, '2021-03-15 18:37:02', '2021-03-15 18:37:02', '2022-03-15 18:37:02'),
('2edb17868bd72c0af2022546113387aa29fa79b72f468687fb16c39235cf08ff38f5461b46fe433b', 171, 5, 'authToken', '[]', 0, '2021-05-07 20:18:20', '2021-05-07 20:18:20', '2022-05-07 20:18:20'),
('2f9d51635d34553431d29a8dd8b50459cb19aeb2788faa0e7e1777cd42dfefedd9cfe8b55766f9d3', 60, 3, 'authToken', '[]', 0, '2021-01-18 04:50:09', '2021-01-18 04:50:09', '2022-01-18 04:50:09'),
('30822253da5ef7c503fbddc59dc29b27ac08b9b3098d0614fec82a8a232ac24e8349404d55cf572f', 107, 3, 'authToken', '[]', 0, '2021-02-15 19:34:48', '2021-02-15 19:34:48', '2022-02-15 19:34:48'),
('3151d291499c15ff1836a2e0a01c69aaf505de0c5993619c7e1c9c3e1e7c76a271c3f1e9e256f47a', 109, 3, 'authToken', '[]', 0, '2021-03-23 01:05:29', '2021-03-23 01:05:29', '2022-03-23 01:05:29'),
('31b56bddcbd072b7cd8bb7ad0be084e40e8862ba7e5c96dad400ed992fb21e71c2a4f769028ca02a', 180, 5, 'authToken', '[]', 0, '2021-07-04 05:00:53', '2021-07-04 05:00:53', '2022-07-04 05:00:53'),
('32016ce28bd5868d5b0418197b3b3c44949380900514fb701a63e0187cef2fabf9054aaf43e95ba1', 187, 5, 'authToken', '[]', 0, '2021-07-20 20:32:34', '2021-07-20 20:32:34', '2022-07-20 20:32:34'),
('328cde586bc8c1197985be175f799c0ae367979723feae6ba95e19c9f216b40921e99677a2588bb7', 1, 3, 'authToken', '[]', 0, '2021-01-28 23:50:59', '2021-01-28 23:50:59', '2022-01-28 23:50:59'),
('339d6425661fed78725e6284d3033ec866c93e349aa875b947cf1c23696f8fa62a88e3bb4ee3a733', 197, 5, 'authToken', '[]', 1, '2021-08-05 07:44:28', '2021-08-05 07:44:28', '2022-08-05 07:44:28'),
('3451250732ed908e00f628fd774d3250257eb18b445c1899baa726e1a9fbbe7bbf1405749091695e', 83, 3, 'authToken', '[]', 0, '2021-02-02 04:49:43', '2021-02-02 04:49:43', '2022-02-02 04:49:43'),
('352513258aa00d5994c2c3367dc6eb5bc0ddb00215531b98a3f72133b310c62450561c7df3b4ee16', 159, 5, 'authToken', '[]', 1, '2021-04-15 17:03:07', '2021-04-15 17:03:07', '2022-04-15 17:03:07'),
('35ebd59d18d344b92da6414fedd1cf7d2264ed72f21e9c52c1c41c0d379aeef46050b9dbf35a4970', 163, 5, 'authToken', '[]', 0, '2021-04-22 03:40:37', '2021-04-22 03:40:37', '2022-04-22 03:40:37'),
('367bfe428295f46b7f7b622919dfb30481702164639a3d8ea9fd0f3f9d091e4d6abb68f01ef5b361', 96, 3, 'authToken', '[]', 0, '2021-02-12 23:29:40', '2021-02-12 23:29:40', '2022-02-12 23:29:40'),
('36e3a85fc8f7b58a0a029c98150cb36424c8f135e7d7c556d947f17b64234793dd200b21701bcde0', 51, 3, 'authToken', '[]', 0, '2020-12-29 21:29:29', '2020-12-29 21:29:29', '2021-12-29 21:29:29'),
('37b58c780ad770015fd71d643d2f89f6a7daf059623ff3ee8530d8af54bdf453eed18e4e33477153', 2, 5, 'authToken', '[]', 1, '2021-07-19 14:56:48', '2021-07-19 14:56:48', '2022-07-19 14:56:48'),
('37db7d088a569df73cc1489808946e5a2085e78b5a5b44502280ff77f146644a46ddf1b4eec80c69', 187, 5, 'authToken', '[]', 1, '2021-07-20 20:38:42', '2021-07-20 20:38:42', '2022-07-20 20:38:42'),
('3962ab4f456a8a3023999d54505bddc210a078eb585c81a831bc059212f0728652ecb1208f6c3b65', 100, 3, 'authToken', '[]', 0, '2021-02-13 19:26:11', '2021-02-13 19:26:11', '2022-02-13 19:26:11'),
('3a67e23c80bb27b7e5155dfaacf272381190eff0a662f95073befbfceaaa59f7a63f2f98050dda0d', 3, 3, 'authToken', '[]', 1, '2020-11-13 12:50:50', '2020-11-13 12:50:50', '2021-11-13 12:50:50'),
('3bb9ccc13db98cc241b2b8bdd19b9e6831d88b68eab8afed14694c2ea4e54f1ccd516057d255bc27', 161, 5, 'authToken', '[]', 0, '2021-04-17 20:54:53', '2021-04-17 20:54:53', '2022-04-17 20:54:53'),
('3c20959f14ed566b4730ae2c2051a1dc01fb84116fe7c2c8373b4382bf2ed3f97360fd74b57a9824', 1, 5, 'authToken', '[]', 1, '2021-09-08 17:20:40', '2021-09-08 17:20:40', '2022-09-08 17:20:40'),
('3c4b60138219b9490e2e23c9be4e866dbddd1b62f81e8e2c6bb1da2a6cef24b19ad7bbc8ef7e21e5', 49, 3, 'authToken', '[]', 1, '2020-12-29 16:13:34', '2020-12-29 16:13:34', '2021-12-29 16:13:34'),
('3c624e9a357fbc3633b14b7767ce46160693de11e2d2169a9ca8dd4bbea4f7f8dbe226bebc997a0d', 151, 3, 'authToken', '[]', 0, '2021-03-24 15:56:15', '2021-03-24 15:56:15', '2022-03-24 15:56:15'),
('3df5625ba06ef1367919dc4cf6679fb877b64c8daaba389774253d0ed3fd5359b581d218bcd1bc0f', 44, 3, 'authToken', '[]', 0, '2020-12-22 16:42:45', '2020-12-22 16:42:45', '2021-12-22 16:42:45'),
('3ea574e0e4da8d2bcac8ff189e23d5ae0f299c08fb68b81ec7f83bb6e9e914fa9c516494a9ccdb95', 170, 5, 'authToken', '[]', 1, '2021-08-31 19:18:41', '2021-08-31 19:18:41', '2022-08-31 19:18:41'),
('3f35f05ff7a8c2c743b2cb9d5174e4baaf26054e3a213657bac0fe140d20a38d76da6f4c881939ca', 1, 3, 'authToken', '[]', 1, '2021-03-04 08:18:10', '2021-03-04 08:18:10', '2022-03-04 08:18:10'),
('401e6eab745b91a64f8bdc369b44b419872ba7df3f8a83ee8a1ae85eee40074450698078b2089c54', 175, 5, 'authToken', '[]', 0, '2021-05-25 16:12:39', '2021-05-25 16:12:39', '2022-05-25 16:12:39'),
('405ba7b8b5fc35ce31d17edfa5e3115f16a228a3c5a69bc286ccb9b38b38d97adab29de2c689dcf1', 61, 3, 'authToken', '[]', 0, '2021-01-09 19:36:14', '2021-01-09 19:36:14', '2022-01-09 19:36:14'),
('406739c6594bb2ec350812a5e554005c8c539a12cd5aa019a04b635ce86b17615bfeeb88188e5c9e', 89, 3, 'authToken', '[]', 0, '2021-02-10 20:45:52', '2021-02-10 20:45:52', '2022-02-10 20:45:52'),
('40ec5fe4ea3ea00fbde78f10eee73abd7ab0ef6bbe33b432094ca0e885d7a3bd05e9ca282b7c257f', 109, 3, 'authToken', '[]', 1, '2021-03-30 08:10:29', '2021-03-30 08:10:29', '2022-03-30 08:10:29'),
('41bcc1e98d4fad11b77141abcee47881e2446c130648db8ffaf6a4eb71eb493e7f284473873dccdc', 144, 3, 'authToken', '[]', 0, '2021-03-15 13:55:36', '2021-03-15 13:55:36', '2022-03-15 13:55:36'),
('41e3d9ae55e8b00f5d6fbbe910ce2c65f60bec9cdb9d93c8d8f72e8b74d5f0b9e65261cd182b1a7a', 153, 3, 'authToken', '[]', 0, '2021-03-27 04:34:27', '2021-03-27 04:34:27', '2022-03-27 04:34:27'),
('439b921bd50de38c5cbd405cfecb299945104220f0d5e210104d3795352ab3c814e1656d8b293e1f', 43, 3, 'authToken', '[]', 0, '2020-12-19 06:51:44', '2020-12-19 06:51:44', '2021-12-19 06:51:44'),
('43bb4ff2626a8e0cc78f33d30dfc718f0d9c7532875856a369796066d1a76830d57a8c60ce78ecd2', 3, 3, 'authToken', '[]', 0, '2020-11-24 05:09:37', '2020-11-24 05:09:37', '2021-11-24 05:09:37'),
('45584d28b60d0156c054d091a02103ad7380df838c72140ed94f905db1599bc01514782171dfcaf8', 175, 5, 'authToken', '[]', 0, '2021-05-25 16:13:24', '2021-05-25 16:13:24', '2022-05-25 16:13:24'),
('4672880317151716125e3d542ab1c3739c1cb673b45b4b11aff8020a3605e26b2e0ccd3dba3bcf3b', 199, 5, 'authToken', '[]', 0, '2021-08-12 16:25:26', '2021-08-12 16:25:26', '2022-08-12 16:25:26'),
('46a01b337e5e36b560f8a139c986964ca608e21ac4ef79b5be500ef0303263d6870bd8df92c1cc00', 90, 3, 'authToken', '[]', 1, '2021-02-26 13:01:08', '2021-02-26 13:01:08', '2022-02-26 13:01:08'),
('47ffe17d61562b80db0afa1de6bfa92dec4b2e9c6bf2a7644c0482d963cd73818e324ecd4f44d65c', 165, 5, 'authToken', '[]', 0, '2021-04-26 03:26:00', '2021-04-26 03:26:00', '2022-04-26 03:26:00'),
('48304f9c476ad553e736b7f66c4232f6cd8423773191bfda10bd065600bc292ee6180ebff4b6d609', 48, 3, 'authToken', '[]', 0, '2020-12-25 05:07:45', '2020-12-25 05:07:45', '2021-12-25 05:07:45'),
('4851f4d2bc4ebcbab4d55e3b33c5d4f6c0cc835fe9e63027e9cb54a9d004050cb974abc97a584c8e', 3, 3, 'authToken', '[]', 1, '2020-11-24 05:08:57', '2020-11-24 05:08:57', '2021-11-24 05:08:57'),
('48b1d6b386baa76d6cbca1dcd46e900973f66622679ac14a1e8f69472d016ea60932c5fce1669e5d', 144, 3, 'authToken', '[]', 0, '2021-03-15 13:56:27', '2021-03-15 13:56:27', '2022-03-15 13:56:27'),
('48d31ee92fc2c3a6ad42b0e85f9234eea5aed0de55b8546f17e1c308b035e10c9496eeffe7792382', 1, 5, 'authToken', '[]', 1, '2021-08-04 22:57:07', '2021-08-04 22:57:07', '2022-08-04 22:57:07'),
('49121e8858138a17a8881b87c4890ab8b16b461c323ccd359ee7a73c45bcc337d46078746bb27f6e', 3, 3, 'authToken', '[]', 1, '2020-11-12 14:35:41', '2020-11-12 14:35:41', '2021-11-12 14:35:41'),
('496ea86b5123a63f21ae1b746b6a677a0c4e6e4bcdf928aa3336781f81c68837fb5aeee6b84dc0a2', 68, 3, 'authToken', '[]', 0, '2021-01-17 04:05:23', '2021-01-17 04:05:23', '2022-01-17 04:05:23'),
('49b66e1fe37f47d9ffba448e6c09528e160ae8977b4995293239d6ccebc3df7af2dc7f5d9b775635', 159, 5, 'authToken', '[]', 0, '2021-04-15 14:38:10', '2021-04-15 14:38:10', '2022-04-15 14:38:10'),
('4a15b9e510c7cc89db4ba7b501f8bc3996489ea89cd7043b1cb5e23bce80102e50898f588110f0f3', 73, 3, 'authToken', '[]', 0, '2021-01-25 18:55:22', '2021-01-25 18:55:22', '2022-01-25 18:55:22'),
('4a242ccf91a3ea144d1cfc1295c87bcb68cbca0d0ff1a8b0a18d3d8b03d30dc78ef39ab4ad265b17', 61, 3, 'authToken', '[]', 0, '2021-01-09 19:42:50', '2021-01-09 19:42:50', '2022-01-09 19:42:50'),
('4a4b2b8f857b5c9f12fa89998ada28a9c007ed09ee7dca31d25cd6e9067fcab731c23d72474ff8d6', 5, 5, 'authToken', '[]', 0, '2021-04-15 07:36:14', '2021-04-15 07:36:14', '2022-04-15 07:36:14'),
('4a51b56e9d0d39163e0f692df3414d58f4e3653a7eff4da288308dba3919cc5b15150b4d35cfe558', 109, 3, 'authToken', '[]', 0, '2021-02-26 11:29:28', '2021-02-26 11:29:28', '2022-02-26 11:29:28'),
('4a7cee01193546d3e87644797f4732f11bb99ca2266cd855acb374bcd330e20764cc412482e72a8f', 81, 3, 'authToken', '[]', 0, '2021-02-02 01:36:59', '2021-02-02 01:36:59', '2022-02-02 01:36:59'),
('4aeae53701d4dc46af8b141b28191d6bd9a404c02e8186c63bb2dc7fca60ee36c558a206df814017', 71, 3, 'authToken', '[]', 0, '2021-01-18 18:25:40', '2021-01-18 18:25:40', '2022-01-18 18:25:40'),
('4b04ef68766ecd6400d85955c2cb7d94dd1de35ab427f15ab535b8e476d5d33317c6b55368c66548', 108, 3, 'authToken', '[]', 0, '2021-02-15 21:21:59', '2021-02-15 21:21:59', '2022-02-15 21:21:59'),
('4b6d2cd6ec1423897650645b49d313beec354b1c57f4bab2cbb0f2a1bccc558975b64ad0cdaaa7a1', 204, 5, 'authToken', '[]', 0, '2021-09-06 20:41:17', '2021-09-06 20:41:17', '2022-09-06 20:41:17'),
('4c20600b6dc6461d0f1ef56a6424d6508241f40721a47230bc9385b8711e2e01b4cf057226d260a2', 120, 3, 'authToken', '[]', 0, '2021-03-01 17:34:57', '2021-03-01 17:34:57', '2022-03-01 17:34:57'),
('4cc3fc086128f0aaa82d34de7e81c4969b47ba71f5e17a56d704f0383ab939da44b5cbd178e15649', 117, 3, 'authToken', '[]', 0, '2021-02-26 16:50:08', '2021-02-26 16:50:08', '2022-02-26 16:50:08'),
('4cd817b53c6971f19fd0853c6fabd047c07c8394db514ff362843ffcb02b28223d6f546a4fa42ae0', 149, 3, 'authToken', '[]', 0, '2021-03-19 00:48:33', '2021-03-19 00:48:33', '2022-03-19 00:48:33'),
('4df04bc958a1a6554ea64784c576448289fc61fac72cf681b3b80c7e2a72553a8a90a5c916b8093a', 190, 5, 'authToken', '[]', 0, '2021-07-24 08:22:27', '2021-07-24 08:22:27', '2022-07-24 08:22:27'),
('4e00a7901dd27c41d00c13033d453d903cb45abe8f578bf0ed0315498f057f18c401aecb080db162', 152, 3, 'authToken', '[]', 0, '2021-03-25 11:36:37', '2021-03-25 11:36:37', '2022-03-25 11:36:37'),
('4f0d45a913d8c2309a00b0d978f34454fe14e69bfa6daa7d7caf3a82a80cfd4b6fb1d4a277859766', 201, 5, 'authToken', '[]', 0, '2021-08-15 19:30:32', '2021-08-15 19:30:32', '2022-08-15 19:30:32'),
('4f14dd477fd43f9f616fa310448b9932b99864c4d081827943395816e7d2145dfb6ca2ff3c8a081f', 184, 5, 'authToken', '[]', 0, '2021-07-15 13:19:42', '2021-07-15 13:19:42', '2022-07-15 13:19:42'),
('4f2a541ce0c003b7fcb77c54a46dc41dc1d52812b754f7b318368f9ef86adc515861d174f5848311', 5, 3, 'authToken', '[]', 1, '2021-02-11 11:53:42', '2021-02-11 11:53:42', '2022-02-11 11:53:42'),
('4fc9edc664c1c3c38aeffc3c90009904c35314ac502a70232d127f01b6f5e0ad85f8253260be97ee', 17, 3, 'authToken', '[]', 1, '2020-12-09 15:49:14', '2020-12-09 15:49:14', '2021-12-09 15:49:14'),
('50975f2a8052aac53940c1f18d60fe2c8586b3ba458feee349b61436a621f5c85e83672d245a4248', 1, 3, 'authToken', '[]', 1, '2021-02-13 19:35:06', '2021-02-13 19:35:06', '2022-02-13 19:35:06'),
('50e7e23a54c09fbe55f31a4938c6566faecf68298deec494f4eea5e2b07119fe0dcba6d77d9633db', 186, 5, 'authToken', '[]', 0, '2021-07-18 04:47:27', '2021-07-18 04:47:27', '2022-07-18 04:47:27'),
('50f9bfd1e13f7ad4bd9c833a46eba157b5821ad3fd62186297f670d8ebe25ce8e8f0e89de795d5bc', 50, 3, 'authToken', '[]', 0, '2020-12-29 21:16:11', '2020-12-29 21:16:11', '2021-12-29 21:16:11'),
('515f55be3f57750bef47fbf275a739a3e0926d43a40eece0fa3f01ffb888d016656c2485bf687a03', 171, 5, 'authToken', '[]', 1, '2021-08-20 18:21:25', '2021-08-20 18:21:25', '2022-08-20 18:21:25'),
('52d4c55120c29d04544b298d36032018e05bc74f032f2ef92fab8709a37352d98d577793e7e04d2b', 183, 5, 'authToken', '[]', 0, '2021-07-14 16:13:35', '2021-07-14 16:13:35', '2022-07-14 16:13:35'),
('53d0a14fa8c1fb9eaaf105418d2ecacd2416c55f60db599540acd464a7570b1326c3c6beb9ca60a1', 133, 3, 'authToken', '[]', 0, '2021-03-10 16:57:55', '2021-03-10 16:57:55', '2022-03-10 16:57:55'),
('53e791b59f651f5437952b2517ce6c3f9124d2ec987d3f5ddc41254b68c18ada88273126a2a555c8', 72, 3, 'authToken', '[]', 0, '2021-01-23 08:09:55', '2021-01-23 08:09:55', '2022-01-23 08:09:55'),
('5426307ea5c911fcde7c7bf0691967db19b96bb9b0b1032f5365fe05cb5215f5689b6c616b2c2dc8', 135, 3, 'authToken', '[]', 0, '2021-03-11 00:41:37', '2021-03-11 00:41:37', '2022-03-11 00:41:37'),
('546d38b9d6b69055bfccaf63ceeced1f66c40c6ce69af13b4474a9cf1e41117d6f6f58e00a4aef2c', 170, 5, 'authToken', '[]', 1, '2021-08-30 14:20:20', '2021-08-30 14:20:20', '2022-08-30 14:20:20'),
('54c771651ffb431a233d860a06c29e56e906a82ea7e9c2717f2cad339d2eb1d2f70403fad648e2a7', 110, 3, 'authToken', '[]', 0, '2021-02-16 06:00:40', '2021-02-16 06:00:40', '2022-02-16 06:00:40'),
('54c95b0ee408ce941ec15daab0ba4c51e5706a1e1c1f2afe3167f6aab85d1e81ff02a22354f9c26c', 136, 3, 'authToken', '[]', 0, '2021-03-11 01:25:26', '2021-03-11 01:25:26', '2022-03-11 01:25:26'),
('54d736dcecc89625de2f8a51afcdc2b12c1d38b5a03353eb822fdb7890dbafed171c62a7edc76092', 143, 3, 'authToken', '[]', 1, '2021-04-05 08:31:25', '2021-04-05 08:31:25', '2022-04-05 08:31:25'),
('555b9d0788dccc5e7741aabdcc3a70abead5f63e6e4def0b08469431af787c00e97ec23e0067370f', 1, 5, 'authToken', '[]', 1, '2021-08-20 18:21:51', '2021-08-20 18:21:51', '2022-08-20 18:21:51'),
('5600ca257138413c4b92fa2f7f3025a880eb72b11bd12b052f0dc1f2d18fcca4f251252ca3903485', 2, 3, 'authToken', '[]', 1, '2020-11-13 12:34:17', '2020-11-13 12:34:17', '2021-11-13 12:34:17'),
('56b9f12e75ef8a186372b0cf70be8d56bbec856012f7b502402cb533514f8975749681e2d09cf556', 90, 3, 'authToken', '[]', 1, '2021-02-11 11:46:03', '2021-02-11 11:46:03', '2022-02-11 11:46:03'),
('57b554fbb307fba23756120aadf3c7ff959f7781edb13b94a4f3e50f97a42c0de247039167690ec8', 81, 3, 'authToken', '[]', 1, '2021-02-13 00:14:54', '2021-02-13 00:14:54', '2022-02-13 00:14:54'),
('595d1104b3bfcd9992526da863571e6c763bea6bb5f53f5ae2bacfcc8ee811126893326bb0770641', 39, 3, 'authToken', '[]', 0, '2020-12-17 09:22:10', '2020-12-17 09:22:10', '2021-12-17 09:22:10'),
('59b91add29c716373de7d03768810ceea9b86fc186746597b03a990389187391b30b5ca41f123f7f', 1, 3, 'authToken', '[]', 1, '2020-12-17 08:57:19', '2020-12-17 08:57:19', '2021-12-17 08:57:19'),
('5c1a49b431bf758d7345d84d2bd41d19b40e854ac7aec603ec73c0fd20e49861b1e37f4b60115c42', 92, 3, 'authToken', '[]', 0, '2021-02-11 12:20:28', '2021-02-11 12:20:28', '2022-02-11 12:20:28'),
('5c48adabe40934485e96f4b8f6bfa5a5da651a338e864f7bce1eec8b43a38fa795b7890bb811efbe', 148, 3, 'authToken', '[]', 0, '2021-03-19 00:41:03', '2021-03-19 00:41:03', '2022-03-19 00:41:03'),
('5c9c7d85f07e8a0cf320f0fba4934f7038e6236ac19cea5b87cb449f7f3eb5ce5c7f119ba7d49777', 130, 3, 'authToken', '[]', 0, '2021-03-09 15:31:26', '2021-03-09 15:31:26', '2022-03-09 15:31:26'),
('5cb815070cc7aeb4af3de52847c6ae0d4984f012a58b0f38cdfb505da8dcdbe061c1901b80d397eb', 176, 5, 'authToken', '[]', 0, '2021-05-27 04:09:29', '2021-05-27 04:09:29', '2022-05-27 04:09:29'),
('5d05c88fd222d6090280ab42e3566aa22396ed93d998dbcc3d533cf2cbdcb996a41227663539a8af', 195, 5, 'authToken', '[]', 1, '2021-08-04 23:46:57', '2021-08-04 23:46:57', '2022-08-04 23:46:57'),
('5d609599b0c130a0096f3e488640f36c0dba8f7255c6d71dd37bf85d83f1a6d7e7f1abead1456618', 50, 3, 'authToken', '[]', 1, '2020-12-29 21:25:30', '2020-12-29 21:25:30', '2021-12-29 21:25:30'),
('5ed13f6e1c0275f3c1b44f04874a0d461641c494303de84a68c30a7b02a46007e84f9524e56dc3c2', 40, 3, 'authToken', '[]', 0, '2020-12-18 13:49:33', '2020-12-18 13:49:33', '2021-12-18 13:49:33'),
('5f4b60328da7bd167ce0874dabd0ae9970fd8088ff5c888bebd00e68ef47cb01881805e32ff70b63', 1, 5, 'authToken', '[]', 1, '2021-08-31 19:17:11', '2021-08-31 19:17:11', '2022-08-31 19:17:11'),
('5f815b310c1a2ea3a6537a354807158bb83b940918cb2ad3ac82d87cd8d9d247114601663cfc024a', 171, 5, 'authToken', '[]', 1, '2021-08-30 14:20:08', '2021-08-30 14:20:08', '2022-08-30 14:20:08'),
('600d62d0e1134d452a45012318fe72134cdde8cb3060ca30eb365f83d233256bf7439738ecc4a321', 1, 3, 'authToken', '[]', 0, '2021-01-12 22:49:29', '2021-01-12 22:49:29', '2022-01-12 22:49:29'),
('60bbf213f68ba2ca805b1221058a38a970aa642651d0e8d330b23c6e46214a35667e4addbe7b3f64', 188, 5, 'authToken', '[]', 0, '2021-07-23 08:05:25', '2021-07-23 08:05:25', '2022-07-23 08:05:25'),
('60bc8704eabab7d172d71f6bb0a2a8220aea5182e8bc344184b5df6f7c94e07b63d4c2d4772a99de', 32, 3, 'authToken', '[]', 0, '2020-12-14 17:46:18', '2020-12-14 17:46:18', '2021-12-14 17:46:18'),
('60cd8b3ab73071258dd22bb563e2c62d3880b965017516f7d9ccc620e1a5034f4bffea7dc7b10c80', 204, 5, 'authToken', '[]', 0, '2021-09-06 20:40:17', '2021-09-06 20:40:17', '2022-09-06 20:40:17'),
('615fafa78d1c9c6929a6b131345ac771b4786c52a5fa51b64f68f3c85d76e3f924d7d43b738ff398', 112, 3, 'authToken', '[]', 0, '2021-02-18 09:41:10', '2021-02-18 09:41:10', '2022-02-18 09:41:10'),
('61f2cfc35bd689958c91afe82e65ff3f2a2c2b00295f8ae455ad8cdfd54708911b1523f4f0321335', 2, 5, 'authToken', '[]', 0, '2021-05-07 21:04:46', '2021-05-07 21:04:46', '2022-05-07 21:04:46'),
('62b4b4ecae7b7b39d38316fe6ff8c703be8aacf9492363619edd674701b96f49785ea33764c645f7', 171, 5, 'authToken', '[]', 1, '2021-08-30 14:30:39', '2021-08-30 14:30:39', '2022-08-30 14:30:39'),
('63084f7ad5ab88f423c7ea5a5109c0113382d0eb87dc8ccf3123a93ca77213d619895536235d1e8d', 62, 3, 'authToken', '[]', 1, '2021-01-11 05:41:09', '2021-01-11 05:41:09', '2022-01-11 05:41:09'),
('63340436b0e54b2c55259ae751082e2191c20a504c5d8f691d9061cbd3746f6fc8a0cec2466d3873', 67, 3, 'authToken', '[]', 0, '2021-01-14 04:07:02', '2021-01-14 04:07:02', '2022-01-14 04:07:02'),
('674b56b799be41a41126441c6294e7ddb0263db20598fd48584227a7196c85e5ce2414e0113d8523', 132, 3, 'authToken', '[]', 0, '2021-03-09 23:56:23', '2021-03-09 23:56:23', '2022-03-09 23:56:23'),
('675b078bfffe7cb3482aa4ad8020b14300d54ecf14a83c56b192ae36c6b80658a390c4248967ab1b', 73, 3, 'authToken', '[]', 0, '2021-01-25 18:53:24', '2021-01-25 18:53:24', '2022-01-25 18:53:24'),
('6796226a4e594be04d1e845984412f9288818388d04d969933187a086815be05ec43706e943c9668', 143, 3, 'authToken', '[]', 1, '2021-03-18 13:49:10', '2021-03-18 13:49:10', '2022-03-18 13:49:10'),
('679f41459fb7f2eeb429649bf80744d1a14b41e812dff3f009f3d71abb127d88b97e595dad9d5ab3', 109, 3, 'authToken', '[]', 0, '2021-03-22 18:31:28', '2021-03-22 18:31:28', '2022-03-22 18:31:28'),
('680efc42f9a5072213bff3c02c4a327a8713ebc6f43f382a44d4d7bf170f557bb4f8d27b3af4cbd2', 46, 3, 'authToken', '[]', 0, '2020-12-22 16:48:12', '2020-12-22 16:48:12', '2021-12-22 16:48:12'),
('681421e9100f1a60478edfdda914fd42fc6deaeba5bd38113c3b39fdc949b054549cdb207de28dcd', 140, 3, 'authToken', '[]', 0, '2021-03-15 13:18:50', '2021-03-15 13:18:50', '2022-03-15 13:18:50'),
('691304959aa859a6103950bf02f55d5fc3a928f7b915f121b68ac86fa0a48c6a14023b33864e1552', 154, 5, 'authToken', '[]', 0, '2021-04-21 14:41:53', '2021-04-21 14:41:53', '2022-04-21 14:41:53'),
('699cdf30e14b31602980ee29fa4bc0159b37e9adf272acc0df6349d5ce70e2d506065ff4b30cf276', 2, 3, 'authToken', '[]', 1, '2020-11-13 12:48:39', '2020-11-13 12:48:39', '2021-11-13 12:48:39'),
('69e655397adcdf9761bdb6b6f2029699b719c74c9723d07d76566a3a821fbd56e5f0478df436bf50', 61, 3, 'authToken', '[]', 1, '2021-01-09 19:37:14', '2021-01-09 19:37:14', '2022-01-09 19:37:14'),
('69fcf505eb78ddf20af75fe83a1b20ceede11603470ef8e5f5bdde842a27eb4261e2702863a5c56b', 131, 3, 'authToken', '[]', 0, '2021-03-09 21:32:58', '2021-03-09 21:32:58', '2022-03-09 21:32:58'),
('6a4f14a5988d9b48b2daedb75360022ab4a940fd99eb483e1b395f2ce504482eb151919d0ef5d073', 3, 3, 'authToken', '[]', 1, '2020-11-12 10:37:26', '2020-11-12 10:37:26', '2021-11-12 10:37:26'),
('6b5cba56b88db131cd53a79f79c7954562c1995f51cdb94101cd4508c8e14016612d1dc115c5747f', 200, 5, 'authToken', '[]', 0, '2021-08-13 02:26:15', '2021-08-13 02:26:15', '2022-08-13 02:26:15'),
('6b86b1633051695b11437c166bb50f84a59452180c5b10ed2e9abe3da9b66d619499ba8396a29664', 68, 3, 'authToken', '[]', 0, '2021-01-17 04:04:02', '2021-01-17 04:04:02', '2022-01-17 04:04:02'),
('6bd38d4a3dbd9e34442341fe6645a6d6f24735ecd08e304ceeb32996321ccaf8a2559165f78b4a37', 107, 3, 'authToken', '[]', 0, '2021-02-15 19:33:40', '2021-02-15 19:33:40', '2022-02-15 19:33:40'),
('6c541cd44d6d4a3c4f021ad5dbefdcf03d949c4354606da2396c62ae32548074ad27c8c7496c06a6', 161, 5, 'authToken', '[]', 0, '2021-04-17 20:42:08', '2021-04-17 20:42:08', '2022-04-17 20:42:08'),
('6c694cf192e62ec4ef4a108b4218b606720c40f6191c4e0f5d4587eeb351e93d7c87cd2e0aa24b53', 129, 3, 'authToken', '[]', 0, '2021-03-06 13:48:22', '2021-03-06 13:48:22', '2022-03-06 13:48:22'),
('6c81182e8a08fdbaa2eb34c9f31a9a5952f3bde0d23c45be2aff41e406c4691cb0aa9ea03916a2ec', 1, 3, 'authToken', '[]', 0, '2021-01-28 11:27:28', '2021-01-28 11:27:28', '2022-01-28 11:27:28'),
('6cb92e1d2bcc0803478cbfbe8dcb6ab7c8756de295d8d7e60a6f0b673b60a4790d77de92c0453987', 36, 3, 'authToken', '[]', 1, '2020-12-16 16:37:25', '2020-12-16 16:37:25', '2021-12-16 16:37:25'),
('6d38540b76132fd83d883af8a722250a688b4c1f12b48fa5d7441dc0b72021f98b2a922758bf50c7', 1, 3, 'authToken', '[]', 1, '2020-12-16 18:09:48', '2020-12-16 18:09:48', '2021-12-16 18:09:48'),
('6dccfff242a7751b18f07548bf13aa1a34bee8db361b4dc917ece77b0d31a19dfb8329e7e1fce951', 1, 3, 'authToken', '[]', 1, '2020-12-22 17:23:27', '2020-12-22 17:23:27', '2021-12-22 17:23:27'),
('6e64d54e2b128b043ffa6aaf50b749a4090ad0cc8df5e090d46e9593ec917f7cdee42b3e68df6171', 2, 5, 'authToken', '[]', 1, '2021-05-07 21:57:00', '2021-05-07 21:57:00', '2022-05-07 21:57:00'),
('701344485833f67d180aad6a5d4d12f778cea5820e9176ae89a35b513dff7ecde1040a6a892c3d87', 95, 3, 'authToken', '[]', 1, '2021-02-12 06:31:34', '2021-02-12 06:31:34', '2022-02-12 06:31:34'),
('708f289ea747c79459d6b8c99c40b1b76a5368f1aa5e9f09c54fdea1c2c4899780a88bb82649b69c', 150, 3, 'authToken', '[]', 1, '2021-03-22 23:52:49', '2021-03-22 23:52:49', '2022-03-22 23:52:49'),
('70b1201fe951e43effb521d68f867f029bfc275f0e76cff7b50e8de0e7c20110246fc0f73cd2fc69', 141, 3, 'authToken', '[]', 0, '2021-03-15 13:28:22', '2021-03-15 13:28:22', '2022-03-15 13:28:22'),
('7187cb3da5d82125a81a085d5976b729c82390a1b43c5c316908494b1ab2dc7063e07b75030ab774', 1, 3, 'authToken', '[]', 1, '2020-12-15 16:59:05', '2020-12-15 16:59:05', '2021-12-15 16:59:05'),
('7227433a664fee73377a31c627da7255e41d7b79330e4cc188a08d40446cbc1d6db91c7404599c42', 54, 3, 'authToken', '[]', 0, '2021-01-04 17:48:16', '2021-01-04 17:48:16', '2022-01-04 17:48:16'),
('726ea80bd57f09ec07e2197ad09fd5ace5176a2710b9c2948f157d067debc530b404cdc5583b3059', 154, 5, 'authToken', '[]', 0, '2021-04-15 08:03:06', '2021-04-15 08:03:06', '2022-04-15 08:03:06'),
('732b88aec268c6e247715384e84bc445d1c856332ae9b8017ee6058e7998ebe4e73839584470bdab', 177, 5, 'authToken', '[]', 0, '2021-06-02 23:16:14', '2021-06-02 23:16:14', '2022-06-02 23:16:14'),
('75482514eb330bf7a5ad864a67fce93d5fa1772b21ba1e8f7c42418596822812bf2e29d8327f6f65', 6, 3, 'authToken', '[]', 1, '2020-11-11 09:40:32', '2020-11-11 09:40:32', '2021-11-11 09:40:32'),
('75d9e598fbeb49dad729b051c1947f8bb48540de91f5532830505d70c45153650cb27301525de68c', 172, 5, 'authToken', '[]', 0, '2021-05-11 20:45:43', '2021-05-11 20:45:43', '2022-05-11 20:45:43'),
('773c29e95ad79422c0bdf04c3aad8a5ca28bca4fd54ca19357ceadfbcab763c84c3dde941cfcd332', 1, 3, 'authToken', '[]', 1, '2020-12-22 16:56:30', '2020-12-22 16:56:30', '2021-12-22 16:56:30'),
('781f69ae1e1718d690d3ebd0174332b2a11d7f50c3c713d7405a5751ba88cbfe9e0a0ae60b60e96a', 71, 3, 'authToken', '[]', 0, '2021-01-18 18:23:37', '2021-01-18 18:23:37', '2022-01-18 18:23:37'),
('789a026c15283fb223642dd2a7bf5b92273b3208141a24d6ceb5073d10f0fd9b11f92f8b680ce9a0', 1, 3, 'authToken', '[]', 1, '2020-12-30 17:11:42', '2020-12-30 17:11:42', '2021-12-30 17:11:42'),
('78a479b02b28eb1e5e01882cbe7bbe4011d3798047b197f777fd76080e3e077d7915cd74aa05fc06', 62, 3, 'authToken', '[]', 0, '2021-01-11 05:39:31', '2021-01-11 05:39:31', '2022-01-11 05:39:31'),
('794b8c8ec9fd16b77d00cc5cecab93d18304cb676a52206c3c89a2917daf997a3dcebc5c668f4d51', 44, 3, 'authToken', '[]', 1, '2020-12-22 16:43:28', '2020-12-22 16:43:28', '2021-12-22 16:43:28'),
('79557140e2368995376597be22cc72cd29bb3a7000d210382fd96e36f8014e845c0d5b4c62eb0b8f', 79, 3, 'authToken', '[]', 0, '2021-02-01 18:12:54', '2021-02-01 18:12:54', '2022-02-01 18:12:54'),
('79a4b2f61eeb4a64f998a07b1f7660cad1510636dfb33491f8711097811bff8f019f4e5267a7c5de', 53, 3, 'authToken', '[]', 0, '2020-12-30 17:09:18', '2020-12-30 17:09:18', '2021-12-30 17:09:18'),
('79acbb202ce39981f29989bacff21b0da6373451a24ccad8b73d8d21bc1cf65aab424101d85118b8', 1, 3, 'authToken', '[]', 0, '2020-11-10 15:32:49', '2020-11-10 15:32:49', '2021-11-10 15:32:49'),
('7b2a3050755fff68c02ab20a31b6e5ad351bb94d4042c99342bcefb15aef77af92b63d86b93e9cd4', 90, 3, 'authToken', '[]', 0, '2021-02-11 11:44:46', '2021-02-11 11:44:46', '2022-02-11 11:44:46'),
('7b35b98de6d75e0e53e4ca2754db01e2608ffdbd288ef9c4a7ad4e1f79b07a7e9827e03510b83289', 195, 5, 'authToken', '[]', 0, '2021-08-04 23:02:13', '2021-08-04 23:02:13', '2022-08-04 23:02:13'),
('7b741eb5dff7850919df9bbedcb0f4649c10403c250fb21e415851d50a912737301a1141aed6488b', 192, 5, 'authToken', '[]', 0, '2021-07-28 00:47:15', '2021-07-28 00:47:15', '2022-07-28 00:47:15'),
('7d708a8bde32048cf8f3c24e76e0d7cc0170520ebc7e01cacc53a22ece077886dd4330bc403b644d', 88, 3, 'authToken', '[]', 0, '2021-02-09 21:04:01', '2021-02-09 21:04:01', '2022-02-09 21:04:01'),
('7d7558f439e07471bade8082fab39753a23b3571a76be50d0cc27089f7c235bbaa97f373e6c729d2', 94, 3, 'authToken', '[]', 1, '2021-02-12 06:22:43', '2021-02-12 06:22:43', '2022-02-12 06:22:43'),
('7d8155c7c2d9b00e4f3adf663d024222d6587a9823d6de0319f2bd88adb0c829e3973d648308c8d4', 147, 3, 'authToken', '[]', 0, '2021-03-15 19:14:09', '2021-03-15 19:14:09', '2022-03-15 19:14:09'),
('7d903c149676693811eafa26d23dd736c3ab4ec1d46a39e3d1c8b9c576849b9cdab064e009e4fcfe', 161, 5, 'authToken', '[]', 0, '2021-04-17 20:38:22', '2021-04-17 20:38:22', '2022-04-17 20:38:22'),
('7e133d7cb58e6ce1417db1d0cefe6f39da354bf32b690c2c5964d92b91c34b520ad3b01f70b52548', 87, 3, 'authToken', '[]', 0, '2021-02-08 19:07:18', '2021-02-08 19:07:18', '2022-02-08 19:07:18'),
('7e526c57056d97495a4e4cd09f9bd63c842a8b37231b2f1936a659c66382652de24f3f4e38b855b8', 1, 5, 'authToken', '[]', 0, '2021-09-01 04:18:30', '2021-09-01 04:18:30', '2022-09-01 04:18:30'),
('7eaed4c7d2e8585742c7a5a9876388922d7a879fa0d1b57aa26f410a7290cc4f8277c01705772e1b', 109, 3, 'authToken', '[]', 0, '2021-02-16 03:10:13', '2021-02-16 03:10:13', '2022-02-16 03:10:13'),
('807ddb22ee898c8e4eb880854b18a71d8257b3da5b71bb0f1e6da84fb5dce10b0b38b7ccf81b6cf8', 37, 3, 'authToken', '[]', 0, '2020-12-16 18:03:27', '2020-12-16 18:03:27', '2021-12-16 18:03:27'),
('82910e38b8a59fcb3177ee7c2c50e523262534ce344cf302ecf338fb9adec6d2e8e34b51409d757d', 42, 3, 'authToken', '[]', 0, '2020-12-19 05:07:02', '2020-12-19 05:07:02', '2021-12-19 05:07:02'),
('82de7faf56fc49e44d87ed84c2dcdcca240e84678cc25185223dacf9fda9602a9fe5573b21393296', 200, 5, 'authToken', '[]', 0, '2021-08-13 02:25:42', '2021-08-13 02:25:42', '2022-08-13 02:25:42'),
('8348da343727e37145afa28f645612601a45a238a2f8be2a338be6862da1c55fe2c9edf1648df206', 149, 3, 'authToken', '[]', 0, '2021-03-19 00:47:14', '2021-03-19 00:47:14', '2022-03-19 00:47:14'),
('836cea47f0ceff701834279100a7f1caf376ca69e70024325306128c02052145c73d07e67cf52c07', 165, 5, 'authToken', '[]', 0, '2021-05-01 03:31:29', '2021-05-01 03:31:29', '2022-05-01 03:31:29'),
('838a694c235b065c5d226f327a8c1d514e698fad4ff2df5420e5f86e518017ef90ad42b6ef706b14', 74, 3, 'authToken', '[]', 0, '2021-01-27 15:49:51', '2021-01-27 15:49:51', '2022-01-27 15:49:51'),
('83ce6c10000d2a36c5d3e2d6d9daa927e8726cc01ca2afa3ac73aa1898fc11c543cdfcbf3af59b12', 9, 3, 'authToken', '[]', 1, '2020-11-13 17:40:42', '2020-11-13 17:40:42', '2021-11-13 17:40:42'),
('846d317b6eab7d5f8950d1bcf0fdce07858fbef2510a77dcad726a9aefcf7b0115d52c535e7cbdd9', 143, 3, 'authToken', '[]', 1, '2021-03-15 13:49:39', '2021-03-15 13:49:39', '2022-03-15 13:49:39'),
('84a106d2eed30c85c833f0216d47e1f45da12a313ae99bbbbfd7c01d3e57632a4536519b0f295a62', 170, 5, 'authToken', '[]', 1, '2021-08-31 19:16:30', '2021-08-31 19:16:30', '2022-08-31 19:16:30'),
('84b9a4b7d2e0da9dac6ff57ac5ad6b5f68a43ecf191cb55e3b14716b5223e70be054ce5c008d9a10', 98, 3, 'authToken', '[]', 1, '2021-02-13 00:01:59', '2021-02-13 00:01:59', '2022-02-13 00:01:59'),
('851cb4d143f4e57f024eb53f25c12d6feb34f9c0db6415423cf4f01091af434d9e2abb907728e856', 2, 3, 'authToken', '[]', 1, '2020-11-11 09:53:20', '2020-11-11 09:53:20', '2021-11-11 09:53:20'),
('85f5b10909169440a31733febf923e225f99331f63ff24be812f9a04226f0043a32ee2318600d41f', 2, 1, 'authToken', '[]', 0, '2020-11-10 14:16:57', '2020-11-10 14:16:57', '2021-11-10 14:16:57'),
('873db7d6b450ff2b5a1289c3c487c3aaff491b83ed2bac5284bee22ac3e54ab0b19803c7048b3280', 52, 3, 'authToken', '[]', 0, '2020-12-29 21:41:27', '2020-12-29 21:41:27', '2021-12-29 21:41:27'),
('87b32d56176b3a64d9f908b8e6f6a1c2efc9e88f8c4b3ae54dd06257bf5281ae6c81cddb2f0bf9f8', 1, 5, 'authToken', '[]', 1, '2021-05-07 20:28:20', '2021-05-07 20:28:20', '2022-05-07 20:28:20'),
('87c0aa35676831e82b9239bd00366bcd7f8635fd6c998047f08615a1a89eb475da2fa11e818fa05d', 189, 5, 'authToken', '[]', 0, '2021-07-24 04:01:27', '2021-07-24 04:01:27', '2022-07-24 04:01:27'),
('88f00ed098d4cf10f54d8648b55905c9d1ee33143706315dcc943293fe0a1c940ccc36f884194440', 162, 5, 'authToken', '[]', 0, '2021-04-19 21:36:40', '2021-04-19 21:36:40', '2022-04-19 21:36:40'),
('88f52f20b076fd027b9819ca8a5cce88bdae43c07de29c678ae315c4ca14d4d708e7ac144da296f3', 79, 3, 'authToken', '[]', 0, '2021-02-01 18:13:25', '2021-02-01 18:13:25', '2022-02-01 18:13:25'),
('8915665fdddbcaf20138f32ca7b7a60894219eb8a503415c752197cc055aaaac527fbde0b5600bef', 119, 3, 'authToken', '[]', 0, '2021-02-27 14:37:20', '2021-02-27 14:37:20', '2022-02-27 14:37:20'),
('89759ab7517b51312f8dc535d843dfb4de6bd9e4150bd3424f053a183657544e3b53bf891bffc336', 109, 3, 'authToken', '[]', 0, '2021-03-05 18:07:36', '2021-03-05 18:07:36', '2022-03-05 18:07:36'),
('89b9bee28dfdca7881506057c38722cb3b3f8618045b4c8351e734ff150ef4ee3a4a655d229ba873', 1, 5, 'authToken', '[]', 1, '2021-08-31 17:19:50', '2021-08-31 17:19:50', '2022-08-31 17:19:50'),
('89f8adc28103cddf3238f6829dde90415005e28a0a04793aafbb0733a61f62dd285169c0f11c011f', 5, 3, 'authToken', '[]', 1, '2021-03-11 16:20:48', '2021-03-11 16:20:48', '2022-03-11 16:20:48'),
('8a2e4ee407d96943217ba844b9493098d17951d8c0f1cc926433ddfd3c8c0dfac1eed3ca5c657429', 120, 3, 'authToken', '[]', 0, '2021-03-01 17:35:39', '2021-03-01 17:35:39', '2022-03-01 17:35:39'),
('8a97a94048bdf0506dadcbebf39b6ab1c5dea70ff4d7cb778c5a24677b6497185edcb185aa572b71', 125, 3, 'authToken', '[]', 0, '2021-03-04 07:25:15', '2021-03-04 07:25:15', '2022-03-04 07:25:15'),
('8b8bbb5a97ac4ad3fc0273ba31610ee8e29790cc15c6e3940db328a8391423a94e923953ba632568', 1, 5, 'authToken', '[]', 1, '2021-05-07 20:40:28', '2021-05-07 20:40:28', '2022-05-07 20:40:28'),
('8bf5dfbb67e6bbbbd0995bae14d5272b45000ae66dc138831193f07a03928e7dc67ba02ae9295c21', 109, 3, 'authToken', '[]', 0, '2021-03-19 00:53:17', '2021-03-19 00:53:17', '2022-03-19 00:53:17'),
('8c77bff254c0bf255ec0583b41b4dabdd939fe4518136e8844d4ecb5a6e8dfe79e76b8b753fac72f', 193, 5, 'authToken', '[]', 0, '2021-08-02 05:56:37', '2021-08-02 05:56:37', '2022-08-02 05:56:37'),
('8d0422a538e8e765276fd79d9e7bf929bc882ad1b718b8409c55e09dcd821d7f0d0162e9bf0dedea', 185, 5, 'authToken', '[]', 0, '2021-07-17 19:05:11', '2021-07-17 19:05:11', '2022-07-17 19:05:11'),
('8d2bbfcec78c876b68d9c753c32763b5a165b9e212a52060520db25d7c40d7775e15c4f7394d8faf', 1, 3, 'authToken', '[]', 1, '2020-12-30 00:16:09', '2020-12-30 00:16:09', '2021-12-30 00:16:09'),
('8d97ad66b235fb0799e43e6186bb1ae6729ef19ab21b607ed4ea8207cb1aa628618322148811aa82', 158, 5, 'authToken', '[]', 0, '2021-04-15 08:28:26', '2021-04-15 08:28:26', '2022-04-15 08:28:26'),
('8eeef9fcfe2e77aacd01fb54db710ca5ae4dd3dcf57fa7f1148e5f523ba4321608435b54773f45bc', 134, 3, 'authToken', '[]', 0, '2021-03-10 19:21:31', '2021-03-10 19:21:31', '2022-03-10 19:21:31'),
('922ecb2640b674404811a6a0e9ea622105d83483c28caf6daa2ceac441ac182c965b8777213ae8db', 106, 3, 'authToken', '[]', 0, '2021-02-14 19:44:58', '2021-02-14 19:44:58', '2022-02-14 19:44:58'),
('925f2192012bca519cfa792441c974dca5f104abe89f660081fbf10c0971f90d709120b886cd3b72', 81, 3, 'authToken', '[]', 0, '2021-02-02 01:37:42', '2021-02-02 01:37:42', '2022-02-02 01:37:42'),
('927f11eed632893301114da91310b2d4e2c1f403643c0f4aef11cf613e02aef885636e21fde7f250', 3, 3, 'authToken', '[]', 1, '2020-11-11 07:32:01', '2020-11-11 07:32:01', '2021-11-11 07:32:01'),
('9319e769c7b8ef5d7382f7977b9867b11f89d7e24ce38c33a3dafa9915cbf479981a67555c1b8bcd', 181, 5, 'authToken', '[]', 0, '2021-07-07 22:17:03', '2021-07-07 22:17:03', '2022-07-07 22:17:03'),
('93435b4ea355ea98e25e12a2dd2d01802835435991dc176c33f4d43ac0a9def56bd2fa8196775673', 192, 5, 'authToken', '[]', 0, '2021-07-28 00:46:10', '2021-07-28 00:46:10', '2022-07-28 00:46:10'),
('936d9788d29d3d52f5fabf7f52ea45ffae27da3beeee5731563399829892bae6346432cb524c700a', 109, 3, 'authToken', '[]', 0, '2021-03-09 20:13:24', '2021-03-09 20:13:24', '2022-03-09 20:13:24'),
('93a321f263d0bd42fd540faf991fcf5d704b3d210354f2fd74427b36054b2aed624b3411c967379a', 72, 3, 'authToken', '[]', 0, '2021-01-23 08:11:40', '2021-01-23 08:11:40', '2022-01-23 08:11:40'),
('93ec508283ffe49abf014e0bbbc1ce3e66c46ec4875507b79dead10ceaa6fb5232152b60389938f8', 111, 3, 'authToken', '[]', 0, '2021-02-16 21:49:53', '2021-02-16 21:49:53', '2022-02-16 21:49:53'),
('9422f288d7ea1ecbbd20bdba4850f674f5a6f5973854c1bd164e807b89713998e1f83cf7f044a33d', 98, 3, 'authToken', '[]', 1, '2021-02-13 00:14:23', '2021-02-13 00:14:23', '2022-02-13 00:14:23'),
('949e2ce264ed7defea7becc3d0c39060686e522e0b8346b57dad5c8a9a2e902e0b1393ac69dc208c', 172, 5, 'authToken', '[]', 0, '2021-05-11 20:45:04', '2021-05-11 20:45:04', '2022-05-11 20:45:04'),
('94c61f9a3990dc320bc015544b10b585aed55b95dc48bfd55bfca448d42d91dd3e85fba19730406c', 184, 5, 'authToken', '[]', 1, '2021-07-15 13:22:15', '2021-07-15 13:22:15', '2022-07-15 13:22:15'),
('962209865d951b0e6cf3d6a9a6b072b9e66ce1a73e7212affc7c29ab26bd8ee7f491417f40f6e71e', 158, 5, 'authToken', '[]', 0, '2021-04-21 14:42:08', '2021-04-21 14:42:08', '2022-04-21 14:42:08'),
('96fa2a30f6f0cdf2b734e297b1a0b930bcb7a2d00226904401de9afa9d52598ccbacc565e69ae544', 67, 3, 'authToken', '[]', 0, '2021-01-14 04:09:00', '2021-01-14 04:09:00', '2022-01-14 04:09:00'),
('97166cdf855ac2f74f3558b6f7231902708f87cb7ca96bad7cb56220c31c0bc5864c63d4fc5dd06b', 36, 3, 'authToken', '[]', 1, '2020-12-16 16:34:31', '2020-12-16 16:34:31', '2021-12-16 16:34:31'),
('97556bc7f2379e578abacfbb1828a72252d2270363e5af9f4b89b502e29ff7feba95025a583e366f', 40, 3, 'authToken', '[]', 0, '2021-03-12 15:34:40', '2021-03-12 15:34:40', '2022-03-12 15:34:40'),
('982ad85676202ed89d9d4ec570dace13cf6d276c21be133af1bd48de078c574247aa4b2dbc6f752f', 203, 5, 'authToken', '[]', 0, '2021-09-03 13:30:13', '2021-09-03 13:30:13', '2022-09-03 13:30:13'),
('98ab7a6bab29bbc5ac3f99676f571d8cc10df888e9ae7353936c38d768f0257608bf1238281c5792', 109, 3, 'authToken', '[]', 0, '2021-02-16 03:16:57', '2021-02-16 03:16:57', '2022-02-16 03:16:57'),
('99580de17c186f06c251c4ea9e8be4fa51040c9f2bcc9003476506ee3e530e1dd7f4ec1774283dde', 66, 3, 'authToken', '[]', 1, '2021-01-13 14:22:21', '2021-01-13 14:22:21', '2022-01-13 14:22:21'),
('999296a681ac9fee62816233753d2245f5efa482b5feee049618f56dd517c8bd28c7f04f36af67a8', 1, 3, 'authToken', '[]', 1, '2021-02-13 19:14:08', '2021-02-13 19:14:08', '2022-02-13 19:14:08'),
('99d1ff4f86ff027ac69b95cc341dc9cf7e93cfa678a3555660ac0eb193bbcf455495c3c8694d5993', 51, 3, 'authToken', '[]', 0, '2020-12-29 21:30:27', '2020-12-29 21:30:27', '2021-12-29 21:30:27'),
('9a7515d49de8e8706319af03a582223fb0504b5c2540b84092338fd22fc0a6eecef6f0f15dcafc4e', 1, 3, 'authToken', '[]', 1, '2021-03-04 08:26:34', '2021-03-04 08:26:34', '2022-03-04 08:26:34'),
('9adccae914ceccd7728b2398015d20136d7be7310fac3c41386f9746bfa31d381a298113ce63b09e', 5, 3, 'authToken', '[]', 1, '2021-02-12 06:42:23', '2021-02-12 06:42:23', '2022-02-12 06:42:23'),
('9bcde956bfc3465b62d34e8e46fcbd7caada247b05ef4249b6644f11fb45219e85d9dbdd39031b2a', 1, 3, 'authToken', '[]', 0, '2020-12-16 16:41:35', '2020-12-16 16:41:35', '2021-12-16 16:41:35'),
('9bd3955cae0146ce7ea9d64582bfa0c52b177f20bffd1a1c3bba9730115dd3a05f321ecaae1d8cbd', 1, 5, 'authToken', '[]', 1, '2021-04-16 07:39:45', '2021-04-16 07:39:45', '2022-04-16 07:39:45'),
('9c3bbb52b54ca4932d635d4863ee997dfb86054bf95a3febbf031086d210a1aa2934732cba5a5d30', 159, 5, 'authToken', '[]', 0, '2021-04-15 17:56:36', '2021-04-15 17:56:36', '2022-04-15 17:56:36'),
('9ca9f17cbf427b88c2b10a5be50ee2622129eeb95f9266acf5a16056331176d3cd6de1642de170b3', 96, 3, 'authToken', '[]', 0, '2021-02-12 23:30:29', '2021-02-12 23:30:29', '2022-02-12 23:30:29');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('9f3c5efc499567c766edfa67884d72a235c99808e5365d649b794fbfb20c7af82c07b81c65ac8843', 196, 5, 'authToken', '[]', 1, '2021-08-04 23:40:28', '2021-08-04 23:40:28', '2022-08-04 23:40:28'),
('9f76976f366347c2edf2e1e40017bd3c9c7e58f926384c34891d4c51751d3aa21664d176b996d3b9', 94, 3, 'authToken', '[]', 1, '2021-02-27 14:35:45', '2021-02-27 14:35:45', '2022-02-27 14:35:45'),
('9f98b03681d8486c2480f52c076e870e643d6f66cb509bfda10c613657b927c647c84a7214cf56b0', 102, 3, 'authToken', '[]', 0, '2021-02-14 07:39:39', '2021-02-14 07:39:39', '2022-02-14 07:39:39'),
('9fc0c4e46f43148439b401029bc7aa95b5ee679e482c53eb2ced514bf7e2d9a337ec85faca234183', 199, 5, 'authToken', '[]', 0, '2021-08-12 16:29:48', '2021-08-12 16:29:48', '2022-08-12 16:29:48'),
('9feee31bbabed66e6b03fa67f3bfefb1a41cf2b4a986b786f7667e73809b6d4be02850523f2463dc', 170, 5, 'authToken', '[]', 1, '2021-08-20 18:16:39', '2021-08-20 18:16:39', '2022-08-20 18:16:39'),
('a06467af065704bd50acafa0eb524d75ca27111cec2eff534170f57025783073487742c18fe768b1', 39, 3, 'authToken', '[]', 0, '2021-03-05 18:19:38', '2021-03-05 18:19:38', '2022-03-05 18:19:38'),
('a0bcaebd28f51e5086a9c8f4ef6c666663648f9032395c500106522c3bb773fabdc52a7d9632f56a', 191, 5, 'authToken', '[]', 0, '2021-07-26 13:20:15', '2021-07-26 13:20:15', '2022-07-26 13:20:15'),
('a0bf29205bc861037cbf64acce87b92caf3b402b6c41e3283b08bad9b72275590561ce6f2c345c05', 100, 3, 'authToken', '[]', 1, '2021-03-04 08:08:21', '2021-03-04 08:08:21', '2022-03-04 08:08:21'),
('a0df1dcbdffa8778a4c681cc9a80f6c17544f56ae7d69bc9318c06e2ce17ffe47329f366cf258b11', 1, 3, 'authToken', '[]', 1, '2020-12-16 13:55:58', '2020-12-16 13:55:58', '2021-12-16 13:55:58'),
('a0fd9e93ea2919561370d6cc433b2012a7613463e4d0ccb1e6279921fdf43c5ec1f23817817d85b8', 98, 3, 'authToken', '[]', 1, '2021-02-13 00:05:30', '2021-02-13 00:05:30', '2022-02-13 00:05:30'),
('a11b63e26e9730b6b61cf47d2b4998c387be3658abcd99341ec1dee0e62fbff718e8e6a99e10f53e', 132, 3, 'authToken', '[]', 0, '2021-03-09 23:51:23', '2021-03-09 23:51:23', '2022-03-09 23:51:23'),
('a26c7b51e1560c2b63c26c1bdb4c6f7b53a273d2f006c06358da12b42a8147740de25bf64f26b07e', 184, 5, 'authToken', '[]', 1, '2021-07-15 13:21:14', '2021-07-15 13:21:14', '2022-07-15 13:21:14'),
('a2b328af21fa1bacada59c6f919f9c84b83e2b7d0f869f50d808a7b0d69eb37277416238932b9177', 5, 3, 'authToken', '[]', 1, '2020-11-11 09:38:34', '2020-11-11 09:38:34', '2021-11-11 09:38:34'),
('a2cfb9b371f3c958dcb022640d8cb4a24d87773e031e008143d4b3b76fabdcb0d022ef62d035f5db', 3, 1, 'authToken', '[]', 0, '2020-11-10 14:19:22', '2020-11-10 14:19:22', '2021-11-10 14:19:22'),
('a398dd1820fa6e8141f07c8600b61a062134e70decc6b997856ed58b94baa1b37312daa818f1de39', 1, 3, 'authToken', '[]', 0, '2021-02-13 00:09:34', '2021-02-13 00:09:34', '2022-02-13 00:09:34'),
('a3ef53dd1fa60cbb4e9e4fbf536c086b301bc39bb13106b069b54e5162f3d40a425b2936ac5e2e0f', 135, 3, 'authToken', '[]', 0, '2021-03-11 00:40:40', '2021-03-11 00:40:40', '2022-03-11 00:40:40'),
('a4a458590d6701b8a087a6e833da5a7a948039eafe58f529f7561d0d2fa0f522af065887e7b7fa5c', 166, 5, 'authToken', '[]', 0, '2021-04-28 21:09:07', '2021-04-28 21:09:07', '2022-04-28 21:09:07'),
('a562c64aee03bc89ada3e36e46fd31026a1b86d4e9b5c31bb5413d5ba6a8a58e841b4622390cd987', 132, 3, 'authToken', '[]', 0, '2021-03-09 23:50:46', '2021-03-09 23:50:46', '2022-03-09 23:50:46'),
('a58d4d895fd13b95ecce33138c1f5f125b37fbd86e1d7d516276d19c6f2cfeff1268486818776cfc', 171, 5, 'authToken', '[]', 1, '2021-05-07 20:42:20', '2021-05-07 20:42:20', '2022-05-07 20:42:20'),
('a61fb3a459cf578681dbed62c1040ff36c11632459e2ce8f4799baaedffcf5b0e9672a2b2f87535c', 113, 3, 'authToken', '[]', 0, '2021-02-20 15:08:23', '2021-02-20 15:08:23', '2022-02-20 15:08:23'),
('a65c8c5d154126b39fecf30c9b531ec1f3eae30ecf97c021726835109808a2e9ef83a7f194fb58d7', 3, 3, 'authToken', '[]', 0, '2020-12-08 02:50:36', '2020-12-08 02:50:36', '2021-12-08 02:50:36'),
('a65ce9900985b9a05abb5856caaef0d27a8d5b3ca6c5527e6268546474ba3e4fab4fb9800079a8eb', 2, 3, 'authToken', '[]', 1, '2020-11-12 10:36:50', '2020-11-12 10:36:50', '2021-11-12 10:36:50'),
('a6fc1056170c3807c89d42c481348878ca3814a81ec4a612fd1c5636ec0bbfbec7b045d3be3095f6', 3, 3, 'authToken', '[]', 1, '2020-12-08 15:33:18', '2020-12-08 15:33:18', '2021-12-08 15:33:18'),
('a75ae01802c171953f0a9f3a59e480c79860753be00801cd02ba6d157f086a0348c8dfbe31f33db4', 21, 3, 'authToken', '[]', 0, '2020-12-11 18:01:39', '2020-12-11 18:01:39', '2021-12-11 18:01:39'),
('a75e0f10bb2dafb401ebdbf91f711f68e7f518f13116f64e63bc0008917538b68c03c2ad69ec4909', 100, 3, 'authToken', '[]', 1, '2021-02-13 19:34:05', '2021-02-13 19:34:05', '2022-02-13 19:34:05'),
('a7956fde8ef1b5bbeea5eb58a6bd81992596454f4597ab67db207f973bf62790d917f252a8ae633d', 1, 3, 'authToken', '[]', 0, '2020-12-17 09:32:00', '2020-12-17 09:32:00', '2021-12-17 09:32:00'),
('a854d9bea3701579b2b6c354453d5a854cb660bda930def76a9779be06e7a07dd52dfc7e1eefca0d', 109, 3, 'authToken', '[]', 1, '2021-03-30 07:50:23', '2021-03-30 07:50:23', '2022-03-30 07:50:23'),
('a8d6a50e3c15c92aa2f0683797447867262088e429f7898f8d2d4f3276031e92ce83b51acd19229c', 184, 5, 'authToken', '[]', 0, '2021-07-15 13:18:53', '2021-07-15 13:18:53', '2022-07-15 13:18:53'),
('a8fc48ae4305ee9989f1d1c386c61f18635200e22b8e64d45bae99fc3fed080f7496a6d1fc30b04f', 1, 3, 'authToken', '[]', 1, '2021-03-04 07:48:03', '2021-03-04 07:48:03', '2022-03-04 07:48:03'),
('a917cfa33c2398b88831b7ab86282e420495db6af0169b2a67215fd4f42690a5adabb62f69a496ce', 121, 3, 'authToken', '[]', 0, '2021-03-03 20:07:09', '2021-03-03 20:07:09', '2022-03-03 20:07:09'),
('a93e091c10c54ce39e57ad7a37b786ee7509118de625fe4afd3759412fdc58e972d19e86c218d0a3', 1, 5, 'authToken', '[]', 1, '2021-08-31 19:05:39', '2021-08-31 19:05:39', '2022-08-31 19:05:39'),
('ab30a4fdc5ec0447b4441faa5d6e96f6d04f357fa6681120f490922661eefb3bde62b99164c0c616', 16, 3, 'authToken', '[]', 0, '2020-12-08 12:51:04', '2020-12-08 12:51:04', '2021-12-08 12:51:04'),
('ab3290f9dae4779881a0de001a4c4430d82abeae9c1dec95ae91b8c5aa486160f55f8d8ef9ff1ab6', 53, 3, 'authToken', '[]', 0, '2020-12-30 17:10:40', '2020-12-30 17:10:40', '2021-12-30 17:10:40'),
('abcaae816abf2699d3746d365c2a656e90273c03e830df7ed25f0bddc8d9d4f7fd9445fbb2e6270b', 189, 5, 'authToken', '[]', 0, '2021-07-24 04:00:13', '2021-07-24 04:00:13', '2022-07-24 04:00:13'),
('abda74d1135b1a780ce2b594599134ab1238f1da8e0a79dfff09f211dcdd53999deb1774b3f29a5d', 73, 3, 'authToken', '[]', 0, '2021-02-17 18:17:44', '2021-02-17 18:17:44', '2022-02-17 18:17:44'),
('ac50d5c8cdf393c88c30c47ba99055cec31afdf80157ccc5bf9ca841429644dbfb5a15b39f8dbc0c', 162, 5, 'authToken', '[]', 0, '2021-04-19 21:22:26', '2021-04-19 21:22:26', '2022-04-19 21:22:26'),
('ad156479635a49dd26ef510bcd5728e16d3174b8412b4cb303668a5320ea8e803ebc5056f46c4952', 56, 3, 'authToken', '[]', 0, '2021-01-08 18:31:34', '2021-01-08 18:31:34', '2022-01-08 18:31:34'),
('af60a438ab60647820025dcd1d3652f5a775c37a3aa00be5ea75b760ef18bf6676f49bb621027c57', 7, 3, 'authToken', '[]', 0, '2020-12-08 12:35:45', '2020-12-08 12:35:45', '2021-12-08 12:35:45'),
('af7c117f05367b1a807f56ada0971a64b1732c8f43ec3ad4007bfd7bfd3bdd142df9bee2dcd5762e', 171, 5, 'authToken', '[]', 1, '2021-08-31 19:16:20', '2021-08-31 19:16:20', '2022-08-31 19:16:20'),
('afcf99882d9407c9ab9080ecb131ab552b487c736d1774d6f65bb118f78a5a506335292e116b1e20', 170, 5, 'authToken', '[]', 1, '2021-08-30 14:30:28', '2021-08-30 14:30:28', '2022-08-30 14:30:28'),
('b043c0daffa6881ebf87faea6fd458501520e49750a75b8c6f4a0885fdbf07d59f5b462b5a06b952', 1, 5, 'authToken', '[]', 1, '2021-08-04 23:41:48', '2021-08-04 23:41:48', '2022-08-04 23:41:48'),
('b13c7c9d97ead1a9fa14298ecd9e6ae53bf7f70913d2a82245532b9c8e45afb21b45ee881be63cd5', 82, 3, 'authToken', '[]', 1, '2021-02-02 02:26:37', '2021-02-02 02:26:37', '2022-02-02 02:26:37'),
('b16bd6660614e0b275c650592c878a35c1fe40a5fa07ee4e9e559b76a2f592e45f7f96cc64207e8f', 118, 3, 'authToken', '[]', 0, '2021-02-26 22:21:18', '2021-02-26 22:21:18', '2022-02-26 22:21:18'),
('b1ef8a58739324e4c665b8c24e97155d2526a597903a5bd595552bdb884fc920fec0798625b5bbc4', 52, 3, 'authToken', '[]', 0, '2020-12-29 21:41:01', '2020-12-29 21:41:01', '2021-12-29 21:41:01'),
('b33a2f6c4c2c90be86228b1b24cb629ce8668d4fe74cd7dbed4cb70a5f8ba420ac75a8d5a7d36cdd', 1, 5, 'authToken', '[]', 1, '2021-08-31 04:59:08', '2021-08-31 04:59:08', '2022-08-31 04:59:08'),
('b46f5473eacb2110356d3ac699f7002384450e29ca46b657bbdea9b0397621031e664b192cd82468', 196, 5, 'authToken', '[]', 1, '2021-08-04 23:44:59', '2021-08-04 23:44:59', '2022-08-04 23:44:59'),
('b4a9883217c750d5857732c05ca649fadf11e72f2042119bc716827ac2fd93560e579bb711cdd741', 96, 3, 'authToken', '[]', 0, '2021-02-12 23:28:06', '2021-02-12 23:28:06', '2022-02-12 23:28:06'),
('b4c52fc3816019642f174d880a26f6d1daae26b084bbf40c9bd7af1a924b41f6e6e0a0d511502165', 1, 5, 'authToken', '[]', 0, '2021-04-22 02:59:05', '2021-04-22 02:59:05', '2022-04-22 02:59:05'),
('b527ad0c9808840950fcb5eb2675f87e0a6fd62bdd596f6428443c6a1f81d01cdf37b36c74b573d0', 184, 5, 'authToken', '[]', 1, '2021-07-15 13:25:50', '2021-07-15 13:25:50', '2022-07-15 13:25:50'),
('b5e7a7ca08519e9333751f57b9a39387ff7db54aaf3c9abec96fcc83d0ba53a9846056929b7dd8e9', 115, 3, 'authToken', '[]', 0, '2021-02-23 19:05:22', '2021-02-23 19:05:22', '2022-02-23 19:05:22'),
('b74c9729866b644c5595379182ebc400f6bd8971e53d84789b1d7a52750784b71b08af275577a30c', 150, 3, 'authToken', '[]', 0, '2021-03-22 23:50:17', '2021-03-22 23:50:17', '2022-03-22 23:50:17'),
('b795ffee9cac2d79d8151d4c76ac2be6838393883e41febbaa53761910daf4cf3f8862ffeac5f6b2', 12, 3, 'authToken', '[]', 1, '2020-11-24 05:04:38', '2020-11-24 05:04:38', '2021-11-24 05:04:38'),
('b8dafd4b5b384fb13b3059f2b980f71e09141d9799b760556896667b6bb61541a5aa0d37c6fb63cf', 60, 3, 'authToken', '[]', 0, '2021-01-09 17:24:37', '2021-01-09 17:24:37', '2022-01-09 17:24:37'),
('b9283242d0d46787b505672aab48a5ea6ee550a9a33dfcb25566090f2cdc7d00dc0259eb818d036a', 2, 3, 'authToken', '[]', 0, '2020-12-14 17:50:50', '2020-12-14 17:50:50', '2021-12-14 17:50:50'),
('b96d4db24198ea28c979a65551bf071eae7a3d63bd90482f3f181bd4006744935a2df81f342f00b0', 3, 3, 'authToken', '[]', 1, '2020-12-10 03:00:45', '2020-12-10 03:00:45', '2021-12-10 03:00:45'),
('b9783c6693d5a55148cfc7135386970969c29b5795e8f72879a918bfea7796c338f08d45caec538e', 3, 3, 'authToken', '[]', 1, '2020-11-13 17:42:39', '2020-11-13 17:42:39', '2021-11-13 17:42:39'),
('b9ff80293ae966b8fe478d8e6ddb2b5096957a2c6d552dc16883d7005c9e1420339e331a392bfd45', 141, 3, 'authToken', '[]', 0, '2021-03-15 13:24:31', '2021-03-15 13:24:31', '2022-03-15 13:24:31'),
('ba8b882c5d47f8449391320aa018dc318adb0ec21bf4547dc1808bc655546f451d03f2841777e575', 3, 3, 'authToken', '[]', 1, '2020-11-11 07:23:06', '2020-11-11 07:23:06', '2021-11-11 07:23:06'),
('bb7719308f47ae1f9456a7881526d98cec13e68f54cd9104ffb742590dd6166d19819adad7e6d375', 179, 5, 'authToken', '[]', 0, '2021-06-23 07:11:40', '2021-06-23 07:11:40', '2022-06-23 07:11:40'),
('bcabae5532747ed8595ab40d76fc4f89ac063af1f2f440cee23d92d47bad89f97382bb29a1e92c6e', 36, 3, 'authToken', '[]', 0, '2020-12-16 16:33:51', '2020-12-16 16:33:51', '2021-12-16 16:33:51'),
('bcfdc8f2c9dd6f40eb1e957a02a3edca3a1fa9a6395f104c5e937a1bc1e64a5ad73de254177ad859', 100, 3, 'authToken', '[]', 1, '2021-03-04 08:20:07', '2021-03-04 08:20:07', '2022-03-04 08:20:07'),
('bd3cb94461ed7accb29b6a43a943f96b98a09daa5e2e184b3369b744cde563bdd3e00c936d42fc33', 155, 3, 'authToken', '[]', 0, '2021-04-06 17:34:20', '2021-04-06 17:34:20', '2022-04-06 17:34:20'),
('bd958e502fcf770140336c13614ceb609a848c89f1c72ad1ae8605d8390bd9aaad30bb499f09414f', 174, 5, 'authToken', '[]', 0, '2021-06-01 19:59:11', '2021-06-01 19:59:11', '2022-06-01 19:59:11'),
('bf6d3085b319f2d52e6e8b90857b078c8b90cdbd1e0f05c592081f9e2b65b82d53a84845adecdb91', 65, 3, 'authToken', '[]', 0, '2021-01-13 06:44:24', '2021-01-13 06:44:24', '2022-01-13 06:44:24'),
('bf7bd614500cc75b8eb8f9c9fda15a81746209a807ffe2e74fd9fc5d224a222100b745cb03d993bb', 1, 5, 'authToken', '[]', 1, '2021-08-30 14:30:52', '2021-08-30 14:30:52', '2022-08-30 14:30:52'),
('c02b4d2cfff71527af2e2bb724efe4636d6029a1206d11f1a49578749e61d079ee3b91780b1b5021', 171, 5, 'authToken', '[]', 1, '2021-08-20 18:16:24', '2021-08-20 18:16:24', '2022-08-20 18:16:24'),
('c064c92f06699df1cba0ec8b443836277bfa8cb13381f89f43c67d4698928012ca31d9ad0beed069', 138, 3, 'authToken', '[]', 0, '2021-03-12 00:33:12', '2021-03-12 00:33:12', '2022-03-12 00:33:12'),
('c125b491971202556835477a6215ce69f6ee5c060b4b3a39db8af684d659dab7aba209af680adec1', 134, 3, 'authToken', '[]', 0, '2021-03-10 19:23:34', '2021-03-10 19:23:34', '2022-03-10 19:23:34'),
('c1a61065d61c546171e414ac5ccd7e2a1ab72908475b9b5d2f1be1cbfd1d108e302cb1319d7f5c1a', 1, 5, 'authToken', '[]', 1, '2021-05-07 20:43:43', '2021-05-07 20:43:43', '2022-05-07 20:43:43'),
('c31cba357488a425c7d35fbf1f1d0dd1370984c0f4557b18900a623a7ebfb8d01d4062142218d73d', 90, 3, 'authToken', '[]', 0, '2021-02-11 12:41:11', '2021-02-11 12:41:11', '2022-02-11 12:41:11'),
('c4890fbf3035e12d1e81f993f0e061e66f845a4dcc55d05f47d3a02bfd1e1823d42341e27aadce8c', 59, 3, 'authToken', '[]', 0, '2021-01-09 07:07:29', '2021-01-09 07:07:29', '2022-01-09 07:07:29'),
('c4d27523e81df104426c449372e08a695c328e1b8c8229ab28e48e9dfbc96a0c1abd86bcbed32df3', 141, 3, 'authToken', '[]', 1, '2021-03-18 13:48:07', '2021-03-18 13:48:07', '2022-03-18 13:48:07'),
('c562dbf37149f76f9ee3306f4bc2d4e7b12e8a91afc2cb6fa864f30cee776ec87ef990eb6ffa41b7', 1, 3, 'authToken', '[]', 1, '2021-03-04 08:11:42', '2021-03-04 08:11:42', '2022-03-04 08:11:42'),
('c5842bc4df333d0ed9d70bdb45196f56d9740a570c9d7830496fe5ee55e3290842765598c8a236d2', 203, 5, 'authToken', '[]', 0, '2021-09-03 13:36:42', '2021-09-03 13:36:42', '2022-09-03 13:36:42'),
('c6616b5f483d16622eb9be98542f4e7fbeaea4c8a940719b2d8b022f0747657f3700b1c7358affbe', 77, 3, 'authToken', '[]', 0, '2021-01-28 22:56:48', '2021-01-28 22:56:48', '2022-01-28 22:56:48'),
('c66a865354b36ca453a2aa0bc4d18d9b6e5942db04e91b6ead7788eddf006216dc39079d8fd5aa8c', 190, 5, 'authToken', '[]', 0, '2021-07-24 08:18:56', '2021-07-24 08:18:56', '2022-07-24 08:18:56'),
('c6e202173847b216325aabb3f21b0d75a2cc67e1d18cee61220df1ccc62e4eaab11c65d71fb994c6', 119, 3, 'authToken', '[]', 1, '2021-02-27 14:38:24', '2021-02-27 14:38:24', '2022-02-27 14:38:24'),
('c751c4f432c801df10b00569df1400dd809f14eaeb8437b97e47e602c5cd06854f4fa19673858032', 1, 3, 'authToken', '[]', 0, '2021-03-10 00:09:02', '2021-03-10 00:09:02', '2022-03-10 00:09:02'),
('c788009589574ab9719e42eaef1812052f5c87598600fdf7dceb9a165f92f88eb0b1abfd4eea11cf', 123, 3, 'authToken', '[]', 0, '2021-03-04 00:51:36', '2021-03-04 00:51:36', '2022-03-04 00:51:36'),
('c7e112622d3c2d8fae920d0073b813fe20bf7c24f3ebf28e05297005d86082db893f86e87f182739', 143, 3, 'authToken', '[]', 0, '2021-03-15 13:48:43', '2021-03-15 13:48:43', '2022-03-15 13:48:43'),
('c8cb00312997d38a397eab799c5eaf47789b1c2c0171e9893166d2ffeab21a59bf5a6a3d124fdd6d', 63, 3, 'authToken', '[]', 1, '2021-01-12 22:03:36', '2021-01-12 22:03:36', '2022-01-12 22:03:36'),
('c96f4de455128a548e815e988ebbc935d5e81c94013c5336597e7260359e73953000096c6c231e5d', 153, 3, 'authToken', '[]', 0, '2021-03-27 04:36:12', '2021-03-27 04:36:12', '2022-03-27 04:36:12'),
('c9c60f01131311e59b464e33406ed5c1e15ca4d619b5e4b0fac9e17ac0403ad06731e087cd0b50aa', 176, 5, 'authToken', '[]', 0, '2021-05-27 04:11:19', '2021-05-27 04:11:19', '2022-05-27 04:11:19'),
('c9e4e60fd9ca9bec84af6a97bc9a3f97f95b231c15d3fb09fe785209062bd0d2be45b8c4ae0802a5', 8, 3, 'authToken', '[]', 1, '2020-11-13 12:38:22', '2020-11-13 12:38:22', '2021-11-13 12:38:22'),
('cc252f07a3a56d7a45820eab29b7683025551838198dc2b1a2ceb9f7c9024155f555c65f7bbbaf48', 1, 3, 'authToken', '[]', 0, '2021-01-18 19:58:07', '2021-01-18 19:58:07', '2022-01-18 19:58:07'),
('cc2ace23969293ead2d8b7588488ee128089ce054faf5ada39332e3baa60aca3b3faf0e3e245ceb9', 142, 3, 'authToken', '[]', 0, '2021-03-15 13:46:47', '2021-03-15 13:46:47', '2022-03-15 13:46:47'),
('cce5f093f9a2197ffbee564c0e5771fd05c69a36a2058429022fae0c88f312309bb9420f4679641c', 1, 5, 'authToken', '[]', 0, '2021-04-15 09:47:18', '2021-04-15 09:47:18', '2022-04-15 09:47:18'),
('ccec016a86797da5aac391b08665444dd62d354a651e0bffbd1599be53922faf26101c7abab9c026', 114, 3, 'authToken', '[]', 0, '2021-02-21 19:03:02', '2021-02-21 19:03:02', '2022-02-21 19:03:02'),
('ce08e9662a3c8628a95f132f4abada8dccdae28d566dd8da15af23c6c00ccc517b7e1c7591afb86e', 78, 3, 'authToken', '[]', 0, '2021-01-30 17:16:57', '2021-01-30 17:16:57', '2022-01-30 17:16:57'),
('ce5a8d6ea29e901d06593c2812456c5d94880739a6363080d110caacad41065793b9a126a33094dc', 194, 5, 'authToken', '[]', 1, '2021-08-04 05:44:33', '2021-08-04 05:44:33', '2022-08-04 05:44:33'),
('cf3c32de4f57dfd87f0fb9f8e1a9ebce620629da2136cfba84793a9b916d9c4dbd8bfffd5e0a6f9b', 3, 3, 'authToken', '[]', 1, '2020-11-13 12:42:02', '2020-11-13 12:42:02', '2021-11-13 12:42:02'),
('cf6c62f66a8a69dbcee50dae12eed3e9db63c0790f211f4a34aae4650e26948c9338958d889090e2', 15, 3, 'authToken', '[]', 0, '2020-12-09 18:22:36', '2020-12-09 18:22:36', '2021-12-09 18:22:36'),
('cf8d2f84e1da5ba726c52e0c422f52449ab096523bfdcdea2cfa72761db439b2b3a9a8e23fcc4c15', 1, 5, 'authToken', '[]', 1, '2021-08-31 17:30:32', '2021-08-31 17:30:32', '2022-08-31 17:30:32'),
('cfeeba720373757bbefcb9632b3caba4ea256497bc70bbd0439f906c526b5655768eb81773732aba', 174, 5, 'authToken', '[]', 0, '2021-05-23 16:14:08', '2021-05-23 16:14:08', '2022-05-23 16:14:08'),
('d00c48a94d06db44cdcc886080fb2299d8be7d6cae069086f0c7462df7a33923d47bd4fb362a788c', 104, 3, 'authToken', '[]', 0, '2021-02-14 18:44:13', '2021-02-14 18:44:13', '2022-02-14 18:44:13'),
('d02b6e47490637c10cc9e9da1a562067a868df50522b8e04d9f3ffd5dd9c29e02ec71c3b5f904da7', 70, 3, 'authToken', '[]', 0, '2021-01-18 16:58:28', '2021-01-18 16:58:28', '2022-01-18 16:58:28'),
('d0a821ba350ec3a1b406325a5fa3e7ec439ddb5d8d73a90ef095a5cab3b2c7b69dbf117a49420c82', 49, 3, 'authToken', '[]', 0, '2020-12-29 16:12:23', '2020-12-29 16:12:23', '2021-12-29 16:12:23'),
('d0acc1c927a913876dde24e2703a6d1c415595d88b6a6530d6ecb4391674fe8d2155b65d6a38f614', 76, 3, 'authToken', '[]', 1, '2021-01-28 20:46:31', '2021-01-28 20:46:31', '2022-01-28 20:46:31'),
('d0ce86713e2298b95672a80a2687ab1e08df64c32830472f0fded24fca0d0d1049f41718a77de296', 199, 5, 'authToken', '[]', 0, '2021-08-12 16:24:06', '2021-08-12 16:24:06', '2022-08-12 16:24:06'),
('d17b91c1ca7e0796902b930d336eac89145110489bd0b8221b312408bc90c1f06aac79996dd7985e', 170, 5, 'authToken', '[]', 0, '2021-05-07 20:07:56', '2021-05-07 20:07:56', '2022-05-07 20:07:56'),
('d1da9aa75ee390fe839f2582d997ba3e04929f02b69182e3ac051734e341cee7f5438ae8f159b7e7', 59, 3, 'authToken', '[]', 1, '2021-01-09 07:10:15', '2021-01-09 07:10:15', '2022-01-09 07:10:15'),
('d286a2cffd4c5c67305adbbc21765f29b4372bca2804025dc9ef6bc272a04e0567b20cc24c9d2bc5', 109, 3, 'authToken', '[]', 0, '2021-02-16 05:22:16', '2021-02-16 05:22:16', '2022-02-16 05:22:16'),
('d363f2e54219fcce0cda10f2f737014de4c9165181400a9bbf55c47970fce1a969a95bce854f1dda', 147, 3, 'authToken', '[]', 1, '2021-03-15 19:15:14', '2021-03-15 19:15:14', '2022-03-15 19:15:14'),
('d3a3e3ddb55ed9e83e0bd36b5c381748af4ae2c08ebd0ab21fc72dc520c06d9f375d772e8dc32080', 39, 3, 'authToken', '[]', 1, '2020-12-17 09:30:07', '2020-12-17 09:30:07', '2021-12-17 09:30:07'),
('d3f7924fb5c9c60306bc9f0c5c339fc8c35993cdd586fb87fed3e950d69ba32f0258809e1f1b35a5', 3, 3, 'authToken', '[]', 0, '2020-12-08 14:55:09', '2020-12-08 14:55:09', '2021-12-08 14:55:09'),
('d43751ebfc1ec06eb267bcd0a50e63e3f98262c4a7631c69acfa2da53cb34660f2cdb35b1d4458f3', 188, 5, 'authToken', '[]', 0, '2021-07-23 08:07:06', '2021-07-23 08:07:06', '2022-07-23 08:07:06'),
('d43dc9bc7acf77b92a54623ef475fdb522237c109a9ea30270cef76c8e46644bd0ea65e25f3c2419', 72, 3, 'authToken', '[]', 0, '2021-01-23 08:10:31', '2021-01-23 08:10:31', '2022-01-23 08:10:31'),
('d46fe22ab5462d2c32e1968c52a11bb8400ba7c315d38ac033f4167cbad8f7ae31a1025729de0ffe', 170, 5, 'authToken', '[]', 1, '2021-08-31 17:17:23', '2021-08-31 17:17:23', '2022-08-31 17:17:23'),
('d4d28e7d4bd28551f083a55b5dfc79a07795295db91a1c6dbbed60dcf67a0196570c641248927547', 2, 5, 'authToken', '[]', 0, '2021-05-07 19:48:16', '2021-05-07 19:48:16', '2022-05-07 19:48:16'),
('d5475ea3fc2c93b2213ca89600269b30160c954c6b3f3c3c1d411da5f3d423dcd130c9470bdd7fb4', 1, 5, 'authToken', '[]', 0, '2021-08-31 08:04:54', '2021-08-31 08:04:54', '2022-08-31 08:04:54'),
('d5655da7734ff387f350898ca51d96a6d02b48975280e4ad66d18f0acc5f62ee9109b67cebb6465d', 63, 3, 'authToken', '[]', 0, '2021-01-12 19:40:19', '2021-01-12 19:40:19', '2022-01-12 19:40:19'),
('d5ad55e4115fc4391922a53b43515ee701913bc0255cf28bc827cc41cbc26c1c19fbc4c797b6e7c7', 86, 3, 'authToken', '[]', 0, '2021-02-05 22:59:00', '2021-02-05 22:59:00', '2022-02-05 22:59:00'),
('d5ae78ebfdd3f01f06eef067f2fde2e3c54dabc9df9332f55d3373cb6cd4d4b474297e6b6d56c4c1', 12, 3, 'authToken', '[]', 1, '2020-11-16 16:30:38', '2020-11-16 16:30:38', '2021-11-16 16:30:38'),
('d5c112ae0ac9d161a093c98baf6eeb67110312bebd51073f1696074095cfbbc884427b8b5bb86cdf', 170, 5, 'authToken', '[]', 1, '2021-05-07 20:38:55', '2021-05-07 20:38:55', '2022-05-07 20:38:55'),
('d5fb15ff97b15243a3c0a89bc6a57a7b8679687c2505a5f7c8bc32ef810e32c660591ceeed890909', 146, 3, 'authToken', '[]', 0, '2021-03-15 18:35:43', '2021-03-15 18:35:43', '2022-03-15 18:35:43'),
('d6c6d3642a8c6e65a5744b5ea1aabd46fe009abae5388acb3f55a467ac0df9ea03c69fd559bb7e55', 183, 5, 'authToken', '[]', 0, '2021-07-14 15:53:13', '2021-07-14 15:53:13', '2022-07-14 15:53:13'),
('d7132396ff52d9580c5b0231e2d0b728d0f72678ce0e449f80df64a60f1eb70ff8383c7ce92c2a56', 95, 3, 'authToken', '[]', 0, '2021-02-12 06:30:03', '2021-02-12 06:30:03', '2022-02-12 06:30:03'),
('d7278659dae08d69d9229614af16f7d15bb9d5ffb0f62e4d994138fa112d5d5a5c46681b0c4125e0', 1, 5, 'authToken', '[]', 1, '2021-08-04 23:47:25', '2021-08-04 23:47:25', '2022-08-04 23:47:25'),
('d73395ddd1b74282e5526f1fdacdecd3773dd3c887ede58c8f3602a41444177b9a9f61da5c60e429', 90, 3, 'authToken', '[]', 1, '2021-02-27 14:35:02', '2021-02-27 14:35:02', '2022-02-27 14:35:02'),
('d773c2b6378b352bc03237a72b0f2f4e16b95f2379b50fb273fc8847a5ba2ea9697071b28788084a', 154, 3, 'authToken', '[]', 0, '2021-04-05 08:33:54', '2021-04-05 08:33:54', '2022-04-05 08:33:54'),
('d98e141ede01487ecdbd08343f57528e40d7fa59e1f5c54136161d43c53df0f5be72c52c5b41e643', 5, 3, 'authToken', '[]', 1, '2021-02-27 14:40:20', '2021-02-27 14:40:20', '2022-02-27 14:40:20'),
('da5332e21712b2170a2c864478323a4a257195af04a70aab6de5e51d6ca5a04ac67a1a3c870671ab', 168, 5, 'authToken', '[]', 0, '2021-04-29 04:00:04', '2021-04-29 04:00:04', '2022-04-29 04:00:04'),
('da848b75f128d71d19ef747272177328948b9b0d5ab975a8204eac74e44a3b0df157dd4233e1c20a', 112, 3, 'authToken', '[]', 0, '2021-02-18 09:40:15', '2021-02-18 09:40:15', '2022-02-18 09:40:15'),
('db6b02832a10c4d10717dbc0b2d92d990abe093efc8f7c6f05e6c41bb2796e9e7f7ed015f9a15bbd', 2, 3, 'authToken', '[]', 1, '2020-11-11 07:33:17', '2020-11-11 07:33:17', '2021-11-11 07:33:17'),
('dbda416cd05a0d2bb653a50cb251ed46885f069f6abf13caa3abb80af1bc3996eae9634470ab584d', 5, 5, 'authToken', '[]', 0, '2021-04-21 17:00:49', '2021-04-21 17:00:49', '2022-04-21 17:00:49'),
('dc21bebd5ce950655ed7c37ee889b0d93146ed510f3fc167a4aca8256a0f7281f3d0afc4431bfda8', 170, 5, 'authToken', '[]', 1, '2021-08-31 17:29:21', '2021-08-31 17:29:21', '2022-08-31 17:29:21'),
('dd41656ef1cadca8ac3990e4ed2773d894b0a79e0430fa7cebfbc0ac01c2159264618eca11c4a03a', 139, 3, 'authToken', '[]', 0, '2021-03-13 18:13:48', '2021-03-13 18:13:48', '2022-03-13 18:13:48'),
('dd660089bf21140e51c8e0f597df47bbee2a61f7a5e93ebc6ac9fb07cefe99aa592af8fdb381dc3b', 167, 5, 'authToken', '[]', 0, '2021-04-29 03:58:29', '2021-04-29 03:58:29', '2022-04-29 03:58:29'),
('dd9d679e52bdff63783756bdf45bc7b7b00f7e5e5d85c476fcde5e30fd44626d9e5970585984e4d8', 176, 5, 'authToken', '[]', 0, '2021-05-27 04:11:19', '2021-05-27 04:11:19', '2022-05-27 04:11:19'),
('ddc2ec32e8569acbc8fb03d76630a0a49b4340c38c9a7d56eaa75277dd53c1f9ce0c654fd944c8c6', 201, 5, 'authToken', '[]', 0, '2021-08-15 19:29:45', '2021-08-15 19:29:45', '2022-08-15 19:29:45'),
('dde2d58bcfcd9dc6e8c89b7a610a23caadcd1ad2141383225a6a30b98ffb4f828a4c64f7e132baf3', 118, 3, 'authToken', '[]', 0, '2021-02-26 22:16:24', '2021-02-26 22:16:24', '2022-02-26 22:16:24'),
('e06b892f668673930101e3a28e366467793ead7d52fd040d0bcbe1f45f18cb106c3d5d15dc9a851e', 143, 5, 'authToken', '[]', 0, '2021-04-15 08:02:48', '2021-04-15 08:02:48', '2022-04-15 08:02:48'),
('e21f47e90cf4fdbb2e69849b4639e380eadf03aabdf72beed31d7f01a2fe8750530c6aec55b6d0d1', 171, 5, 'authToken', '[]', 1, '2021-05-07 20:19:59', '2021-05-07 20:19:59', '2022-05-07 20:19:59'),
('e2ecdfdfbfabe30da923d55957ab688810c06f74a8ef7d9acc58f0a4a37b5b59daace4e3db1eca14', 5, 3, 'authToken', '[]', 1, '2021-03-30 08:08:30', '2021-03-30 08:08:30', '2022-03-30 08:08:30'),
('e3142a3ce436c0fd5d6bd9dcf4ce9edae921c91489d49f914701c4722c938990de01bb8fac2a1e72', 156, 3, 'authToken', '[]', 0, '2021-04-11 19:33:31', '2021-04-11 19:33:31', '2022-04-11 19:33:31'),
('e3f68dfc6349cdef4713ae45923f8e4b1332c47894a33f03769f77aaea6fbdc14476dbdd52cd6586', 182, 5, 'authToken', '[]', 0, '2021-07-14 07:33:52', '2021-07-14 07:33:52', '2022-07-14 07:33:52'),
('e4b53e05066c51fb4991159266f2deb900375e05dbef737ebcf129357e29ece910d43964af3e6eba', 76, 3, 'authToken', '[]', 0, '2021-01-28 20:45:41', '2021-01-28 20:45:41', '2022-01-28 20:45:41'),
('e4c27df2aff86bc316aab898bc81f3b8999b0c46f1bea563c0d22a1e0ecd2a4faeb890e0fb94f409', 46, 3, 'authToken', '[]', 1, '2020-12-22 16:51:11', '2020-12-22 16:51:11', '2021-12-22 16:51:11'),
('e4fdcac10ee56fc4aadc32201daec6deeca9574f22470ee2f52a5484492563d2806086f01da3df2c', 156, 3, 'authToken', '[]', 0, '2021-04-11 19:34:17', '2021-04-11 19:34:17', '2022-04-11 19:34:17'),
('e50bb5a144776c5a2d1597a43a8d437f89f35b00e6ceb10921c011b37315e9d983c26f268ca5b92f', 54, 3, 'authToken', '[]', 0, '2021-01-04 18:11:30', '2021-01-04 18:11:30', '2022-01-04 18:11:30'),
('e5278cf23f0c26330688d08f16528f951778303ec9e34cbae0275ca5c5160193ece9162db206d3b6', 151, 3, 'authToken', '[]', 1, '2021-03-24 15:59:34', '2021-03-24 15:59:34', '2022-03-24 15:59:34'),
('e5b241df456b246f1cfd1443257183cd053a19c130cc82663dd97b706f367ca36d66cf12b71192c0', 174, 5, 'authToken', '[]', 0, '2021-05-23 16:15:17', '2021-05-23 16:15:17', '2022-05-23 16:15:17'),
('e686c402af234c568853612101d5c1e581e901eed3066588c40910715825cff45a4a0f54b75abc66', 3, 3, 'authToken', '[]', 1, '2020-12-11 17:26:11', '2020-12-11 17:26:11', '2021-12-11 17:26:11'),
('e76656a45980aa8d6889f831359b1a9a32a9dfb4e8d722c7e976b5c9d1f141887630a63e1ce2a687', 64, 3, 'authToken', '[]', 0, '2021-01-12 21:19:15', '2021-01-12 21:19:15', '2022-01-12 21:19:15'),
('e8c0cafc2160dabc4ed30a2baff2774852cd60f8d5b5006681a78768f0baf3a78afe19add40c6fc4', 5, 5, 'authToken', '[]', 1, '2021-09-06 07:00:01', '2021-09-06 07:00:01', '2022-09-06 07:00:01'),
('e98c1144baf2b48c6d1ea825c0e02f9808bea75b55845dd997efbd95a0838ea335cf0b51b7df9ceb', 94, 3, 'authToken', '[]', 0, '2021-02-12 06:21:31', '2021-02-12 06:21:31', '2022-02-12 06:21:31'),
('ea4f2a8cf64839745a5c1d33f0168321e9264f3148416dd5003d21ecfbb372724414e4fc78e7c023', 1, 3, 'authToken', '[]', 0, '2021-02-26 17:07:27', '2021-02-26 17:07:27', '2022-02-26 17:07:27'),
('ec337a54b1b23940cd9f6f5b6f3525c42846df84d0586745136cda68803a49b6ff5a0add0e59a34f', 1, 3, 'authToken', '[]', 1, '2021-02-13 19:30:44', '2021-02-13 19:30:44', '2022-02-13 19:30:44'),
('ec5ded431da9ce010e48d54e57e299ca4b45c44dc53533933e43eb8639113c0c966573291e75f4ed', 176, 5, 'authToken', '[]', 0, '2021-05-27 04:11:19', '2021-05-27 04:11:19', '2022-05-27 04:11:19'),
('eedade9b070fc5da3b11557f435ce3d1d07decc412d212abe9014ef9993770ab29c71b22bb64bea1', 168, 5, 'authToken', '[]', 0, '2021-05-01 09:20:55', '2021-05-01 09:20:55', '2022-05-01 09:20:55'),
('ef6ccf5ab792267399ad14ddf1d6f52f176289c20849e1a7a968279ccad0b10f6422d6229c5e7809', 1, 5, 'authToken', '[]', 0, '2021-09-02 14:58:14', '2021-09-02 14:58:14', '2022-09-02 14:58:14'),
('ef98985b25d85dcb180e29342808bdde4067375a32715367150a71bb1cb5d83570cc6513af1b56fd', 54, 3, 'authToken', '[]', 0, '2021-01-04 17:47:07', '2021-01-04 17:47:07', '2022-01-04 17:47:07'),
('efbfd32d46515b9e4fe40e753f3769d2ea35e654cd9040ef02b1ebbd823b9ee4cdfb6522787c5459', 109, 3, 'authToken', '[]', 1, '2021-03-24 23:49:32', '2021-03-24 23:49:32', '2022-03-24 23:49:32'),
('f01b19e23c86b66883cfc5b918a30661f847a4ff97f8ebb0db1a560a789fbd8a206a4651bc0d4598', 179, 5, 'authToken', '[]', 0, '2021-06-23 07:10:54', '2021-06-23 07:10:54', '2022-06-23 07:10:54'),
('f067a546796b64a7c72964d96fc2a8c3a904444b3c68dae09ec069c66b59ba719a82cbcb87c51275', 57, 3, 'authToken', '[]', 0, '2021-01-08 18:45:29', '2021-01-08 18:45:29', '2022-01-08 18:45:29'),
('f122065d1788c0c80745808b6170e6065cff5a9f5ff42d52c80ed4ae26f4ac742ee1d0ad4ce74e08', 130, 3, 'authToken', '[]', 0, '2021-03-09 15:32:29', '2021-03-09 15:32:29', '2022-03-09 15:32:29'),
('f19ece9709e624c55e460a23d9bb4757f51effc37c04ad02504c1781571431f39d7de48b8f4154e4', 133, 3, 'authToken', '[]', 0, '2021-03-10 16:58:24', '2021-03-10 16:58:24', '2022-03-10 16:58:24'),
('f2ecb7cc26cf31aef1d358de242e77ab6af62c31b2d45e5fca5f162505913d7fb97ae691a638c3cb', 137, 3, 'authToken', '[]', 0, '2021-03-12 00:33:22', '2021-03-12 00:33:22', '2022-03-12 00:33:22'),
('f3657088a9b8e6a333d1e510eefeb64639c5fdfda82e5c3db57a8751229641d617fa48996ed470d8', 92, 3, 'authToken', '[]', 0, '2021-02-11 12:21:27', '2021-02-11 12:21:27', '2022-02-11 12:21:27'),
('f4d7c395c6d3861f716102f3be34358d5a2017a03d2f5ffdc44eaf744edb95de882b8ae3502ed3b9', 102, 3, 'authToken', '[]', 0, '2021-02-14 07:38:54', '2021-02-14 07:38:54', '2022-02-14 07:38:54'),
('f57d375041f7d0758ba7463ed99092925b0168d9f6bba2185c56b63149067b6b77ac92d1687f18c4', 117, 3, 'authToken', '[]', 0, '2021-02-26 16:53:15', '2021-02-26 16:53:15', '2022-02-26 16:53:15'),
('f6172d6e95f60aed38cff94fd1bfee8a64667408c2db916411c54200b2968cfe56d2078546ed2e75', 3, 3, 'authToken', '[]', 1, '2020-11-11 08:29:31', '2020-11-11 08:29:31', '2021-11-11 08:29:31'),
('f6228ddc7088dd0725a8b4de2a35aac411bf43d7b42d80c1eb33f18a5e2ea873bd9c8dc33c7ccecf', 58, 3, 'authToken', '[]', 0, '2021-01-09 17:17:25', '2021-01-09 17:17:25', '2022-01-09 17:17:25'),
('f7efe4409085369a5a67288f947fab1427c7d3394631a2a36fce5689d8ca421996b16bfd8f9f3145', 98, 3, 'authToken', '[]', 0, '2021-02-12 23:58:57', '2021-02-12 23:58:57', '2022-02-12 23:58:57'),
('f811f1ee54b5359d1049dfbd602167216920e0cb008c3d7c91cd453e2724ac01f565b87f14511a3e', 17, 3, 'authToken', '[]', 0, '2020-12-14 11:03:43', '2020-12-14 11:03:43', '2021-12-14 11:03:43'),
('f863a309cf64bbb6593c41bbf28c2a924bf980729e9e3ac288034608681e651bc76af53522931ff0', 83, 3, 'authToken', '[]', 0, '2021-02-02 04:48:52', '2021-02-02 04:48:52', '2022-02-02 04:48:52'),
('f8faa68533a64572d9712e7aa9ee1ea54e30f00bbdf001c51f27b3a17bed678921d622af6c86b0de', 158, 5, 'authToken', '[]', 0, '2021-04-15 08:26:15', '2021-04-15 08:26:15', '2022-04-15 08:26:15'),
('f9b53071f6d5866387b7cb50c96ec40b223296a56d8bce2b83613d57efe2037028ae195ab6ad30ea', 105, 3, 'authToken', '[]', 0, '2021-02-14 19:34:27', '2021-02-14 19:34:27', '2022-02-14 19:34:27'),
('fa02caaa9de50879bb05d115ea759a8aa5548baba5363b706baa43d819a819f926845459b9c4b356', 1, 3, 'authToken', '[]', 1, '2020-12-14 16:38:21', '2020-12-14 16:38:21', '2021-12-14 16:38:21'),
('fa2e92b7c3d63a65aac45cf386adf34414a04e2fbc7c7345053878121efbfa153efd3fe5d994ce0a', 17, 3, 'authToken', '[]', 0, '2020-12-14 13:31:15', '2020-12-14 13:31:15', '2021-12-14 13:31:15'),
('fa34a6545daef2198c7d6281bbed4bd4c73d4f3a0b54032c33b07185819ca597d9a5d08357c9d26f', 21, 3, 'authToken', '[]', 1, '2020-12-11 18:02:44', '2020-12-11 18:02:44', '2021-12-11 18:02:44'),
('fa700e7b4f41c340b4832cca80e444a4875ea1266eed0686d11f050951e05c8a757cf4482034136c', 137, 3, 'authToken', '[]', 0, '2021-03-12 00:33:47', '2021-03-12 00:33:47', '2022-03-12 00:33:47'),
('fb8ca82460dc5ed859079d8a20d3e6ebae0bb8aee4cf40763151bd193c6de34c231e1f3daabc26e4', 58, 3, 'authToken', '[]', 0, '2021-01-09 03:33:21', '2021-01-09 03:33:21', '2022-01-09 03:33:21'),
('fc1ec434491f51cd390d67fe06802a2b1559625d99ee7000accc2d3f43594ac75ac0b94c35bee7cb', 1, 5, 'authToken', '[]', 1, '2021-05-07 20:43:17', '2021-05-07 20:43:17', '2022-05-07 20:43:17'),
('fc8ca23bb26717023322c192f46a286a46c1e35cc194456b114457ba4b2f2bfef079d8f4a2da7bc9', 63, 3, 'authToken', '[]', 1, '2021-01-12 19:41:23', '2021-01-12 19:41:23', '2022-01-12 19:41:23'),
('fca921d5fa2ac9209e3c81d8f7c02d8a27519ad2fe479b15f0ff62ba44152e9da238ae0dd747982f', 53, 3, 'authToken', '[]', 1, '2020-12-30 17:11:15', '2020-12-30 17:11:15', '2021-12-30 17:11:15'),
('fd32c5e50522f1393de53204ada3fe53b94794a47cda43031cedd6e98b70aa24ccf77160fb0e7154', 180, 5, 'authToken', '[]', 0, '2021-07-04 05:01:18', '2021-07-04 05:01:18', '2022-07-04 05:01:18'),
('fdcadeee697c242927e1c7faa3826fa3e314605f692d13aa1bdd70589681d6302d9b01eb26a53d19', 150, 3, 'authToken', '[]', 1, '2021-03-29 21:32:05', '2021-03-29 21:32:05', '2022-03-29 21:32:05'),
('fdfc0ecee34b66d46047524d926b74e9db067ec126b9054b530c4108489ae87d6af28552f7eebbfc', 103, 3, 'authToken', '[]', 0, '2021-02-14 10:26:22', '2021-02-14 10:26:22', '2022-02-14 10:26:22'),
('fe25d6b98500e2df35fe4cec48c238748bee27ec4d73b09d2e0543b625c0fc7ee58a32c09f8f4ae2', 128, 3, 'authToken', '[]', 0, '2021-03-05 20:39:55', '2021-03-05 20:39:55', '2022-03-05 20:39:55'),
('fed533b798e190d9d9f9d67d20d5e5a9e9ee1881d8e37ccd0d2a738255d590a0bf4ac914a23801a3', 2, 3, 'authToken', '[]', 1, '2020-11-10 15:32:22', '2020-11-10 15:32:22', '2021-11-10 15:32:22'),
('fefdbaca92f52e2c7466a52e063e3d7411f664f8b19c4610fe7149eef853bea6f54c37b33777bd47', 38, 3, 'authToken', '[]', 0, '2020-12-17 09:06:57', '2020-12-17 09:06:57', '2021-12-17 09:06:57'),
('ff1ec1af6fabc636c7ae2146fc5901d0deb9c67d8d8ae49a1d388fa9adceb3a5d85ac576aeebd6fa', 1, 3, 'authToken', '[]', 1, '2021-02-13 18:52:47', '2021-02-13 18:52:47', '2022-02-13 18:52:47'),
('ff370a9bbeaf049c2cfb806eda2ced5f88a6dce9f5ff6326a49cde5924a5ea1f95073e7547c64270', 1, 5, 'authToken', '[]', 1, '2021-07-20 09:40:02', '2021-07-20 09:40:02', '2022-07-20 09:40:02');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'Ks5TznueKRIgv1qOxuh8nZXuhXuSpAGML0Dc7Y1t', NULL, 'http://localhost', 1, 0, 0, '2020-11-10 14:11:11', '2020-11-10 14:11:11'),
(2, NULL, 'Laravel Password Grant Client', 'DzzYcOp7gWsMDn6JKy1ZnhxBZ0bZvOVE06CKK4Xk', 'users', 'http://localhost', 0, 1, 0, '2020-11-10 14:11:11', '2020-11-10 14:11:11'),
(3, NULL, 'Laravel Personal Access Client', 'QNl3Wa8YmkHw5fF9MzAm6qt5aftOzxt72bJs0QEl', NULL, 'http://localhost', 1, 0, 0, '2020-11-10 15:32:15', '2020-11-10 15:32:15'),
(4, NULL, 'Laravel Password Grant Client', 'wndMJoOcrRUxEZeZQ6uT75Le3yTTz78BC0osdtTe', 'users', 'http://localhost', 0, 1, 0, '2020-11-10 15:32:15', '2020-11-10 15:32:15'),
(5, NULL, 'Laravel Personal Access Client', 'xtyZoen3D8Z18aPGni2dHmAKJjyNUNlJ34dqCi0s', NULL, 'http://localhost', 1, 0, 0, '2021-04-14 13:37:05', '2021-04-14 13:37:05'),
(6, NULL, 'Laravel Password Grant Client', 'tQFv1nva7ng0mW2pb44J4hxHjc7WkE2JWqnHYx9d', 'users', 'http://localhost', 0, 1, 0, '2021-04-14 13:37:05', '2021-04-14 13:37:05');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-11-10 14:11:11', '2020-11-10 14:11:11'),
(2, 3, '2020-11-10 15:32:15', '2020-11-10 15:32:15'),
(3, 5, '2021-04-14 13:37:05', '2021-04-14 13:37:05');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personnel_details`
--

CREATE TABLE `personnel_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `required_personnel_id` bigint(20) NOT NULL,
  `personnel_request_at` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_title` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personnel_details`
--

INSERT INTO `personnel_details` (`id`, `created_at`, `updated_at`, `deleted_at`, `required_personnel_id`, `personnel_request_at`, `job_title`, `job_description`, `quantity`) VALUES
(21, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, '', 'title', 'job', 4),
(22, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, '', 'title 2', 'job1', 6),
(23, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, '', 'aaish', 'des', 5),
(24, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, '', 'title', 'aaa', 1),
(25, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, '', 'title', '34', 2),
(26, '2021-03-15 13:59:07', '2021-03-15 13:59:07', NULL, 48, '', 'fg', 'fgdfg', NULL),
(27, '2021-04-01 06:59:36', '2021-04-01 06:59:36', NULL, 49, '', '1', '1', 1),
(28, '2021-04-01 06:59:36', '2021-04-01 06:59:36', NULL, 49, '', '1', '1', 1),
(29, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 50, '', 'Test', 'Test', 2),
(30, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 50, '', 'Test', 'Test', 1),
(31, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 50, '', 'Test 2', 'Test', 1),
(32, '2021-04-15 08:46:06', '2021-04-15 08:46:06', NULL, 75, '', 'CEO', 'sdfsdfsdf', NULL),
(33, '2021-04-15 09:00:10', '2021-04-15 09:00:10', NULL, 76, '', 'dfgdfg', '123', 12),
(34, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 77, '', 'Test Laborer 1', 'Test Laborer 1', 3),
(35, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 77, '', 'Test Laborer 2', 'Test Laborer 2', 0),
(36, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 78, '', 'TEST OPERATOR 1', 'TEST OPERATOR 1', 2),
(37, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 79, '', 'Test', 'Test', 2),
(38, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 80, '', '123', '123123', 123),
(39, '2021-04-21 15:18:03', '2021-04-21 15:18:03', NULL, 81, '', 'Te', 'wtretert', 2),
(40, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 82, '', 'General Laborer', 'Test', 1),
(41, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 82, '', 'Confined Space Laborer', 'test', 1),
(42, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 83, '', 'Forklift', 'Test', 2),
(43, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 84, '', 'Laborer Test 1 - Low Weight', 'TEst', 1),
(44, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 84, '', 'Laborer Test 2 - High Weight', 'Test', 1),
(45, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 85, '', 'Fork Lift', 'All ForkLift - Great History', 3),
(46, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 86, '', 'Project Manager', 'Test', 1),
(47, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 87, '', 'Janitors', 'Cleaning', 2),
(48, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 87, '', 'Chefs', 'Cooking', 2);

-- --------------------------------------------------------

--
-- Table structure for table `personnel_drug_and_alcohol_tests`
--

CREATE TABLE `personnel_drug_and_alcohol_tests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `required_personnel_id` bigint(20) UNSIGNED NOT NULL,
  `test` varchar(250) NOT NULL,
  `is_cannabis_swap_acceptable` tinyint(1) DEFAULT NULL,
  `how_recent` varchar(250) DEFAULT NULL,
  `mask_fit_requirements` varchar(250) DEFAULT NULL,
  `can_lift_more_than_sixty_pounds` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `personnel_drug_and_alcohol_tests`
--

INSERT INTO `personnel_drug_and_alcohol_tests` (`id`, `created_at`, `updated_at`, `deleted_at`, `required_personnel_id`, `test`, `is_cannabis_swap_acceptable`, `how_recent`, `mask_fit_requirements`, `can_lift_more_than_sixty_pounds`) VALUES
(63, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 67, '8 Panel Express', NULL, 'Within 90 days', 'scott', 1),
(64, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 68, '8 Panel Express', NULL, 'Within 30 days', 'aa', 1),
(65, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 69, '8 Panel Express', NULL, 'Within 30 days', 'aa', 0),
(66, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 70, '8 Panel Express', NULL, 'Within 30 days', 'd', 1),
(67, '2021-03-15 13:59:07', '2021-03-15 13:59:07', NULL, 71, '12 Panel Express', 1, 'Within 30 days', '12213', 0),
(68, '2021-04-01 06:59:36', '2021-04-01 06:59:36', NULL, 72, '8 Panel Express', 1, 'Within 30 days', '1', 1),
(69, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 73, '8 Panel Express', 1, 'Within 30 days', 'test', 0),
(70, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 74, '8 Panel Express', 1, 'Within 30 days', 'test', 0),
(71, '2021-04-15 08:46:06', '2021-04-15 08:46:06', NULL, 75, '8 Panel Lab Based', 1, 'Within 60 days', 'wfdvfdb', 0),
(72, '2021-04-15 09:00:10', '2021-04-15 09:00:10', NULL, 76, '8 Panel Express', NULL, 'Within 30 days', '123123', 1),
(73, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 77, '8 Panel Express', 1, 'Within 30 days', 'TES', 1),
(74, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 78, '8 Panel Express', 1, 'Within 30 days', 'yes', 0),
(75, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 79, '8 Panel Express', NULL, 'Within 30 days', '1231', 0),
(76, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 80, '8 Panel Express', NULL, 'Within 30 days', '123', 0),
(77, '2021-04-21 15:18:03', '2021-04-21 15:18:03', NULL, 81, '8 Panel Express', NULL, 'Within 30 days', '123', 1),
(78, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 82, '8 Panel Express', 1, 'Within 30 days', 'N/A', 1),
(79, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 83, '8 Panel Express', 1, 'Within 30 days', 'Half mask', 1),
(80, '2021-08-04 23:31:30', '2021-08-04 23:33:41', NULL, 84, 'Other', 0, 'Within 30 days', 'Scott AV 3000', 1),
(81, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 85, '8 Panel Express', NULL, 'Within 90 days', 'N/A', 0),
(82, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 86, 'Other', NULL, 'Within 30 days', 'no', 0),
(83, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 87, '8 Panel Express', 1, 'Within 30 days', 'n/a', 0);

-- --------------------------------------------------------

--
-- Table structure for table `personnel_operator_requirements`
--

CREATE TABLE `personnel_operator_requirements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `required_personnel_id` bigint(20) UNSIGNED NOT NULL,
  `license_class` varchar(250) CHARACTER SET utf8mb4 DEFAULT NULL,
  `driver_abstract` varchar(250) NOT NULL,
  `demerit_points_acceptable` int(11) DEFAULT NULL,
  `driver_requirements` varchar(250) NOT NULL,
  `hours_of_service` varchar(250) NOT NULL,
  `is_off_road_needed` tinyint(1) NOT NULL,
  `is_chain_up_needed` tinyint(1) NOT NULL,
  `mountain_experience` tinyint(1) NOT NULL,
  `radio_calling_experience` tinyint(1) NOT NULL,
  `dispatch_apps_for_smartphone_required` tinyint(1) NOT NULL,
  `transmission_type` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `personnel_operator_requirements`
--

INSERT INTO `personnel_operator_requirements` (`id`, `created_at`, `updated_at`, `deleted_at`, `required_personnel_id`, `license_class`, `driver_abstract`, `demerit_points_acceptable`, `driver_requirements`, `hours_of_service`, `is_off_road_needed`, `is_chain_up_needed`, `mountain_experience`, `radio_calling_experience`, `dispatch_apps_for_smartphone_required`, `transmission_type`) VALUES
(19, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 68, NULL, '3 Years Commercial', 2, '[\"2\"]', 'Exempt', 1, 0, 1, 0, 0, '[\"automatic\"]'),
(20, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 74, NULL, 'Not Required', NULL, '[\"1\"]', 'Exempt', 1, 1, 1, 1, 1, '[\"automatic\"]'),
(21, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 78, NULL, '3 Years Commercial', 3, '[\"5\",\"Q (Airbrakes Endorsement)\"]', 'Exempt', 1, 1, 1, 1, 1, '[\"automatic\"]'),
(22, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 80, NULL, '5 Years Commercial', 123, '[\"3\"]', 'Provincial', 0, 0, 0, 0, 0, '[\"automatic\"]'),
(23, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 83, NULL, '3 Years Commercial', 2, '[\"5\",\"4\"]', 'Provincial', 1, 1, 1, 1, 1, '[\"manual\"]'),
(24, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 85, NULL, '3 Years Commercial', 3, '[\"1\",\"5\",\"3\"]', 'Provincial', 1, 1, 1, 1, 0, '[\"manual\"]');

-- --------------------------------------------------------

--
-- Table structure for table `personnel_requests`
--

CREATE TABLE `personnel_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `request_id` varchar(255) NOT NULL,
  `status` varchar(250) NOT NULL DEFAULT 'open',
  `job_location` varchar(250) NOT NULL,
  `site_location` varchar(250) NOT NULL,
  `estimated_start_date` date DEFAULT NULL,
  `estimated_end_date` date DEFAULT NULL,
  `is_admin_notified` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `personnel_requests`
--

INSERT INTO `personnel_requests` (`id`, `created_at`, `updated_at`, `deleted_at`, `company_id`, `date`, `request_id`, `status`, `job_location`, `site_location`, `estimated_start_date`, `estimated_end_date`, `is_admin_notified`) VALUES
(46, '2021-03-09 20:20:51', '2021-05-07 19:51:37', '2021-05-07 19:51:37', 22, '2021-03-10', '20210309-AMZONESTEP-001', 'open', 'karachi', 'outorigin', '2021-03-06', '2021-03-20', 0),
(47, '2021-03-09 23:49:50', '2021-04-21 15:16:21', NULL, 31, '2021-03-10', '20210309-PARANOIDAPPARELS-001', 'open', 'new jersey', 'paranoidapparels', '2021-03-04', '2021-04-14', 0),
(48, '2021-03-15 13:59:07', '2021-03-15 13:59:07', NULL, 33, '2021-03-15', '20210315-THINK-TESTER-001', 'open', 'Cheerio', 'Cheero', '2021-03-17', '2021-03-20', 0),
(49, '2021-04-01 06:59:36', '2021-04-21 15:16:16', NULL, 4, '2021-04-01', '20210401-PRIMUS-001', 'open', '11', 'Ontario, CA', '2021-04-01', '2021-04-15', 0),
(50, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 4, '2021-04-05', '20210405-PRIMUS-001', 'open', 'Edmonton', 'Edmonton A', '2021-04-08', '2021-04-21', 0),
(51, '2021-04-15 08:46:06', '2021-04-15 08:46:06', NULL, 36, '2021-04-15', '20210415-GROWTHGECKO-001', 'open', 'Alberta', 'No Clue', '2021-04-02', '2021-04-30', 0),
(52, '2021-04-15 08:57:27', '2021-04-15 08:57:27', NULL, 36, '2021-04-15', '20210415-GROWTHGECKO-002', 'open', 'Alberta', 'adsad', '2021-04-01', '2021-04-30', 0),
(53, '2021-04-15 09:00:10', '2021-04-15 09:00:10', NULL, 36, '2021-04-15', '20210415-GROWTHGECKO-003', 'open', 'Alberta', 'No Clue', '2021-04-02', '2021-04-29', 0),
(54, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 32, '2021-04-15', '20210415-THINK-TESTER-001', 'open', 'Edmonton', 'Edmonton', '2021-04-29', '2021-06-17', 0),
(55, '2021-04-16 08:03:10', '2021-04-16 08:03:10', NULL, 4, '2021-04-16', '20210416-PRIMUS-001', 'open', 'Toronto', 'Vieux Port', '2021-04-16', '2021-04-16', 0),
(56, '2021-04-16 08:03:13', '2021-04-16 08:03:13', NULL, 4, '2021-04-16', '20210416-PRIMUS-002', 'open', 'Toronto', 'Vieux Port', '2021-04-16', '2021-04-16', 0),
(57, '2021-04-16 08:03:14', '2021-04-16 08:03:14', NULL, 4, '2021-04-16', '20210416-PRIMUS-003', 'open', 'Toronto', 'Vieux Port', '2021-04-16', '2021-04-16', 0),
(58, '2021-04-16 08:03:17', '2021-04-16 08:03:17', NULL, 4, '2021-04-16', '20210416-PRIMUS-004', 'open', 'Toronto', 'Vieux Port', '2021-04-16', '2021-04-16', 0),
(59, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 36, '2021-04-21', '20210421-GROWTHGECKO-001', 'open', 'Cheerio', 'Cheero', '2021-04-01', '2021-04-30', 0),
(60, '2021-04-21 15:18:03', '2021-04-21 15:18:03', NULL, 33, '2021-04-21', '20210421-THINK-TESTER-001', 'open', 'Alberta', 'Suncar', '2021-04-01', '2021-04-23', 0),
(61, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 37, '2021-05-07', '20210507-MEGAN-EMPLOYER-001', 'open', 'Edmonton', 'Test', '2021-05-21', '2021-05-28', 0),
(62, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 38, '2021-08-04', '20210804-THINK-ORION-TEST-001', 'open', 'Edmonton', 'Suncor', '2021-08-11', '2021-08-18', 0);

-- --------------------------------------------------------

--
-- Table structure for table `personnel_request_required_personnels`
--

CREATE TABLE `personnel_request_required_personnels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `personnel_request_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(250) NOT NULL,
  `personnel_needed` int(11) NOT NULL,
  `scope_of_work` varchar(225) NOT NULL,
  `shift_duration` float NOT NULL,
  `percentage_of_people_on_day_shift` int(11) NOT NULL,
  `hours_of_orientation_on_site` int(11) DEFAULT NULL,
  `hours_of_orientation_online` int(11) DEFAULT NULL,
  `accomodation` varchar(250) NOT NULL,
  `pre_employments` varchar(250) DEFAULT NULL,
  `work_conditions` varchar(250) NOT NULL,
  `specialized_PPE` varchar(250) DEFAULT NULL,
  `file_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `personnel_request_required_personnels`
--

INSERT INTO `personnel_request_required_personnels` (`id`, `created_at`, `updated_at`, `deleted_at`, `personnel_request_id`, `type`, `personnel_needed`, `scope_of_work`, `shift_duration`, `percentage_of_people_on_day_shift`, `hours_of_orientation_on_site`, `hours_of_orientation_online`, `accomodation`, `pre_employments`, `work_conditions`, `specialized_PPE`, `file_id`) VALUES
(66, '2021-03-09 20:20:51', '2021-03-09 20:20:51', NULL, 46, 'laborers', 10, 'hello world', 9, 40, 0, NULL, 'Camp', 'hello world', 'remote', '5', NULL),
(67, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, 'laborers', 10, 'description', 9, 40, 12, 13, 'Camp', 'nothing', 'outdoor', 'yes', NULL),
(68, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, 'operators', 5, 'project', 10, 40, NULL, 12, 'Other', 'bro', 'asd', 'no', NULL),
(69, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, 'supervisors', 2, 'work', 4, 40, NULL, NULL, 'Camp', NULL, 'remote', NULL, NULL),
(70, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 47, 'other_personnel', 7, 'asa', 3, 100, NULL, NULL, 'Camp', '3er', 'qwe', NULL, NULL),
(71, '2021-03-15 13:59:07', '2021-03-15 13:59:07', NULL, 48, 'laborers', 1, 'Gsgfg', 1, 30, NULL, NULL, 'Hotel', '123123123', '12', '12', NULL),
(72, '2021-04-01 06:59:36', '2021-04-01 06:59:36', NULL, 49, 'laborers', 1, '1', 1, 20, NULL, NULL, 'Camp', '1', '1', '1', NULL),
(73, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 50, 'laborers', 2, 'Test', 5, 100, NULL, NULL, 'Camp', 'Test', 'test', 'test', NULL),
(74, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 50, 'operators', 2, 'Test', 5, 100, NULL, NULL, 'Other', 'test', 'test', 'test', NULL),
(75, '2021-04-15 08:46:06', '2021-04-15 08:46:06', NULL, 51, 'laborers', 2, 'sdfsdf', 3, 20, 1, NULL, 'Arrange by Primus', 'sfgdfgdfgdfg', 'qefsvd', 'vfvbb', NULL),
(76, '2021-04-15 09:00:10', '2021-04-15 09:00:10', NULL, 53, 'laborers', 1, 'dsgdfgdfg', 1, 0, 2, NULL, 'Arrange by Primus', '123123132123', '123123', '123123', NULL),
(77, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 54, 'laborers', 5, 'TEST', 12, 50, 12, NULL, 'Camp', 'TEST', 'Remote', 'yes', NULL),
(78, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 54, 'operators', 2, 'Test', 12, 100, NULL, 10, 'Camp', 'Test', 'Remote', 'yes', NULL),
(79, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 59, 'laborers', 1, 'Test', 3, 10, NULL, 1, 'Arrange by Primus', '123123', '12', '21', NULL),
(80, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 59, 'operators', 2, '1312323', 123, 0, NULL, 1, 'Camp', '123123123', '123', '123', NULL),
(81, '2021-04-21 15:18:03', '2021-04-21 15:18:03', NULL, 60, 'laborers', 1, '5678678678', 1, 0, 1, NULL, 'Arrange by Primus', '123123', '123', '123', NULL),
(82, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 61, 'laborers', 2, 'Test', 12, 50, 5, NULL, 'Arrange by Primus', 'N/A', 'Remote', 'NO', NULL),
(83, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 61, 'operators', 2, 'Test', 12, 50, NULL, 2, 'Camp', 'Test', 'Remote', 'Hard Hat', NULL),
(84, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 62, 'laborers', 2, 'Test', 12, 50, 4, 2, 'Camp', 'RCMP clearance', 'Remote', 'Rain Suit', NULL),
(85, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 62, 'operators', 3, 'Test', 12, 50, NULL, 12, 'Camp', 'RCMP Clearance', 'Outdoors', 'NO', NULL),
(86, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 62, 'supervisors', 1, 'Test', 8, 100, NULL, NULL, 'Camp', 'FITNESS', 'test', 'test', NULL),
(87, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 62, 'other_personnel', 4, 'Janitors and chefs', 12, 50, NULL, 12, 'Arrange by Primus', 'test', 'Remote', 'NO', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `personnel_required_tickets`
--

CREATE TABLE `personnel_required_tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `required_personnel_id` bigint(20) UNSIGNED NOT NULL,
  `first_aid` varchar(250) DEFAULT NULL,
  `H2S_alive` varchar(250) DEFAULT NULL,
  `CSTS` varchar(250) DEFAULT NULL,
  `confined_space` varchar(250) DEFAULT NULL,
  `ground_disturbance` varchar(250) DEFAULT NULL,
  `fall_arrest` varchar(250) DEFAULT NULL,
  `CSO` varchar(250) DEFAULT NULL,
  `other` varchar(250) DEFAULT NULL,
  `whmis` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `personnel_required_tickets`
--

INSERT INTO `personnel_required_tickets` (`id`, `created_at`, `updated_at`, `deleted_at`, `required_personnel_id`, `first_aid`, `H2S_alive`, `CSTS`, `confined_space`, `ground_disturbance`, `fall_arrest`, `CSO`, `other`, `whmis`) VALUES
(66, '2021-03-09 20:20:51', '2021-03-09 20:20:51', NULL, 66, '3', NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL),
(67, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 67, 'rtrt', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(68, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 68, NULL, 'aa', 'aas', 'yes', NULL, NULL, NULL, NULL, NULL),
(69, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 69, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(70, '2021-03-09 23:49:50', '2021-03-09 23:49:50', NULL, 70, NULL, NULL, NULL, 'yes', 'yes', NULL, NULL, NULL, NULL),
(71, '2021-03-15 13:59:07', '2021-03-15 13:59:07', NULL, 71, 'yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, '2021-04-01 06:59:36', '2021-04-01 06:59:36', NULL, 72, NULL, 'yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(73, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 73, 'yes', 'yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, '2021-04-05 08:34:18', '2021-04-05 08:34:18', NULL, 74, NULL, NULL, NULL, NULL, NULL, 'yes', 'yes', NULL, NULL),
(75, '2021-04-15 08:46:06', '2021-04-15 08:46:06', NULL, 75, '1', NULL, NULL, 'yes', NULL, NULL, NULL, NULL, NULL),
(76, '2021-04-15 09:00:10', '2021-04-15 09:00:10', NULL, 76, 'yes', '2', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 77, 'Advanced', 'yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(78, '2021-04-15 09:52:14', '2021-04-15 09:52:14', NULL, 78, NULL, NULL, NULL, NULL, 'yes', NULL, NULL, 'TEST', NULL),
(79, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 79, '1', 'yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, '2021-04-21 15:02:56', '2021-04-21 15:02:56', NULL, 80, '1', NULL, 'yes', '2', NULL, NULL, NULL, NULL, NULL),
(81, '2021-04-21 15:18:03', '2021-04-21 15:18:03', NULL, 81, '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(82, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 82, 'N/A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(83, '2021-05-07 20:26:42', '2021-05-07 20:26:42', NULL, 83, NULL, NULL, NULL, 'Very confined', NULL, NULL, NULL, NULL, NULL),
(84, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 84, 'in class', 'in class', 'in class', 'in class', 'in class', 'in class', 'in class', NULL, '1'),
(85, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 85, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1'),
(86, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 86, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(87, '2021-08-04 23:31:30', '2021-08-04 23:31:30', NULL, 87, NULL, 'Test for covid', NULL, NULL, NULL, NULL, NULL, NULL, '1');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `company_id` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_avatar_id` bigint(20) DEFAULT NULL,
  `is_company_admin` tinyint(1) DEFAULT '0',
  `first_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirmation_code` text COLLATE utf8mb4_unicode_ci,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `verification_status` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_available` date DEFAULT NULL,
  `location` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `created_at`, `updated_at`, `deleted_at`, `company_id`, `email`, `password`, `type`, `file_avatar_id`, `is_company_admin`, `first_name`, `last_name`, `phone`, `country_code`, `confirmation_code`, `is_verified`, `verification_status`, `remember_token`, `date_available`, `location`, `content`) VALUES
(1, '2020-11-10 14:19:22', '2020-12-14 16:38:06', NULL, '1', 'dev@thinkorion.com', '$2y$10$j.9awzrDt8CfuvFHb1qSMO8qzdrV5qjXsRcZOWTJ3UPxgxt/Z/VwS', 'Admin', 7, 0, 'Dev', 'Thinkorion', '+971585965923', NULL, 'vrfy-d2c0e192-03c0-47bd-8219-b02602e89741', 1, 'sent', NULL, NULL, NULL, NULL),
(2, '2020-11-13 09:03:37', '2021-05-07 21:04:31', NULL, '1', 'usama@primusworkforce.com', '$2y$10$pMf5WinQ9DcluebtIRw77.PzcD7VHaBaDQSCDxNjdwxsHdie6l8qC', 'Admin', NULL, NULL, 'Usama', 'Chaudhry', '+17808851373', NULL, NULL, 1, 'sent', NULL, NULL, NULL, NULL),
(3, '2020-12-08 12:33:46', '2020-12-10 10:19:16', NULL, '1', 'michael@primusworkforce.com', '$2y$10$og6mmGtcOz3YhP.AyTiAhOWM7435NIeOHvuFhLwevD9qx4vcw1l3i', 'Admin', NULL, NULL, 'Michael', 'Desautels', '+17806999597', NULL, NULL, 1, 'sent', NULL, NULL, NULL, NULL),
(4, '2020-12-08 12:35:07', '2020-12-16 19:19:11', NULL, '1', 'christina@primusworkforce.com', '$2y$10$f.JrfzLb6Yb9S/Qq338JZ.X8qrvPm0JAXwW209etedaK8kmqwRzJ2', 'Admin', NULL, NULL, 'Christina', 'Abraham', '+17808185463', NULL, NULL, 1, 'sent', NULL, NULL, NULL, NULL),
(5, '2020-12-09 15:48:56', '2021-02-11 11:53:29', NULL, '1', 'manno@thinkorion.com', '$2y$10$F7.DvJ4q/kMqe6KfFXx8IOwCKwi0p4RhmybHHTANu4OT4Q7WDudJW', 'Admin', NULL, NULL, 'Manno', 'Notermans', '+971585965923', NULL, NULL, 1, 'sent', NULL, NULL, NULL, NULL),
(32, '2020-12-14 17:46:18', '2021-02-11 11:56:22', '2021-02-11 11:56:22', '4', 'hr@primusworkforce.com', '$2y$10$zilEFwbLTnZpLZ60balYS.BVM435199x.N2pl9idhUXyQdRkBa3/K', 'Employer', NULL, 1, 'Usama', 'Chaudhry', NULL, NULL, 'vrfy-581fee3b-05a1-453e-b648-932541462bf7', 0, 'sent', NULL, NULL, NULL, NULL),
(35, '2020-12-15 18:39:13', '2021-02-11 11:56:25', '2021-02-11 11:56:25', '6', 'usamaschaudhry@gmail.com', '$2y$10$8lWDuZ42BoKf8ykVMB2Og.nSuADKLG00U8Iq1.KdkdSCt5KTwCrAa', 'Employer', NULL, 1, 'Usama', 'usama@primusworkforce.com', '7808851373', NULL, NULL, 1, 'sent', NULL, NULL, NULL, NULL),
(36, '2020-12-16 16:33:51', '2020-12-16 16:36:28', NULL, NULL, 'jamguzm95@gmail.com', '$2y$10$skspp6bnBpSd.Y1w6oQINOVrss/4CsV81co9zOiybQlLcr7xGJE8q', 'Candidate', NULL, 0, 'James', 'Guzman', NULL, NULL, 'vrfy-30554a04-0c49-4abb-91ae-9e1e4591a5d8', 1, 'verified', NULL, NULL, NULL, NULL),
(37, '2020-12-16 18:03:27', '2021-02-11 11:56:28', '2021-02-11 11:56:28', '7', 'dev.kenjimagto@gmail.com', '$2y$10$rMxkYDL0UpiIGMG32olIuu7VaECCOpcsZJbkD.eQlQrBuSWlobhNy', 'Employer', NULL, 1, 'USAMA', 'CHAUDHRY', NULL, NULL, 'vrfy-624e009f-4ca7-438e-a039-2fbc292abbc3', 0, 'sent', NULL, NULL, NULL, NULL),
(39, '2020-12-17 09:22:10', '2021-03-09 18:33:17', '2021-03-09 18:33:17', NULL, 'rayedchaudhry@gmail.com', '$2y$10$C.4daKvEynrOL42fO1FcDuzuuKRW.Y7hpEKkHu/0gIMiYpDpRms/.', 'Candidate', NULL, 0, 'Rayed', 'Chaudhry', NULL, NULL, 'vrfy-47e1897e-da11-43b9-828d-73e109a23cdc', 1, 'verified', NULL, NULL, NULL, NULL),
(40, '2020-12-18 12:31:12', '2021-04-15 08:13:51', '2021-04-15 08:13:51', NULL, 'manno.notermans@gmail.com', '$2y$10$tALA.Ol.2v/7060qEeSHMufWfEXCyy3BuGrH8axOxxPv8oyWtdsSu', 'Candidate', NULL, 0, 'Manno', 'Notermans', '+31646337290', NULL, NULL, 1, 'sent', NULL, NULL, NULL, NULL),
(41, '2020-12-18 12:31:49', '2021-03-09 18:33:13', '2021-03-09 18:33:13', NULL, 'finance@thinkorion.com', '$2y$10$NBb6PDW8m9DHrhJ/MioQGOfMudyekexaqGPHvaKQmpiW4gyHf1ByW', 'Candidate', NULL, NULL, 'Manno', 'Notermans', '+971585965923', NULL, NULL, 1, 'sent', NULL, NULL, NULL, NULL),
(42, '2020-12-19 05:07:02', '2020-12-19 05:07:03', NULL, NULL, 'yasir-asadi89@outlook.com', '$2y$10$KqKPsrg3q40OtQ/wd9NUH.KMlrfaiz04jMbRbozWvRyTqonSUVfcm', 'Candidate', NULL, 0, 'Yasir', 'Asadi', NULL, NULL, 'vrfy-37038b8c-e058-4160-887b-716f973dbe61', 0, 'sent', NULL, NULL, NULL, NULL),
(43, '2020-12-19 06:51:44', '2020-12-19 06:52:02', NULL, NULL, 'ysir-asadi90@hotmail.com', '$2y$10$8Pgq7hbvT6Xw1.KxkklI5uNitlXd8uH7PKvbiwy2BjXmbwB.FYswu', 'Candidate', NULL, 0, 'Yasir', 'Asadi', NULL, NULL, 'vrfy-02101723-69c4-4ffa-b953-f050a795021c', 0, 'sent', NULL, NULL, NULL, NULL),
(48, '2020-12-25 05:07:45', '2020-12-25 05:08:03', NULL, NULL, 'ali.as.aa332@gmail.com', '$2y$10$JGOwqgUDfT6djypuLl6Tk../1Dk6FmvHHcXQFscGAlI6/hSzh6LpW', 'Candidate', NULL, 0, 'Abdul', 'Aziz', NULL, NULL, 'vrfy-2e3cfba0-8963-4373-9215-e501c4df095b', 0, 'sent', NULL, NULL, NULL, NULL),
(49, '2020-12-29 16:12:23', '2020-12-29 16:13:34', NULL, NULL, 'sldjmix@gmail.com', '$2y$10$1MQ4r5S.p0pI3lsdbCAPgeqOmaDG0REsWHMX0VkTctXYO50R.D5qu', 'Candidate', NULL, 0, 'SAMSON', 'BORGES', NULL, NULL, 'vrfy-c2400786-8252-430b-99bc-0feec3fd8c7a', 1, 'verified', NULL, NULL, NULL, NULL),
(54, '2021-01-04 17:47:07', '2021-09-09 11:29:57', NULL, NULL, 'Ckassian7@me.com', '$2y$10$GWmwZ/qJD26HPDfrdcUZ5us.DM7jBY8YOT.Et5Vb5XuNaN4JMOwmi', 'Candidate', NULL, 0, 'Clinton', 'Kassian', NULL, NULL, 'vrfy-e24a9eca-5836-4864-97fc-cbef1d488377', 1, 'verified', NULL, NULL, NULL, 'Been in the Oil and Gas for 15 years 8 years as a plant operator at Gibsons Energy and the last few at clean Harbors.\nHave done some scaffolding and other labour jobs.'),
(55, '2021-01-05 20:21:08', '2021-01-06 01:07:56', NULL, NULL, 'annasinchongco@yahoo.com', '$2y$10$2riNBw3RNL/tr.OJmWjZKuliZA1xPFi3iNK2v3Mdi/M2LiWg8gSya', 'Candidate', NULL, 0, 'Analyn', 'Sinchongco', NULL, NULL, 'vrfy-7532723a-0534-4d1c-884a-2d6bf9c19ee0', 0, 'sent', NULL, NULL, NULL, NULL),
(56, '2021-01-08 18:31:34', '2021-01-08 18:32:02', NULL, NULL, 'michaelgauchier21@gmail.com', '$2y$10$bYGI.DsRFtMlv8e.vPimbekU9qmMrzpv.NgUuz99Q6S/DfgRKguEW', 'Candidate', NULL, 0, 'Michael', 'Gauchier', NULL, NULL, 'vrfy-2a274482-4590-45a5-9bc4-edbe700dac9b', 0, 'sent', NULL, NULL, NULL, NULL),
(57, '2021-01-08 18:45:29', '2021-09-09 11:29:57', NULL, NULL, 'edomiemmanuel@gmail.com', '$2y$10$F4SVCikrPI4vOMeOOlCmnOKA7zFCoX2zw1reZczoFYh/LNsFhDGim', 'Candidate', NULL, 0, 'Emmanuel Ogheneviyeze', 'Edomi', '+2348076704664', NULL, 'vrfy-cc52dbfc-eafd-429a-9fd8-c3ec97f4d011', 1, 'verified', NULL, NULL, NULL, 'Energized, Organized, good leadership style, time and data management, and always pay attention to details.'),
(58, '2021-01-09 03:33:21', '2021-01-09 17:21:34', NULL, NULL, 'landonschaffer@gmail.com', '$2y$10$GfHrZnnVzjyGNMltjbDyF.sPxYmjxNhGd7CGaWmapP/EIhY/feVI2', 'Candidate', 9, 0, 'Landon', 'Schaffer', '4039704063', NULL, 'vrfy-ca0d5e2a-0a5f-4059-baac-d365372eaddd', 1, 'verified', NULL, NULL, NULL, NULL),
(59, '2021-01-09 07:07:29', '2021-01-09 07:08:30', NULL, NULL, 'markhoulihan82@gmail.com', '$2y$10$kAoiujOX64xGF/s2p5UxN.kBTS3nhLgwySSgNJS1E0Oav3PC9nsU2', 'Candidate', NULL, 0, 'Mark', 'Houlihan', NULL, NULL, 'vrfy-cddcaf11-b48e-4921-b06c-9461eeebbd6c', 1, 'verified', NULL, NULL, NULL, NULL),
(60, '2021-01-09 17:23:53', '2021-01-09 17:24:37', NULL, NULL, 'dustin.tebb@live.com', '$2y$10$pX1F9eAQ.ya9mM16WsNAM.XSQlxA/IB1fHo2zIjMk/YzlfL8AtRJ.', 'Candidate', NULL, 0, 'Dustin', 'Tebb', NULL, NULL, 'vrfy-71c16942-e6c7-47dc-8dcc-20c4a1c3c647', 1, 'verified', NULL, NULL, NULL, NULL),
(61, '2021-01-09 19:36:14', '2021-01-09 19:37:46', NULL, NULL, 'ali.aladel02@gmail.com', '$2y$10$HnAdgD00WbTrxJlQl2rQsuIJpi6N2nS3g6Ej0uCNTs5scmTr0KvSK', 'Candidate', NULL, 0, 'Ali', 'Adel', '4034736683', NULL, 'vrfy-f82946ea-fa24-4c8f-aaac-7e202cef7b5f', 1, 'verified', NULL, NULL, NULL, NULL),
(62, '2021-01-11 05:39:31', '2021-01-11 06:40:51', NULL, NULL, 'pavlosanmartinek@outlook.com', '$2y$10$6eDGH3rU7/rTw6M5tPxqVe/hExD9G/i/O7pMaAXkpl1s4ZgxVPA.a', 'Candidate', 11, 0, 'Pavlo', 'San-Martinek', '5875974605', NULL, 'vrfy-808f4002-5ddc-43b9-91f3-a23bed0350be', 1, 'verified', NULL, NULL, NULL, NULL),
(64, '2021-01-12 21:19:15', '2021-01-12 21:20:03', NULL, NULL, 'Vbahakush@gmail.com', '$2y$10$Yt.oAruxzJCRY6A8eSeVaebMza9TGSuJk/4en396SQZrYh4B.mTpq', 'Candidate', NULL, 0, 'Jordan', 'Bratko', NULL, NULL, 'vrfy-301593fd-4a1c-447f-916b-49f761068e86', 0, 'sent', NULL, NULL, NULL, NULL),
(65, '2021-01-13 06:44:24', '2021-01-13 06:45:04', NULL, NULL, 'canucks.dodman@gmail.com', '$2y$10$Rmm64eH2068lq0jNCYavS.BUvzt1DkvDCulxMjnAlMqGt5s36hcre', 'Candidate', NULL, 0, 'Jess', 'Dodman', NULL, NULL, 'vrfy-241924d0-cfb3-45b6-b6bc-733ddb145cf6', 0, 'sent', NULL, NULL, NULL, NULL),
(66, '2021-01-13 14:20:20', '2021-09-09 11:29:57', NULL, NULL, 'gotthelfm3@live.ca', '$2y$10$OpEIgWlalJsXBPTVvagQc.pjr2EbYtB4BmSk4IqgpxHzPdZ/5tApe', 'Candidate', NULL, 0, 'Martin', 'Gotthelf', '5875986382', NULL, 'vrfy-c30ad596-ba18-47ed-98ec-dd6c7970e4ff', 1, 'verified', NULL, NULL, NULL, 'I am looking for accounts payable, payroll, or a combination thereof.'),
(67, '2021-01-14 04:07:02', '2021-01-14 04:09:00', NULL, NULL, 'haroon131@gmail.com', '$2y$10$khgplkt14bW1WA59aUiaCO0ByKFFuMf1iyrxpxYmugIft0yAp5Vau', 'Candidate', NULL, 0, 'Haroon', 'Rasheed', NULL, NULL, 'vrfy-cbf14e51-3ee7-4280-aa9d-8ca59ac9cc8b', 1, 'verified', NULL, NULL, NULL, NULL),
(68, '2021-01-17 04:04:02', '2021-01-17 04:05:23', NULL, NULL, 'patrickshekey@gmail.com', '$2y$10$DYPKYXRlLABeNO42n2kKte8Y/EN.TlniOMSKkUmzsRCeS98Ho.yOS', 'Candidate', NULL, 0, 'Patrick', 'Shekey', NULL, NULL, 'vrfy-103b159e-9bfe-4d62-b561-18836e5f9bb0', 1, 'verified', NULL, NULL, NULL, NULL),
(69, '2021-01-18 16:53:52', '2021-01-18 16:54:03', NULL, NULL, 'albertaeskimo27@hotmail.com', '$2y$10$okXMEGdAa5L7tTUJCR51xuLUCO2fCGA36bNORtaFvVhy5rsyz2iVu', 'Candidate', NULL, NULL, 'Nathan', 'Lee', '7802397181', NULL, NULL, 0, 'sent', NULL, NULL, NULL, NULL),
(70, '2021-01-18 16:58:28', '2021-01-18 17:54:23', NULL, NULL, 'bizzrelated@hotmail.com', '$2y$10$pA3/LMudqgCkdCnPXvrq8.cpE7gK799QH9iOT9mukpw4bRpMZVOLO', 'Candidate', NULL, 0, 'Myles', 'Deibert', NULL, NULL, 'vrfy-e285f62f-723c-4eb5-8238-d8eadb1ba7a0', 0, 'sent', NULL, NULL, NULL, NULL),
(71, '2021-01-18 18:23:37', '2021-09-09 11:29:57', NULL, NULL, 'kenstev7@hotmail.com', '$2y$10$N55ifTlJrzDMIpja1S9ahOK8.AJb2j7XDNduMHali6SN2FmafHeZ.', 'Candidate', NULL, 0, 'Roy', 'Stevenson', '403-990-4564', NULL, 'vrfy-03c1fc8f-37de-49c5-ad93-e18da575f710', 1, 'verified', NULL, NULL, NULL, 'Experienced (6 years) Survey Assistant, Buried Line Locator (2 years) with 2 years of technical school (SAIT) training in geomatics. I am single and free to travel for any work location or schedule.'),
(72, '2021-01-23 08:09:55', '2021-01-23 08:10:31', NULL, NULL, 'md.cannon@yahoo.ca', '$2y$10$M5wMzZClqiMbGCSAXP31v.VFu01difTieccK9JSZ3ibuOGzLw6ZmS', 'Candidate', NULL, 0, 'Michael', 'Cannon', NULL, NULL, 'vrfy-a165d4e2-375d-4419-86f4-d1f6a69c03f9', 1, 'verified', NULL, NULL, NULL, NULL),
(73, '2021-01-25 18:53:24', '2021-01-25 18:55:22', NULL, NULL, 'mitchell.macdonald506@gmail.com', '$2y$10$IoaU3oU/1b1xhsx2QUNB1.eBX0djNe5mSGPQoKB/47UkCCOC2zrpu', 'Candidate', NULL, 0, 'Mitchell', 'Macdonald', NULL, NULL, 'vrfy-4cd75bf7-13d5-4e32-a9d2-c4d6ba0fe9a2', 1, 'verified', NULL, NULL, NULL, NULL),
(74, '2021-01-27 15:49:51', '2021-01-27 15:50:53', NULL, NULL, 'greg_2699@hotmail.com', '$2y$10$V8eUMBH1verG2HVpEPVQRuocgQAWgL21tnS8HHvG5XdnvWwu1tExG', 'Candidate', NULL, 0, 'Gregory', 'Menchenton', NULL, NULL, 'vrfy-47a101c4-9a70-4d8d-b4e3-b9bfa5b9d6af', 1, 'verified', NULL, NULL, NULL, NULL),
(75, '2021-01-27 23:47:30', '2021-09-09 11:29:57', NULL, NULL, 'triplemc.services@gmail.com', '$2y$10$leLw9deW8T1iM4tBz5TLl.YuAI9fUNk70RTkLhUoD8LazK8wmN1zG', 'Candidate', NULL, 0, 'Mike', 'Lewis', NULL, NULL, 'vrfy-d4059a09-2b8a-4609-ad18-558627591e64', 1, 'verified', NULL, NULL, NULL, 'An Oil and Gas professional with over 23 years of experience in Quality Assurance and Quality Control who has worn many different hats throughout his career taking him from the grass roots of QA/QC to becoming Operational Manager. Mike prides himself as being professional, conscientious, and adaptable to industry and client needs. With these attributes, he is able to provide dependable and positive results.'),
(76, '2021-01-28 20:45:41', '2021-01-28 20:46:31', NULL, NULL, 'ms2593pawar@gmail.com', '$2y$10$lnD8BVEgYlenD9GZ5uWJJ.H6Vw91kIl/WYgWIYzQBQUlSVwIHcWiO', 'Candidate', NULL, 0, 'Mayur', 'Pawar', NULL, NULL, 'vrfy-590dedc3-0b4e-4f52-be31-f3dd97de5ac9', 1, 'verified', NULL, NULL, NULL, NULL),
(77, '2021-01-28 22:56:48', '2021-01-29 02:22:45', NULL, NULL, 'warren.oostlander@gmail.com', '$2y$10$Ifp1qQwluoD.je1Ggt2AJOymt766QdjFiHxeegvmXASwfv7YCTDQO', 'Candidate', NULL, 0, 'Warren', 'Oostlander', NULL, NULL, 'vrfy-8d6e36ba-c162-4fc9-ac48-03a182e85d2d', 1, 'verified', NULL, NULL, NULL, NULL),
(78, '2021-01-30 17:16:57', '2021-01-30 23:09:29', NULL, NULL, 'kjkinch@shaw.ca', '$2y$10$bi9vo.7JnvlAAEjLzQi8S.la6FFuG40GoxFks1HenihMhTm3lgvpe', 'Candidate', NULL, 0, 'Kevin', 'Kinch', NULL, NULL, 'vrfy-1d5623e3-da5b-4087-8685-4d48bd5d4709', 1, 'verified', NULL, NULL, NULL, NULL),
(79, '2021-02-01 18:12:54', '2021-02-01 18:13:25', NULL, NULL, 'bradlawrence1313@icloud.com', '$2y$10$5JB6GPCtbKreAV.PF/G4VO3w8XYfrExDkD82QSgO5nWR4zfnGsYHW', 'Candidate', NULL, 0, 'Bradley', 'Lawrence', NULL, NULL, 'vrfy-513dfd5d-a8f9-4e1f-ae3e-a6dc163e16a0', 1, 'verified', NULL, NULL, NULL, NULL),
(83, '2021-02-02 04:48:52', '2021-02-02 04:49:43', NULL, NULL, 'developer@amazonebcexperts.com', '$2y$10$2mTbt.FyLclczYkldqr3.OmYJt3M.gjZOow.Uui3k7OmhqrFy24c6', 'Candidate', NULL, 0, 'Developer', 'Developer', NULL, NULL, 'vrfy-a63c8f88-ad32-47e7-b5fe-a7979e921ff1', 1, 'verified', NULL, NULL, NULL, NULL),
(84, '2021-02-04 02:11:55', '2021-02-04 02:12:03', NULL, NULL, 'mikegust@sasktel.net', '$2y$10$rusn6UDQ9KUZTQoRcZiA0eo7lxhErwsddwFtNbiU5f/VVKSkFypzG', 'Candidate', NULL, 0, 'Mike', 'Gustafson', NULL, NULL, 'vrfy-cec97b24-8a1b-419c-8716-95854d457853', 0, 'sent', NULL, NULL, NULL, NULL),
(85, '2021-02-05 04:08:16', '2021-02-05 04:09:03', NULL, NULL, 'michael.c.poulsen@gmail.com', '$2y$10$vEIofTgX.WBYAfnBQZL2Te54MtYJiYyIVVBjTZniGcqCe8U4j6jj2', 'Candidate', NULL, 0, 'Michael', 'Poulsen', NULL, NULL, 'vrfy-2ff8a4e4-8db0-415a-ac7a-0f394e784e0a', 0, 'sent', NULL, NULL, NULL, NULL),
(86, '2021-02-05 22:59:00', '2021-02-05 23:00:54', NULL, NULL, 'josephreyracho@yahoo.com', '$2y$10$Z6JRIAIiXl2esI.CfJJIWOhGsE1MBdQVdhHnh/XgRAud25VuKhMUO', 'Candidate', NULL, 0, 'Joseph', 'Racho', '5066262990', NULL, 'vrfy-4f05fdff-457a-4407-81b2-9a1c1a8b2ba8', 1, 'verified', NULL, NULL, NULL, NULL),
(87, '2021-02-08 19:06:44', '2021-09-09 11:29:57', NULL, NULL, 'K.prystupa@shaw.ca', '$2y$10$OqvGvKMKqHgEN8QQiC0LHe.i1YljMuBFM12nX13kUzfydnWj.hM.i', 'Candidate', NULL, 0, 'Kale', 'Prystupa', '403-324-5034', NULL, 'vrfy-1c6b2e8f-074f-4eaf-91d3-103fc3163690', 1, 'verified', NULL, NULL, NULL, 'I am a licensed Automotive Service Technician Red Seal Inter Provincial I have 24 years experience 16 in automotive repair and 8 years as a field service technician working on all different types of equipment.'),
(88, '2021-02-09 21:04:01', '2021-02-09 21:04:03', NULL, NULL, 'lisalovescopy@gmail.com', '$2y$10$px6QU72PPxSfbKlyKo4exeQGbTNigYl6aFUUL.4IqIglfFYbieBGS', 'Candidate', NULL, 0, 'Lisa', 'Loves', NULL, NULL, 'vrfy-bba236c8-785c-4cf0-87e8-a8e571cca578', 0, 'sent', NULL, NULL, NULL, NULL),
(89, '2021-02-10 20:45:52', '2021-02-10 20:46:03', NULL, NULL, 'j_q_j_w@hotmail.com', '$2y$10$RQwYq5JdVJDjyxaOvQlu5ua8W9chbX30/CCOoXPMoohVSGZqhJ0Ii', 'Candidate', NULL, 0, 'Jordan', 'Waskewitch', NULL, NULL, 'vrfy-95a46562-7dc8-4e3f-874d-ccfec92c0d4e', 0, 'sent', NULL, NULL, NULL, NULL),
(101, '2021-02-13 21:42:02', '2021-02-13 21:43:02', NULL, NULL, 'hamada_cj00@icoud.ca', '$2y$10$5KRP1Xtwt2CfXeeWdazVf.ReXopEeOJHekaiR/qD7fBe7P4ixpLSm', 'Candidate', NULL, NULL, 'Ahmad', 'Hamada', '2269881073', NULL, NULL, 0, 'sent', NULL, NULL, NULL, NULL),
(102, '2021-02-14 07:38:54', '2021-02-14 07:39:39', NULL, NULL, 'namger2009@yahoo.com', '$2y$10$Jw6g8opWKOMjjn2.SMs.RuACq22.w841c7ZES1F4Um.2Ff0YOrRW.', 'Candidate', NULL, 0, 'Gervais', 'Ouefio-Nambokinena', NULL, NULL, 'vrfy-db4dd7a7-f8ef-4c08-b150-c8655e8c4393', 1, 'verified', NULL, NULL, NULL, NULL),
(103, '2021-02-14 10:25:26', '2021-02-14 10:26:22', NULL, NULL, 'mark.hanna780@gmail.com', '$2y$10$nYmuXTuRXsi1b7qenqZ3I.Hnh4rnFOJWpdQOWcoWD9/264udxntGW', 'Candidate', NULL, 0, 'Mark', 'Hanna', NULL, NULL, 'vrfy-c3713965-7281-4385-91e2-dbcf71966b25', 1, 'verified', NULL, NULL, NULL, NULL),
(104, '2021-02-14 18:44:13', '2021-02-24 03:54:08', NULL, NULL, 'robjgibson2010@hotmail.com', '$2y$10$eEX7STweA0QFnefi.QHo9..2vgUOn/vEx6HLOUX4vkYz.z3yqu49W', 'Candidate', NULL, 0, 'Robert', 'Gibson', NULL, NULL, 'vrfy-1d1cc6ea-c71c-40ac-81ae-c013923066aa', 0, 'sent', NULL, NULL, NULL, NULL),
(105, '2021-02-14 19:34:27', '2021-02-14 19:35:04', NULL, NULL, 'qaim.ali@edu.sait.ca', '$2y$10$HyRFcm2yDn2jJVTCz9Y0beW96Gp7L5ZxbByvGHemLjoYPCYo1mQTG', 'Candidate', NULL, 0, 'Qaim', 'Ali', NULL, NULL, 'vrfy-6d111e42-ab4d-474e-91b9-f91ba1e773d7', 0, 'sent', NULL, NULL, NULL, NULL),
(106, '2021-02-14 19:44:58', '2021-02-14 19:45:04', NULL, NULL, 'samantha.mazarura@outlook.com', '$2y$10$YYg4Kw7opNoWuyDBfAl6gOVveYbFI3Qnkb7bLZK.oS7.SNTWuOFKO', 'Candidate', NULL, 0, 'Samantha', 'Mazarura', NULL, NULL, 'vrfy-fbf580d6-8895-4add-a60a-8ae155039574', 0, 'sent', NULL, NULL, NULL, NULL),
(107, '2021-02-15 19:33:40', '2021-02-15 19:38:38', NULL, NULL, 'leswood1@telus.net', '$2y$10$r8lTYPyPL537ZVzI0.SiJ.anLPXiYe9EwNOk/7KS8q4gp/aoOeCHa', 'Candidate', NULL, 0, 'Les', 'Wood', '14038523135', NULL, 'vrfy-ba4c2f36-8616-49f3-bdc8-b2b005b39d6a', 1, 'verified', NULL, NULL, NULL, NULL),
(108, '2021-02-15 21:21:59', '2021-06-21 16:25:04', NULL, NULL, 'tony_wildeman@msn.com', '$2y$10$qi0O7ocq.Rq/Es/9jhdjqe5Xd.nBUhIMh91Xr6cynYOZdBIXXDN/.', 'Candidate', NULL, 0, 'Anthony', 'Wildeman', '306-830-4013', NULL, 'vrfy-967f0cde-3590-4a82-a560-b1b2af97883d', 0, 'sent', NULL, NULL, NULL, NULL),
(109, '2021-02-16 03:10:13', '2021-09-09 11:29:57', NULL, NULL, 'developer@outorigin.com', '$2y$10$Fj0ksZ9jJHVrxOLY33EEEubDJJZfwL6mPc74NyHJ6xwuKRI07V0Yu', 'Candidate', 51, 0, 'Developer', 'Outorigin', '03098989822', NULL, 'vrfy-5b093cb3-f054-4535-b598-bf26561fcf0a', 1, 'verified', NULL, NULL, NULL, 'hello world'),
(110, '2021-02-16 05:59:20', '2021-02-16 06:03:23', NULL, NULL, 'goldnslim@gmail.com', '$2y$10$TyhF1AQQo1W2CEQXYnNH2uqL2upf4PNKM/vM3zdiI5TIFtzC.KT1i', 'Candidate', NULL, 0, 'Chika', 'Ibegbu', '3653369123', NULL, 'vrfy-ba730a44-4c6e-4fbb-aa3c-2432edde8d51', 1, 'verified', NULL, NULL, NULL, NULL),
(111, '2021-02-16 21:49:53', '2021-02-16 21:50:04', NULL, NULL, 'tdk787@hotmail.com', '$2y$10$sGMyWROaYSlU/1UkXoEdE.CmWq68haqUmV/0z0pV/kf55XTivADqO', 'Candidate', NULL, 0, 'Tariq', 'Durrani', NULL, NULL, 'vrfy-91709b96-105b-4942-b008-c117bf2332c1', 0, 'sent', NULL, NULL, NULL, NULL),
(112, '2021-02-18 09:39:53', '2021-02-18 09:40:15', NULL, NULL, 'robloewen12@hotmail.com', '$2y$10$3h105mYnaquQAY.pZ93jpe8bVBB1hTaO7RXhfNWwvl1B5UBjIfi4S', 'Candidate', NULL, 0, 'Robert', 'Loewen', NULL, NULL, 'vrfy-c85f8d05-9102-471c-bca1-948c43a2f09a', 1, 'verified', NULL, NULL, NULL, NULL),
(113, '2021-02-20 15:07:12', '2021-02-20 15:08:23', NULL, NULL, 'rob_jd_smith@hotmail.com', '$2y$10$hMIF8Mjm39jQ6PsbKUPaW.ArN.RGAhrKUJ80yGO14iNCYWlqJMhzK', 'Candidate', NULL, 0, 'Robert', 'Smith', NULL, NULL, 'vrfy-c31b1cff-73d4-4b0c-a957-a571aa0ac1ad', 1, 'verified', NULL, NULL, NULL, NULL),
(114, '2021-02-21 19:03:02', '2021-02-21 19:03:20', NULL, NULL, 'greg.see@gmail.com', '$2y$10$gGGHMKyW384A21uJqG3iOeinQyPlDcauqDHVM4LkdHQJArqeV7oTC', 'Candidate', NULL, 0, 'Greg', 'See', NULL, NULL, 'vrfy-992d0654-15bb-48bb-9375-015eb8c62562', 1, 'verified', NULL, NULL, NULL, NULL),
(115, '2021-02-23 19:04:05', '2021-02-23 19:05:22', NULL, NULL, 'rattandeepsinghpannu@gmail.com', '$2y$10$Y42sbLwPWsYXAlQ/RKuRKOJYjgJYsn3Ke7zuTfRwtd2WFXGhhXTvm', 'Candidate', NULL, 0, 'Rattandeep', 'Singh', NULL, NULL, 'vrfy-71af9242-696d-4cae-bb62-a75e5092cec8', 1, 'verified', NULL, NULL, NULL, NULL),
(117, '2021-02-26 16:50:08', '2021-03-15 14:22:43', '2021-03-15 14:22:43', '22', 'amric@outorigin.com', '$2y$10$kM9vm9MZk.hBffcWr0gCMegHCVG4t9dSS1BjTm7vUuNiMJY0rO.oO', 'Employer', NULL, 1, 'Amric', 'Paul', NULL, NULL, 'vrfy-72b127d7-8499-4d76-bcec-0a55d1da3ce4', 1, 'verified', NULL, NULL, NULL, NULL),
(118, '2021-02-26 22:16:24', '2021-02-26 22:21:18', NULL, NULL, 'kemmeritha@yahoo.com', '$2y$10$ooD8EcaaSccEpHVATXr6XuAgocsMLSLiZMyVhQ2seD3oHTec3pVjS', 'Candidate', NULL, 0, 'Emmeritha', 'Kasuvire', NULL, NULL, 'vrfy-4f18cc0d-b97c-41c0-95b2-df766494e17a', 1, 'verified', NULL, NULL, NULL, NULL),
(120, '2021-03-01 17:34:57', '2021-03-01 17:35:39', NULL, NULL, 'renebartolome@gmail.com', '$2y$10$GYbCGoGP0QWMLZiTgWBhru9HKAV9xVUC1FBKYG.N7M0jrI8s5.a/2', 'Candidate', NULL, 0, 'Renato', 'Bartolome', NULL, NULL, 'vrfy-739bad6f-d3c4-4460-884e-ad8c545e532e', 1, 'verified', NULL, NULL, NULL, NULL),
(121, '2021-03-03 20:07:09', '2021-03-03 20:10:10', NULL, NULL, 'WITOLDBALANDA@HOTMAIL.COM', '$2y$10$vOzj9ZPduv8njYSJOCimIe1isJDJ.2RK7O7IkvnKxpaWTjC9NwFmu', 'Candidate', NULL, 0, 'Witold', 'Balanda', NULL, NULL, 'vrfy-14455b76-cc11-4dfa-b20e-b89da250ed86', 1, 'verified', NULL, NULL, NULL, NULL),
(126, '2021-03-04 08:02:10', '2021-03-04 08:03:02', NULL, '1', 'rayed@thinkorion.com', '$2y$10$2QkzjzN.ErwvnFSgfULdpu1ok/WqLtF4eEtdewehutYPFED2Dq/0G', 'Admin', NULL, NULL, 'rayed', 'chaudhry', NULL, NULL, NULL, 0, 'sent', NULL, NULL, NULL, NULL),
(127, '2021-03-05 18:10:24', '2021-03-05 18:10:24', NULL, '30', 'amric@amazonebcexperts.com', '$2y$10$qJdv6dLbnJP2AkEKknBp/.7nlhw1kBQQ3x7ln04mJZ9yMsplqbUH6', 'Employer', NULL, 1, 'Amric', 'Paul', '03082766829', NULL, NULL, 1, 'verified', NULL, NULL, NULL, NULL),
(128, '2021-03-05 20:39:55', '2021-03-05 20:40:04', NULL, NULL, 'Abouhija@hotmail.com', '$2y$10$GqTyNy/pEks.LE1xdC6BtO66pU/YS206pZ4CtAipHDfCWzAiTn2RC', 'Candidate', NULL, 0, 'Chadi', 'Abdul-Rahim', NULL, NULL, 'vrfy-3036388d-6511-4a82-9247-8497f3a069e7', 0, 'sent', NULL, NULL, NULL, NULL),
(129, '2021-03-06 13:48:22', '2021-03-06 13:49:03', NULL, NULL, 'clayton2882@hotmail.com', '$2y$10$UQ.P4TxbwOTMMAtr6KShne.hc6ccd12ysH946Y/bjsB4aGEZCTlC2', 'Candidate', NULL, 0, 'Clayton', 'Macdonald', NULL, NULL, 'vrfy-792ea2b4-9a8a-4393-8a5c-c3879bd15da6', 0, 'sent', NULL, NULL, NULL, NULL),
(130, '2021-03-09 15:31:26', '2021-03-09 15:32:29', NULL, NULL, 'jewlzloewen1998@gmail.com', '$2y$10$tccT6TpOIDXM9qSJHJkS5eYtLnqbX5Wh31g1V14EFwHFf56DBNcpe', 'Candidate', NULL, 0, 'Julian', 'Loewen', NULL, NULL, 'vrfy-9d90145a-6590-4472-aacd-90c6a1cfdce6', 1, 'verified', NULL, NULL, NULL, NULL),
(131, '2021-03-09 21:31:55', '2021-04-01 02:55:51', '2021-04-01 02:55:51', '31', 'khanjeeaaish8903@gmail.com', '$2y$10$g8ql1G9uPQnVz9yh1csWnO9BVhFXxKXFw89dFU.Fk5S7vfYB.FfLW', 'Employer', NULL, 1, 'Aaish', 'Khan', NULL, NULL, 'vrfy-8714a8ef-7038-4cd9-873e-13240b2a26d8', 1, 'verified', NULL, NULL, NULL, NULL),
(132, '2021-03-09 23:50:46', '2021-09-09 11:29:57', NULL, NULL, 'aaishk007@gmail.com', '$2y$10$otEbt3iD73Qc7sKpj9q0TedJovYlpfedLD.0Vubraz0AZobyyxMWi', 'Candidate', NULL, 0, 'ZAYN', 'MALIK', NULL, NULL, 'vrfy-e8c89201-ff04-4002-a299-0b57b1a65862', 1, 'verified', NULL, NULL, NULL, 'madridsta'),
(133, '2021-03-10 16:57:55', '2021-03-10 16:58:24', NULL, NULL, 'travis.432196@gmail.com', '$2y$10$Yso9fcRgQwpKKtK2ZC.w/u3diy.P6d/i5JL2Z.RCYjyRMbuMfBpGW', 'Candidate', NULL, 0, 'Travis', 'McCormick', NULL, NULL, 'vrfy-c822f825-387d-4518-b2cc-85d5610baa5f', 1, 'verified', NULL, NULL, NULL, NULL),
(134, '2021-03-10 19:21:31', '2021-03-10 19:23:34', NULL, NULL, 'hamada_cj00@icloud.com', '$2y$10$HVWPKHX8WeBGrt301q4f.eURjRzWOcDbbOiGk96v0dbhUI5ujT3vG', 'Candidate', NULL, 0, 'Ahmad', 'Hamada', NULL, NULL, 'vrfy-8ee4bacd-40bc-46e6-832d-57558eb90e12', 1, 'verified', NULL, NULL, NULL, NULL),
(135, '2021-03-11 00:40:40', '2021-03-11 00:42:47', NULL, NULL, 'guy.desharnais@live.com', '$2y$10$XeIkKmhfYJqzjeLSyAUMKulidWftymmdQfNwUgItAvkZXIk7BKX0W', 'Candidate', NULL, 0, 'Guy', 'Desharnais', '+1 (709) 209-2876', NULL, 'vrfy-b9bcc52d-0471-4e36-bb81-502fe87ceef1', 1, 'verified', NULL, NULL, NULL, NULL),
(136, '2021-03-11 01:25:26', '2021-03-11 01:26:02', NULL, NULL, 'shania.weir@hotmail.com', '$2y$10$bJbbd3/tsXlomTXjXq8j3ec0y/iXgw78MPrNiHYevVjp5/TXx5D.C', 'Candidate', NULL, 0, 'Shania', 'Weir', NULL, NULL, 'vrfy-b0937f17-7249-4d64-a57f-54191877b795', 0, 'sent', NULL, NULL, NULL, NULL),
(137, '2021-03-12 00:32:49', '2021-03-12 00:33:22', NULL, NULL, 'okoromarho9@gmail.com', '$2y$10$VVbSpjQovfF2kyUaObG1W.Qv7xpsVofalUONqWgmgUgz/j22xwcf6', 'Candidate', NULL, 0, 'Oghenemarho', 'Okoro', NULL, NULL, 'vrfy-b8688a7c-2807-4d8d-b8a1-8742428dfe53', 1, 'verified', NULL, NULL, NULL, NULL),
(138, '2021-03-12 00:33:12', '2021-03-12 00:34:02', NULL, NULL, 'taniscardinal@hotmail.com', '$2y$10$Rn8vOalnbIXK7raxEGogSu/V8Mw4YCyj1ue1lCCXbQRn7aUtE6qiO', 'Candidate', NULL, 0, 'Tanis', 'Cardinal', NULL, NULL, 'vrfy-79ecfb4e-1e83-49ca-bc20-705a8707abad', 0, 'sent', NULL, NULL, NULL, NULL),
(139, '2021-03-13 18:13:48', '2021-03-13 18:14:03', NULL, NULL, 'Maesonstabbler@gmail.com', '$2y$10$aUWMBDyzThVgkSQrU/CVienSkj7oHO3ZQ3jxh14QJhN83U7kpvJEW', 'Candidate', NULL, 0, 'Michelle', 'Stabbler', NULL, NULL, 'vrfy-ccf76ae5-ce59-451a-85fc-14ecabad0d86', 0, 'sent', NULL, NULL, NULL, NULL),
(140, '2021-03-15 13:18:50', '2021-04-15 08:13:51', '2021-04-15 08:13:51', NULL, 'mannotest07@thinkorion.com', '$2y$10$GKtKX.BEL8t/2EO5/UCrp.RmwTMnSMI.MNbo/lk/4EMA.tIg7i1vG', 'Candidate', NULL, 0, 'Manno 07', 'Tester', NULL, NULL, 'vrfy-bba128c0-12f2-47d1-9ad8-e72ab2fb09fa', 0, 'sent', NULL, NULL, NULL, NULL),
(141, '2021-03-15 13:24:31', '2021-04-15 08:13:51', '2021-04-15 08:13:51', NULL, 'lisa1@thinkorion.com', '$2y$10$33uptgdU9toFFgvNUNxcMOFc3y8eTXjeEtM.ETyRcqYyqliopGZWW', 'Candidate', NULL, 0, 'Lisa 01', 'Tester', '+1654564544', NULL, 'vrfy-c0ee0f15-6809-42de-bde0-b60e690fb0d8', 1, 'verified', NULL, NULL, NULL, NULL),
(142, '2021-03-15 13:46:47', '2021-04-01 02:55:51', '2021-04-01 02:55:51', '32', 'lisa02@thinkorion.com', '$2y$10$VzfcgX/ut5iVzs/jTn22KOGCQgghxj93X1ZH6cI.9h5O0Eb5t7wKe', 'Employer', NULL, 1, 'Lisa 02', 'Tester', NULL, NULL, 'vrfy-0e00fbdd-3e1d-4636-a76e-a2c1c83db7ee', 0, 'sent', NULL, NULL, NULL, NULL),
(143, '2021-03-15 13:48:43', '2021-04-15 08:13:51', '2021-04-15 08:13:51', NULL, 'lisa2@thinkorion.com', '$2y$10$TeFwS2yng9GMKxX8.26CWOBg1hh77YWKap5brJEJMULqQM57HcPWa', 'Candidate', NULL, 0, 'Lisa 02', 'Tester', NULL, NULL, 'vrfy-3530bcb7-b8a9-495f-90cd-c41962fc648e', 1, 'verified', NULL, NULL, NULL, NULL),
(144, '2021-03-15 13:55:36', '2021-04-01 02:54:07', '2021-04-01 02:54:07', '33', 'lisa3@thinkorion.com', '$2y$10$9t6AyOeJB/E03.aDyCdkuu/NYljZ2HTxHukeVIPaPVrisF51ZD/zu', 'Employer', NULL, 1, 'Lisa 03', 'Tester', NULL, NULL, 'vrfy-4ac62488-e433-4f20-aa0b-dd23dad7a9c5', 1, 'verified', NULL, NULL, NULL, NULL),
(145, '2021-03-15 14:20:37', '2021-04-01 02:54:16', '2021-04-01 02:54:16', '34', 'lisa4@thinkorion.com', '$2y$10$5U7zN2S7lBPlCtxth3A9GeLRGBm7p9iSo27hmvYRo0XlA3FJU5yj2', 'Employer', NULL, 1, 'Lisa 04', 'Tester', '+31646337290', NULL, NULL, 1, 'verified', NULL, NULL, NULL, NULL),
(146, '2021-03-15 18:35:43', '2021-03-15 18:36:32', NULL, NULL, 'Sydneytr_05@hotmail.ca', '$2y$10$wUCJR33FxGEsJ.V8OSSzKecwR7wCuv1cZ6s4XL/cYb04USCsMv/OG', 'Candidate', NULL, 0, 'Sydney', 'Tremblay', NULL, NULL, 'vrfy-6788d09c-3317-4c66-b882-046fbb842147', 1, 'verified', NULL, NULL, NULL, NULL),
(147, '2021-03-15 19:14:09', '2021-09-09 11:29:57', NULL, NULL, 'Aniefiok.Akpan@hotmail.com', '$2y$10$S2uozRGbUqjMBKXjYbaY9eAQmuy8TZNaSkDcsfLue8oB8HOMgdkHS', 'Candidate', NULL, 0, 'Aniefiok', 'Akpan', NULL, NULL, 'vrfy-bd1f2ce2-56a6-4b6f-b54a-e2ff32c3f43e', 1, 'verified', NULL, NULL, NULL, 'I am a Power Engineering Technology graduate with sound training on safe operation and maintenance of process systems including boilers, turbines, pumps, compressors, refrigeration units, chillers etc. Also, I can operate, install new equipment and inspect existing systems for signs of defects before completing repairs with safety and cost control as top priorities. I can be useful in information technology, measurement and communication as well. In addition, I am very fast learner, analytical, dedicated and adaptable to all work environments.\n\nMoreover, I offer outstanding organizational skills, which have proven to be a critical asset in developing and maintaining process systems. These qualities combined with my dedication and tireless work ethic should enable me to make a positive impact at the company. . I hope to hear from you at your convenience to discuss your needs and objectives and the possibility of working together to meet them. Thank you for your time and consideration.'),
(149, '2021-03-19 00:47:14', '2021-04-01 03:00:47', '2021-04-01 03:00:47', NULL, 'anas.ahmed@amzonestep.com', '$2y$10$EwlkbPtMOZU2W0UUZ0mUgedKjsWsdilBaibR.UzEBvE5ng1CZs1Kq', 'Candidate', NULL, 0, 'Anas', 'Ahmed', NULL, NULL, 'vrfy-59518db5-5f82-4926-b3f2-ea14de53a4f2', 1, 'verified', NULL, NULL, NULL, NULL),
(150, '2021-03-22 23:50:17', '2021-04-15 08:13:51', '2021-04-15 08:13:51', NULL, 'amric@amzonestep.com', '$2y$10$aAwzkCP4NZU1h8Bzg2/l3OYnjFQX6pXRABb914ya9hJONNlAUGWnW', 'Candidate', NULL, 0, 'Amric', 'Paul', NULL, NULL, 'vrfy-8f97ac8f-0dd4-40b0-bb09-af9928a2fd0d', 1, 'verified', NULL, NULL, NULL, NULL),
(151, '2021-03-24 15:56:15', '2021-04-01 03:00:47', '2021-04-01 03:00:47', NULL, 'wasif@amzonestep.com', '$2y$10$Noins0e2pHo9DXCEiQnRuOoho6uk/Mj2W.YTvsHrene1GMj.b2kMe', 'Candidate', NULL, 0, 'Syed', 'Ali', NULL, NULL, 'vrfy-c121c14b-801d-4f00-aab9-9ffb90b56d82', 1, 'verified', NULL, NULL, NULL, NULL),
(152, '2021-03-25 11:36:37', '2021-03-25 11:37:21', NULL, NULL, 'firedup.landscaping@gmail.com', '$2y$10$y9KTC9lnjPAZPWfif7.qTenwrj7ew5B81rZIR7AG14ziCZW3MYcWK', 'Candidate', NULL, 0, 'Keith', 'Fraser', NULL, NULL, 'vrfy-98ddfc79-1160-4a6e-ac3a-951ff08c2398', 1, 'verified', NULL, NULL, NULL, NULL),
(153, '2021-03-27 04:34:27', '2021-03-27 04:36:12', NULL, NULL, 'aaron-naistus@hotmail.com', '$2y$10$hk/kL2Rn/PVquak6OL5Eme7rhI5IxBBNpmVv0XnztR5GPiEVwCC32', 'Candidate', NULL, 0, 'Aaron', 'Naistus', NULL, NULL, 'vrfy-05070ac1-71d4-40e0-878c-9b8c0d549b7f', 1, 'verified', NULL, NULL, NULL, NULL),
(154, '2021-04-05 08:33:54', '2021-04-05 08:34:31', NULL, '36', 'lisa5@thinkorion.com', '$2y$10$P048yBOjc0hP9LZc8Iphl.8WhRoho8HxXMMz2cAEBBLZSIIFLk0Kq', 'Employer', NULL, 1, 'Lisa (employer)', 'Tester', NULL, NULL, 'vrfy-4164f1cc-8517-4bff-8043-bddb460572a5', 1, 'verified', NULL, NULL, NULL, NULL),
(155, '2021-04-06 17:34:20', '2021-04-06 17:35:04', NULL, NULL, 'joelanderson79@gmail.com', '$2y$10$LA/OXuc1rchHUggHNyanCeVELZ1HuJcpWBaPRttNd1l7/MsRM3S9W', 'Candidate', NULL, 0, 'Joel', 'Anderson', NULL, NULL, 'vrfy-ef39bbb6-06f7-4052-b15e-7e37663ebd27', 0, 'sent', NULL, NULL, NULL, NULL),
(156, '2021-04-11 19:33:31', '2021-04-11 19:34:17', NULL, NULL, 'msariasosa@yahoo.com.mx', '$2y$10$hPkZzQyvD57EE9CAqIkrh.93Ve9m3eHKVGMcGx2QrbrWbjSyO98TO', 'Candidate', NULL, 0, 'Manolo', 'Arias', NULL, NULL, 'vrfy-c517425a-6853-4e80-a339-a82bd67a1e59', 1, 'verified', NULL, NULL, NULL, NULL),
(158, '2021-04-15 08:26:15', '2021-09-09 11:29:57', NULL, NULL, 'lisa8@thinkorion.com', '$2y$10$dDa7XRPJqGYFchqZKYCvqOcmLQoYWWKXtFKpSi/PqeemW2GGhKBNW', 'Candidate', 93, 0, 'Lisa', 'Candidate', '+31646337290', NULL, 'vrfy-9ea3ed27-f372-498f-a3fe-085f46e1725b', 1, 'verified', NULL, NULL, NULL, 'Lots to share.'),
(159, '2021-04-15 14:38:10', '2021-09-09 11:29:57', NULL, NULL, 'snackpak75@hotmail.com', '$2y$10$ydX3bhcFneoJ4O/uGFkYNOalZ.h9apn4UbG4hIJ6//czCVfEBxrqC', 'Candidate', NULL, 0, 'David', 'White', '782-233-1076', NULL, 'vrfy-4664727e-202e-40c0-9ad9-5876318500f0', 1, 'verified', NULL, NULL, NULL, 'Iam a class 1 operator with 15 years driving experience I ha e operated many different types of equipment IE   tandom&tridrive 5 ton with crane and piggyback 5 years experience operating 12 ton picker,pump truck ,pressure truck and tank truck also have experience with float trailer hauling equipment,  I can operate loader and skidsteer confidently great mechanical aptitude and  i learn fast'),
(160, '2021-04-17 18:25:26', '2021-04-17 19:09:09', NULL, NULL, 'alexbaldie840@gmail.com', '$2y$10$IWZX1omDO5bST7rN9fFEZuv8krnnpM3rquCgdJXEYZJyXebqOHrQ6', 'Candidate', NULL, 0, 'Alex', 'B.', NULL, NULL, 'vrfy-63791251-041b-4f74-9bc6-551fbadb9efa', 1, 'verified', NULL, NULL, NULL, NULL),
(161, '2021-04-17 20:38:22', '2021-09-09 11:29:57', NULL, NULL, 'festchou83@yahoo.co.uk', '$2y$10$u.vcGrJi4PM9kMr596wN/.7bGT09s/0CMKS.Ll.jc3uCiFrkw8PZy', 'Candidate', NULL, 0, 'Njike', 'Tchoumi', '780-934-9173', NULL, 'vrfy-b99e8677-7825-4331-9c7a-f0df6ea4d690', 1, 'verified', NULL, NULL, NULL, 'I have more than 5 years in oil and gas and 8 plus years in construction. I can work for a longer period of time with minimal or limited supervision. I have great stamina and can adapt easily in new environment. I have done many different camp jobs and I\'m available for relocation. Safety is my watch world and I carry all tasks Safely to ensure my safety and that of my co-workers.'),
(162, '2021-04-19 21:22:26', '2021-04-19 21:36:40', NULL, NULL, 'alexburt48@gmail.com', '$2y$10$8AmEARrlqkQfG5YND3HzaOD75gKkYqQAxVfBLCl0d2nFrZjOJtUs6', 'Candidate', NULL, 0, 'Alex', 'Burt', NULL, NULL, 'vrfy-eb13a0fc-b6a5-4f62-9c88-a66497c102aa', 1, 'verified', NULL, NULL, NULL, NULL),
(163, '2021-04-22 03:40:37', '2021-04-30 07:25:04', NULL, NULL, 'jinhu5240@gmail.com', '$2y$10$xl.Al21XiF7fqJQG07NFtuMcflPMhsVXvtP3i0WZ5fqFHuxEcVdhO', 'Candidate', NULL, 0, 'Alex', 'Jin', NULL, NULL, 'vrfy-776a0421-7f3d-43ff-9d83-f65e83d80823', 0, 'sent', NULL, NULL, NULL, NULL),
(164, '2021-04-25 20:54:22', '2021-04-30 07:25:04', NULL, NULL, 'shaydentupper20@hotmail.ca', '$2y$10$1Q5PVnNQX5cMDLa4T6KAVe254BB5olit51KuOg4Rk4sGAAI20TVH.', 'Candidate', NULL, 0, 'Shayden', 'Tupper', NULL, NULL, 'vrfy-0266c30d-9f04-4948-896c-621f3906afdb', 0, 'sent', NULL, NULL, NULL, NULL),
(165, '2021-04-26 03:26:00', '2021-09-09 11:29:57', NULL, NULL, 'cyrustobias2009@gmail.com and cyrustobias2000@yahoo.com', '$2y$10$/EM.kaY4nH49Zd2B0WMtO.e5y6/vUz0Zv3.VcrjEW3BGeu3ZqI2am', 'Candidate', NULL, 0, 'Cyrus', 'Tobias', '1-780-974-8421', NULL, 'vrfy-7b45ab69-2fc7-4738-a14a-ab98d7027c9a', 1, 'verified', NULL, NULL, NULL, 'I came from Asia year 2009, I\'ve worked most of the time in Food Production, like Beef Processing, Plant and Turkey and Chicken Process Foods, I have minimal experienced in Oil and Gas and Construction as well. I\'ve worked in Savanna Drilling for 1 season and Construction since I was in High School but not always and just Labourer job. Year 2018 I decided to settle my self and Family in Canada, I bought in Edmonton City but sad to say that this pandemic really affect most of any individual all over the world specially Me. I wan\'t to stay with food and Beverage Industry but my Bills and Mortgage scared me all the time, and I believed those experienced that I had in Oil and Gas can put me back into the Field.'),
(166, '2021-04-28 21:09:07', '2021-04-30 07:25:05', NULL, NULL, 'edemkujoe@gmail.com', '$2y$10$u4mH77R0lZYbSN68n9epL.y81AKskVFBy8TFDh8Mzn03QlqOki1.e', 'Candidate', NULL, 0, 'Edem', 'Atsrim', NULL, NULL, 'vrfy-859945c4-8007-40d7-9f87-c3ff54ddb795', 0, 'sent', NULL, NULL, NULL, NULL),
(167, '2021-04-29 03:58:29', '2021-06-04 17:41:51', NULL, NULL, 'richledrew@hotmail.com', '$2y$10$fRNA1bhr99ih74yfP2Ji2OmRykGsFU8C2PgCJptX7DuHzbAsr0Ziy', 'Candidate', NULL, 0, 'Richard', 'LeDrew', NULL, NULL, 'vrfy-ef872fb6-1089-4b9d-bf96-17d13542e798', 0, 'sent', NULL, NULL, NULL, NULL),
(168, '2021-04-29 04:00:04', '2021-05-01 09:20:55', NULL, NULL, 'Cyrustobias2000@yahoo.com', '$2y$10$CnSN1KK/UGKeaKwx911QleVQQxypFRCklF/JCt2F68kWWcP9lxWcu', 'Candidate', NULL, 0, 'Cyrus', 'Tobias', NULL, NULL, 'vrfy-14a86de3-a970-4ddd-8205-55e0ba798197', 1, 'verified', NULL, NULL, NULL, NULL),
(169, '2021-05-04 16:24:00', '2021-05-04 16:24:05', NULL, NULL, 'aldenrichards@gmail.com', '$2y$10$SBfLzLRQXkRn7utlycaPOu5ANwBHikejRINRChVXp.ScLAMNooOmy', 'Candidate', NULL, NULL, 'alden', 'richards', NULL, NULL, NULL, 0, 'sent', NULL, NULL, NULL, NULL),
(170, '2021-05-07 20:07:56', '2021-05-07 20:09:44', NULL, NULL, 'testmachine019@thinkorion.com', '$2y$10$ZNd.qrZOKJEeay5ECw2ETufa0ku7ThZGwxcWuWxjsIPl/QQB7n7Iu', 'Candidate', NULL, 0, 'Megan', 'Candidate Test', '+17802070753', NULL, 'vrfy-08d0837b-678c-41bf-9499-c53a6e22731c', 1, 'verified', NULL, NULL, NULL, NULL),
(171, '2021-05-07 20:18:20', '2021-05-07 20:19:59', NULL, '37', 'testmachine020@thinkorion.com', '$2y$10$N.tqhUbQNJVFM0BSuehT6u1VeDTgp6lT0hTESAt0Wudxwhtzg3Quu', 'Employer', NULL, 1, 'Megan', 'Employer Test', NULL, NULL, 'vrfy-07dd4b9d-59b0-4e34-8ab1-198693ed4a64', 1, 'verified', NULL, NULL, NULL, NULL),
(172, '2021-05-11 20:45:03', '2021-05-11 20:45:43', NULL, NULL, 'mark.zavin@gmail.com', '$2y$10$p4Yyrl6OQHV6IIDJj9G00ugdxu75FjRSrq0uRt0ly3GTmLfP5MkFG', 'Candidate', NULL, 0, 'Mark', 'Zavin', NULL, NULL, 'vrfy-7faf2d5a-561b-4150-a107-fe3d053c5182', 1, 'verified', NULL, NULL, NULL, NULL),
(173, '2021-05-12 16:50:55', '2021-05-12 16:51:03', NULL, NULL, 'hamulake@gmail.com', '$2y$10$davYIzW8DqF7MKZb4t9qp.ZOKPa9l3t6iCkK7lc8jmGFSzxlGy2X2', 'Candidate', NULL, NULL, 'Kaitlin', 'Hamula', '780-974-7557', NULL, NULL, 0, 'sent', NULL, NULL, NULL, NULL),
(174, '2021-05-23 16:14:08', '2021-05-23 16:15:17', NULL, NULL, 'Ryan.scotty91@gmail.com', '$2y$10$MuDVdImBqPfDSTOzfKXKGOUh/6/eM.boHxnjGZSMES9gqNUCAUqpW', 'Candidate', NULL, 0, 'Ryan', 'Scott', NULL, NULL, 'vrfy-2c1ede85-b9a8-4fb5-a294-b12822fe2fd3', 1, 'verified', NULL, NULL, NULL, NULL),
(175, '2021-05-25 16:12:39', '2021-09-09 11:29:57', NULL, NULL, 'benjaminwilliams68@yahoo.com', '$2y$10$nIckerhPDIQfUnJyxzP0quO7j3/KUPFVJqGyzzzyZH6GfSZ.iITP6', 'Candidate', NULL, 0, 'Benjamin', 'Williams', '7802675592', NULL, 'vrfy-d81139b1-a72d-4585-8b23-82815baf4654', 1, 'verified', NULL, NULL, NULL, 'I am a hard working and disciplined individual that is committed to learn, understand and complete given tasks. I am currently training and preparing for the 2021 Summer Olympics as an Athletics 100 meter Sprinter.'),
(176, '2021-05-27 04:09:29', '2021-05-27 04:10:34', NULL, NULL, 'zowen4god@yahoo.com', '$2y$10$Ir2IiO8WaSjc2Ofirj4Wp.iZrt5KYLRx1zre60lhlHvjxhvpuJvWK', 'Candidate', NULL, 0, 'Danley', 'Iwuagwu', NULL, NULL, 'vrfy-a7c3867b-c105-40d8-9f8d-b4a9aee2449f', 1, 'verified', NULL, NULL, NULL, NULL),
(177, '2021-06-02 23:15:30', '2021-06-02 23:16:14', NULL, NULL, 'trudi.hendry@gmail.com', '$2y$10$23dpKJ3SgqFeaxfWZP0pzO.y9XRgaTAqeWZyglbOoPTlu/l5HVAne', 'Candidate', NULL, 0, 'TRUDI', 'HENDRI', NULL, NULL, 'vrfy-e0f2c813-72d0-4f3a-bda8-18312dd69d74', 1, 'verified', NULL, NULL, NULL, NULL),
(178, '2021-06-21 19:11:30', '2021-06-21 19:12:04', NULL, NULL, 'megsaccary89@gmail.com', '$2y$10$QNpkACQF1zq6rbrBQaTGGOfdxS6RMv.Pxsa8CTF1xG4nUwlQZ4Zsi', 'Candidate', NULL, NULL, 'Megan', 'Williams', '780-203-0753', NULL, 'vrfy-a7c3867b-c105-40d8-9f8d-b4a9aee25001', 1, 'verified', NULL, NULL, NULL, NULL),
(179, '2021-06-23 07:10:54', '2021-09-09 11:29:57', NULL, NULL, 'erickwakuassuman@gmail.com', '$2y$10$rmlPxgorWSZ2RIC5kEb2wuBHkOlhGgIMrTKa.2YvgrDBfdorgDqJq', 'Candidate', NULL, 0, 'ERIC KWAKU', 'ASSUMAN', '+233244713231', NULL, 'vrfy-ab783c1b-5001-477c-b4d8-d2a8d83ba5f5', 1, 'verified', NULL, NULL, NULL, 'am a self motivated person, ready to learn a new skill when the opportunity present itself'),
(180, '2021-07-04 05:00:53', '2021-07-04 05:01:18', NULL, NULL, 'messegermain1@gmail.com', '$2y$10$WdMqKAeV0m2mQFkuoCbJme3O8dZRdJEceE/yYoWdkfSgdS6HAU7Ae', 'Candidate', NULL, 0, 'GERMAIN', 'MESSE', NULL, NULL, 'vrfy-04cf7995-c910-4024-a419-0ac17e52be12', 1, 'verified', NULL, NULL, NULL, NULL),
(181, '2021-07-07 22:17:02', '2021-07-07 22:17:04', NULL, NULL, 'b_mcculloch1966@outlook.com', '$2y$10$yTmfsXOGz2PGoMcY8hTZkOnU3aTqnpRzml9XILI4ciU.kYUwgZmc6', 'Candidate', NULL, 0, 'Bryan', 'McCulloch', NULL, NULL, 'vrfy-9fdf7954-7f72-436a-9dbb-d904fe6bffa8', 0, 'sent', NULL, NULL, NULL, NULL),
(182, '2021-07-13 21:55:35', '2021-07-14 07:33:52', NULL, NULL, 'cailen0estey@gmail.com', '$2y$10$R/.M2opU7rzBxWs0ylpKN.AHFdywTAdlq0Zfq6TxLOf/8djtBqQam', 'Candidate', NULL, NULL, 'Cailen', 'Estey', '7809194235', NULL, 'vrfy-8f483cc1-ad1b-4518-b7a2-5494942c3964', 1, 'verified', NULL, NULL, NULL, NULL),
(183, '2021-07-14 15:53:13', '2021-07-14 16:13:35', NULL, NULL, 'gymworkout36@hotmail.com', '$2y$10$WWmUKvjc2k/j/lgx.EgWJ.KbNRpnRl0jHrjhGk/CFs.S7MBMYsQsa', 'Candidate', NULL, 0, 'Jason', 'Soper', NULL, NULL, 'vrfy-2cf86729-f995-425e-a6c0-3725fdb04e09', 1, 'verified', NULL, NULL, NULL, NULL),
(184, '2021-07-15 13:18:53', '2021-07-15 13:21:48', NULL, NULL, 'stephan.naf@gmail.com', '$2y$10$Y2zuDxHPXYcfJ5i2zCLHg.c1ziGHTyjGkdxmlY55BhTjSQN560qIq', 'Candidate', NULL, 0, 'Stephan', 'Naf', '4035068950', NULL, 'vrfy-7e96fb49-08ff-4ec7-80b1-4848d8dd3557', 1, 'verified', NULL, NULL, NULL, NULL),
(185, '2021-07-17 17:47:36', '2021-07-17 19:05:11', NULL, NULL, 'Drewzski@hotmail.com', '$2y$10$9bapW8p4ufQ5ZRxKYUm9le4BXXlPaO5SIwnYkES3PrFb4iQPOCByW', 'Candidate', NULL, 0, 'Drew', 'Fertuck', NULL, NULL, 'vrfy-28292a5b-ba22-437c-ae45-f50ab7d41c0a', 1, 'verified', NULL, NULL, NULL, NULL),
(186, '2021-07-18 04:47:27', '2021-07-18 04:48:03', NULL, NULL, 'atefrahman01@gmail.com', '$2y$10$mYkqwdrEwnK.0GldcMX8A.NIkG1LMY9.H8.xa4m3qeBs2nBngtVqi', 'Candidate', NULL, 0, 'Atef', 'Rahman', NULL, NULL, 'vrfy-e77b82c8-faa6-4ee3-a25f-b78b2b4f1a05', 0, 'sent', NULL, NULL, NULL, NULL),
(187, '2021-07-20 20:32:34', '2021-07-20 20:39:47', NULL, NULL, 'qharder@msn.com', '$2y$10$5OUcH6URalYzcK1BpM9GG..akuqPC7ZEMn2Z9fyfEglaq9urPQGUO', 'Candidate', NULL, 0, 'Quintin', 'Harder', '778 212 9804', NULL, 'vrfy-6e89f8ec-a306-43dc-8cb7-c0fbc7a8c991', 1, 'verified', NULL, NULL, NULL, NULL),
(188, '2021-07-23 08:05:25', '2021-07-23 08:08:35', NULL, NULL, 'nghiepcongngo@gmail.com', '$2y$10$aQEoHtdV5hpaq0FrdNfANOsrO1VFhkxGemiAMPK4MAPpwW7k2q36i', 'Candidate', NULL, 0, 'Nghiep', 'Ngo', '7807221970', NULL, 'vrfy-13d8f4b1-110a-4077-8f5d-c80d7030e59f', 1, 'verified', NULL, NULL, NULL, NULL),
(189, '2021-07-24 04:00:13', '2021-07-24 04:01:27', NULL, NULL, 'b_pachiorka@hotmail.com', '$2y$10$cUuTFifC0S6WKDv2rEqAH.u96G2hRt9.Xt7KaYaMljy/gYT8wRc/u', 'Candidate', NULL, 0, 'Bradley', 'Pachiorka', NULL, NULL, 'vrfy-ed02d2fa-85b8-4582-8455-52f81255b115', 1, 'verified', NULL, NULL, NULL, NULL),
(190, '2021-07-24 08:18:56', '2021-07-24 08:22:27', NULL, NULL, 'info.mansher@gmail.com', '$2y$10$UdtPhu05L4oWk88rWeYPBOENdNxwbXOmiJqqcV0QkayM135RU6Doe', 'Candidate', NULL, 0, 'Mansher', 'Singh', NULL, NULL, 'vrfy-659c481d-6a2d-4e8b-9d67-7006b567e0ab', 1, 'verified', NULL, NULL, NULL, NULL),
(191, '2021-07-26 13:20:15', '2021-07-26 13:21:04', NULL, NULL, 'Johnburger343@gmail.com', '$2y$10$GJoXaL7k.uWsZS4bzUb0muLvvZHy3MtUPD6eos31vWmx5DsAvrvrK', 'Candidate', NULL, 0, 'John', 'Burger', NULL, NULL, 'vrfy-265d7041-a15b-4acf-8b55-ecca55997ec6', 0, 'sent', NULL, NULL, NULL, NULL),
(192, '2021-07-28 00:46:10', '2021-07-28 00:47:15', NULL, NULL, 'willcahill40@gmail.com', '$2y$10$lC6hATuN7.IcLGKmhf7CUu7yj.F.z9sf3R.UHX9xVJsXVOVEjX2A6', 'Candidate', NULL, 0, 'William', 'Cahill', NULL, NULL, 'vrfy-863581eb-da46-484a-9d33-5d36580cf43f', 1, 'verified', NULL, NULL, NULL, NULL),
(193, '2021-08-02 05:55:18', '2021-08-02 05:56:37', NULL, NULL, 'nhasna@shaw.ca', '$2y$10$y73rsbwxmooLt5qIeqB8pO0rsseJ/kNYdT9/4J.AHNLSpQFdI2WAS', 'Candidate', NULL, 0, 'Nate', 'Hasna', NULL, NULL, 'vrfy-7d21b9df-cbee-40fc-83c5-dffee973ee16', 1, 'verified', NULL, NULL, NULL, NULL),
(194, '2021-08-04 05:42:44', '2021-08-11 15:35:16', NULL, NULL, 'megan@primusworkforce.com', '$2y$10$QfAOp2/woqP1hgLhlvOhw.k8gxsgjnKADUC4Yi8C9rtmhk3EYEnMu', 'Candidate', NULL, NULL, 'Megan', 'williams', '7802030753', NULL, 'vrfy-01ce8d84-c85d-4c39-900b-68d072f5571f', 1, 'verified', NULL, NULL, NULL, NULL),
(195, '2021-08-04 23:01:14', '2021-08-04 23:02:13', NULL, NULL, 'testmachine001@thinkorion.com', '$2y$10$R19ox1JVpXZo7tFhvWqdPOWeZ3b3hmThD7jGNigXbyBmurYQs0N1.', 'Candidate', NULL, NULL, 'Rayed', 'Chaudhry', '+12892424097', NULL, 'vrfy-e7a245cf-cf5a-490e-b674-1f9947e56101', 1, 'verified', NULL, NULL, NULL, NULL),
(196, '2021-08-04 23:12:45', '2021-08-04 23:12:45', NULL, '38', 'testmachine002@thinkorion.com', '$2y$10$7u4x6RDZlyk73B6Jept85eE2Tpx85SIG3pJVI588efQkqEXwhJ.gC', 'Employer', NULL, 1, 'Rayed', 'Chaudhry - Employer', '+12892424097', NULL, 'vrfy-883e63b5-ef5e-49b0-9482-2deaf1c29017', 1, 'verified', NULL, NULL, NULL, NULL),
(197, '2021-08-05 07:43:25', '2021-08-05 07:44:28', NULL, NULL, 'info@adsmonk.com', '$2y$10$KOUKpyFq0y8o73qwaReW5.mR0qBNSvgcoAeqgb7J55/A2V/uu70B6', 'Candidate', NULL, 0, 'Manno', 'Notermans', NULL, NULL, 'vrfy-fc9d8eaf-3716-4d90-98b4-4821d559a0bb', 1, 'verified', NULL, NULL, NULL, NULL),
(198, '2021-08-11 15:29:50', '2021-08-11 15:30:06', NULL, NULL, 'usamasaeed1988@hotmail.com', '$2y$10$Z3mMzZiu6zV4y5N0AcuP7O5C1U4WdQmIkZWO5ZDjVH8JdPVSk6D3S', 'Candidate', NULL, NULL, 'Usama', 'ch1', '+1 07808851373', NULL, 'vrfy-633c7aea-f67a-4bf2-b77a-ff5f8c74411a', 0, 'sent', NULL, NULL, NULL, NULL),
(199, '2021-08-12 16:24:06', '2021-08-12 16:44:09', NULL, NULL, 'sherrielynnoliver76@gmail.com', '$2y$10$QO5xjME5wB/1EYrnHb1gLO59dkzOgSOF6dqb./v4wzla7IQ3Q4BN6', 'Candidate', 139, 0, 'Sherrie', 'Oliver', '17094860151', NULL, 'vrfy-260b3950-d892-4009-96d0-24922531ba20', 1, 'verified', NULL, NULL, NULL, NULL),
(200, '2021-08-13 02:25:42', '2021-08-13 02:26:15', NULL, NULL, 'Khoumch@gmail.com', '$2y$10$D3NErpGG/E1AgdrTHHNQ9uXdx0VIwwDDUco.fC9v9XZSSQjZSpY2S', 'Candidate', NULL, 0, 'Hasna', 'Khoumch', NULL, NULL, 'vrfy-ce2099c3-e69f-4943-b5c3-b5d984e2ede1', 1, 'verified', NULL, NULL, NULL, NULL),
(201, '2021-08-15 19:29:45', '2021-08-15 19:30:32', NULL, NULL, 'malikandleeb18@gmail.com', '$2y$10$zUZ0fiDHLh6tMaUsfPKyqeOUyJq4whqytRvCm1vYp2G/X8/DYaPzW', 'Candidate', NULL, 0, 'Kashif', 'Mehmood', NULL, NULL, 'vrfy-611a4e23-f7df-4082-bdff-0c3ad432545f', 1, 'verified', NULL, NULL, NULL, NULL),
(202, '2021-08-31 08:43:09', '2021-08-31 08:44:04', NULL, NULL, 'sales@amperbros.ph', '$2y$10$PWfJ85PSLBW7CyBPdvz/2eyG9usvrwi1ln1l2Wzdh2XE54BTWy0r.', 'Candidate', NULL, NULL, 'asds', 'asdsa', '09193199055', NULL, 'vrfy-7547c9cf-7cce-4d87-a409-fb45beed30e6', 0, 'sent', NULL, NULL, NULL, NULL),
(203, '2021-09-03 13:30:13', '2021-09-03 13:36:42', NULL, NULL, 'claresawyer1995@hotmail.com', '$2y$10$3chZPHSCfoLz3DD2xnOAP.tMaKCZ32cekuBL4Jt8fOqDq8ZNUT6TO', 'Candidate', NULL, 0, 'Clare', 'Sawyer', NULL, NULL, 'vrfy-9ec5414f-813b-4b65-9835-4d456b3f8f7d', 1, 'verified', NULL, NULL, NULL, NULL),
(204, '2021-09-06 20:40:17', '2021-09-06 20:41:17', NULL, NULL, 'rasarth@gmail.com', '$2y$10$wxjAWwo03lAEvcExanctRuK6Tpfo2N4GvpCHPoJHb51/0E8CuPJuW', 'Candidate', NULL, 0, 'Sarthk', 'Rana', NULL, NULL, 'vrfy-6a6fe1ec-954a-4467-8f58-08edf6a844a3', 1, 'verified', NULL, NULL, NULL, NULL),
(205, '2021-09-07 16:33:08', '2021-09-07 16:34:04', NULL, NULL, 'Paul@primusworkforce.com', '$2y$10$lTSoOMhqV5BMT6km03/hJOAbwvhO7IEI0xd2DdKaATg8nCXmh.hhK', 'Candidate', NULL, 0, 'Paul', 'Smith', NULL, NULL, 'vrfy-cf0ca276-1acc-4e9c-bd6c-39d91bf6745c', 0, 'sent', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_employees`
--

CREATE TABLE `user_employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_files`
--

CREATE TABLE `user_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_files`
--

INSERT INTO `user_files` (`id`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `type`, `name`, `original_name`, `size`) VALUES
(1, '2021-01-04 17:51:12', '2021-03-30 04:26:08', '2021-03-30 04:26:08', 54, 'ticket', 'ticket-54-1609782672.jpeg', 'B2E25D0F-C5EE-4BA1-A4AF-1545080860C2.jpeg', 3731180),
(2, '2021-01-04 17:53:43', '2021-03-30 05:05:18', '2021-03-30 05:05:18', 54, 'ticket', 'ticket-54-1609782823.jpeg', 'E8DC7C1C-DE62-43F6-802C-9E0C544C3CC5.jpeg', 3731180),
(3, '2021-01-04 18:12:28', '2021-01-04 18:12:28', NULL, 54, 'ticket', 'ticket-54-1609783948.epub', 'resume.epub', 5595),
(4, '2021-01-08 18:57:20', '2021-01-08 18:57:20', NULL, 57, 'resume', 'resume-57-1610132240.pdf', 'Edomi O. Emmanuel CV.pdf', 308069),
(5, '2021-01-09 17:17:50', '2021-01-09 17:17:50', NULL, 58, 'resume', 'resume-58-1610212670.docx', 'Landon Schaffer - Cover Letter.docx', 18161),
(6, '2021-01-09 17:18:18', '2021-01-09 17:18:18', NULL, 58, 'resume', 'resume-58-1610212698.docx', 'Landon Schaffer - Resume.docx', 20079),
(7, '2021-01-09 17:18:30', '2021-01-09 17:18:30', NULL, 58, 'ticket', 'ticket-58-1610212710.pdf', 'erwcard21361907-2.pdf', 9470),
(8, '2021-01-09 17:20:16', '2021-01-09 17:20:16', NULL, 58, 'avatar', 'avatar-58-1610212816.jpeg', 'F2240052-57E4-4437-88AB-B4667D1BA72E.jpeg', 638767),
(9, '2021-01-09 17:21:34', '2021-01-09 17:21:34', NULL, 58, 'avatar', 'avatar-58-1610212894.jpeg', 'E615BD16-FA1F-4CD6-8289-450A9F625B32.jpeg', 618059),
(10, '2021-01-09 19:38:40', '2021-01-09 19:38:40', NULL, 61, 'resume', 'resume-61-1610221120.pdf', 'Ali Adel_Resume.pdf', 165292),
(11, '2021-01-11 06:40:42', '2021-01-11 06:40:42', NULL, 62, 'avatar', 'avatar-62-1610347242.jpeg', '55564466_10215536485460153_4430663931563868160_n.jpg', 43288),
(12, '2021-01-13 14:22:57', '2021-01-13 14:22:57', NULL, 66, 'resume', 'resume-66-1610547777.docx', 'MGotthelf_Resume_Dec2020-2.docx', 33212),
(13, '2021-01-17 04:06:06', '2021-01-17 04:06:06', NULL, 68, 'resume', 'resume-68-1610856366.pdf', 'Resume Shekey.pdf', 28602),
(14, '2021-01-18 04:50:24', '2021-01-18 04:50:24', NULL, 60, 'resume', 'resume-60-1610945424.docx', 'Tebb, Dustin - heavy Equipment Technician .docx', 18840),
(15, '2021-01-18 16:56:50', '2021-01-18 16:56:50', NULL, 69, 'resume', 'resume-69-1610989010.pdf', 'Nathan Lee -Labourer.pdf', 121986),
(16, '2021-01-18 16:58:25', '2021-01-18 16:58:25', NULL, 69, 'ticket', 'ticket-69-1610989105.pdf', 'Lee, N. SAFETY TICKETS.pdf', 465958),
(17, '2021-01-18 16:58:35', '2021-01-18 16:58:35', NULL, 69, 'ticket', 'ticket-69-1610989115.jpeg', 'Lee, N. Confined Space & Fall Pro.JPG', 126740),
(18, '2021-01-18 18:30:25', '2021-01-18 18:30:25', NULL, 71, 'resume', 'resume-71-1610994625.docx', 'Roy_H_RES1azz.docx', 33710),
(19, '2021-01-18 18:30:47', '2021-01-18 18:30:47', NULL, 71, 'ticket', 'ticket-71-1610994647.pdf', 'Roy_Stevenson_First Aid_2019.pdf', 201914),
(20, '2021-01-18 18:31:13', '2021-01-18 18:31:13', NULL, 71, 'ticket', 'ticket-71-1610994673.jpeg', 'Roy H2S Alive 2020.jpg', 4851661),
(21, '2021-01-18 18:32:00', '2021-01-18 18:32:00', NULL, 71, 'ticket', 'ticket-71-1610994720.pdf', 'Roy_Stevenson_First Aid_2019.pdf', 201914),
(22, '2021-01-27 23:49:20', '2021-01-27 23:49:20', NULL, 75, 'resume', 'resume-75-1611791360.pdf', 'CV++Mike+Lewis++2020.pdf', 99832),
(23, '2021-01-27 23:49:47', '2021-01-27 23:49:47', NULL, 75, 'ticket', 'ticket-75-1611791387.jpeg', '20190427_103517.jpg', 2446526),
(24, '2021-02-01 18:14:42', '2021-02-01 18:14:42', NULL, 79, 'resume', 'resume-79-1612203282.docx', 'BRAD LAWRENCE  copy copy.docx', 17799),
(25, '2021-02-05 23:00:04', '2021-02-05 23:00:04', NULL, 86, 'resume', 'resume-86-1612566004.pdf', 'jrachocv1.pdf', 192926),
(26, '2021-02-08 19:57:39', '2021-02-08 19:57:39', NULL, 87, 'resume', 'resume-87-1612814259.pdf', 'KalePrystumaResume_1.pdf', 137480),
(27, '2021-02-11 15:12:44', '2021-02-11 15:12:44', NULL, 93, 'resume', 'resume-93-1613056364.pdf', 'Rayed Chaudhry Resume.pdf', 63833),
(28, '2021-02-11 15:12:53', '2021-02-11 15:12:53', NULL, 93, 'ticket', 'ticket-93-1613056373.pdf', 'Rayed Chaudhry Resume.pdf', 63833),
(29, '2021-02-11 15:13:02', '2021-02-11 15:13:02', NULL, 93, 'ticket', 'ticket-93-1613056382.pdf', 'RayedStatementFeb2019.pdf', 92466),
(30, '2021-02-14 07:51:26', '2021-02-14 07:51:26', NULL, 102, 'resume', 'resume-102-1613289086.docx', 'GERVAIS OUEFIO  CHEMICAL CLEANING FIELD LAB TECH.docx', 21497),
(31, '2021-02-15 19:37:38', '2021-02-15 19:37:38', NULL, 107, 'resume', 'resume-107-1613417858.docx', 'NEWRESUME LES.docx', 17346),
(32, '2021-02-16 06:09:13', '2021-02-16 06:09:13', NULL, 110, 'ticket', 'ticket-110-1613455753.jpeg', 'H2S Alive.jpg', 3791577),
(33, '2021-02-16 06:09:29', '2021-02-16 06:09:29', NULL, 110, 'ticket', 'ticket-110-1613455769.jpeg', 'standard First AID.jpg', 3524576),
(34, '2021-02-16 13:06:37', '2021-02-16 13:06:37', NULL, 110, 'resume', 'resume-110-1613480797.pdf', 'Chika_Ibegbu.pdf', 5453),
(35, '2021-02-17 18:19:12', '2021-02-17 18:19:12', NULL, 73, 'resume', 'resume-73-1613585952.pdf', 'Mitchell Macdonald Resume 2021 .pdf', 133462),
(36, '2021-02-19 05:07:01', '2021-02-19 05:07:01', NULL, 112, 'ticket', 'ticket-112-1613711221.jpeg', 'Screenshot_20210217-111118_Gallery.jpg', 667187),
(37, '2021-03-03 20:10:58', '2021-03-03 20:10:58', NULL, 121, 'resume', 'resume-121-1614802258.pdf', 'RESUME - Witold__Balanda.pdf', 150103),
(38, '2021-03-03 20:15:56', '2021-03-03 20:15:56', NULL, 121, 'ticket', 'ticket-121-1614802556.jpeg', 'Journeyman ticket.jpg', 3354817),
(39, '2021-03-04 08:28:13', '2021-03-04 08:28:13', NULL, 110, 'ticket', 'ticket-110-1614846493.pdf', 'eCommerce-Marketing-Ultimate-Pinterest-Guide-For-Beginners-Think-Orion.pdf', 3517203),
(40, '2021-03-04 22:36:40', '2021-03-04 22:36:40', NULL, 109, 'resume', 'resume-109-1614897400.txt', 'job_subcategory_items.csv', 15749),
(41, '2021-03-04 22:36:52', '2021-03-04 22:36:52', NULL, 109, 'ticket', 'ticket-109-1614897412.txt', 'job_types.csv', 2161),
(42, '2021-03-09 15:33:14', '2021-03-09 15:33:14', NULL, 130, 'resume', 'resume-130-1615303994.pdf', '😁 J RESUME .pdf', 51598),
(43, '2021-03-09 18:25:35', '2021-03-09 18:25:35', NULL, 36, 'ticket', 'ticket-36-1615314335.jpeg', 'mask_3d_copy_2048x.jpg', 80696),
(44, '2021-03-09 18:25:45', '2021-03-09 18:25:45', NULL, 36, 'ticket', 'ticket-36-1615314345.png', 'Image from iOS (2).png', 55479),
(45, '2021-03-09 23:59:07', '2021-03-09 23:59:07', NULL, 132, 'resume', 'resume-132-1615334347.txt', 'license_certificate_XHD6U7L42W (1).txt', 1224),
(46, '2021-03-12 00:34:26', '2021-03-12 00:34:26', NULL, 137, 'resume', 'resume-137-1615509266.docx', '(wA file) Oghenemarho Okoro Resume (updated).docx', 23111),
(47, '2021-03-15 13:39:52', '2021-03-15 13:39:52', NULL, 141, 'resume', 'resume-141-1615815592.pdf', '9563369_1588312743807Ecommerce-Blueprint.pdf', 3184771),
(48, '2021-03-15 13:39:59', '2021-03-15 13:39:59', NULL, 141, 'ticket', 'ticket-141-1615815599.jpeg', 'documentforneo.jpeg', 107035),
(49, '2021-03-15 19:17:00', '2021-03-15 19:17:00', NULL, 147, 'resume', 'resume-147-1615835820.docx', 'Akpan Aniefiok  Resume_ Operator@Primus.docx.docx', 36816),
(50, '2021-03-15 19:17:28', '2021-03-15 19:17:28', NULL, 147, 'ticket', 'ticket-147-1615835848.pdf', 'Aniefiok Akpan ABSA 3rd class certificate.pdf', 1026486),
(51, '2021-03-19 01:16:04', '2021-03-19 01:16:04', NULL, 109, 'avatar', 'avatar-109-1616116564.jpeg', 'pp.jfif', 68477),
(52, '2021-03-25 11:38:18', '2021-03-25 11:38:18', NULL, 152, 'resume', 'resume-152-1616672298.pdf', 'Fraser, Keith Resume May 6 2020 (1)(1)(1).pdf', 163600),
(53, '2021-03-29 22:29:16', '2021-03-29 22:29:16', NULL, 150, 'resume', 'resume-150-1617056956.txt', 'OFL.txt', 4480),
(54, '2021-03-29 22:33:03', '2021-03-29 22:33:03', NULL, 150, 'resume', 'resume-150-1617057183.txt', 'resume-150-1617056956.txt', 4480),
(55, '2021-03-29 23:47:09', '2021-03-29 23:47:09', NULL, 150, 'resume', 'resume-150-1617061629.txt', 'License premium.txt', 1116),
(56, '2021-03-30 00:01:00', '2021-03-30 00:01:00', NULL, 150, 'resume', 'resume-150-1617062460.txt', 'License premium.txt', 1116),
(57, '2021-03-30 00:04:32', '2021-03-30 00:04:32', NULL, 150, 'resume', 'resume-150-1617062672.txt', '.gitattributes', 66),
(58, '2021-03-30 00:05:34', '2021-03-30 00:05:34', NULL, 150, 'resume', 'resume-150-1617062734.txt', '.gitattributes', 66),
(59, '2021-03-30 00:07:12', '2021-03-30 00:07:12', NULL, 150, 'resume', 'resume-150-1617062832.txt', '.gitattributes', 66),
(60, '2021-03-30 00:24:51', '2021-03-30 00:24:51', NULL, 150, 'resume', 'resume-150-1617063891.txt', 'hello world', 66),
(61, '2021-03-30 00:26:11', '2021-03-30 00:26:11', NULL, 150, 'resume', 'resume-150-1617063971.txt', 'hello world', 66),
(62, '2021-03-30 00:39:17', '2021-03-30 00:39:17', NULL, 150, 'resume', 'resume-150-1617064757.txt', 'hello world', 66),
(63, '2021-03-30 01:17:22', '2021-03-30 02:24:23', '2021-03-30 02:24:23', 150, 'ticket', 'ticket-150-1617067042.txt', 'hello world', 66),
(64, '2021-03-30 01:36:52', '2021-03-30 01:36:52', NULL, 150, 'resume', 'resume-150-1617068212.txt', 'hello world', 66),
(65, '2021-03-30 01:37:03', '2021-03-30 01:37:03', NULL, 150, 'resume', 'resume-150-1617068223.txt', 'resume-150-1617056956.txt', 4480),
(66, '2021-03-30 01:45:38', '2021-03-30 01:45:38', NULL, 150, 'resume', 'resume-150-1617068738.txt', 'License premium.txt', 1116),
(67, '2021-03-30 01:50:50', '2021-03-30 02:24:33', '2021-03-30 02:24:33', 150, 'ticket', 'ticket-150-1617069050.', 'newfile.txt', 0),
(68, '2021-03-30 02:17:29', '2021-03-30 02:24:44', '2021-03-30 02:24:44', 150, 'ticket', 'ticket-150-1617070649.', 'newfile.txt', 0),
(69, '2021-03-30 02:17:43', '2021-03-30 02:29:49', '2021-03-30 02:29:49', 150, 'ticket', 'ticket-150-1617070663.txt', 'License premium.txt', 1116),
(70, '2021-03-30 02:20:56', '2021-03-30 02:41:07', '2021-03-30 02:41:07', 150, 'ticket', 'ticket-150-1617070856.txt', 'License premium.txt', 1116),
(71, '2021-03-30 02:30:05', '2021-03-30 02:30:08', '2021-03-30 02:30:08', 150, 'ticket', 'ticket-150-1617071405.', 'newfile.txt', 0),
(72, '2021-03-30 02:33:29', '2021-03-30 02:33:31', '2021-03-30 02:33:31', 150, 'ticket', 'ticket-150-1617071609.', 'newfile.txt', 0),
(73, '2021-03-30 02:40:25', '2021-03-30 02:40:27', '2021-03-30 02:40:27', 150, 'ticket', 'ticket-150-1617072025.', 'newfile.txt', 0),
(74, '2021-03-30 02:40:37', '2021-03-30 02:40:39', '2021-03-30 02:40:39', 150, 'ticket', 'ticket-150-1617072037.', 'newfile.txt', 0),
(75, '2021-03-30 02:41:05', '2021-03-30 02:58:38', '2021-03-30 02:58:38', 150, 'ticket', 'ticket-150-1617072065.', 'newfile.txt', 0),
(76, '2021-03-30 02:41:36', '2021-03-30 02:58:35', '2021-03-30 02:58:35', 150, 'ticket', 'ticket-150-1617072096.txt', 'License premium.txt', 1116),
(77, '2021-03-30 02:42:05', '2021-03-30 02:42:16', '2021-03-30 02:42:16', 150, 'ticket', 'ticket-150-1617072125.', 'New Text Document.txt', 0),
(78, '2021-03-30 02:42:37', '2021-03-30 02:54:24', '2021-03-30 02:54:24', 150, 'ticket', 'ticket-150-1617072157.txt', 'resume-150-1617056956.txt', 4480),
(79, '2021-03-30 02:42:46', '2021-03-30 02:42:49', '2021-03-30 02:42:49', 150, 'ticket', 'ticket-150-1617072166.txt', 'License premium.txt', 1116),
(80, '2021-03-30 02:58:45', '2021-03-30 02:59:05', '2021-03-30 02:59:05', 150, 'ticket', 'ticket-150-1617073125.txt', 'License premium.txt', 1116),
(81, '2021-03-30 02:58:51', '2021-03-30 02:58:55', '2021-03-30 02:58:55', 150, 'ticket', 'ticket-150-1617073131.', 'newfile.txt', 0),
(82, '2021-03-30 02:59:03', '2021-03-30 02:59:03', NULL, 150, 'ticket', 'ticket-150-1617073143.', 'newfile.txt', 0),
(83, '2021-03-30 02:59:26', '2021-03-30 02:59:26', NULL, 150, 'ticket', 'ticket-150-1617073166.', 'newfile.txt', 0),
(84, '2021-03-30 02:59:32', '2021-03-30 02:59:40', '2021-03-30 02:59:40', 150, 'ticket', 'ticket-150-1617073172.', 'New Text Document.txt', 0),
(85, '2021-03-30 02:59:37', '2021-03-30 02:59:37', NULL, 150, 'ticket', 'ticket-150-1617073177.txt', 'resume-150-1617056956.txt', 4480),
(86, '2021-03-30 04:27:00', '2021-03-30 04:27:00', NULL, 150, 'ticket', 'ticket-150-1617078420.txt', 'License premium.txt', 1116),
(87, '2021-03-30 05:05:38', '2021-03-30 05:05:38', NULL, 150, 'ticket', 'ticket-150-1617080738.', 'newfile.txt', 0),
(88, '2021-04-06 01:07:22', '2021-04-06 01:07:37', '2021-04-06 01:07:37', 36, 'ticket', 'ticket-36-1617671242.docx', 'Primus- Bugs.docx', 559708),
(89, '2021-04-15 08:35:32', '2021-04-15 08:35:32', NULL, 158, 'ticket', 'ticket-158-1618475732.pdf', '6 Common Messaging Mistakes and How to Avoid Them.pdf', 233842),
(90, '2021-04-15 08:35:53', '2021-04-21 15:22:57', '2021-04-21 15:22:57', 158, 'resume', 'resume-158-1618475753.pdf', 'Content Strategy Myk Pono.pdf', 9587826),
(91, '2021-04-15 08:36:20', '2021-04-15 08:36:20', NULL, 158, 'ticket', 'ticket-158-1618475780.pdf', 'The Ideal First Sales Meeting Agenda and Presentation.pdf', 137409),
(92, '2021-04-15 08:36:56', '2021-04-15 08:36:56', NULL, 158, 'ticket', 'ticket-158-1618475816.pdf', '6 Common Messaging Mistakes and How to Avoid Them.pdf', 233842),
(93, '2021-04-15 08:38:08', '2021-04-15 08:38:08', NULL, 158, 'avatar', 'avatar-158-1618475888.png', 'circle-cropped (6).png', 165108),
(94, '2021-04-15 17:36:53', '2021-04-15 17:36:53', NULL, 159, 'resume', 'resume-159-1618508213.docx', 'David White resume 2018 (1).docx', 17982),
(95, '2021-04-15 17:37:22', '2021-04-15 17:37:22', NULL, 159, 'ticket', 'ticket-159-1618508242.jpeg', '202104051036561000.jpg', 433003),
(96, '2021-04-17 20:43:15', '2021-04-21 15:21:56', NULL, 161, 'resume', 'resume-161-1618692195.docx', 'RESUME new1.docx', 23939),
(97, '2021-04-17 20:43:57', '2021-04-17 20:43:57', NULL, 161, 'ticket', 'ticket-161-1618692237.pdf', 'safety certificates.pdf', 828736),
(98, '2021-04-17 20:44:31', '2021-04-17 20:44:31', NULL, 161, 'ticket', 'ticket-161-1618692271.pdf', 'WHMIS 2015.pdf', 117177),
(99, '2021-04-20 04:58:22', '2021-04-20 04:58:22', NULL, 64, 'avatar', 'avatar-64-1618894702.jpeg', 'forlaget_johanna_holmstrom_2017_webres-001.jpg', 912409),
(100, '2021-04-21 14:55:06', '2021-04-21 14:55:06', NULL, 158, 'avatar', 'avatar-158-1619016906.png', 'circle-cropped (6).png', 165108),
(101, '2021-04-22 08:45:15', '2021-04-22 08:45:15', NULL, 163, 'avatar', 'avatar-163-1619081115.jpeg', 'FB_IMG_1610142999657.jpg', 40903),
(102, '2021-05-01 03:51:36', '2021-05-01 03:51:36', NULL, 165, 'resume', 'resume-165-1619841096.pdf', 'Resume.pdf', 47213),
(103, '2021-05-07 20:10:50', '2021-05-07 20:10:50', NULL, 170, 'resume', 'resume-170-1620418250.pdf', 'Rayed Chaudhry Resume.pdf', 63833),
(104, '2021-05-07 20:11:29', '2021-05-07 20:11:29', NULL, 170, 'ticket', 'ticket-170-1620418289.pdf', 'Rayed Chaudhry Resume.pdf', 63833),
(105, '2021-05-07 20:11:53', '2021-05-07 20:12:06', '2021-05-07 20:12:06', 170, 'ticket', 'ticket-170-1620418313.pdf', '2. Iqama.pdf', 303380),
(106, '2021-05-12 17:02:21', '2021-05-12 17:02:21', NULL, 173, 'resume', 'resume-173-1620838941.docx', 'Kaitlin Resume.docx', 32590),
(107, '2021-05-25 16:17:50', '2021-05-25 16:17:50', NULL, 175, 'resume', 'resume-175-1621959470.pdf', 'Benjamin_A_Williams_Resume_New.pdf', 107553),
(108, '2021-06-01 19:59:39', '2021-06-01 19:59:39', NULL, 174, 'resume', 'resume-174-1622577579.docx', 'Ryan[15491] 2.docx', 10061),
(109, '2021-06-21 16:25:38', '2021-06-21 16:25:38', NULL, 108, 'ticket', 'ticket-108-1624292738.docx', '2020 resume 2.docx', 20052),
(110, '2021-06-21 16:25:46', '2021-06-21 16:25:46', NULL, 108, 'ticket', 'ticket-108-1624292746.pdf', 'N9494089 Dynacare Report.pdf', 31294),
(111, '2021-06-21 16:25:52', '2021-06-21 16:25:52', NULL, 108, 'ticket', 'ticket-108-1624292752.pdf', 'N9494089 Wildeman.pdf', 156586),
(112, '2021-06-21 16:25:59', '2021-06-21 16:25:59', NULL, 108, 'ticket', 'ticket-108-1624292759.jpeg', 'Bear Aware.jpg', 388463),
(113, '2021-06-21 16:26:05', '2021-06-21 16:28:15', '2021-06-21 16:28:15', 108, 'ticket', 'ticket-108-1624292765.jpeg', 'tickets 2.jpg', 590658),
(114, '2021-06-21 16:26:08', '2021-06-21 16:28:13', '2021-06-21 16:28:13', 108, 'ticket', 'ticket-108-1624292768.jpeg', 'tickets.jpg', 561282),
(115, '2021-06-21 16:27:37', '2021-06-21 16:27:37', NULL, 108, 'ticket', 'ticket-108-1624292857.jpeg', 'Anthony Wildeman Bank Info.jpg', 76072),
(116, '2021-06-21 16:27:41', '2021-06-21 16:27:41', NULL, 108, 'ticket', 'ticket-108-1624292861.zip', 'Blackstone, Husky - Anthony Wildemen.zip', 5144954),
(117, '2021-06-21 16:27:49', '2021-06-21 16:27:49', NULL, 108, 'ticket', 'ticket-108-1624292869.jpeg', 'Badge ID Picture.jpg', 1191001),
(118, '2021-06-21 16:28:10', '2021-06-21 16:28:10', NULL, 108, 'ticket', 'ticket-108-1624292890.jpeg', 'CSO.jpg', 1601434),
(119, '2021-06-21 16:28:18', '2021-06-21 16:28:18', NULL, 108, 'ticket', 'ticket-108-1624292898.jpeg', 'H2S.jpg', 388463),
(120, '2021-06-21 16:28:21', '2021-06-21 16:28:21', NULL, 108, 'ticket', 'ticket-108-1624292901.jpeg', 'HCSO.jpg', 277057),
(121, '2021-06-21 16:28:24', '2021-06-21 16:28:24', NULL, 108, 'ticket', 'ticket-108-1624292904.jpeg', 'JSA.jpg', 285033),
(122, '2021-06-21 16:28:28', '2021-06-21 16:28:28', NULL, 108, 'ticket', 'ticket-108-1624292908.jpeg', 'LSR.jpg', 127124),
(123, '2021-06-21 16:28:35', '2021-06-21 16:28:35', NULL, 108, 'ticket', 'ticket-108-1624292915.jpeg', 'sso.jpg', 117947),
(124, '2021-06-21 16:28:37', '2021-06-21 16:28:37', NULL, 108, 'ticket', 'ticket-108-1624292917.jpeg', 'SSWP.jpg', 257097),
(125, '2021-06-21 16:28:42', '2021-06-21 16:28:42', NULL, 108, 'ticket', 'ticket-108-1624292922.pdf', 'Confined space.pdf', 1548017),
(126, '2021-06-23 07:16:58', '2021-06-23 07:16:58', NULL, 179, 'resume', 'resume-179-1624432618.pdf', 'ERIC KWAKU ASSUMAN- 21.pdf', 407834),
(127, '2021-06-23 07:20:09', '2021-06-23 07:20:09', NULL, 179, 'ticket', 'ticket-179-1624432809.jpeg', 'ERIC KWAKU ASSUMAN BSC.jpg', 4385068),
(128, '2021-07-13 21:56:18', '2021-07-13 21:56:18', NULL, 182, 'resume', 'resume-182-1626213378.docx', 'Cailens Resume 2021.docx', 30602),
(129, '2021-07-14 16:14:35', '2021-07-14 16:14:35', NULL, 183, 'resume', 'resume-183-1626279275.pdf', 'Jason-Soper-4.pdf', 27070),
(130, '2021-07-14 16:21:33', '2021-07-14 16:21:33', NULL, 183, 'ticket', 'ticket-183-1626279693.pdf', '20210311_170337.jpg.pdf', 5275072),
(131, '2021-07-20 20:43:06', '2021-07-20 20:43:06', NULL, 187, 'resume', 'resume-187-1626813786.pdf', 'Quintin.pdf', 93101),
(132, '2021-07-23 08:10:07', '2021-07-23 08:10:07', NULL, 188, 'resume', 'resume-188-1627027807.doc', 'Resume1.doc', 58880),
(133, '2021-07-24 08:23:41', '2021-07-24 08:23:41', NULL, 190, 'resume', 'resume-190-1627115021.pdf', 'Mansher-Singh 21jul21.pdf', 65887),
(134, '2021-08-04 23:07:08', '2021-08-04 23:07:16', '2021-08-04 23:07:16', 195, 'resume', 'resume-195-1628118428.pdf', '2. Iqama.pdf', 303380),
(135, '2021-08-04 23:07:46', '2021-08-04 23:07:55', '2021-08-04 23:07:55', 195, 'ticket', 'ticket-195-1628118466.pdf', '2Crazy - Overview PAID Ignition with Appendix.pdf', 237109),
(136, '2021-08-04 23:08:00', '2021-08-04 23:08:00', NULL, 195, 'ticket', 'ticket-195-1628118480.pdf', '2. Iqama.pdf', 303380),
(137, '2021-08-04 23:08:05', '2021-08-04 23:08:05', NULL, 195, 'ticket', 'ticket-195-1628118485.png', '3 Amigos ads Spanish (1).png', 1170344),
(138, '2021-08-12 16:30:20', '2021-08-12 16:30:20', NULL, 199, 'resume', 'resume-199-1628785820.pdf', 'Resume & References.pdf', 64429),
(139, '2021-08-12 16:44:09', '2021-08-12 16:44:09', NULL, 199, 'avatar', 'avatar-199-1628786649.jpeg', 'Screenshot_20210513-171308_Snapchat.jpg', 90867),
(140, '2021-09-06 20:41:47', '2021-09-06 20:41:47', NULL, 204, 'resume', 'resume-204-1630960907.doc', 'Sarth Rana (Canada) .doc', 59904);

-- --------------------------------------------------------

--
-- Table structure for table `user_logs`
--

CREATE TABLE `user_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(250) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `description` varchar(250) NOT NULL,
  `outcome` varchar(250) DEFAULT NULL,
  `logged_by` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_logs`
--

INSERT INTO `user_logs` (`id`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `type`, `date`, `time`, `description`, `outcome`, `logged_by`) VALUES
(1, '2020-12-18 12:33:05', '2020-12-18 12:33:05', NULL, 41, 'sms', '0000-00-00', '00:00:00', 'This is an automated log by system. Triggered on SEND SMS.', NULL, 5),
(2, '2020-12-18 12:33:20', '2020-12-18 12:33:20', NULL, 41, 'email', '0000-00-00', '00:00:00', 'This is an automated log by system. Triggered on SEND EMAIL.', NULL, 5),
(3, '2021-08-04 23:02:32', '2021-08-04 23:02:32', NULL, 195, 'email', '0000-00-00', '00:00:00', 'This is an automated log by system. Triggered on SEND EMAIL.', NULL, 1),
(4, '2021-08-04 23:03:45', '2021-08-04 23:03:45', NULL, 195, 'sms', '0000-00-00', '00:00:00', 'This is an automated log by system. Triggered on SEND SMS.', NULL, 1),
(5, '2021-08-11 15:32:00', '2021-08-11 15:32:00', NULL, 198, 'sms', '0000-00-00', '00:00:00', 'This is an automated log by system. Triggered on SEND SMS.', NULL, 2),
(6, '2021-08-11 15:38:41', '2021-08-11 15:38:41', NULL, 194, 'sms', '0000-00-00', '00:00:00', 'This is an automated log by system. Triggered on SEND SMS.', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_resumes`
--

CREATE TABLE `user_resumes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_available` date DEFAULT NULL,
  `location` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `file_avatar_id` bigint(20) UNSIGNED DEFAULT NULL,
  `file_resume_id` bigint(20) UNSIGNED DEFAULT NULL,
  `file_tickets_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_resumes`
--

INSERT INTO `user_resumes` (`id`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `first_name`, `last_name`, `email`, `phone`, `date_available`, `location`, `content`, `file_avatar_id`, `file_resume_id`, `file_tickets_id`) VALUES
(1, '2020-12-14 17:42:08', '2020-12-14 17:42:32', NULL, 29, 'Ikeee', 'Chaudhry', 'testmachine004@thinkorion.com', '', '2020-12-16', 'Alberta', 'Oke please', NULL, NULL, NULL),
(2, '2020-12-14 17:43:59', '2020-12-14 17:43:59', NULL, 30, 'Erikaaa', 'Gekkie', 'testmachine005@thinkorion.com', '', NULL, '', NULL, NULL, NULL, NULL),
(3, '2020-12-14 17:44:34', '2020-12-14 17:44:34', NULL, 31, 'Erikaaaaa', 'last', 'testmachine006@thinkorion.com', '', NULL, '', NULL, NULL, NULL, NULL),
(4, '2020-12-17 09:31:06', '2020-12-17 09:31:06', NULL, 39, 'Rayed', 'Chaudhry', 'rayedchaudhry@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(5, '2020-12-18 12:30:33', '2021-04-06 01:07:22', NULL, 36, 'James', 'Guzman', 'jamguzm95@gmail.com', '', NULL, '', NULL, NULL, NULL, 88),
(6, '2020-12-18 12:31:51', '2020-12-18 12:32:21', NULL, 41, 'Manno', 'Notermans', 'finance@thinkorion.com', '', '2020-12-18', 'Check', 'Hey how are you!', NULL, NULL, NULL),
(7, '2020-12-22 16:52:33', '2020-12-22 16:52:33', NULL, 46, 'Rayed-candidate', 'Candidate', 'testmachine013@thinkorion.com', '', NULL, '', NULL, NULL, NULL, NULL),
(8, '2020-12-22 17:13:17', '2020-12-22 17:13:17', NULL, 47, 'rayed-test', 'chaudhry', 'testmachine015@thinkorion.com', '', NULL, '', NULL, NULL, NULL, NULL),
(9, '2020-12-22 17:20:58', '2020-12-22 17:20:58', NULL, 33, 'Rayed', 'Chaudhry', 'testmachine007@thinkorion.com', '', NULL, '', NULL, NULL, NULL, NULL),
(10, '2020-12-22 17:21:12', '2020-12-22 17:21:12', NULL, 38, 'Rayed', 'Chaudhry', 'testmachine009@thinkorion.com', '', NULL, '', NULL, NULL, NULL, NULL),
(11, '2020-12-29 16:13:44', '2020-12-29 16:13:44', NULL, 49, 'SAMSON', 'BORGES', 'sldjmix@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(12, '2020-12-29 21:25:47', '2020-12-29 21:25:47', NULL, 50, 'Amric', 'Paul', 'amric@outorigin.com', '', NULL, '', NULL, NULL, NULL, NULL),
(13, '2020-12-30 17:11:25', '2020-12-30 17:11:25', NULL, 53, 'Abbas', 'AMz', 'abbas@amzonestep.com', '', NULL, '', NULL, NULL, NULL, NULL),
(14, '2021-01-04 17:48:59', '2021-01-04 18:29:39', NULL, 54, 'Clinton', 'Kassian', 'Ckassian7@me.com', '', '2021-01-04', 'sherwood park', 'Been in the Oil and Gas for 15 years 8 years as a plant operator at Gibsons Energy and the last few at clean Harbors.\nHave done some scaffolding and other labour jobs.', NULL, NULL, 3),
(15, '2021-01-08 18:49:02', '2021-01-08 18:57:20', NULL, 57, 'Emmanuel Ogheneviyeze', 'Edomi', 'edomiemmanuel@gmail.com', '', '2021-01-25', 'Nigeria', 'Energized, Organized, good leadership style, time and data management, and always pay attention to details.', NULL, 4, NULL),
(16, '2021-01-09 07:09:29', '2021-01-09 07:09:29', NULL, 59, 'Mark', 'Houlihan', 'markhoulihan82@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(17, '2021-01-09 17:17:33', '2021-01-09 17:18:30', NULL, 58, 'Landon', 'Schaffer', 'landonschaffer@gmail.com', '', NULL, '', NULL, NULL, 6, 7),
(18, '2021-01-09 17:26:03', '2021-01-18 04:50:24', NULL, 60, 'Dustin', 'Tebb', 'dustin.tebb@live.com', '', NULL, '', NULL, NULL, 14, NULL),
(19, '2021-01-09 19:37:22', '2021-01-09 19:38:40', NULL, 61, 'Ali', 'Adel', 'ali.aladel02@gmail.com', '', '2021-02-01', 'Calgary, AB', NULL, NULL, 10, NULL),
(20, '2021-01-13 14:22:31', '2021-01-13 14:24:33', NULL, 66, 'Martin', 'Gotthelf', 'gotthelfm3@live.ca', '', NULL, '', 'I am looking for accounts payable, payroll, or a combination thereof.', NULL, 12, NULL),
(21, '2021-01-14 04:09:24', '2021-01-14 04:09:24', NULL, 67, 'Haroon', 'Rasheed', 'haroon131@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(22, '2021-01-17 04:05:40', '2021-01-17 04:06:07', NULL, 68, 'Patrick', 'Shekey', 'patrickshekey@gmail.com', '', NULL, '', NULL, NULL, 13, NULL),
(23, '2021-01-18 16:53:56', '2021-01-18 16:58:35', NULL, 69, 'Nathan', 'Lee', 'albertaeskimo27@hotmail.com', '', NULL, 'Edmonton', NULL, NULL, 15, 17),
(24, '2021-01-18 18:25:50', '2021-01-18 18:32:00', NULL, 71, 'Roy', 'Stevenson', 'kenstev7@hotmail.com', '', '2021-01-18', 'Calgary, Alberta', 'Experienced (6 years) Survey Assistant, Buried Line Locator (2 years) with 2 years of technical school (SAIT) training in geomatics. I am single and free to travel for any work location or schedule.', NULL, 18, 21),
(25, '2021-01-19 22:19:26', '2021-04-20 04:58:22', NULL, 64, 'Jordan', 'Bratko', 'Vbahakush@gmail.com', '', NULL, '', NULL, 99, NULL, NULL),
(26, '2021-01-23 08:12:02', '2021-01-23 08:12:02', NULL, 72, 'Michael', 'Cannon', 'md.cannon@yahoo.ca', '', NULL, '', NULL, NULL, NULL, NULL),
(27, '2021-01-25 18:55:36', '2021-02-17 18:19:12', NULL, 73, 'Mitchell', 'Macdonald', 'mitchell.macdonald506@gmail.com', '', NULL, '', NULL, NULL, 35, NULL),
(28, '2021-01-27 23:48:33', '2021-01-27 23:51:42', NULL, 75, 'Mike', 'Lewis', 'triplemc.services@gmail.com', '', NULL, '', 'An Oil and Gas professional with over 23 years of experience in Quality Assurance and Quality Control who has worn many different hats throughout his career taking him from the grass roots of QA/QC to becoming Operational Manager. Mike prides himself as being professional, conscientious, and adaptable to industry and client needs. With these attributes, he is able to provide dependable and positive results.', NULL, 22, 23),
(29, '2021-01-28 20:46:41', '2021-01-28 20:46:41', NULL, 76, 'Mayur', 'Pawar', 'ms2593pawar@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(30, '2021-01-29 02:22:57', '2021-01-29 02:22:57', NULL, 77, 'Warren', 'Oostlander', 'warren.oostlander@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(31, '2021-02-01 18:14:14', '2021-02-01 18:14:42', NULL, 79, 'Bradley', 'Lawrence', 'bradlawrence1313@icloud.com', '', NULL, '', NULL, NULL, 24, NULL),
(32, '2021-02-02 01:38:33', '2021-02-02 01:38:33', NULL, 81, 'Amric', 'Paul', 'developer@amzonestep.com', '', NULL, '', NULL, NULL, NULL, NULL),
(33, '2021-02-02 02:26:58', '2021-02-02 02:26:58', NULL, 82, 'Muhammad', 'Ahtisham', 'ahtisham@amzonestep.com', '', NULL, '', NULL, NULL, NULL, NULL),
(34, '2021-02-05 22:59:47', '2021-02-05 23:01:11', NULL, 86, 'Joseph', 'Racho', 'josephreyracho@yahoo.com', '', NULL, 'Miramichi New Brunswick', NULL, NULL, 25, NULL),
(35, '2021-02-08 19:08:15', '2021-02-08 19:57:39', NULL, 87, 'Kale', 'Prystupa', 'K.prystupa@shaw.ca', '', '2021-02-22', 'Strathmore,Alberta', 'I am a licensed Automotive Service Technician Red Seal Inter Provincial I have 24 years experience 16 in automotive repair and 8 years as a field service technician working on all different types of equipment.', NULL, 26, NULL),
(36, '2021-02-11 11:46:23', '2021-02-11 11:46:23', NULL, 90, 'Manno', 'Notermans', 'mannotest1@thinkorion.com', '', NULL, '', NULL, NULL, NULL, NULL),
(37, '2021-02-11 15:11:56', '2021-02-11 15:13:02', NULL, 93, 'Rayed', 'Chaudhry', 'testmachine080@thinkorion.com', '', '2021-02-13', 'All', 'Forklift Operator is my main thing.', NULL, 27, 29),
(38, '2021-02-12 06:23:26', '2021-02-27 14:36:12', NULL, 94, 'Staff 1', 'Yes', 'mannotest4@thinkorion.com', '', '2021-02-25', '', NULL, NULL, NULL, NULL),
(39, '2021-02-13 00:06:33', '2021-02-13 00:06:33', NULL, 98, 'Developer', 'Outorigin', 'asher@outorigin.com', '', NULL, '', NULL, NULL, NULL, NULL),
(40, '2021-02-13 00:28:15', '2021-02-13 00:28:15', NULL, 43, 'Yasir', 'Asadi', 'ysir-asadi90@hotmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(41, '2021-02-13 21:42:05', '2021-02-13 21:42:05', NULL, 101, 'Ahmad', 'Hamada', 'hamada_cj00@icoud.ca', '', NULL, '', NULL, NULL, NULL, NULL),
(42, '2021-02-14 07:40:54', '2021-02-14 07:51:26', NULL, 102, 'Gervais', 'Ouefio-Nambokinena', 'namger2009@yahoo.com', '', NULL, '', NULL, NULL, 30, NULL),
(43, '2021-02-14 10:27:40', '2021-02-14 10:27:40', NULL, 103, 'Mark', 'Hanna', 'mark.hanna780@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(44, '2021-02-15 19:35:21', '2021-02-15 19:37:38', NULL, 107, 'Les', 'Wood', 'leswood1@telus.net', '', NULL, '', NULL, NULL, 31, NULL),
(45, '2021-02-16 03:17:10', '2021-03-22 21:35:14', NULL, 109, 'Developer', 'Outorigin', 'developer@outorigin.com', '', '2021-03-03', 'hello', 'hello world', NULL, 40, 41),
(46, '2021-02-16 06:01:08', '2021-03-04 08:28:13', NULL, 110, 'Chika', 'Ibegbu', 'goldnslim@gmail.com', '', NULL, '', NULL, NULL, 34, 39),
(47, '2021-02-19 05:06:46', '2021-02-19 05:07:01', NULL, 112, 'Robert', 'Loewen', 'robloewen12@hotmail.com', '', NULL, '', NULL, NULL, NULL, 36),
(48, '2021-02-20 15:09:19', '2021-02-20 15:09:19', NULL, 113, 'Robert', 'Smith', 'rob_jd_smith@hotmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(49, '2021-03-01 17:36:29', '2021-03-01 17:36:29', NULL, 120, 'Renato', 'Bartolome', 'renebartolome@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(50, '2021-03-03 20:10:16', '2021-03-03 20:15:56', NULL, 121, 'Witold', 'Balanda', 'WITOLDBALANDA@HOTMAIL.COM', '', '2021-03-08', '', NULL, NULL, 37, 38),
(51, '2021-03-05 18:17:10', '2021-03-05 18:17:10', NULL, 83, 'Developer', 'Developer', 'developer@amazonebcexperts.com', '', NULL, '', NULL, NULL, NULL, NULL),
(52, '2021-03-09 15:32:59', '2021-03-09 15:33:14', NULL, 130, 'Julian', 'Loewen', 'jewlzloewen1998@gmail.com', '', NULL, '', NULL, NULL, 42, NULL),
(53, '2021-03-09 18:31:31', '2021-06-21 16:28:42', NULL, 108, 'Anthony', 'Wildeman', 'tony_wildeman@msn.com', '', NULL, '', NULL, NULL, NULL, 125),
(54, '2021-03-09 18:33:49', '2021-03-09 18:33:49', NULL, 42, 'Yasir', 'Asadi', 'yasir-asadi89@outlook.com', '', NULL, '', NULL, NULL, NULL, NULL),
(55, '2021-03-09 18:34:10', '2021-03-09 18:34:10', NULL, 118, 'Emmeritha', 'Kasuvire', 'kemmeritha@yahoo.com', '', NULL, '', NULL, NULL, NULL, NULL),
(56, '2021-03-09 22:11:14', '2021-03-09 22:11:14', NULL, 48, 'Abdul', 'Aziz', 'ali.as.aa332@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(57, '2021-03-09 22:12:09', '2021-03-09 22:12:09', NULL, 111, 'Tariq', 'Durrani', 'tdk787@hotmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(58, '2021-03-09 22:12:14', '2021-03-09 22:12:14', NULL, 115, 'Rattandeep', 'Singh', 'rattandeepsinghpannu@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(59, '2021-03-09 22:12:37', '2021-03-09 22:12:37', NULL, 128, 'Chadi', 'Abdul-Rahim', 'Abouhija@hotmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(60, '2021-03-09 23:56:37', '2021-03-09 23:59:07', NULL, 132, 'Aaish', 'Khan', 'aaishk007@gmail.com', '', '2021-03-02', 'ssd', 'madridsta', NULL, 45, NULL),
(61, '2021-03-10 16:58:38', '2021-03-10 16:58:38', NULL, 133, 'Travis', 'McCormick', 'travis.432196@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(62, '2021-03-10 19:24:09', '2021-03-10 19:24:09', NULL, 134, 'Ahmad', 'Hamada', 'hamada_cj00@icloud.com', '', NULL, '', NULL, NULL, NULL, NULL),
(63, '2021-03-11 00:41:46', '2021-03-11 00:43:12', NULL, 135, 'Guy', 'Desharnais', 'guy.desharnais@live.com', '', '2021-03-11', 'Edmonton, Alberta', NULL, NULL, NULL, NULL),
(64, '2021-03-12 00:34:12', '2021-03-12 00:34:26', NULL, 137, 'Oghenemarho', 'Okoro', 'okoromarho9@gmail.com', '', NULL, '', NULL, NULL, 46, NULL),
(65, '2021-03-12 15:28:51', '2021-03-12 15:28:51', NULL, 40, 'Manno', 'Notermans', 'manno.notermans@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(66, '2021-03-15 13:30:17', '2021-03-15 13:39:59', NULL, 141, 'Lisa 01', 'Tester', 'lisa1@thinkorion.com', '', '2021-03-24', 'Alberta', 'What do you want to know?', NULL, 47, 48),
(67, '2021-03-15 13:54:27', '2021-03-15 13:54:27', NULL, 143, 'Lisa 02', 'Tester', 'lisa2@thinkorion.com', '', NULL, '', NULL, NULL, NULL, NULL),
(68, '2021-03-15 18:37:27', '2021-03-15 18:37:27', NULL, 146, 'Sydney', 'Tremblay', 'Sydneytr_05@hotmail.ca', '', NULL, '', NULL, NULL, NULL, NULL),
(69, '2021-03-15 19:15:42', '2021-03-15 19:23:27', NULL, 147, 'Aniefiok', 'Akpan', 'Aniefiok.Akpan@hotmail.com', '', '2021-03-22', '', 'I am a Power Engineering Technology graduate with sound training on safe operation and maintenance of process systems including boilers, turbines, pumps, compressors, refrigeration units, chillers etc. Also, I can operate, install new equipment and inspect existing systems for signs of defects before completing repairs with safety and cost control as top priorities. I can be useful in information technology, measurement and communication as well. In addition, I am very fast learner, analytical, dedicated and adaptable to all work environments.\n\nMoreover, I offer outstanding organizational skills, which have proven to be a critical asset in developing and maintaining process systems. These qualities combined with my dedication and tireless work ethic should enable me to make a positive impact at the company. . I hope to hear from you at your convenience to discuss your needs and objectives and the possibility of working together to meet them. Thank you for your time and consideration.', NULL, 49, 50),
(70, '2021-03-22 23:52:54', '2021-03-30 05:05:38', NULL, 150, 'Amric', 'Paul', 'amric@amzonestep.com', '', NULL, '', 'hello world', NULL, 66, 87),
(71, '2021-03-24 15:59:39', '2021-03-24 15:59:39', NULL, 151, 'Syed', 'Ali', 'wasif@amzonestep.com', '', NULL, '', NULL, NULL, NULL, NULL),
(72, '2021-03-25 11:37:25', '2021-03-25 11:38:18', NULL, 152, 'Keith', 'Fraser', 'firedup.landscaping@gmail.com', '', NULL, '', NULL, NULL, 52, NULL),
(73, '2021-03-27 04:36:20', '2021-03-27 04:36:20', NULL, 153, 'Aaron', 'Naistus', 'aaron-naistus@hotmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(74, '2021-04-11 19:34:35', '2021-04-11 19:34:35', NULL, 156, 'Manolo', 'Arias', 'msariasosa@yahoo.com.mx', '', NULL, '', NULL, NULL, NULL, NULL),
(75, '2021-04-15 08:32:50', '2021-04-21 14:55:06', NULL, 158, 'Lisa', 'Candidate', 'lisa8@thinkorion.com', '', '2021-04-06', 'Alberta', 'Lots to share.', 100, 90, 92),
(76, '2021-04-15 17:35:58', '2021-04-15 17:52:36', NULL, 159, 'David', 'White', 'snackpak75@hotmail.com', '', '2021-04-15', '', 'Iam a class 1 operator with 15 years driving experience I ha e operated many different types of equipment IE   tandom&tridrive 5 ton with crane and piggyback 5 years experience operating 12 ton picker,pump truck ,pressure truck and tank truck also have experience with float trailer hauling equipment,  I can operate loader and skidsteer confidently great mechanical aptitude and  i learn fast', NULL, 94, 95),
(77, '2021-04-17 20:42:25', '2021-04-17 20:50:23', NULL, 161, 'Njike', 'Tchoumi', 'festchou83@yahoo.co.uk', '', '2021-04-24', 'Alberta', 'I have more than 5 years in oil and gas and 8 plus years in construction. I can work for a longer period of time with minimal or limited supervision. I have great stamina and can adapt easily in new environment. I have done many different camp jobs and I\'m available for relocation. Safety is my watch world and I carry all tasks Safely to ensure my safety and that of my co-workers.', NULL, 96, 98),
(78, '2021-04-19 21:37:01', '2021-04-19 21:37:01', NULL, 162, 'Alex', 'Burt', 'alexburt48@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(79, '2021-04-20 05:12:33', '2021-04-20 05:12:33', NULL, 62, 'Pavlo', 'San-Martinek', 'pavlosanmartinek@outlook.com', '', NULL, '', NULL, NULL, NULL, NULL),
(80, '2021-04-22 08:45:10', '2021-04-22 08:45:15', NULL, 163, 'Alex', 'Jin', 'jinhu5240@gmail.com', '', NULL, '', NULL, 101, NULL, NULL),
(81, '2021-05-01 03:31:45', '2021-05-01 03:51:36', NULL, 165, 'Cyrus', 'Tobias', 'cyrustobias2009@gmail.com', '', '2021-05-05', 'Edmonton', 'I came from Asia year 2009, I\'ve worked most of the time in Food Production, like Beef Processing, Plant and Turkey and Chicken Process Foods, I have minimal experienced in Oil and Gas and Construction as well. I\'ve worked in Savanna Drilling for 1 season and Construction since I was in High School but not always and just Labourer job. Year 2018 I decided to settle my self and Family in Canada, I bought in Edmonton City but sad to say that this pandemic really affect most of any individual all over the world specially Me. I wan\'t to stay with food and Beverage Industry but my Bills and Mortgage scared me all the time, and I believed those experienced that I had in Oil and Gas can put me back into the Field.', NULL, 102, NULL),
(82, '2021-05-04 16:24:02', '2021-05-04 16:24:02', NULL, 169, 'alden', 'richards', 'aldenrichards@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(83, '2021-05-07 20:09:29', '2021-05-07 20:11:53', NULL, 170, 'Megan', 'Candidate Test', 'testmachine019@thinkorion.com', '', '2021-05-07', 'Edmonton', NULL, NULL, 103, 105),
(84, '2021-05-11 20:45:53', '2021-05-11 20:45:53', NULL, 172, 'Mark', 'Zavin', 'mark.zavin@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(85, '2021-05-12 16:50:58', '2021-05-12 17:05:08', NULL, 173, 'Kaitlin', 'Hamula', 'hamulake@gmail.com', '', '2021-05-10', 'Leduc', NULL, NULL, 106, NULL),
(86, '2021-05-25 16:13:36', '2021-05-25 16:17:50', NULL, 175, 'Benjamin', 'Williams', 'benjaminwilliams68@yahoo.com', '', NULL, 'Edmonton AB', 'I am a hard working and disciplined individual that is committed to learn, understand and complete given tasks. I am currently training and preparing for the 2021 Summer Olympics as an Athletics 100 meter Sprinter.', NULL, 107, NULL),
(87, '2021-06-01 19:59:20', '2021-06-01 19:59:39', NULL, 174, 'Ryan', 'Scott', 'Ryan.scotty91@gmail.com', '', NULL, '', NULL, NULL, 108, NULL),
(88, '2021-06-21 19:11:32', '2021-06-21 19:11:32', NULL, 178, 'Megan', 'Williams', 'megsaccary89@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(89, '2021-06-23 07:12:00', '2021-06-23 07:20:09', NULL, 179, 'ERIC KWAKU', 'ASSUMAN', 'erickwakuassuman@gmail.com', '', '2021-06-30', 'Ghana', 'am a self motivated person, ready to learn a new skill when the opportunity present itself', NULL, 126, 127),
(90, '2021-07-13 21:55:37', '2021-07-13 21:56:18', NULL, 182, 'Cailen', 'Estey', 'cailen0estey@gmail.com', '', NULL, '', NULL, NULL, 128, NULL),
(91, '2021-07-14 16:14:04', '2021-07-14 16:21:33', NULL, 183, 'Jason', 'Soper', 'gymworkout36@hotmail.com', '', NULL, '', NULL, NULL, 129, 130),
(92, '2021-07-15 13:21:29', '2021-07-15 13:25:21', NULL, 184, 'Stephan', 'Naf', 'stephan.naf@gmail.com', '', '2021-07-15', 'Olds, AB', NULL, NULL, NULL, NULL),
(93, '2021-07-20 20:34:12', '2021-07-20 20:43:06', NULL, 187, 'Quintin', 'Harder', 'qharder@msn.com', '', '2021-07-20', '', NULL, NULL, 131, NULL),
(94, '2021-07-23 08:07:37', '2021-07-23 08:10:08', NULL, 188, 'Nghiep', 'Ngo', 'nghiepcongngo@gmail.com', '', '2021-07-25', '', NULL, NULL, 132, NULL),
(95, '2021-07-24 04:01:44', '2021-07-24 04:01:44', NULL, 189, 'Bradley', 'Pachiorka', 'b_pachiorka@hotmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(96, '2021-07-24 08:23:33', '2021-07-24 16:49:00', NULL, 190, 'Mansher', 'Singh', 'info.mansher@gmail.com', '', NULL, 'edmonton', NULL, NULL, 133, NULL),
(97, '2021-08-02 05:56:52', '2021-08-02 05:56:52', NULL, 193, 'Nate', 'Hasna', 'nhasna@shaw.ca', '', NULL, '', NULL, NULL, NULL, NULL),
(98, '2021-08-04 05:42:48', '2021-08-04 05:42:48', NULL, 194, 'Megan', 'williams', 'megan@primusworkforce.com', '', NULL, '', NULL, NULL, NULL, NULL),
(99, '2021-08-04 23:01:16', '2021-08-04 23:08:05', NULL, 195, 'Rayed', 'Chaudhry', 'testmachine001@thinkorion.com', '', '2021-08-29', '', NULL, NULL, 134, 137),
(100, '2021-08-05 07:44:40', '2021-08-05 07:44:40', NULL, 197, 'Manno', 'Notermans', 'info@adsmonk.com', '', NULL, '', NULL, NULL, NULL, NULL),
(101, '2021-08-11 15:29:54', '2021-08-11 15:29:54', NULL, 198, 'Usama', 'ch1', 'usamasaeed1988@hotmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(102, '2021-08-12 16:30:02', '2021-08-12 16:32:56', NULL, 199, 'Sherrie', 'Oliver', 'sherrielynnoliver76@gmail.com', '', '2121-10-04', 'Fort McMurray', NULL, NULL, 138, NULL),
(103, '2021-08-13 17:25:59', '2021-08-13 17:25:59', NULL, 200, 'Hasna', 'Khoumch', 'Khoumch@gmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(104, '2021-08-31 08:43:12', '2021-08-31 08:43:12', NULL, 202, 'asds', 'asdsa', 'sales@amperbros.ph', '', NULL, '', NULL, NULL, NULL, NULL),
(105, '2021-09-03 13:36:47', '2021-09-03 13:36:47', NULL, 203, 'Clare', 'Sawyer', 'claresawyer1995@hotmail.com', '', NULL, '', NULL, NULL, NULL, NULL),
(106, '2021-09-06 20:41:20', '2021-09-06 20:42:48', NULL, 204, 'Sarthk', 'Rana', 'rasarth@gmail.com', '', '2021-09-27', 'Edmonton', NULL, NULL, 140, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_retrievals`
--

CREATE TABLE `user_retrievals` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_retrievals`
--

INSERT INTO `user_retrievals` (`id`, `user_id`, `token`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'RTRV-8a25f689-9e7e-4f80-bf2b-d0a8d8a9a3e3', 'sent', '2020-12-14 16:37:00', '2020-12-16 09:21:02', NULL),
(2, 2, 'RTRV-5246bc59-b2a5-483c-a928-c9b726781a65', 'sent', '2020-12-14 17:44:18', '2021-05-07 19:43:03', NULL),
(3, 27, 'RTRV-a5224cb2-e127-40cb-88ec-c7b069fe6a63', 'sent', '2020-12-15 16:38:15', '2020-12-15 16:39:03', NULL),
(4, 36, 'RTRV-10523132-b189-4d89-8422-98449d2bcc2e', 'expired', '2020-12-16 16:34:57', '2020-12-16 16:36:28', NULL),
(5, 4, 'RTRV-09f33248-191d-4115-be23-b7801ce7c1ea', 'expired', '2020-12-16 19:10:08', '2020-12-16 19:19:11', NULL),
(6, 43, 'RTRV-93d4ff08-8fac-43e1-bf75-c922c9da1dbb', 'sent', '2020-12-20 03:34:35', '2020-12-20 03:35:04', NULL),
(7, 55, 'RTRV-4dac91e5-bef2-4637-966d-befe88f80d8c', 'expired', '2021-01-06 01:02:06', '2021-01-06 01:07:56', NULL),
(8, 70, 'RTRV-ab6d54c2-7696-43ca-b200-691e509cea2f', 'expired', '2021-01-18 17:53:43', '2021-01-18 17:54:23', NULL),
(9, 50, 'RTRV-e74fb6d3-3fb9-470e-9d3c-3f18ecd22658', 'sent', '2021-02-02 01:32:17', '2021-02-02 01:34:03', NULL),
(10, 82, 'RTRV-1a525168-98b7-4a03-b6a7-42e83028411a', 'sent', '2021-02-02 02:26:20', '2021-02-02 02:27:02', NULL),
(11, 89, 'RTRV-7c7f0bce-133b-4609-b90b-62cfd0bdadac', 'sent', '2021-02-10 20:52:05', '2021-02-10 20:53:03', NULL),
(12, 5, 'RTRV-ec77396d-b196-4886-93bc-c36dd3407153', 'expired', '2021-02-11 11:52:21', '2021-02-11 11:53:29', NULL),
(13, 91, 'RTRV-4d63523a-6782-4405-9807-d47793781f75', 'expired', '2021-02-11 11:59:27', '2021-02-11 12:01:45', NULL),
(14, 81, 'RTRV-e5c77289-e22c-4247-87c7-c16b568a9ba5', 'expired', '2021-02-13 00:12:22', '2021-02-13 00:14:14', NULL),
(15, 111, 'RTRV-bac17dad-7dc6-48b5-bde1-b513f8ae5f7d', 'sent', '2021-02-16 21:54:05', '2021-02-16 21:55:03', NULL),
(16, 104, 'RTRV-ec37d250-d173-4bcb-8b8f-d0a6526b4981', 'expired', '2021-02-24 03:50:31', '2021-02-24 03:54:08', NULL),
(17, 39, 'RTRV-c696b042-bdf0-422a-87c5-08e140e3b24d', 'expired', '2021-03-05 18:18:16', '2021-03-05 18:19:28', NULL),
(18, 167, 'RTRV-2baa0768-8517-4c01-b390-4bd6b4619d2f', 'expired', '2021-06-04 14:58:03', '2021-06-04 17:41:51', NULL),
(19, 199, 'RTRV-a95cf1b1-350c-4351-930b-9da0263535c3', 'expired', '2021-08-12 16:27:37', '2021-08-12 16:29:33', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_logs_user_id_foreign` (`user_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `companies_email_unique` (`email`);

--
-- Indexes for table `company_employees`
--
ALTER TABLE `company_employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_employees_company_id_foreign` (`company_id`),
  ADD KEY `company_employees_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_categories`
--
ALTER TABLE `job_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_posts`
--
ALTER TABLE `job_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_posts_user_id_foreign` (`user_id`),
  ADD KEY `job_posts_employer_id_foreign` (`company_id`);

--
-- Indexes for table `job_post_applications`
--
ALTER TABLE `job_post_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_post_applications_job_post_id_foreign` (`job_post_id`),
  ADD KEY `job_post_applications_user_id_foreign` (`user_id`);

--
-- Indexes for table `job_post_categories`
--
ALTER TABLE `job_post_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_post_categories_job_post_id_foreign` (`job_post_id`),
  ADD KEY `job_post_categories_job_category_id_foreign` (`job_category_id`);

--
-- Indexes for table `job_post_recommendations`
--
ALTER TABLE `job_post_recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_post_recommendations_job_post_id_foreign` (`job_post_id`),
  ADD KEY `job_post_recommendations_user_id_foreign` (`user_id`);

--
-- Indexes for table `job_post_skills`
--
ALTER TABLE `job_post_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_post_skills_job_post_id_foreign` (`job_post_id`),
  ADD KEY `job_post_skills_job_subcategory_item_id_foreign` (`job_subcategory_item_id`);

--
-- Indexes for table `job_subcategories`
--
ALTER TABLE `job_subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_subcategories_job_category_id_foreign` (`job_category_id`);

--
-- Indexes for table `job_subcategory_items`
--
ALTER TABLE `job_subcategory_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_subcategory_items_job_subcategory_id_foreign` (`job_subcategory_id`),
  ADD KEY `job_subcategory_items_job_type_id_foreign` (`job_type_id`);

--
-- Indexes for table `job_types`
--
ALTER TABLE `job_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_worker_recommendations`
--
ALTER TABLE `job_worker_recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_worker_recommendations_job_post_id_foreign` (`job_post_id`),
  ADD KEY `job_worker_recommendations_user_id_foreign` (`user_id`);

--
-- Indexes for table `mails`
--
ALTER TABLE `mails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_receivers`
--
ALTER TABLE `mail_receivers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mail_receivers_mail_id_foreign` (`mail_id`),
  ADD KEY `mail_receivers_user_id_foreign` (`user_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_sender_id_foreign` (`sender_id`),
  ADD KEY `messages_receiver_id_foreign` (`receiver_id`);

--
-- Indexes for table `message_logs`
--
ALTER TABLE `message_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_logs_sender_id_foreign` (`sender_id`),
  ADD KEY `message_logs_receiver_id_foreign` (`receiver_id`);

--
-- Indexes for table `message_replies`
--
ALTER TABLE `message_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_replies_message_id_foreign` (`message_id`),
  ADD KEY `message_replies_sender_id_foreign` (`sender_id`),
  ADD KEY `message_replies_receiver_id_foreign` (`receiver_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notes_user_id_foreign` (`user_id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personnel_details`
--
ALTER TABLE `personnel_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personnel_drug_and_alcohol_tests`
--
ALTER TABLE `personnel_drug_and_alcohol_tests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `required_personnel_id` (`required_personnel_id`);

--
-- Indexes for table `personnel_operator_requirements`
--
ALTER TABLE `personnel_operator_requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `required_personnel_id` (`required_personnel_id`);

--
-- Indexes for table `personnel_requests`
--
ALTER TABLE `personnel_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `po_no` (`request_id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indexes for table `personnel_request_required_personnels`
--
ALTER TABLE `personnel_request_required_personnels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `personnel_request_id` (`personnel_request_id`);

--
-- Indexes for table `personnel_required_tickets`
--
ALTER TABLE `personnel_required_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `required_personnel_id` (`required_personnel_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_employees`
--
ALTER TABLE `user_employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_employees_user_id_foreign` (`user_id`),
  ADD KEY `user_employees_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `user_files`
--
ALTER TABLE `user_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_files_user_id_foreign` (`user_id`);

--
-- Indexes for table `user_logs`
--
ALTER TABLE `user_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_resumes`
--
ALTER TABLE `user_resumes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_resumes_user_id_foreign` (`user_id`);

--
-- Indexes for table `user_retrievals`
--
ALTER TABLE `user_retrievals`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;
--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `company_employees`
--
ALTER TABLE `company_employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `job_categories`
--
ALTER TABLE `job_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `job_posts`
--
ALTER TABLE `job_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;
--
-- AUTO_INCREMENT for table `job_post_applications`
--
ALTER TABLE `job_post_applications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `job_post_categories`
--
ALTER TABLE `job_post_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `job_post_recommendations`
--
ALTER TABLE `job_post_recommendations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `job_post_skills`
--
ALTER TABLE `job_post_skills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
--
-- AUTO_INCREMENT for table `job_subcategories`
--
ALTER TABLE `job_subcategories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `job_subcategory_items`
--
ALTER TABLE `job_subcategory_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=292;
--
-- AUTO_INCREMENT for table `job_types`
--
ALTER TABLE `job_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;
--
-- AUTO_INCREMENT for table `job_worker_recommendations`
--
ALTER TABLE `job_worker_recommendations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `mails`
--
ALTER TABLE `mails`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `mail_receivers`
--
ALTER TABLE `mail_receivers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `message_logs`
--
ALTER TABLE `message_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `message_replies`
--
ALTER TABLE `message_replies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;
--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `personnel_details`
--
ALTER TABLE `personnel_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `personnel_drug_and_alcohol_tests`
--
ALTER TABLE `personnel_drug_and_alcohol_tests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;
--
-- AUTO_INCREMENT for table `personnel_operator_requirements`
--
ALTER TABLE `personnel_operator_requirements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `personnel_requests`
--
ALTER TABLE `personnel_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT for table `personnel_request_required_personnels`
--
ALTER TABLE `personnel_request_required_personnels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;
--
-- AUTO_INCREMENT for table `personnel_required_tickets`
--
ALTER TABLE `personnel_required_tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;
--
-- AUTO_INCREMENT for table `user_employees`
--
ALTER TABLE `user_employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_files`
--
ALTER TABLE `user_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;
--
-- AUTO_INCREMENT for table `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `user_resumes`
--
ALTER TABLE `user_resumes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;
--
-- AUTO_INCREMENT for table `user_retrievals`
--
ALTER TABLE `user_retrievals`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `company_employees`
--
ALTER TABLE `company_employees`
  ADD CONSTRAINT `company_employees_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `company_employees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `job_posts`
--
ALTER TABLE `job_posts`
  ADD CONSTRAINT `job_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `job_post_applications`
--
ALTER TABLE `job_post_applications`
  ADD CONSTRAINT `job_post_applications_job_post_id_foreign` FOREIGN KEY (`job_post_id`) REFERENCES `job_posts` (`id`),
  ADD CONSTRAINT `job_post_applications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `job_post_categories`
--
ALTER TABLE `job_post_categories`
  ADD CONSTRAINT `job_post_categories_job_category_id_foreign` FOREIGN KEY (`job_category_id`) REFERENCES `job_categories` (`id`),
  ADD CONSTRAINT `job_post_categories_job_post_id_foreign` FOREIGN KEY (`job_post_id`) REFERENCES `job_posts` (`id`);

--
-- Constraints for table `job_post_recommendations`
--
ALTER TABLE `job_post_recommendations`
  ADD CONSTRAINT `job_post_recommendations_job_post_id_foreign` FOREIGN KEY (`job_post_id`) REFERENCES `job_posts` (`id`),
  ADD CONSTRAINT `job_post_recommendations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `job_post_skills`
--
ALTER TABLE `job_post_skills`
  ADD CONSTRAINT `job_post_skills_job_post_id_foreign` FOREIGN KEY (`job_post_id`) REFERENCES `job_posts` (`id`),
  ADD CONSTRAINT `job_post_skills_job_subcategory_item_id_foreign` FOREIGN KEY (`job_subcategory_item_id`) REFERENCES `job_subcategory_items` (`id`);

--
-- Constraints for table `job_subcategories`
--
ALTER TABLE `job_subcategories`
  ADD CONSTRAINT `job_subcategories_job_category_id_foreign` FOREIGN KEY (`job_category_id`) REFERENCES `job_categories` (`id`);

--
-- Constraints for table `job_subcategory_items`
--
ALTER TABLE `job_subcategory_items`
  ADD CONSTRAINT `job_subcategory_items_job_subcategory_id_foreign` FOREIGN KEY (`job_subcategory_id`) REFERENCES `job_subcategories` (`id`),
  ADD CONSTRAINT `job_subcategory_items_job_type_id_foreign` FOREIGN KEY (`job_type_id`) REFERENCES `job_types` (`id`);

--
-- Constraints for table `job_worker_recommendations`
--
ALTER TABLE `job_worker_recommendations`
  ADD CONSTRAINT `job_worker_recommendations_job_post_id_foreign` FOREIGN KEY (`job_post_id`) REFERENCES `job_posts` (`id`),
  ADD CONSTRAINT `job_worker_recommendations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `mail_receivers`
--
ALTER TABLE `mail_receivers`
  ADD CONSTRAINT `mail_receivers_mail_id_foreign` FOREIGN KEY (`mail_id`) REFERENCES `mails` (`id`),
  ADD CONSTRAINT `mail_receivers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `message_logs`
--
ALTER TABLE `message_logs`
  ADD CONSTRAINT `message_logs_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `message_logs_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `message_replies`
--
ALTER TABLE `message_replies`
  ADD CONSTRAINT `message_replies_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  ADD CONSTRAINT `message_replies_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `message_replies_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `personnel_drug_and_alcohol_tests`
--
ALTER TABLE `personnel_drug_and_alcohol_tests`
  ADD CONSTRAINT `personnel_drug_and_alcohol_tests_ibfk_1` FOREIGN KEY (`required_personnel_id`) REFERENCES `personnel_request_required_personnels` (`id`);

--
-- Constraints for table `personnel_operator_requirements`
--
ALTER TABLE `personnel_operator_requirements`
  ADD CONSTRAINT `personnel_operator_requirements_ibfk_1` FOREIGN KEY (`required_personnel_id`) REFERENCES `personnel_request_required_personnels` (`id`);

--
-- Constraints for table `personnel_requests`
--
ALTER TABLE `personnel_requests`
  ADD CONSTRAINT `personnel_requests_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Constraints for table `personnel_request_required_personnels`
--
ALTER TABLE `personnel_request_required_personnels`
  ADD CONSTRAINT `personnel_request_required_personnels_ibfk_1` FOREIGN KEY (`personnel_request_id`) REFERENCES `personnel_requests` (`id`);

--
-- Constraints for table `personnel_required_tickets`
--
ALTER TABLE `personnel_required_tickets`
  ADD CONSTRAINT `personnel_required_tickets_ibfk_1` FOREIGN KEY (`required_personnel_id`) REFERENCES `personnel_request_required_personnels` (`id`);

--
-- Constraints for table `user_employees`
--
ALTER TABLE `user_employees`
  ADD CONSTRAINT `user_employees_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_employees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_files`
--
ALTER TABLE `user_files`
  ADD CONSTRAINT `user_files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_logs`
--
ALTER TABLE `user_logs`
  ADD CONSTRAINT `user_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_resumes`
--
ALTER TABLE `user_resumes`
  ADD CONSTRAINT `user_resumes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
