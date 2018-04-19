-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: shareddb-h.hosting.stackcp.net
-- Generation Time: Apr 19, 2018 at 05:54 PM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 5.6.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ign-content-db-333186af`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`dmcfarland`@`%` FUNCTION `RandString` (`length` INT(3)) RETURNS VARCHAR(100) CHARSET utf8 begin
    SET @returnStr = '';
    SET @allowedChars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    SET @i = 0;

    WHILE (@i < length) DO
        SET @returnStr = CONCAT(@returnStr, substring(@allowedChars, FLOOR(RAND() * LENGTH(@allowedChars) + 1), 1));
        SET @i = @i + 1;
    END WHILE;

    RETURN @returnStr;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `RssFeedContent`
--

CREATE TABLE `RssFeedContent` (
  `rssID` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `GUID` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `Category` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `Title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `PubDate` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `Link` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Networks` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `State` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Tags` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `RssFeedContent`
--
DELIMITER $$
CREATE TRIGGER `rssIdCheck` BEFORE INSERT ON `RssFeedContent` FOR EACH ROW BEGIN
    SET @rssId = 1;
    WHILE (@rssId IS NOT NULL) DO 
      SET NEW.rssID = RANDSTRING(24);
      SET @rssId = (SELECT rssID FROM `RssFeedContent` WHERE `rssID` = NEW.rssID);
    END WHILE;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Thumbnails`
--

CREATE TABLE `Thumbnails` (
  `ThumbnailID` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `GUID` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `Link` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Size` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Width` int(6) NOT NULL,
  `Height` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Triggers `Thumbnails`
--
DELIMITER $$
CREATE TRIGGER `thumbnailIdCheck` BEFORE INSERT ON `Thumbnails` FOR EACH ROW BEGIN
    SET @thumbnailId = 1;
    WHILE (@thumbnailId IS NOT NULL) DO 
      SET NEW.thumbnailId = RANDSTRING(24);
      SET @thumbnailId = (SELECT ThumbnailID FROM `Thumbnails` WHERE `ThumbnailID` = NEW.thumbnailId);
    END WHILE;
  END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `RssFeedContent`
--
ALTER TABLE `RssFeedContent`
  ADD PRIMARY KEY (`rssID`),
  ADD UNIQUE KEY `GUID_2` (`GUID`),
  ADD KEY `GUID` (`GUID`);

--
-- Indexes for table `Thumbnails`
--
ALTER TABLE `Thumbnails`
  ADD PRIMARY KEY (`ThumbnailID`),
  ADD KEY `GUID` (`GUID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Thumbnails`
--
ALTER TABLE `Thumbnails`
  ADD CONSTRAINT `GUID` FOREIGN KEY (`GUID`) REFERENCES `RssFeedContent` (`GUID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
