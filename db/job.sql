-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for job
CREATE DATABASE IF NOT EXISTS `job` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `job`;

-- Dumping structure for table job.applicants
CREATE TABLE IF NOT EXISTS `applicants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `jobId` int(11) NOT NULL,
  `cv` varchar(255) NOT NULL,
  `status` enum('new','reviewed','shortlisted','rejected') NOT NULL DEFAULT 'new',
  `experience` int(11) NOT NULL DEFAULT 0,
  `joiningDate` date DEFAULT NULL,
  `coverLetter` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `jobId` (`jobId`),
  CONSTRAINT `applicants_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `applicants_ibfk_2` FOREIGN KEY (`jobId`) REFERENCES `jobs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table job.applicants: ~0 rows (approximately)

-- Dumping structure for table job.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `numberOfJobs` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table job.categories: ~8 rows (approximately)
INSERT INTO `categories` (`id`, `title`, `numberOfJobs`) VALUES
	(1, 'Information Technology', 10),
	(2, 'Creative Arts\n', 10),
	(3, 'Engineering', 10),
	(4, 'Healthcare', 10),
	(5, 'Education', 10),
	(6, 'Sales & Marketing', 10),
	(7, 'Administration', 10),
	(8, 'Construction', 10);

-- Dumping structure for table job.featuredjobs
CREATE TABLE IF NOT EXISTS `featuredjobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jobId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobId` (`jobId`),
  CONSTRAINT `featuredjobs_ibfk_1` FOREIGN KEY (`jobId`) REFERENCES `jobs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table job.featuredjobs: ~0 rows (approximately)

-- Dumping structure for table job.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `postedBy` varchar(255) NOT NULL,
  `category` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `companyName` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `salaryRange` varchar(255) DEFAULT NULL,
  `duration` enum('part-time','full-time','contract','internship') NOT NULL,
  `type` enum('remote','onsite','hybrid') NOT NULL,
  `datePosted` datetime NOT NULL DEFAULT current_timestamp(),
  `skills` text DEFAULT NULL,
  `status` enum('active','closed') NOT NULL DEFAULT 'active',
  `numberOfApplicants` int(11) NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `requirements` text NOT NULL,
  `department` varchar(255) NOT NULL,
  `experience` enum('entry-level','mid-level','senior-level','expert-level') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `postedBy` (`postedBy`),
  KEY `category` (`category`),
  CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`postedBy`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `jobs_ibfk_2` FOREIGN KEY (`category`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table job.jobs: ~0 rows (approximately)

-- Dumping structure for table job.testimonials
CREATE TABLE IF NOT EXISTS `testimonials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) DEFAULT NULL,
  `review` text NOT NULL,
  `name` varchar(255) NOT NULL,
  `occupation` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `testimonials_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table job.testimonials: ~0 rows (approximately)

-- Dumping structure for table job.users
CREATE TABLE IF NOT EXISTS `users` (
  `userId` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','applicant','employer') NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table job.users: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
