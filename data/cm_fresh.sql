-- Adminer 5.4.1 MySQL 5.7.44-48 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

CREATE DATABASE `cm`;
USE `cm`;
DELIMITER ;;

DROP FUNCTION IF EXISTS `SEC_TO_TIMEB`;;
CREATE FUNCTION `SEC_TO_TIMEB` (`in_seconds` bigint) RETURNS varchar(15) CHARACTER SET 'latin1' LANGUAGE SQL
READS SQL DATA
    DETERMINISTIC
BEGIN                                                                                     
    DECLARE hours VARCHAR(9);                                                 
    DECLARE minutes CHAR(2);                                               
    DECLARE seconds CHAR(2);                                               

    SET hours   := FLOOR(in_seconds / 3600);                                              
    SET hours   := IF(hours < 10,CONCAT('0',hours),hours);                                

    SET minutes := FLOOR(MOD(in_seconds,3600) / 60);                                      
    SET minutes := IF(minutes < 10,CONCAT('0',minutes),minutes);                          

    SET seconds := MOD(MOD(in_seconds,3600),60);                                          
    SET seconds := IF(seconds < 10,CONCAT('0',seconds),seconds);

    RETURN CONCAT(hours,':',minutes,':',seconds);                                         
END;;

DELIMITER ;

DROP TABLE IF EXISTS `aboutMeAnswers`;
CREATE TABLE `aboutMeAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answer` text,
  `aboutmeTakenId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `aboutmeTakenId` (`aboutmeTakenId`),
  KEY `questionId` (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `aboutMeQuestions`;
CREATE TABLE `aboutMeQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` timestamp NULL DEFAULT NULL,
  `question` varchar(300) NOT NULL,
  `order` int(11) DEFAULT '0',
  `info` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `aboutMeTakenTable`;
CREATE TABLE `aboutMeTakenTable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `completed` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `completedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `activeDate` date DEFAULT NULL,
  `filledIn` varchar(30) DEFAULT NULL,
  `pendingApproval` int(11) DEFAULT NULL,
  `approved` timestamp NULL DEFAULT NULL,
  `approvedBy` int(11) DEFAULT NULL,
  `declined` int(11) DEFAULT NULL,
  `reasonDeclined` varchar(50) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `accessPages`;
CREATE TABLE `accessPages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `pageId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `accPage`;
CREATE TABLE `accPage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `call` varchar(100) DEFAULT NULL,
  `page` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `private` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `actionOverwrite`;
CREATE TABLE `actionOverwrite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` date DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `page` varchar(50) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `action` text,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `actionsSectionPRSB`;
CREATE TABLE `actionsSectionPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `responPerson` varchar(100) DEFAULT NULL,
  `responRole` varchar(100) DEFAULT NULL,
  `responTeam` varchar(100) DEFAULT NULL,
  `responContact` varchar(100) DEFAULT NULL,
  `carriedOutWhen` text,
  `strategies` text,
  `status` varchar(100) DEFAULT NULL,
  `confidenceLevel` int(11) DEFAULT NULL,
  `actionLastUpdate` date DEFAULT NULL,
  `actionRevDate` date DEFAULT NULL,
  `questionImgId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `actionsV2`;
CREATE TABLE `actionsV2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `action` varchar(350) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `actionsV2Message`;
CREATE TABLE `actionsV2Message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actionsV2RequiredId` int(11) DEFAULT NULL,
  `actionDate` date DEFAULT NULL,
  `actionName` varchar(50) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `actionsV2RequiredId` (`actionsV2RequiredId`) USING BTREE,
  KEY `created` (`created`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `actionsV2Required`;
CREATE TABLE `actionsV2Required` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actionsV2StatusId` int(11) DEFAULT NULL,
  `side` varchar(6) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `pending` varchar(255) DEFAULT NULL,
  `pendingBy` int(11) DEFAULT NULL,
  `pendingDate` datetime DEFAULT NULL,
  `pendingUpdate` datetime DEFAULT NULL,
  `sent` varchar(255) DEFAULT NULL,
  `sentBy` int(11) DEFAULT NULL,
  `sentDate` datetime DEFAULT NULL,
  `sentUpdate` datetime DEFAULT NULL,
  `complete` varchar(255) DEFAULT NULL,
  `completeBy` int(11) DEFAULT NULL,
  `completeDate` datetime DEFAULT NULL,
  `completeUpdate` datetime DEFAULT NULL,
  `notRequired` varchar(255) DEFAULT NULL,
  `notRequiredBy` int(11) DEFAULT NULL,
  `notRequiredDate` datetime DEFAULT NULL,
  `notRequiredUpdate` datetime DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `deleted` (`deleted`) USING BTREE,
  KEY `carerId` (`carerId`) USING BTREE,
  KEY `clientId` (`clientId`) USING BTREE,
  KEY `actionsv2Id` (`actionsV2StatusId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `actionsV2Status`;
CREATE TABLE `actionsV2Status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idActions` int(11) DEFAULT NULL,
  `idStatus` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `actionsV2StatusFollowUp`;
CREATE TABLE `actionsV2StatusFollowUp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idActions` int(11) DEFAULT NULL,
  `idOriginalStatus` int(11) DEFAULT NULL,
  `idNextStatus` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `activeQRClocking`;
CREATE TABLE `activeQRClocking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `qrcode` varchar(100) DEFAULT NULL,
  `qrcodeActive` varchar(100) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clockType` varchar(10) DEFAULT NULL,
  `alert` varchar(10) DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminContacts`;
CREATE TABLE `adminContacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientID` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `fname` varchar(500) DEFAULT NULL,
  `sname` varchar(50) DEFAULT NULL,
  `address1` varchar(500) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `postCode` varchar(50) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `relation` varchar(500) DEFAULT NULL,
  `contactNight` varchar(3) DEFAULT NULL,
  `companyId` varchar(3) DEFAULT NULL,
  `locationId` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminHolidays`;
CREATE TABLE `adminHolidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `eventType` int(2) DEFAULT NULL,
  `paid` int(2) DEFAULT NULL,
  `payRate` int(11) DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `AdminListAccessLogs`;
CREATE TABLE `AdminListAccessLogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carerId` int(11) NOT NULL,
  `listAccess` int(1) NOT NULL,
  `errorsListAccess` int(1) NOT NULL,
  `integrityAccess` int(1) DEFAULT NULL,
  `whiteList` int(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminLocationAccess`;
CREATE TABLE `adminLocationAccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationAccess` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminLog`;
CREATE TABLE `adminLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `adminName` varchar(50) DEFAULT NULL,
  `adminNote` varchar(500) DEFAULT NULL,
  `ticketId` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminNotes`;
CREATE TABLE `adminNotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `noteAdded` varchar(20) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `noteFor` varchar(10) DEFAULT NULL,
  `scheduleId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `dateShow` date DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `note` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `seen` datetime DEFAULT NULL,
  `seenBy` int(11) DEFAULT NULL,
  `important` int(11) DEFAULT '1',
  `comment` text,
  `signName` varchar(100) DEFAULT NULL,
  `signId` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timesheetId` (`timesheetId`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`),
  KEY `scheduleId` (`scheduleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminQualification`;
CREATE TABLE `adminQualification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `qualificationId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(100) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `dateExpired` date DEFAULT NULL,
  `dateAwarded` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminQualificationArchive`;
CREATE TABLE `adminQualificationArchive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `qualificationId` int(11) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(100) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `dateExpired` date DEFAULT NULL,
  `dateAwarded` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminRecurr`;
CREATE TABLE `adminRecurr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `clientId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `jobType` varchar(10) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `lateLogginIn` date DEFAULT NULL,
  `keepRecur` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `agencyWorker`;
CREATE TABLE `agencyWorker` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) DEFAULT NULL,
  `sname` varchar(255) DEFAULT NULL,
  `workerNo` int(11) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `agencyId` int(11) DEFAULT NULL,
  `note` text,
  `state` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `lastAccess` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `alert`;
CREATE TABLE `alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deletedBy` int(11) DEFAULT NULL,
  `statusChangeTableId` int(11) DEFAULT NULL,
  `futureStatusTableId` int(11) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `statusLeave` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `logId` int(11) DEFAULT NULL,
  `seen` varchar(10) DEFAULT NULL,
  `seenBy` int(11) DEFAULT NULL,
  `notes` text,
  `dateToReturn` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `alertAnswers`;
CREATE TABLE `alertAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `alertLevel` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `seen` int(11) DEFAULT NULL,
  `seenDate` datetime DEFAULT NULL,
  `seenBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `allowedUsernames`;
CREATE TABLE `allowedUsernames` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `username` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `androidCopiedTimesheet`;
CREATE TABLE `androidCopiedTimesheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `androidReceivedSchedulesId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `logIn` datetime DEFAULT NULL,
  `logOut` datetime DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `dueIn` time DEFAULT NULL,
  `dueOut` time DEFAULT NULL,
  `time` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `timeType` varchar(50) DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `timeConfirmed` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `tasksDone` text,
  `comments` varchar(150) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `latitudeIn` varchar(20) DEFAULT NULL,
  `longitudeIn` varchar(20) DEFAULT NULL,
  `accuracyIn` varchar(20) DEFAULT NULL,
  `latitudeOut` varchar(20) DEFAULT NULL,
  `longitudeOut` varchar(20) DEFAULT NULL,
  `accuracyOut` varchar(20) DEFAULT NULL,
  `payRate` varchar(20) DEFAULT NULL,
  `billingRate` varchar(20) DEFAULT NULL,
  `travelRate` varchar(20) DEFAULT NULL,
  `travelMtr` float DEFAULT NULL,
  `travelId` int(11) DEFAULT NULL,
  `travelExpenses` decimal(10,5) DEFAULT NULL,
  `travelPay` decimal(10,5) DEFAULT NULL,
  `dontPay` int(11) DEFAULT NULL,
  `dontBill` int(11) DEFAULT NULL,
  `lateLogginOut` date DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `createdTimesheet` datetime DEFAULT NULL,
  `createdByTimesheet` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `confirmed` datetime DEFAULT NULL,
  `confirmedBy` int(11) DEFAULT NULL,
  `photoIn` int(11) DEFAULT NULL,
  `photoOut` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `androidReceivedSchedules`;
CREATE TABLE `androidReceivedSchedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `androidTimestamp` varchar(50) DEFAULT NULL,
  `modifiedTimestamp` varchar(50) DEFAULT NULL,
  `recurId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `dueInDate` date DEFAULT NULL,
  `dueInTime` time DEFAULT NULL,
  `dueOutDate` date DEFAULT NULL,
  `dueOutTime` time DEFAULT NULL,
  `clockInDate` date DEFAULT NULL,
  `clockInTime` time DEFAULT NULL,
  `clockOutDate` date DEFAULT NULL,
  `clockOutTime` time DEFAULT NULL,
  `clockInLat` double DEFAULT NULL,
  `clockInLong` double DEFAULT NULL,
  `accuracyIn` double DEFAULT NULL,
  `clockOutLat` double DEFAULT NULL,
  `clockOutLong` double DEFAULT NULL,
  `accuracyOut` double DEFAULT NULL,
  `client` varchar(50) DEFAULT NULL,
  `comment` text,
  `tasks` text,
  `tasksDone` text,
  `qrCodeIn` varchar(100) DEFAULT NULL,
  `qrCodeOut` varchar(100) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `api_users`;
CREATE TABLE `api_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `areaId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `linked_system_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(500) NOT NULL,
  `bearer_token` varchar(500) NOT NULL,
  `source` varchar(200) NOT NULL,
  `master_token` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `appDownloadButton`;
CREATE TABLE `appDownloadButton` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `ipAddress` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `appOnlyUse`;
CREATE TABLE `appOnlyUse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `side` varchar(30) NOT NULL,
  `active` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `contactName` varchar(200) DEFAULT NULL,
  `contactAddress` varchar(200) DEFAULT NULL,
  `contactPhone` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `wardFlag` int(1) DEFAULT NULL,
  `careHomeFlag` int(1) DEFAULT NULL,
  `NHFlag` int(1) DEFAULT NULL,
  `sageAreaId` varchar(100) DEFAULT NULL,
  `odsCode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `careHomeFlag` (`careHomeFlag`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `areaSearchSetup`;
CREATE TABLE `areaSearchSetup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `assessment`;
CREATE TABLE `assessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(10) DEFAULT NULL,
  `companyId` int(10) DEFAULT NULL,
  `locationId` int(10) DEFAULT NULL,
  `assessmentId` int(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `assessment` date DEFAULT NULL,
  `nextAss` date DEFAULT NULL,
  `assignToCarer` int(10) DEFAULT NULL,
  `note` text,
  `outcomeId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `assessmentHistory`;
CREATE TABLE `assessmentHistory` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `assessId` int(10) DEFAULT NULL,
  `clientId` int(10) DEFAULT NULL,
  `updatedBy` int(10) DEFAULT NULL,
  `assessBy` int(10) DEFAULT NULL,
  `assessDate` date DEFAULT NULL,
  `nxtAssessDate` date DEFAULT NULL,
  `note` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `outcomeId` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `assessmentOutcome`;
CREATE TABLE `assessmentOutcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `assessmentType`;
CREATE TABLE `assessmentType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `defaultLength` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `colour` varchar(10) DEFAULT NULL,
  `outcomeIds` varchar(250) DEFAULT NULL,
  `defaultAssessment` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `assessmentTypeEntry`;
CREATE TABLE `assessmentTypeEntry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `assessmentTypeGroupId` int(11) DEFAULT NULL,
  `nhAssessmentsId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `days` int(11) DEFAULT '0',
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `assessmentTypeGroup`;
CREATE TABLE `assessmentTypeGroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `assignedHours`;
CREATE TABLE `assignedHours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `minutes` int(15) DEFAULT NULL,
  `recurring` int(15) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `next` date DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `auAnacClass`;
CREATE TABLE `auAnacClass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `archived` datetime DEFAULT NULL,
  `orderBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `auAnacClassMinutes`;
CREATE TABLE `auAnacClassMinutes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `auAnacClassId` int(11) DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `effectiveFinish` date DEFAULT '2060-01-01',
  `careMinutesTotal` float DEFAULT '0',
  `careMinutesRN` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `auAnacClassId_index` (`auAnacClassId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `auClientAnacClass`;
CREATE TABLE `auClientAnacClass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `auAnacClassId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `effectiveFinish` date DEFAULT '2060-01-01',
  PRIMARY KEY (`id`),
  KEY `auAnacClassId_index` (`auAnacClassId`),
  KEY `locationId_index` (`locationId`),
  KEY `companyId_index` (`companyId`),
  KEY `clientId_index` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ausBillingHistory`;
CREATE TABLE `ausBillingHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `expenseId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `jobtypeId` int(11) DEFAULT NULL,
  `jobtypeName` varchar(100) DEFAULT NULL,
  `budgetCategory` int(11) DEFAULT NULL,
  `fundingSource` varchar(10) DEFAULT NULL,
  `serviceType` int(11) DEFAULT NULL,
  `reportingCategory` int(11) DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `schedStart` date DEFAULT NULL,
  `schedFinish` date DEFAULT NULL,
  `expenseCategory` int(11) DEFAULT '0',
  `expenseDescription` varchar(400) DEFAULT NULL,
  `billing` double DEFAULT NULL,
  `clientCont` double DEFAULT NULL,
  `govCont` double DEFAULT NULL,
  `billingStatus` tinyint(1) DEFAULT '1',
  `invoiceGeneration` datetime DEFAULT NULL,
  `processDate` date DEFAULT NULL,
  `variationType` varchar(20) DEFAULT NULL COMMENT 'NULL=normal, missed=prior-period service, adjustment=billing correction',
  `splitFromHistoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_variationType` (`variationType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ausBudgetCategories`;
CREATE TABLE `ausBudgetCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `aus_chsp`;
CREATE TABLE `aus_chsp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `lettersName` varchar(250) DEFAULT NULL,
  `missingFlag` int(11) DEFAULT NULL,
  `dexId` varchar(250) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(15) DEFAULT NULL,
  `countryBirth` varchar(50) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `indigenousStatus` int(11) DEFAULT NULL,
  `disabilitiesConditions` varchar(50) DEFAULT NULL,
  `livingArrangements` int(11) DEFAULT NULL,
  `accommodationSetting` int(11) DEFAULT NULL,
  `dvaCard` int(11) DEFAULT NULL,
  `consentDetails` int(11) DEFAULT NULL,
  `concentContacts` int(11) DEFAULT NULL,
  `carerExistence` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `dobEstimated` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `clientId` (`clientId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `aus_chspHistory`;
CREATE TABLE `aus_chspHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chspId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `lettersName` varchar(250) DEFAULT NULL,
  `missingFlag` int(11) DEFAULT NULL,
  `dexId` varchar(250) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(15) DEFAULT NULL,
  `countryBirth` varchar(50) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `indigenousStatus` int(11) DEFAULT NULL,
  `disabilitiesConditions` varchar(50) DEFAULT NULL,
  `livingArrangements` int(11) DEFAULT NULL,
  `accommodationSetting` int(11) DEFAULT NULL,
  `dvaCard` int(11) DEFAULT NULL,
  `consentDetails` int(11) DEFAULT NULL,
  `concentContacts` int(11) DEFAULT NULL,
  `carerExistence` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `dobEstimated` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `clientId` (`clientId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `autoScripts`;
CREATE TABLE `autoScripts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `travelCalculations` int(11) DEFAULT NULL,
  `holidaysUnassign` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `available`;
CREATE TABLE `available` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `carerId` int(11) NOT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bandingTime`;
CREATE TABLE `bandingTime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` time NOT NULL,
  `to` time NOT NULL,
  `apply` time NOT NULL,
  `groupId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bandingTimeGroup`;
CREATE TABLE `bandingTimeGroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bandingTimeJobType`;
CREATE TABLE `bandingTimeJobType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `jobTypeId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `dateRemoved` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `jobtype` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `time` time DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recurrId` (`recurrId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bankHoliday`;
CREATE TABLE `bankHoliday` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(20) NOT NULL,
  `year` year(4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `holiday` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL COMMENT 'Dates, Newyear, Christmas, Boxing',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bankHolidayPersonalised`;
CREATE TABLE `bankHolidayPersonalised` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `date` date NOT NULL,
  `holiday` varchar(200) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  `carerPay` int(1) DEFAULT '1',
  `clientBilling` int(1) DEFAULT '1',
  `scheduleDisplay` int(1) DEFAULT '1',
  `payIncreasePercent` double DEFAULT NULL,
  `billIncreasePercent` double DEFAULT NULL,
  `dayIncreasePercent` varchar(20) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bankHolidayPersonalisedArea`;
CREATE TABLE `bankHolidayPersonalisedArea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bankHolidayId` int(11) NOT NULL,
  `areaId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `banks`;
CREATE TABLE `banks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `name` varchar(400) DEFAULT NULL,
  `address` varchar(400) DEFAULT NULL,
  `town` varchar(400) DEFAULT NULL,
  `county` varchar(400) DEFAULT NULL,
  `IBAN` varchar(400) DEFAULT NULL,
  `BIC` varchar(400) DEFAULT NULL,
  `accountName` varchar(400) DEFAULT NULL,
  `accountNo` varchar(400) DEFAULT NULL,
  `sortCode` varchar(400) DEFAULT NULL,
  `accountsEmail` varchar(400) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `comment` varchar(600) DEFAULT NULL,
  `footer` varchar(600) DEFAULT NULL,
  `customText` text,
  `vatNumber` varchar(200) DEFAULT NULL,
  `signOff` int(1) DEFAULT NULL,
  `addBankDetails` int(1) DEFAULT NULL,
  `showCarerSignature` int(1) DEFAULT NULL,
  `showAdminSignature` int(1) DEFAULT NULL,
  `carerShow` int(1) DEFAULT NULL,
  `showPO` int(1) DEFAULT NULL,
  `splitCarer` int(1) DEFAULT NULL,
  `showCost` int(1) DEFAULT NULL,
  `showSignOff` int(1) DEFAULT NULL,
  `showExpenses` int(1) DEFAULT NULL,
  `showVAT` int(1) DEFAULT NULL,
  `showClientAddress` int(1) DEFAULT NULL,
  `showRate` int(1) DEFAULT NULL,
  `showClientNextKin` int(1) DEFAULT NULL,
  `showRemittance` int(1) DEFAULT NULL,
  `showJobname` int(1) DEFAULT NULL,
  `showCarerPosition` int(1) DEFAULT NULL,
  `showInvoiceDiscount` int(1) DEFAULT NULL,
  `splitBillingScale` int(1) DEFAULT NULL,
  `ShowTravel` int(1) DEFAULT NULL,
  `ShowNumberPages` int(1) DEFAULT NULL,
  `showClientName` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `batch`;
CREATE TABLE `batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `blacklistedCarers`;
CREATE TABLE `blacklistedCarers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `level` varchar(10) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `BodyMetricsRecords`;
CREATE TABLE `BodyMetricsRecords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `heightCm` decimal(5,2) DEFAULT NULL,
  `weightKg` decimal(5,2) DEFAULT NULL,
  `waistCm` decimal(5,2) DEFAULT NULL,
  `admissionWeightKg` decimal(5,2) DEFAULT NULL,
  `admissionHeightCm` decimal(5,2) DEFAULT NULL,
  `heightComments` text,
  `weightComments` text,
  `waistComments` text,
  `admissionWeightComments` text,
  `admissionHeightComments` text,
  `nextHeightReviewDate` date DEFAULT NULL,
  `nextWeightReviewDate` date DEFAULT NULL,
  `nextWaistReviewDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bookmarkFolders`;
CREATE TABLE `bookmarkFolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `page` mediumint(9) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `description` mediumtext,
  `color` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bookmarks`;
CREATE TABLE `bookmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `page` mediumtext,
  `name` mediumtext,
  `description` longtext,
  `color` varchar(200) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `budgetApprovals`;
CREATE TABLE `budgetApprovals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientID` int(11) DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `assTech` int(1) DEFAULT NULL,
  `homeMod` int(1) DEFAULT NULL,
  `resCare` int(1) DEFAULT NULL,
  `clinicalCare` int(1) DEFAULT NULL,
  `independence` int(1) DEFAULT NULL,
  `edLiving` int(1) DEFAULT NULL,
  `indContribution` float DEFAULT NULL,
  `edlContribution` float DEFAULT NULL,
  `receivedHCP` int(11) DEFAULT NULL,
  `currentlyPayITCF` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(10) unsigned NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(10) unsigned NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cancellationGroup`;
CREATE TABLE `cancellationGroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `cancelledFrom` varchar(20) DEFAULT NULL,
  `cmFutureStatusChange_Id` int(11) DEFAULT NULL,
  `eventId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carePlanAnswersPRSB`;
CREATE TABLE `carePlanAnswersPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `clientStrengths` text,
  `clientPreferences` text,
  `agreeStatement` text,
  `agreeName` varchar(100) DEFAULT NULL,
  `agreeRole` varchar(100) DEFAULT NULL,
  `careFundingSource` varchar(200) DEFAULT NULL,
  `otherDocs` text,
  `dateLastUpdate` date DEFAULT NULL,
  `plannedRevDate` date DEFAULT NULL,
  `reviewReason` int(11) DEFAULT NULL,
  `reviewInfo` text,
  `responPersonName` varchar(100) DEFAULT NULL,
  `responPersonRole` varchar(100) DEFAULT NULL,
  `responPersonContact` varchar(100) DEFAULT NULL,
  `documentLocation` text,
  `performName` varchar(100) DEFAULT NULL,
  `performRole` varchar(100) DEFAULT NULL,
  `performGrade` varchar(100) DEFAULT NULL,
  `performSpeciality` varchar(100) DEFAULT NULL,
  `performIdentifier` varchar(100) DEFAULT NULL,
  `performOrganisation` varchar(100) DEFAULT NULL,
  `performContact` varchar(100) DEFAULT NULL,
  `completingName` varchar(100) DEFAULT NULL,
  `completingRole` varchar(100) DEFAULT NULL,
  `completingGrade` varchar(100) DEFAULT NULL,
  `completingSpeciality` varchar(100) DEFAULT NULL,
  `completingIdentifier` varchar(100) DEFAULT NULL,
  `completingOrganisation` varchar(100) DEFAULT NULL,
  `completingDate` date DEFAULT NULL,
  `completingContact` varchar(100) DEFAULT NULL,
  `signature` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `carePlanTakenId` (`carePlanTakenId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `careplanClientLinkPRSB`;
CREATE TABLE `careplanClientLinkPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `careplanId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `careplanPRSB`;
CREATE TABLE `careplanPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `careplanTakenPRSB`;
CREATE TABLE `careplanTakenPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `closed` timestamp NULL DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carePlanId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `signedOff` timestamp NULL DEFAULT NULL,
  `signedOffBy` int(11) DEFAULT NULL,
  `signOffId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carePlanId` (`carePlanId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carer`;
CREATE TABLE `carer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `start` date DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `carerId` varchar(50) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `sname` varchar(50) DEFAULT NULL,
  `middleName` varchar(32) DEFAULT NULL,
  `knownAs` varchar(30) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(250) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `sex` varchar(12) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `license` varchar(5) DEFAULT NULL,
  `car` varchar(5) DEFAULT NULL,
  `transportType` int(2) DEFAULT NULL,
  `schedule` int(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `email2` varchar(50) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `phone2` varchar(30) DEFAULT NULL,
  `workNumber` varchar(30) DEFAULT NULL,
  `qualification` text,
  `wage` varchar(10) DEFAULT '0',
  `position3` varchar(50) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `in_out` varchar(50) DEFAULT NULL,
  `noteLateIn` varchar(10) DEFAULT 'No',
  `noteLateOut` varchar(10) DEFAULT 'No',
  `emailWhenLate` varchar(10) DEFAULT 'No',
  `emailSchedule` varchar(10) DEFAULT 'No',
  `lateText` varchar(10) DEFAULT 'No',
  `viewPrivateNote` int(1) DEFAULT '0',
  `permissionId` int(11) DEFAULT NULL,
  `levelId` int(1) DEFAULT NULL,
  `customAccess` int(1) DEFAULT NULL,
  `sms` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `comments` text,
  `status` varchar(100) DEFAULT NULL,
  `statusId` varchar(100) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `uniform` varchar(20) DEFAULT NULL,
  `ppsNo` varchar(20) DEFAULT NULL,
  `inviteSent` datetime DEFAULT NULL,
  `privateNote` int(11) DEFAULT NULL,
  `blackList` int(11) DEFAULT NULL,
  `nurse` int(11) DEFAULT NULL,
  `financeNo` int(11) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `lineManager` int(11) DEFAULT NULL,
  `wardFlag` int(1) DEFAULT NULL,
  `pinCode` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `employerNiPercent` float DEFAULT '13.8',
  `payrollColumn` varchar(100) DEFAULT NULL,
  `passwordExpires` date DEFAULT NULL,
  `hotjar_recording` datetime DEFAULT NULL,
  `rcRoleId` int(11) DEFAULT NULL,
  `payrollTemplate` int(11) DEFAULT NULL,
  `hasteeId` int(11) DEFAULT NULL,
  `carerPrefix` varchar(50) DEFAULT NULL,
  `carerNum` int(30) DEFAULT NULL,
  `payrollCycle` int(11) DEFAULT NULL,
  `recruitmentSource` int(11) DEFAULT NULL,
  `baseLocationId` int(11) DEFAULT NULL,
  `agency` int(1) DEFAULT NULL,
  `topFinanceShow` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`location`),
  KEY `companyId` (`companyId`),
  KEY `area` (`area`),
  KEY `state` (`state`),
  KEY `permissionId` (`permissionId`),
  KEY `emailWhenLate` (`emailWhenLate`),
  KEY `username` (`username`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `carer_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerAppLocations`;
CREATE TABLE `carerAppLocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `clientLatitude` varchar(50) DEFAULT NULL,
  `clientLongitude` varchar(50) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `carerLatitude` varchar(50) DEFAULT NULL,
  `carerLongitude` varchar(50) DEFAULT NULL,
  `carerAccuracy` varchar(50) DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `event` varchar(30) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `action` varchar(30) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerEditHistory`;
CREATE TABLE `carerEditHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `editCarerId` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `fname` varchar(200) DEFAULT NULL,
  `sname` varchar(200) DEFAULT NULL,
  `knownAs` varchar(200) DEFAULT NULL,
  `address1` varchar(200) DEFAULT NULL,
  `postcode` varchar(200) DEFAULT NULL,
  `town` varchar(200) DEFAULT NULL,
  `county` varchar(200) DEFAULT NULL,
  `country` varchar(200) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `qualification` varchar(200) DEFAULT NULL,
  `carerId` varchar(50) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `sex` varchar(5) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `license` varchar(5) DEFAULT NULL,
  `transportType` int(2) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `ppsNo` varchar(20) DEFAULT NULL,
  `email2` varchar(50) DEFAULT NULL,
  `phone2` varchar(30) DEFAULT NULL,
  `workNumber` varchar(30) DEFAULT NULL,
  `employerNiPercent` float DEFAULT NULL,
  `payrollCycle` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerLocation`;
CREATE TABLE `carerLocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `locationHome` int(11) DEFAULT NULL,
  `zoneId` int(11) DEFAULT NULL,
  `numberZones` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerOutHome`;
CREATE TABLE `carerOutHome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `homeId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `deleted` (`deleted`),
  KEY `homeId` (`homeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerPay`;
CREATE TABLE `carerPay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `jobType` text,
  `holidays` varchar(200) DEFAULT NULL,
  `day` varchar(200) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `timesBy` float DEFAULT NULL,
  `called` varchar(100) DEFAULT NULL,
  `payfor` varchar(100) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `no` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerPayPick`;
CREATE TABLE `carerPayPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerPending`;
CREATE TABLE `carerPending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `start` date DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `carerId` varchar(50) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `sname` varchar(50) DEFAULT NULL,
  `middleName` varchar(32) DEFAULT NULL,
  `knownAs` varchar(30) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `sex` varchar(5) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `license` varchar(5) DEFAULT NULL,
  `car` varchar(5) DEFAULT NULL,
  `transportType` int(2) DEFAULT NULL,
  `schedule` int(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `email2` varchar(50) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `phone2` varchar(30) DEFAULT NULL,
  `workNumber` varchar(30) DEFAULT NULL,
  `qualification` text,
  `wage` varchar(10) DEFAULT '0',
  `position3` varchar(50) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `in_out` varchar(50) DEFAULT NULL,
  `noteLateIn` varchar(10) DEFAULT 'No',
  `noteLateOut` varchar(10) DEFAULT 'No',
  `emailWhenLate` varchar(10) DEFAULT 'No',
  `emailSchedule` varchar(10) DEFAULT 'No',
  `lateText` varchar(10) DEFAULT 'No',
  `viewPrivateNote` int(1) DEFAULT '0',
  `permissionId` int(11) DEFAULT NULL,
  `levelId` int(1) DEFAULT NULL,
  `customAccess` int(1) DEFAULT NULL,
  `sms` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `comments` text,
  `status` varchar(100) DEFAULT NULL,
  `statusId` varchar(100) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `uniform` varchar(20) DEFAULT NULL,
  `ppsNo` varchar(20) DEFAULT NULL,
  `inviteSent` datetime DEFAULT NULL,
  `privateNote` int(11) DEFAULT NULL,
  `blackList` int(11) DEFAULT NULL,
  `nurse` int(11) DEFAULT NULL,
  `financeNo` int(11) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `lineManager` int(11) DEFAULT NULL,
  `wardFlag` int(1) DEFAULT NULL,
  `pinCode` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`location`),
  KEY `companyId` (`companyId`),
  KEY `area` (`area`),
  KEY `state` (`state`),
  KEY `permissionId` (`permissionId`),
  KEY `emailWhenLate` (`emailWhenLate`),
  KEY `username` (`username`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `carer_idfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerPic`;
CREATE TABLE `carerPic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fileName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerresume`;
CREATE TABLE `carerresume` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `uploaded` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `fileName` varchar(250) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `sname` varchar(100) DEFAULT NULL,
  `email1` varchar(100) DEFAULT NULL,
  `email2` varchar(100) DEFAULT NULL,
  `phone1` varchar(100) DEFAULT NULL,
  `phone2` varchar(100) DEFAULT NULL,
  `countryCode` varchar(4) DEFAULT NULL,
  `postalCode` varchar(10) DEFAULT NULL,
  `municipality` varchar(100) DEFAULT NULL,
  `addressLine` varchar(300) DEFAULT NULL,
  `resume` longblob,
  `jsonReturn` longtext,
  `xmlReturn` longtext,
  `arrayReturn` longtext,
  `fileType` varchar(5) DEFAULT NULL,
  `parseSourceMethod` varchar(10) DEFAULT NULL,
  `error` varchar(500) DEFAULT NULL,
  `plainText` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerScheduleConflicts`;
CREATE TABLE `carerScheduleConflicts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `conflicts` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerSignatures`;
CREATE TABLE `carerSignatures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `dataURL` mediumtext NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carerUpdate`;
CREATE TABLE `carerUpdate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delete` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `newPassword` varchar(100) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `carer_updates`;
CREATE TABLE `carer_updates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `changed` datetime DEFAULT NULL,
  `carer_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `start` date DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `carerId` varchar(50) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `sname` varchar(50) DEFAULT NULL,
  `middleName` varchar(32) DEFAULT NULL,
  `knownAs` varchar(30) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `sex` varchar(5) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `license` varchar(5) DEFAULT NULL,
  `car` varchar(5) DEFAULT NULL,
  `transportType` int(2) DEFAULT NULL,
  `schedule` int(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `email2` varchar(50) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `phone2` varchar(30) DEFAULT NULL,
  `workNumber` varchar(30) DEFAULT NULL,
  `qualification` text,
  `wage` varchar(10) DEFAULT '0',
  `position3` varchar(50) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `in_out` varchar(50) DEFAULT NULL,
  `noteLateIn` varchar(10) DEFAULT 'No',
  `noteLateOut` varchar(10) DEFAULT 'No',
  `emailWhenLate` varchar(10) DEFAULT 'No',
  `emailSchedule` varchar(10) DEFAULT 'No',
  `lateText` varchar(10) DEFAULT 'No',
  `viewPrivateNote` int(1) DEFAULT '0',
  `permissionId` int(11) DEFAULT NULL,
  `levelId` int(1) DEFAULT NULL,
  `customAccess` int(1) DEFAULT NULL,
  `sms` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `comments` text,
  `status` varchar(100) DEFAULT NULL,
  `statusId` varchar(100) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `uniform` varchar(20) DEFAULT NULL,
  `ppsNo` varchar(20) DEFAULT NULL,
  `inviteSent` datetime DEFAULT NULL,
  `privateNote` int(11) DEFAULT NULL,
  `blackList` int(11) DEFAULT NULL,
  `nurse` int(11) DEFAULT NULL,
  `financeNo` int(11) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `lineManager` int(11) DEFAULT NULL,
  `wardFlag` int(1) DEFAULT NULL,
  `pinCode` int(11) DEFAULT NULL,
  `employerNiPercent` float DEFAULT '13.8',
  `passwordExpires` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`location`),
  KEY `companyId` (`companyId`),
  KEY `area` (`area`),
  KEY `state` (`state`),
  KEY `permissionId` (`permissionId`),
  KEY `emailWhenLate` (`emailWhenLate`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `caringAppCarer`;
CREATE TABLE `caringAppCarer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `levelId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `caringAppLevels`;
CREATE TABLE `caringAppLevels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `recordLocation` int(11) DEFAULT NULL,
  `forceLocation` int(11) DEFAULT NULL,
  `carerSchedule` int(11) DEFAULT NULL,
  `carerScheduleDays` int(11) DEFAULT NULL,
  `clientSearch` int(11) DEFAULT NULL COMMENT '1 = All, 2 = Prefered, 3 = NONE, 4  = Area, 5 = Workgroup',
  `postit` int(11) DEFAULT NULL,
  `postitTab` int(11) DEFAULT NULL,
  `filingCabinet` int(11) DEFAULT NULL,
  `profile` int(11) DEFAULT NULL,
  `forms` int(11) DEFAULT NULL,
  `clientSchedule` int(11) DEFAULT NULL,
  `clientScreening` int(11) DEFAULT NULL,
  `clientHistory` int(11) DEFAULT NULL,
  `clientHistoryNotifications` int(11) DEFAULT NULL,
  `offerWork` int(11) DEFAULT NULL,
  `autoAcceptWork` int(1) DEFAULT NULL,
  `offerWorkShowAll` int(1) DEFAULT NULL,
  `trainingVideos` int(11) DEFAULT NULL,
  `holidayRequest` int(11) DEFAULT NULL,
  `pay` int(11) DEFAULT NULL,
  `nok` int(11) DEFAULT NULL,
  `expenses` int(11) DEFAULT NULL,
  `commentsTab` int(11) DEFAULT NULL,
  `notesTab` int(11) DEFAULT NULL,
  `tasksTab` int(11) DEFAULT NULL,
  `documentsTab` int(11) DEFAULT NULL,
  `showTags` int(11) DEFAULT NULL,
  `taskSheet` int(11) DEFAULT NULL,
  `accPortal` int(1) DEFAULT NULL,
  `medChecker` int(1) DEFAULT NULL,
  `medCabinet` int(1) DEFAULT NULL,
  `myMeds` int(1) DEFAULT NULL,
  `medTracker` int(1) DEFAULT NULL,
  `viewPNotes` int(1) DEFAULT NULL,
  `AddPNotes` int(1) DEFAULT NULL,
  `photoOnClock` int(1) DEFAULT NULL,
  `mike1` int(1) DEFAULT NULL,
  `qrReader` int(1) DEFAULT NULL,
  `noticeboard` int(1) DEFAULT NULL,
  `carerTravelTimesheet` int(1) DEFAULT NULL,
  `carerTimesheet` int(1) DEFAULT NULL,
  `carerTimesheetSignOff` int(1) DEFAULT NULL,
  `geofence` int(1) DEFAULT NULL,
  `editForms` int(1) DEFAULT NULL,
  `createOutcome` int(1) DEFAULT NULL,
  `reviewOutcome` int(1) DEFAULT NULL,
  `carerProfileAccess` int(1) DEFAULT NULL,
  `availabilitySchedule` int(1) DEFAULT NULL,
  `clockOutReason` int(1) DEFAULT NULL,
  `hidePhone` int(1) DEFAULT NULL,
  `carerDocuments` int(1) DEFAULT NULL,
  `carerContacts` int(1) DEFAULT NULL,
  `carerActions` int(1) DEFAULT NULL,
  `carerForms` int(1) DEFAULT NULL,
  `hrFiles` int(1) DEFAULT NULL,
  `showCancelled` int(1) DEFAULT NULL,
  `showBodymap` int(1) DEFAULT NULL,
  `profileInfo` int(1) DEFAULT NULL,
  `takeForms` int(1) DEFAULT '1',
  `addMedication` int(1) DEFAULT NULL,
  `editMedication` int(1) DEFAULT NULL,
  `deleteMedication` int(1) DEFAULT NULL,
  `addTask` int(1) DEFAULT NULL,
  `editTask` int(1) DEFAULT NULL,
  `deleteTask` int(1) DEFAULT NULL,
  `clockOutForms` int(1) DEFAULT '1',
  `blueEventForm` int(1) DEFAULT '1',
  `medsInClockOutForm` int(1) DEFAULT '1',
  `tasksInClockOutForm` int(1) DEFAULT '1',
  `ppeInClockOutForm` int(1) DEFAULT '1',
  `carerBankDetails` int(1) DEFAULT NULL,
  `detailsAddComments` int(1) DEFAULT NULL,
  `detailsAddNotes` int(1) DEFAULT NULL,
  `geofenceDistance` float DEFAULT '5',
  `clientAddDocument` int(1) DEFAULT NULL,
  `expensesSearch` int(11) DEFAULT NULL,
  `breakEdit` int(11) DEFAULT '1',
  `clientWallet` int(11) DEFAULT NULL,
  `timesheetInfo` int(11) DEFAULT NULL,
  `onCallFull` int(11) DEFAULT NULL,
  `offlineMode` int(1) DEFAULT '0',
  `unscheduledClockIn` int(1) DEFAULT '0',
  `geofencelite` int(1) DEFAULT NULL,
  `walletBalance` int(1) DEFAULT NULL,
  `walletAddMoney` int(1) DEFAULT NULL,
  `walletSignature` int(1) DEFAULT NULL,
  `mfa_carer` int(1) DEFAULT '0',
  `mandatoryNotes` int(1) DEFAULT NULL,
  `payslipPDF` int(1) DEFAULT NULL,
  `appendingFormToPlan` int(1) DEFAULT NULL,
  `walletClientSignature` int(1) DEFAULT NULL,
  `WoundAssessment` int(1) DEFAULT NULL,
  `goals` int(1) DEFAULT NULL,
  `participation` int(1) DEFAULT NULL,
  `governance` int(1) DEFAULT NULL,
  `displayJobType` int(1) DEFAULT NULL,
  `clientLetter` int(1) DEFAULT '1',
  `gpConnect` int(1) DEFAULT NULL,
  `pushMessages` int(10) DEFAULT NULL,
  `pushNoticeboards` int(10) DEFAULT NULL,
  `pushHolidayRequests` int(10) DEFAULT NULL,
  `multipleClockIn` int(1) DEFAULT NULL,
  `beforeClockInMins` int(11) DEFAULT NULL,
  `interTravel` int(1) DEFAULT NULL,
  `cancelMedication` int(1) DEFAULT NULL,
  `stopMedication` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `caringAppLocation`;
CREATE TABLE `caringAppLocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `levelId` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chart`;
CREATE TABLE `chart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `saved` timestamp NULL DEFAULT NULL,
  `savedBy` int(11) DEFAULT NULL,
  `updateOf` int(11) DEFAULT NULL,
  `originalId` int(11) DEFAULT NULL,
  `directives` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartAlertBaselines`;
CREATE TABLE `chartAlertBaselines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alertId` int(11) DEFAULT NULL,
  `baselineId` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `limit` varchar(255) DEFAULT NULL,
  `limitType` int(11) DEFAULT NULL,
  `limitAlertLevel` int(11) DEFAULT NULL,
  `limitRecommendedAction` longtext,
  `reviewComment` longtext,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartAlerts`;
CREATE TABLE `chartAlerts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referenceType` int(11) DEFAULT NULL,
  `referenceId` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartAnswers`;
CREATE TABLE `chartAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `chartTakenId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `txtAnswer` varchar(1000) DEFAULT NULL,
  `type` varchar(250) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `opened_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chartTakenId` (`chartTakenId`),
  KEY `questionId` (`questionId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `areaId` (`areaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartAssign`;
CREATE TABLE `chartAssign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `keepRecurring` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `details` text,
  `reasonStop` text,
  `stoppedBy` int(11) DEFAULT NULL,
  `stoppedDate` datetime DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `weeks` varchar(10) DEFAULT NULL,
  `daysCount` varchar(10) DEFAULT NULL,
  `cloneOf` int(11) DEFAULT NULL,
  `effectiveStopTime` time DEFAULT NULL,
  `mon` int(1) DEFAULT NULL,
  `tue` int(1) DEFAULT NULL,
  `wed` int(1) DEFAULT NULL,
  `thu` int(1) DEFAULT NULL,
  `fri` int(1) DEFAULT NULL,
  `sat` int(1) DEFAULT NULL,
  `sun` int(1) DEFAULT NULL,
  `week` int(1) DEFAULT NULL,
  `everyNumDays` int(11) DEFAULT NULL,
  `dueRequired` int(1) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `directives` text,
  `periodIds` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartAssignTimes`;
CREATE TABLE `chartAssignTimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `chartAssignId` int(11) DEFAULT NULL,
  `times` time DEFAULT NULL,
  `timePeriodId` int(11) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `extraTime` int(11) DEFAULT NULL,
  `reasonForAdding` text,
  `outcomeId` varchar(200) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartBaselineNumerics`;
CREATE TABLE `chartBaselineNumerics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `baselineId` int(11) DEFAULT NULL,
  `aboveValue` float DEFAULT NULL,
  `aboveAlert` tinyint(1) DEFAULT NULL,
  `aboveAlertLevel` int(11) DEFAULT NULL,
  `aboveNote` varchar(255) DEFAULT NULL,
  `belowValue` float DEFAULT NULL,
  `belowAlert` tinyint(1) DEFAULT NULL,
  `belowAlertLevel` int(11) DEFAULT NULL,
  `belowNote` varchar(255) DEFAULT NULL,
  `totalAboveValue` float DEFAULT NULL,
  `totalAboveAlert` tinyint(1) DEFAULT NULL,
  `totalAboveAlertLevel` int(11) DEFAULT NULL,
  `totalAboveNote` varchar(255) DEFAULT NULL,
  `totalBelowValue` float DEFAULT NULL,
  `totalBelowAlert` tinyint(1) DEFAULT NULL,
  `totalBelowAlertLevel` int(11) DEFAULT NULL,
  `totalBelowNote` varchar(255) DEFAULT NULL,
  `totalHours` int(11) DEFAULT NULL,
  `periodFrom` time DEFAULT NULL,
  `periodTo` time DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chartBaselineNumerics_chartBaselines_id_fk` (`baselineId`),
  CONSTRAINT `chartBaselineNumerics_chartBaselines_id_fk` FOREIGN KEY (`baselineId`) REFERENCES `chartBaselines` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartBaselineOptions`;
CREATE TABLE `chartBaselineOptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `baselineId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `alert` tinyint(1) DEFAULT NULL,
  `alertLevel` int(11) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chartBaselineOptions_chartBaselines_id_fk` (`baselineId`),
  CONSTRAINT `chartBaselineOptions_chartBaselines_id_fk` FOREIGN KEY (`baselineId`) REFERENCES `chartBaselines` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartBaselines`;
CREATE TABLE `chartBaselines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chartId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chartBaselines_carer_id_fk` (`createdBy`),
  KEY `chartBaselines_carer_id_fk_2` (`updatedBy`),
  KEY `chartBaselines_carer_id_fk_3` (`deletedBy`),
  KEY `chartBaselines_chartQuestions_id_fk` (`questionId`),
  KEY `chartBaselines_chart_id_fk` (`chartId`),
  KEY `chartBaselines_client_id_fk` (`clientId`),
  KEY `chartBaselines_company_id_fk` (`companyId`),
  KEY `chartBaselines_location_id_fk` (`locationId`),
  CONSTRAINT `chartBaselines_carer_id_fk` FOREIGN KEY (`createdBy`) REFERENCES `carer` (`id`),
  CONSTRAINT `chartBaselines_carer_id_fk_2` FOREIGN KEY (`updatedBy`) REFERENCES `carer` (`id`),
  CONSTRAINT `chartBaselines_carer_id_fk_3` FOREIGN KEY (`deletedBy`) REFERENCES `carer` (`id`),
  CONSTRAINT `chartBaselines_chartQuestions_id_fk` FOREIGN KEY (`questionId`) REFERENCES `chartQuestions` (`id`),
  CONSTRAINT `chartBaselines_chart_id_fk` FOREIGN KEY (`chartId`) REFERENCES `chart` (`id`),
  CONSTRAINT `chartBaselines_client_id_fk` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `chartBaselines_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `chartBaselines_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartQuestionAnswers`;
CREATE TABLE `chartQuestionAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answer` varchar(250) DEFAULT NULL,
  `appendedQues` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartQuestions`;
CREATE TABLE `chartQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `question` varchar(500) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  `measure` varchar(255) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `updated_id` int(11) NOT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `chartTaken`;
CREATE TABLE `chartTaken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `closed` int(11) DEFAULT NULL,
  `closedTime` datetime DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `assignId` int(11) DEFAULT NULL,
  `assignTimesId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cheswoldAllowedIps`;
CREATE TABLE `cheswoldAllowedIps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ipaddress` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cheswold_scanner`;
CREATE TABLE `cheswold_scanner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scanId` varchar(1000) NOT NULL,
  `carerId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  CONSTRAINT `cheswold_scanner_ibfk_1` FOREIGN KEY (`carerId`) REFERENCES `carer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cheswold_scans`;
CREATE TABLE `cheswold_scans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `mapped_to` int(11) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `surname` varchar(150) NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `jobTypes` varchar(800) DEFAULT NULL,
  `residentId` varchar(20) DEFAULT NULL,
  `uuid` char(36) DEFAULT NULL,
  `councilId` varchar(20) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `sname` varchar(150) DEFAULT NULL,
  `middleName` varchar(50) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `schedule` int(1) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `picId` int(11) DEFAULT NULL,
  `knownAs` varchar(50) DEFAULT NULL,
  `phoneHome` varchar(60) DEFAULT NULL,
  `phoneMobile` varchar(60) DEFAULT NULL,
  `preferredContactMethod` int(11) DEFAULT NULL,
  `maritalStatus` varchar(20) DEFAULT NULL,
  `spouseName` varchar(40) DEFAULT NULL,
  `postCode` varchar(10) DEFAULT NULL,
  `currentAddress1` varchar(250) DEFAULT NULL,
  `currentAddress2` varchar(250) DEFAULT NULL,
  `address2` varchar(250) DEFAULT NULL,
  `currentTown` varchar(250) DEFAULT NULL,
  `currentCounty` varchar(250) DEFAULT NULL,
  `currentCountry` varchar(60) DEFAULT NULL,
  `currentUnit` varchar(30) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `nationality` varchar(30) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `admissionDate` date DEFAULT NULL,
  `inductionDate` date DEFAULT NULL,
  `medCardId` varchar(20) DEFAULT NULL,
  `medCondition` text,
  `mentalHealth` text,
  `medication` text,
  `occuptionalT` varchar(3) DEFAULT NULL,
  `physiotherapy` varchar(3) DEFAULT NULL,
  `clientVulnerble` text,
  `ppsNo` varchar(20) DEFAULT NULL,
  `mobility` varchar(20) DEFAULT NULL,
  `mobilityNotes` varchar(50) DEFAULT NULL,
  `speech` varchar(12) DEFAULT NULL,
  `aidsNone` varchar(3) DEFAULT NULL,
  `aidsWalkingFrame` varchar(3) DEFAULT NULL,
  `aidsCane` varchar(3) DEFAULT NULL,
  `aidsZimmer` varchar(3) DEFAULT NULL,
  `aidsCrutches` varchar(3) DEFAULT NULL,
  `aidsTripod` varchar(3) DEFAULT NULL,
  `aidsGrabber` varchar(3) DEFAULT NULL,
  `aidsWheelchair` varchar(3) DEFAULT NULL,
  `aidsOther` varchar(50) DEFAULT NULL,
  `hearing` varchar(20) DEFAULT NULL,
  `hearingAid` varchar(20) DEFAULT NULL,
  `sight` varchar(20) DEFAULT NULL,
  `glasses` varchar(20) DEFAULT NULL,
  `denturesNone` varchar(3) DEFAULT NULL,
  `denturesLower` varchar(3) DEFAULT NULL,
  `denturesUpper` varchar(3) DEFAULT NULL,
  `denturesPartial` varchar(3) DEFAULT NULL,
  `likes` text,
  `dislikes` varchar(300) DEFAULT NULL,
  `panicAlarm` varchar(120) DEFAULT NULL,
  `healthInsurance` varchar(300) DEFAULT NULL,
  `wellfarePayments` varchar(300) DEFAULT NULL,
  `modifiedDiet` varchar(800) DEFAULT NULL,
  `mealsOnWheels` varchar(300) DEFAULT NULL,
  `homeHelp` varchar(300) DEFAULT NULL,
  `phnVisits` varchar(3) DEFAULT NULL,
  `res_property_list` varchar(300) DEFAULT NULL,
  `res_will_testament` varchar(300) DEFAULT NULL,
  `cognitive_state` varchar(500) DEFAULT NULL,
  `falls_risk` varchar(300) DEFAULT NULL,
  `res_care_plan` text,
  `daily_contact_waiver` varchar(300) DEFAULT NULL,
  `dayCare` varchar(300) DEFAULT NULL,
  `directions` text,
  `status` text,
  `comment` text,
  `SuperVisComment` text,
  `dutiesComment` text,
  `screenComment` text,
  `HSECoordinator` varchar(60) DEFAULT NULL,
  `Invoice` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tag` varchar(30) DEFAULT NULL,
  `currentStatus` varchar(30) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `privateNote` int(11) DEFAULT NULL,
  `blackList` int(11) DEFAULT NULL,
  `pausedSchedule` int(1) DEFAULT NULL,
  `pausedStatus` int(1) DEFAULT NULL,
  `futureStatusChange` date DEFAULT NULL,
  `statusId` varchar(10) DEFAULT NULL,
  `wardFlag` int(1) DEFAULT NULL,
  `nhsNum` varchar(20) DEFAULT NULL,
  `skipGeo` int(1) DEFAULT NULL,
  `currentAddress5` varchar(250) DEFAULT NULL,
  `alias` varchar(250) DEFAULT NULL,
  `nfcTag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`location`),
  KEY `companyId` (`companyId`),
  KEY `area` (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


SET NAMES utf8mb4;

DROP TABLE IF EXISTS `clientAusIdentifiers`;
CREATE TABLE `clientAusIdentifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `careRecipientId` int(10) DEFAULT NULL COMMENT '8-digit number issued by Services Australia',
  `medicareCardNumber` varchar(11) DEFAULT NULL COMMENT '10 or 11 digit Medicare card number (no spaces)',
  `medicareIRN` varchar(10) DEFAULT NULL COMMENT 'Individual Reference Number: the small digit next to the person’s name on the Medicare card.',
  `medicareExpiry` varchar(7) DEFAULT NULL COMMENT 'Card expiry',
  `myAgedCareID` varchar(20) DEFAULT NULL COMMENT 'MAC System identifier for the resident',
  `myAgedCareApproval` date DEFAULT NULL COMMENT 'Date the resident’s MAC assessment was approved',
  `ndssStatus` varchar(100) DEFAULT NULL COMMENT 'Currently registered with the NDSS',
  `pensionType` varchar(10) DEFAULT NULL COMMENT 'Primary income-support pension',
  `agedLevel` varchar(50) DEFAULT NULL COMMENT 'Level printed on the Pensioner Concession Card',
  `agedCRN` varchar(20) DEFAULT NULL COMMENT 'Centrelink Reference Number',
  `agedIssue` date DEFAULT NULL COMMENT 'Date the Pensioner Concession Card was issued',
  `agedExpiry` varchar(7) DEFAULT NULL COMMENT 'Expiry shown on the card',
  `dspCRN` varchar(20) DEFAULT NULL COMMENT 'Centrelink Reference Number',
  `dspStart` date DEFAULT NULL COMMENT 'Date DSP payments commenced',
  `dspExpiry` varchar(7) DEFAULT NULL COMMENT 'Card expiry',
  `dvaCardNo` varchar(20) DEFAULT NULL COMMENT 'Entitlement number printed on the DVA card',
  `dvaColour` varchar(10) DEFAULT NULL COMMENT 'Gold = full treatment; White = condition-specific; Orange = pharmaceutical only',
  `dvaExpiry` varchar(7) DEFAULT NULL COMMENT 'Expiry if shown on the card',
  `dvaEntitlement` varchar(20) DEFAULT NULL COMMENT 'Relationship of card-holder to the service person',
  `healthFundProvider` varchar(20) DEFAULT NULL COMMENT 'Name of insurer',
  `healthFundNumber` varchar(15) DEFAULT NULL COMMENT 'Membership or policy number',
  `choiceOfHospital` varchar(50) DEFAULT NULL COMMENT 'Resident’s preferred hospital for admissions',
  `ndisNumber` varchar(9) DEFAULT NULL COMMENT 'Participant number printed on the NDIS plan',
  `planMgmtType` varchar(30) DEFAULT NULL COMMENT 'Who pays invoices',
  `planStart` date DEFAULT NULL COMMENT 'First day of the current NDIS plan period',
  `planEnd` date DEFAULT NULL COMMENT 'Last day of the current NDIS plan period',
  `planManagerOrg` varchar(50) DEFAULT NULL COMMENT 'Company or accounting firm authorised to pay invoices',
  `planManagerEmail` varchar(50) DEFAULT NULL COMMENT 'Accounts-payable email used for submitting invoices',
  `scName` varchar(50) DEFAULT NULL COMMENT 'Primary NDIS Support Coordinator',
  `scPhone` varchar(15) DEFAULT NULL COMMENT 'Mobile or landline for the Support Coordinator',
  `scEmail` varchar(50) DEFAULT NULL COMMENT 'Email address for referrals and progress updates',
  `portalVerified` enum('Y','N') DEFAULT NULL COMMENT 'Has the participant’s record been checked in the NDIA Provider Portal',
  `pbsStatus` enum('Y','N') DEFAULT NULL COMMENT 'Does the resident hold a PBS Safety Net entitlement',
  `pbsNumber` varchar(20) DEFAULT NULL COMMENT 'PBS concession or entitlement number',
  `ctgPbsStatus` enum('Y','N') DEFAULT NULL COMMENT 'Closing the Gap PBS co‑payment status',
  `ndssResidentStatus` enum('Y','N') DEFAULT NULL COMMENT 'Is the resident currently registered with the NDSS?',
  `ndssNumber` varchar(12) DEFAULT NULL COMMENT 'NDSS participant number',
  `localMRN` varchar(15) DEFAULT NULL COMMENT 'Facility or hospital medical record number',
  `ihiValue` varchar(16) DEFAULT NULL COMMENT '16‑digit national Individual Healthcare Identifier',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table that contains info about Identifiers used in Australian clients';


DROP TABLE IF EXISTS `clientBilling`;
CREATE TABLE `clientBilling` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `jobType` varchar(100) DEFAULT NULL,
  `holidays` varchar(200) DEFAULT NULL,
  `day` varchar(200) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `timesBy` float DEFAULT NULL,
  `called` varchar(100) DEFAULT NULL,
  `payfor` varchar(100) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientBillingPick`;
CREATE TABLE `clientBillingPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `billingScaleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientCarerTags`;
CREATE TABLE `clientCarerTags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientTagId` int(11) DEFAULT NULL,
  `carerTagId` int(11) DEFAULT NULL,
  `level` int(1) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `clientTagId` (`clientTagId`),
  KEY `carerTagId` (`carerTagId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientChartList`;
CREATE TABLE `clientChartList` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chartId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `value` varchar(20) DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `effectiveFinish` date DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientDetails`;
CREATE TABLE `clientDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `breakfast` int(11) DEFAULT NULL,
  `dinner` int(11) DEFAULT NULL,
  `tea` int(11) DEFAULT NULL,
  `referralBy` varchar(500) DEFAULT NULL,
  `referralReason` int(11) DEFAULT NULL,
  `referralNote` varchar(500) DEFAULT NULL,
  `referralDate` date DEFAULT NULL,
  `oldAddress1` varchar(50) DEFAULT NULL,
  `oldTown` varchar(50) DEFAULT NULL,
  `oldCounty` varchar(60) DEFAULT NULL,
  `oldCountry` varchar(60) DEFAULT NULL,
  `ethnicity` int(11) DEFAULT NULL,
  `billingCode` varchar(100) DEFAULT NULL,
  `invoiceCycle` int(11) DEFAULT NULL,
  `futureStatusChangeSet` int(11) DEFAULT NULL,
  `pay_for_travel` varchar(1) NOT NULL DEFAULT 'y',
  `travel_mtrs_deduction` float DEFAULT NULL,
  `invoiceDiscount` float DEFAULT NULL,
  `comission` float DEFAULT NULL,
  `splitCarer` int(11) DEFAULT '0',
  `travelCalculate` int(1) DEFAULT '1',
  `clientPrefix` varchar(30) DEFAULT NULL,
  `clientNum` bigint(20) DEFAULT NULL,
  `contractedHours` float DEFAULT NULL,
  `contratedValue` int(50) DEFAULT NULL,
  `religion` int(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `invoiceCycle` (`invoiceCycle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientGoals`;
CREATE TABLE `clientGoals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `description` longtext,
  `timescale` varchar(200) DEFAULT NULL,
  `timescaleDate` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `themeId` int(11) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `yearReview` int(11) DEFAULT NULL,
  `pay_for_travel` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `timescaleDate` (`timescaleDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientInfections`;
CREATE TABLE `clientInfections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `infectionType` varchar(100) DEFAULT NULL,
  `causativeAgent` varchar(100) DEFAULT NULL,
  `symptoms` varchar(500) DEFAULT NULL,
  `dateFound` date DEFAULT NULL,
  `dateResolved` date DEFAULT NULL,
  `dateReview` date DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientInfectionsMcGeer`;
CREATE TABLE `clientInfectionsMcGeer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Reference to parent (up level)',
  `at_least` tinyint(3) unsigned DEFAULT NULL COMMENT 'Identify how many answers need be selected to turn this option valid',
  `type` enum('question','answer') NOT NULL COMMENT 'Type of item',
  `title` varchar(255) NOT NULL COMMENT 'Title of Question/Anwser',
  `comments` text COMMENT 'Comments',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `clientInfectionsMcGeer_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `clientInfectionsMcGeer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientInfectionsMcGeerResponses`;
CREATE TABLE `clientInfectionsMcGeerResponses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(10) unsigned NOT NULL COMMENT 'Identifier for the questionnaire session clientInfectionsMcGeerSession.id',
  `question_id` int(10) unsigned NOT NULL COMMENT 'Reference to the question in clientInfectionsMcGeer',
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `clientInfectionsMcGeerResponses_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `clientInfectionsMcGeerSession` (`id`),
  CONSTRAINT `clientInfectionsMcGeerResponses_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `clientInfectionsMcGeer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientInfectionsMcGeerResponsesHistory`;
CREATE TABLE `clientInfectionsMcGeerResponsesHistory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `selected_response_id` int(10) unsigned NOT NULL COMMENT 'Reference to the response in clientInfectionsMcGeerResponses',
  `previous_state` enum('added','removed') NOT NULL COMMENT 'Indicates whether the response was added or removed',
  `changed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp of the change',
  `changed_by` varchar(255) DEFAULT NULL COMMENT 'User or system who made the change',
  PRIMARY KEY (`id`),
  KEY `selected_response_id` (`selected_response_id`),
  CONSTRAINT `clientInfectionsMcGeerResponsesHistory_ibfk_1` FOREIGN KEY (`selected_response_id`) REFERENCES `clientInfectionsMcGeerResponses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientInfectionsMcGeerSession`;
CREATE TABLE `clientInfectionsMcGeerSession` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when the questionnaire was created',
  `deleted_at` datetime DEFAULT NULL COMMENT 'If update, will delete one and create another to maintain history',
  `user_id` int(11) DEFAULT NULL COMMENT 'User reference who create/update awnsers',
  `client_infection_id` int(11) DEFAULT NULL COMMENT 'Client infection reference (clientInfections)',
  `category_id` int(10) unsigned NOT NULL COMMENT 'Category McGeer (clientInfectionsMcGeer level 0)',
  `symdrome_id` int(10) unsigned NOT NULL COMMENT 'Syndrome McGeer (clientInfectionsMcGeer level 1)',
  `comments` text COMMENT 'General comments about the questionnaire',
  `met` tinyint(1) DEFAULT NULL COMMENT 'Criteria met?',
  PRIMARY KEY (`id`),
  KEY `client_infection_id` (`client_infection_id`),
  KEY `category_id` (`category_id`),
  KEY `symdrome_id` (`symdrome_id`),
  CONSTRAINT `clientInfectionsMcGeerSession_ibfk_1` FOREIGN KEY (`client_infection_id`) REFERENCES `clientInfections` (`id`),
  CONSTRAINT `clientInfectionsMcGeerSession_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `clientInfectionsMcGeer` (`id`),
  CONSTRAINT `clientInfectionsMcGeerSession_ibfk_3` FOREIGN KEY (`symdrome_id`) REFERENCES `clientInfectionsMcGeer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientIreIdentifiers`;
CREATE TABLE `clientIreIdentifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `medicareCardNumber` varchar(12) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'HSE entitlement card number for free/low-cost healthcare.',
  `medicareExpiry` varchar(7) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Enter the expiry month and year as shown on the Medicare card.',
  `gsmCardNumber` varchar(15) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'General Medical Services card.',
  `gsmCardNumberExpire` varchar(7) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Enter the expiry month and year.',
  `gpCardNumber` varchar(15) DEFAULT NULL COMMENT 'Entitles holder to free GP visits (distinct from GMS).',
  `gpCardExpire` varchar(7) DEFAULT NULL COMMENT 'Enter the expiry month and year.',
  `hseClientId` varchar(10) DEFAULT NULL COMMENT 'Person''s identifier in HSE client systems.',
  `choReference` varchar(12) DEFAULT NULL COMMENT 'Community Health Organization case/reference for the person.',
  `nhssReference` varchar(12) DEFAULT NULL COMMENT 'Nursing Homes Support Scheme funding reference.',
  `privateHealthInsurer` varchar(60) DEFAULT NULL COMMENT 'Insurer name (e.g., Vhi, Laya).',
  `insurancePoliceNumber` varchar(20) DEFAULT NULL COMMENT 'Insurance Policy Number',
  `policyExpiryDate` varchar(7) DEFAULT NULL COMMENT 'Enter the expiry month and year.',
  `ltiNumber` varchar(12) DEFAULT NULL COMMENT 'The reference number printed on the HSE Long',
  `ltiStatus` varchar(20) DEFAULT NULL COMMENT 'Current LTI record status',
  `ltiQualifyingConditions` json DEFAULT NULL COMMENT 'One or more chronic medical conditions that qualify the client for the Long-Term Illness Scheme',
  `ltiIssueDate` date DEFAULT NULL COMMENT 'The date the HSE issued or approved the LTI entitlement.',
  `ltiReview` date DEFAULT NULL COMMENT 'Date when the LTI entitlement should be reviewed or renewed',
  `ltiNotes` text COMMENT 'Free text notes',
  `dpsNumber` varchar(9) DEFAULT NULL COMMENT 'Unique HSE-issued identifier for a household registered under the Drug Payment Scheme',
  `dpsStatus` varchar(20) DEFAULT NULL COMMENT 'Indicates whether the DPS record is currently valid. Typically Active',
  `dpsIssueDate` date DEFAULT NULL COMMENT 'The date the DPS registration or card was first issued by the HSE',
  `dpsReview` date DEFAULT NULL COMMENT 'Optional date for internal or administrative review',
  `dpsNotes` text COMMENT 'Free text notes',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientLinks`;
CREATE TABLE `clientLinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `clientId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `code` varchar(30) NOT NULL,
  `linkConfirm` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientPending`;
CREATE TABLE `clientPending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `jobTypes` varchar(100) DEFAULT NULL,
  `residentId` varchar(20) DEFAULT NULL,
  `councilId` varchar(20) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `sname` varchar(50) DEFAULT NULL,
  `middleName` varchar(50) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `schedule` int(1) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `picId` int(11) DEFAULT NULL,
  `knownAs` varchar(50) DEFAULT NULL,
  `phoneHome` varchar(60) DEFAULT NULL,
  `phoneMobile` varchar(60) DEFAULT NULL,
  `maritalStatus` varchar(20) DEFAULT NULL,
  `spouseName` varchar(40) DEFAULT NULL,
  `postCode` varchar(10) DEFAULT NULL,
  `currentAddress1` varchar(250) DEFAULT NULL,
  `currentTown` varchar(250) DEFAULT NULL,
  `currentCounty` varchar(250) DEFAULT NULL,
  `currentCountry` varchar(60) DEFAULT NULL,
  `currentUnit` varchar(30) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `nationality` varchar(30) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `admissionDate` date DEFAULT NULL,
  `inductionDate` date DEFAULT NULL,
  `medCardId` varchar(20) DEFAULT NULL,
  `medCondition` text,
  `mentalHealth` text,
  `medication` text,
  `occuptionalT` varchar(3) DEFAULT NULL,
  `physiotherapy` varchar(3) DEFAULT NULL,
  `clientVulnerble` text,
  `ppsNo` varchar(20) DEFAULT NULL,
  `mobility` varchar(20) DEFAULT NULL,
  `mobilityNotes` varchar(50) DEFAULT NULL,
  `speech` varchar(12) DEFAULT NULL,
  `aidsNone` varchar(3) DEFAULT NULL,
  `aidsWalkingFrame` varchar(3) DEFAULT NULL,
  `aidsCane` varchar(3) DEFAULT NULL,
  `aidsZimmer` varchar(3) DEFAULT NULL,
  `aidsCrutches` varchar(3) DEFAULT NULL,
  `aidsTripod` varchar(3) DEFAULT NULL,
  `aidsGrabber` varchar(3) DEFAULT NULL,
  `aidsWheelchair` varchar(3) DEFAULT NULL,
  `aidsOther` varchar(50) DEFAULT NULL,
  `hearing` varchar(20) DEFAULT NULL,
  `hearingAid` varchar(20) DEFAULT NULL,
  `sight` varchar(20) DEFAULT NULL,
  `glasses` varchar(20) DEFAULT NULL,
  `denturesNone` varchar(3) DEFAULT NULL,
  `denturesLower` varchar(3) DEFAULT NULL,
  `denturesUpper` varchar(3) DEFAULT NULL,
  `denturesPartial` varchar(3) DEFAULT NULL,
  `likes` text,
  `dislikes` varchar(300) DEFAULT NULL,
  `panicAlarm` varchar(120) DEFAULT NULL,
  `healthInsurance` varchar(300) DEFAULT NULL,
  `wellfarePayments` varchar(300) DEFAULT NULL,
  `modifiedDiet` varchar(800) DEFAULT NULL,
  `mealsOnWheels` varchar(300) DEFAULT NULL,
  `homeHelp` varchar(300) DEFAULT NULL,
  `phnVisits` varchar(3) DEFAULT NULL,
  `res_property_list` varchar(300) DEFAULT NULL,
  `res_will_testament` varchar(300) DEFAULT NULL,
  `cognitive_state` varchar(500) DEFAULT NULL,
  `falls_risk` varchar(300) DEFAULT NULL,
  `res_care_plan` text,
  `daily_contact_waiver` varchar(300) DEFAULT NULL,
  `dayCare` varchar(300) DEFAULT NULL,
  `directions` text,
  `status` text,
  `comment` text,
  `SuperVisComment` text,
  `dutiesComment` text,
  `screenComment` text,
  `HSECoordinator` varchar(60) DEFAULT NULL,
  `Invoice` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tag` varchar(30) DEFAULT NULL,
  `currentStatus` varchar(30) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `privateNote` int(11) DEFAULT NULL,
  `blackList` int(11) DEFAULT NULL,
  `pausedSchedule` int(1) DEFAULT NULL,
  `pausedStatus` int(1) DEFAULT NULL,
  `futureStatusChange` date DEFAULT NULL,
  `statusId` varchar(10) DEFAULT NULL,
  `wardFlag` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`location`),
  KEY `companyId` (`companyId`),
  KEY `area` (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientPic`;
CREATE TABLE `clientPic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fileName` varchar(100) DEFAULT NULL,
  `dateTaken` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientPictureUpload`;
CREATE TABLE `clientPictureUpload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(200) DEFAULT NULL,
  `fileSize` varchar(200) DEFAULT NULL,
  `fileType` varchar(200) DEFAULT NULL,
  `dataUsed` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientsSummaryProfileFundingSignature`;
CREATE TABLE `clientsSummaryProfileFundingSignature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `signedName` varchar(100) DEFAULT NULL,
  `signature` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientTimeChange`;
CREATE TABLE `clientTimeChange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `dateEdit` date DEFAULT NULL,
  `newDate` date DEFAULT NULL,
  `newStartTime` time DEFAULT NULL,
  `newFinishTime` time DEFAULT NULL,
  `notes` text,
  `status` varchar(20) DEFAULT NULL,
  `jobtype` int(11) DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `eventCode` varchar(40) DEFAULT NULL,
  `sendTo` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `clientUkIdentifiers`;
CREATE TABLE `clientUkIdentifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `nhsNumber` varchar(10) NOT NULL COMMENT 'National health identifier',
  `councilTaxNumber` varchar(12) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Local Authority “person” identifier for adult social care.',
  `niNumber` varchar(9) DEFAULT NULL COMMENT 'Some providers request it for legacy or finance workflows; not a healthcare identifier.',
  `localAuthFundingRef` varchar(15) DEFAULT NULL COMMENT 'Council contract/case reference for funded placements.',
  `privateFundingRef` varchar(20) DEFAULT NULL COMMENT 'Internal/self-funder billing/account reference',
  `privateInsurer` varchar(60) DEFAULT NULL COMMENT 'Insurer name for private coverage.',
  `insurancePolicyNumber` varchar(20) DEFAULT NULL COMMENT 'Private insurance policy reference',
  `policyExpiryDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cm2000`;
CREATE TABLE `cm2000` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `lastRun` datetime DEFAULT NULL,
  `agencyId` varchar(50) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '0',
  `ftp_host` varchar(100) NOT NULL,
  `ftp_username` varchar(100) NOT NULL,
  `ftp_password` varchar(100) NOT NULL,
  `ftp_port` int(3) NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cm2000Areas`;
CREATE TABLE `cm2000Areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `cm2000Id` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cm2000Clients`;
CREATE TABLE `cm2000Clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `cm2000Id` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cm2000JobTypes`;
CREATE TABLE `cm2000JobTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `cm2000Id` int(11) DEFAULT NULL,
  `jobTypeId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cm2000PlannedVisits`;
CREATE TABLE `cm2000PlannedVisits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `constructedId` varchar(1000) NOT NULL,
  `plannedVisitId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `com_loc` (`companyId`,`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cm2000Residents`;
CREATE TABLE `cm2000Residents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `cm2000Id` int(11) DEFAULT NULL,
  `residentId` varchar(250) DEFAULT NULL,
  `action` varchar(250) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmAccountsLinked`;
CREATE TABLE `cmAccountsLinked` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(100) DEFAULT NULL,
  `accountCarerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmAndroidUsers`;
CREATE TABLE `cmAndroidUsers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `appVersion` varchar(10) DEFAULT NULL,
  `androidVersion` varchar(400) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmAssignedHours`;
CREATE TABLE `cmAssignedHours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `day` varchar(20) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `week` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `priority` varchar(20) DEFAULT NULL,
  `details` text,
  `overnight` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `jobType` (`jobType`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmAssignedHoursPending`;
CREATE TABLE `cmAssignedHoursPending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `day` varchar(20) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `week` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `priority` varchar(20) DEFAULT NULL,
  `details` text,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `jobType` (`jobType`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmAusStatementHistory`;
CREATE TABLE `cmAusStatementHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `invoiceId` int(11) DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `periodDateStart` timestamp NULL DEFAULT NULL,
  `periodDateEnd` timestamp NULL DEFAULT NULL,
  `budgetTotal` decimal(15,5) DEFAULT NULL,
  `invoiceTimesheetTotal` decimal(15,5) DEFAULT NULL,
  `invoiceExpensesTotal` decimal(15,5) DEFAULT NULL,
  `adjustmentsTotal` decimal(15,5) DEFAULT NULL,
  `hcpSubsidyTotal` decimal(15,5) DEFAULT NULL,
  `supplementsTotal` decimal(15,5) DEFAULT NULL,
  `ictfTotal` decimal(15,5) DEFAULT NULL,
  `openingBalance` decimal(15,5) DEFAULT NULL,
  `closingBalance` decimal(15,5) DEFAULT NULL,
  `openingCwFunds` decimal(15,5) DEFAULT NULL,
  `closingCwFunds` decimal(15,5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmAvailability`;
CREATE TABLE `cmAvailability` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `finishTime` time DEFAULT NULL,
  `allDay` int(2) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmAvailabilityNoShow`;
CREATE TABLE `cmAvailabilityNoShow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` date DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateNoShow` date DEFAULT NULL,
  `availabilityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `availabilityId` (`availabilityId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmBrowserLink`;
CREATE TABLE `cmBrowserLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` datetime NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `cmBudgetStatement`;
CREATE TABLE `cmBudgetStatement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locationid` int(11) NOT NULL,
  `clientid` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `openingBalance` text NOT NULL,
  `closingBalance` text NOT NULL,
  `homeSupportTotal` text NOT NULL,
  `homeSupportOB` text NOT NULL,
  `homeSupportCB` text NOT NULL,
  `homeSupportTotalSpent` text NOT NULL,
  `assistiveTechTotal` text NOT NULL,
  `assistiveTechOB` text NOT NULL,
  `assistiveTechCB` text NOT NULL,
  `homeModificationTotal` text NOT NULL,
  `homeModificationOB` text NOT NULL,
  `homeModificationCB` text NOT NULL,
  `restorativeCareTotal` text NOT NULL,
  `restorativeCareOB` text NOT NULL,
  `restorativeCareCB` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarePackage`;
CREATE TABLE `cmCarePackage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) DEFAULT NULL,
  `contract_no` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerAvailability`;
CREATE TABLE `cmCarerAvailability` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `day` varchar(20) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `adjustedStartDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `week` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId_locationId` (`carerId`,`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerBank`;
CREATE TABLE `cmCarerBank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `accountName` varchar(200) DEFAULT NULL,
  `sortCode` varchar(100) DEFAULT NULL,
  `accountNum` varchar(100) DEFAULT NULL,
  `iban` varchar(100) DEFAULT NULL,
  `bic` varchar(100) DEFAULT NULL,
  `monthlyWage` decimal(10,2) DEFAULT NULL,
  `yearlyWage` decimal(10,2) DEFAULT NULL,
  `payCycle` varchar(100) DEFAULT NULL,
  `eType` varchar(100) DEFAULT NULL,
  `eAccountNumber` varchar(100) DEFAULT NULL,
  `EsortCode` varchar(100) DEFAULT NULL,
  `providerExtraInfo` varchar(100) DEFAULT NULL,
  `eAccount` int(1) DEFAULT NULL,
  `salaried` int(1) DEFAULT NULL,
  `continuousEmploymentDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`carerId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerBaseLocation`;
CREATE TABLE `cmCarerBaseLocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerContract`;
CREATE TABLE `cmCarerContract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `contractType` varchar(50) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `wingId` int(11) DEFAULT NULL,
  `jobtypeId` int(11) DEFAULT NULL,
  `weekContractHrs` decimal(10,2) DEFAULT NULL,
  `payscaleId` int(11) DEFAULT NULL,
  `hourRate` decimal(10,2) DEFAULT NULL,
  `fortnightSalary` decimal(10,2) DEFAULT NULL,
  `annualSalary` decimal(10,2) DEFAULT NULL,
  `annualLeave` varchar(50) DEFAULT NULL,
  `dateStart` date DEFAULT '1990-01-01',
  `dateEnd` date DEFAULT NULL,
  `gradeChangeDate` date DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `childId` int(11) DEFAULT NULL,
  `nextPayScaleId` int(11) DEFAULT NULL,
  `fteHours` varchar(20) DEFAULT NULL,
  `wte` varchar(50) DEFAULT NULL,
  `responsibilityAllowance` varchar(50) DEFAULT NULL,
  `contractId` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_company_location` (`companyId`,`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerContractArea`;
CREATE TABLE `cmCarerContractArea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contractId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_companyId` (`companyId`),
  KEY `idx_locationId` (`locationId`),
  KEY `idx_contractId` (`contractId`),
  KEY `idx_areaId` (`areaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerContractRequiredFields`;
CREATE TABLE `cmCarerContractRequiredFields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `contractType` varchar(256) DEFAULT NULL,
  `requiredFields` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerPay`;
CREATE TABLE `cmCarerPay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `day` varchar(200) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `timesBy` float DEFAULT NULL,
  `called` varchar(100) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `minutes` int(11) DEFAULT NULL,
  `payTotal` float DEFAULT NULL,
  `driverPay` float DEFAULT NULL,
  `overMinutes` int(11) DEFAULT NULL,
  `overPay` float DEFAULT NULL,
  `overTwoRates` int(11) DEFAULT NULL,
  `effectiveStart` date DEFAULT '2000-01-01',
  `effectiveFinish` date DEFAULT '2060-01-01',
  `percentIncrease` double DEFAULT NULL,
  `exportName` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `no` (`no`),
  KEY `start` (`start`),
  KEY `end` (`end`),
  KEY `minutes` (`minutes`),
  KEY `effectiveStart` (`effectiveStart`),
  KEY `effectiveFinish` (`effectiveFinish`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerPayCancelled`;
CREATE TABLE `cmCarerPayCancelled` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `cancelledPercentage` float DEFAULT NULL,
  `effectiveStart` date NOT NULL DEFAULT '2000-01-01',
  `effectiveFinish` date NOT NULL DEFAULT '2060-01-01',
  `payScaleId` int(11) DEFAULT NULL,
  `cancelReasonId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmCarerPayCancelled_index_payScale` (`payScaleId`),
  KEY `cmCarerPayCancelled_index_company` (`companyId`),
  KEY `cmCarerPayCancelled_index_location` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerPayPick`;
CREATE TABLE `cmCarerPayPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT '1990-01-01',
  `dateFinish` date DEFAULT '2050-01-01',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerPayScale`;
CREATE TABLE `cmCarerPayScale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `key` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerPayScaleTravelRates`;
CREATE TABLE `cmCarerPayScaleTravelRates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `rateCar` float DEFAULT NULL,
  `rateWalk` float DEFAULT NULL,
  `rateBike` float DEFAULT NULL,
  `rateBus` float DEFAULT NULL,
  `effectiveStart` date DEFAULT '2000-01-01',
  `effectiveFinish` date DEFAULT '2060-01-01',
  `payScaleId` int(11) DEFAULT NULL,
  `timeRate` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerPayScaleTraveTimelRates`;
CREATE TABLE `cmCarerPayScaleTraveTimelRates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `rateTime` float DEFAULT NULL,
  `effectiveStart` date DEFAULT '2000-01-01',
  `effectiveFinish` date DEFAULT '2060-01-01',
  `payScaleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCarerWorkweek`;
CREATE TABLE `cmCarerWorkweek` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `day` varchar(20) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `week` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId_locationId` (`carerId`,`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCategoryPlansTable`;
CREATE TABLE `cmCategoryPlansTable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `planId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChart`;
CREATE TABLE `cmChart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `saved` timestamp NULL DEFAULT NULL,
  `savedBy` int(11) DEFAULT NULL,
  `updateOf` int(11) DEFAULT NULL,
  `originalId` int(11) DEFAULT NULL,
  `directives` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartAlertBaselines`;
CREATE TABLE `cmChartAlertBaselines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alertId` int(11) DEFAULT NULL,
  `baselineId` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `limit` varchar(255) DEFAULT NULL,
  `limitType` int(11) DEFAULT NULL,
  `limitAlertLevel` int(11) DEFAULT NULL,
  `limitRecommendedAction` longtext,
  `reviewComment` longtext,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartAlerts`;
CREATE TABLE `cmChartAlerts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referenceType` int(11) DEFAULT NULL,
  `referenceId` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartAnswers`;
CREATE TABLE `cmChartAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `chartTakenId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `txtAnswer` varchar(1000) DEFAULT NULL,
  `type` varchar(250) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `opened_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `areaId` (`areaId`),
  KEY `chartTakenId` (`chartTakenId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `questionId` (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartAssign`;
CREATE TABLE `cmChartAssign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `keepRecurring` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `details` text,
  `reasonStop` text,
  `stoppedBy` int(11) DEFAULT NULL,
  `stoppedDate` datetime DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `weeks` varchar(10) DEFAULT NULL,
  `daysCount` varchar(10) DEFAULT NULL,
  `cloneOf` int(11) DEFAULT NULL,
  `effectiveStopTime` time DEFAULT NULL,
  `mon` int(1) DEFAULT NULL,
  `tue` int(1) DEFAULT NULL,
  `wed` int(1) DEFAULT NULL,
  `thu` int(1) DEFAULT NULL,
  `fri` int(1) DEFAULT NULL,
  `sat` int(1) DEFAULT NULL,
  `sun` int(1) DEFAULT NULL,
  `week` int(1) DEFAULT NULL,
  `everyNumDays` int(11) DEFAULT NULL,
  `dueRequired` int(1) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `directives` text,
  `periodIds` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartAssignTimes`;
CREATE TABLE `cmChartAssignTimes` (
  `created` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `chartAssignId` int(11) DEFAULT NULL,
  `times` time DEFAULT NULL,
  `timePeriodId` int(11) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `extraTime` int(11) DEFAULT NULL,
  `reasonForAdding` text,
  `outcomeId` varchar(200) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartBaselineNumerics`;
CREATE TABLE `cmChartBaselineNumerics` (
  `baselineId` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aboveValue` float DEFAULT NULL,
  `aboveAlert` tinyint(1) DEFAULT NULL,
  `aboveAlertLevel` int(11) DEFAULT NULL,
  `aboveNote` varchar(255) DEFAULT NULL,
  `belowValue` float DEFAULT NULL,
  `belowAlert` tinyint(1) DEFAULT NULL,
  `belowAlertLevel` int(11) DEFAULT NULL,
  `belowNote` varchar(255) DEFAULT NULL,
  `totalAboveValue` float DEFAULT NULL,
  `totalAboveAlert` tinyint(1) DEFAULT NULL,
  `totalAboveAlertLevel` int(11) DEFAULT NULL,
  `totalAboveNote` varchar(255) DEFAULT NULL,
  `totalBelowValue` float DEFAULT NULL,
  `totalBelowAlert` tinyint(1) DEFAULT NULL,
  `totalBelowAlertLevel` int(11) DEFAULT NULL,
  `totalBelowNote` varchar(255) DEFAULT NULL,
  `totalHours` int(11) DEFAULT NULL,
  `periodFrom` time DEFAULT NULL,
  `periodTo` time DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmChartBaselineNumerics_baselineId_index` (`baselineId`),
  CONSTRAINT `cmChartBaselineNumerics_cmChartBaselines_id_fk` FOREIGN KEY (`baselineId`) REFERENCES `cmChartBaselines` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartBaselineOptions`;
CREATE TABLE `cmChartBaselineOptions` (
  `baselineId` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answerId` int(11) DEFAULT NULL,
  `alert` tinyint(1) DEFAULT NULL,
  `alertLevel` int(11) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmChartBaselineOptions_baselineId_index` (`baselineId`),
  CONSTRAINT `cmChartBaselineOptions_cmChartBaselines_id_fk` FOREIGN KEY (`baselineId`) REFERENCES `cmChartBaselines` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartBaselines`;
CREATE TABLE `cmChartBaselines` (
  `chartId` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionId` int(11) NOT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmChartBaselines_carer_id_fk` (`createdBy`),
  KEY `cmChartBaselines_carer_id_fk_2` (`updatedBy`),
  KEY `cmChartBaselines_carer_id_fk_3` (`deletedBy`),
  KEY `cmChartBaselines_chartQuestions_id_fk` (`questionId`),
  KEY `cmChartBaselines_chart_id_fk` (`chartId`),
  KEY `cmChartBaselines_client_id_fk` (`clientId`),
  KEY `cmChartBaselines_company_id_fk` (`companyId`),
  KEY `cmChartBaselines_location_id_fk` (`locationId`),
  CONSTRAINT `cmChartBaselines_carer_id_fk` FOREIGN KEY (`createdBy`) REFERENCES `carer` (`id`),
  CONSTRAINT `cmChartBaselines_carer_id_fk_2` FOREIGN KEY (`updatedBy`) REFERENCES `carer` (`id`),
  CONSTRAINT `cmChartBaselines_carer_id_fk_3` FOREIGN KEY (`deletedBy`) REFERENCES `carer` (`id`),
  CONSTRAINT `cmChartBaselines_chartQuestions_id_fk` FOREIGN KEY (`questionId`) REFERENCES `cmChartQuestions` (`id`),
  CONSTRAINT `cmChartBaselines_chart_id_fk` FOREIGN KEY (`chartId`) REFERENCES `cmChart` (`id`),
  CONSTRAINT `cmChartBaselines_client_id_fk` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `cmChartBaselines_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `cmChartBaselines_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartQuestionAnswers`;
CREATE TABLE `cmChartQuestionAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answer` varchar(250) DEFAULT NULL,
  `appendedQues` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartQuestions`;
CREATE TABLE `cmChartQuestions` (
  `created_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `question` varchar(500) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  `measure` varchar(255) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `updated_id` int(11) NOT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmChartTaken`;
CREATE TABLE `cmChartTaken` (
  `created` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `closed` int(11) DEFAULT NULL,
  `closedTime` datetime DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `assignId` int(11) DEFAULT NULL,
  `assignTimesId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientBank`;
CREATE TABLE `cmClientBank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `swift` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientBankDetails`;
CREATE TABLE `cmClientBankDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contactId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `accountName` varchar(200) DEFAULT NULL,
  `sortCode` varchar(100) DEFAULT NULL,
  `bankCode` varchar(100) DEFAULT NULL,
  `accountNum` varchar(100) DEFAULT NULL,
  `iban` varchar(100) DEFAULT NULL,
  `bic` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientBilling`;
CREATE TABLE `cmClientBilling` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `day` varchar(200) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `timesBy` float DEFAULT NULL,
  `called` varchar(100) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `minutes` int(11) DEFAULT NULL,
  `billingTotal` float DEFAULT NULL,
  `overMinutes` int(11) DEFAULT NULL,
  `overBilling` float DEFAULT NULL,
  `overTwoRates` int(11) DEFAULT NULL,
  `effectiveStart` date DEFAULT '2000-01-01',
  `effectiveFinish` date DEFAULT '2060-01-01',
  `percentIncrease` double DEFAULT NULL,
  `cancelPercentBill` double DEFAULT NULL,
  `basedOn` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `no` (`no`),
  KEY `start` (`start`),
  KEY `end` (`end`),
  KEY `minutes` (`minutes`),
  KEY `effectiveStart` (`effectiveStart`),
  KEY `effectiveFinish` (`effectiveFinish`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientBillingCancelled`;
CREATE TABLE `cmClientBillingCancelled` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `cancelledPercentage` float DEFAULT NULL,
  `effectiveStart` date NOT NULL DEFAULT '2000-01-01',
  `effectiveFinish` date NOT NULL DEFAULT '2060-01-01',
  `billingScaleId` int(11) DEFAULT NULL,
  `cancelReasonId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `billingScaleId` (`billingScaleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientBillingPick`;
CREATE TABLE `cmClientBillingPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `billingScaleId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT '1990-01-01',
  `dateFinish` date DEFAULT '2050-01-01',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientBillingScale`;
CREATE TABLE `cmClientBillingScale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientBillingTravelRates`;
CREATE TABLE `cmClientBillingTravelRates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `rateCar` float DEFAULT NULL,
  `rateWalk` float DEFAULT NULL,
  `rateBike` float DEFAULT NULL,
  `rateBus` float DEFAULT NULL,
  `effectiveStart` date DEFAULT '2000-01-01',
  `effectiveFinish` date DEFAULT '2060-01-01',
  `billingScaleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientChartList`;
CREATE TABLE `cmClientChartList` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chartId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `value` varchar(20) DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `effectiveFinish` date DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientPay`;
CREATE TABLE `cmClientPay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `day` varchar(200) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `timesBy` float DEFAULT NULL,
  `called` varchar(100) DEFAULT NULL,
  `no` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `minutes` int(11) DEFAULT NULL,
  `payTotal` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientPayPick`;
CREATE TABLE `cmClientPayPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT '1990-01-01',
  `dateFinish` date DEFAULT '2050-01-01',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`clientId`),
  KEY `carerId_2` (`carerId`),
  CONSTRAINT `cmClientPayPick_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `cmClientPayPick_ibfk_2` FOREIGN KEY (`carerId`) REFERENCES `carer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientPayScale`;
CREATE TABLE `cmClientPayScale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmClientWallet`;
CREATE TABLE `cmClientWallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `expenseId` int(11) DEFAULT NULL,
  `oldAmount` double DEFAULT NULL,
  `transactionAmount` double DEFAULT NULL,
  `newAmount` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmComments`;
CREATE TABLE `cmComments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `comment` text,
  `type` varchar(2) DEFAULT NULL,
  `editId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCommentsGlobal`;
CREATE TABLE `cmCommentsGlobal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `entityTable` varchar(50) NOT NULL,
  `entityId` int(11) NOT NULL,
  `commentTypeId` int(11) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `idx_companyId` (`companyId`),
  KEY `idx_locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCommentsPending`;
CREATE TABLE `cmCommentsPending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `comment` text,
  `type` varchar(2) DEFAULT NULL,
  `editId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCommentTypesGlobal`;
CREATE TABLE `cmCommentTypesGlobal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `entityTable` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCompanyBillingPick`;
CREATE TABLE `cmCompanyBillingPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `billingScaleId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT '1990-01-01',
  `dateFinish` date DEFAULT '2050-01-01',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCompanyClientPayPick`;
CREATE TABLE `cmCompanyClientPayPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCompanyLogo`;
CREATE TABLE `cmCompanyLogo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `image` longblob,
  `name` varchar(100) DEFAULT NULL,
  `prefixId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmCompanyPayPick`;
CREATE TABLE `cmCompanyPayPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT '1990-01-01',
  `dateFinish` date DEFAULT '2050-01-01',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmContractSettings`;
CREATE TABLE `cmContractSettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `calcHolidays` varchar(60) DEFAULT NULL,
  `tupe` varchar(20) DEFAULT 'No',
  `holidaysAllocatedCarer` float DEFAULT NULL,
  `allocatedDays` float DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `noPapi` int(1) DEFAULT NULL,
  `noHTS` int(1) DEFAULT NULL,
  `excludeTravelPay` int(1) DEFAULT NULL,
  `entitlementDays` float DEFAULT NULL,
  `minWeeklyHrs` float DEFAULT NULL,
  `minRate` float DEFAULT NULL,
  `maxLeave` float DEFAULT '0',
  `continuousEmploymentDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmContractsHours`;
CREATE TABLE `cmContractsHours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `mon` int(11) DEFAULT NULL,
  `tue` int(11) DEFAULT NULL,
  `wed` int(11) DEFAULT NULL,
  `thu` int(11) DEFAULT NULL,
  `fri` int(11) DEFAULT NULL,
  `sat` int(11) DEFAULT NULL,
  `sun` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `weekHours` int(11) DEFAULT NULL,
  `archiveId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `cmdailyTaskAssignNoShow`;
CREATE TABLE `cmdailyTaskAssignNoShow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` date DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `dateNoShow` date DEFAULT NULL,
  `cmdailyTaskAssignTimesId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`clientId`),
  KEY `availabilityId` (`cmdailyTaskAssignTimesId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasks`;
CREATE TABLE `cmdailyTasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `categoryId` int(11) DEFAULT '1',
  `themeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksAssign`;
CREATE TABLE `cmdailyTasksAssign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `keepRecurring` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `cmdailyTasksId` int(11) DEFAULT NULL,
  `taskTime` time DEFAULT NULL,
  `details` text,
  `tags` varchar(200) DEFAULT NULL,
  `reasonStop` text,
  `taskOptional` int(11) DEFAULT NULL,
  `stoppedBy` int(11) DEFAULT NULL,
  `stoppedDate` datetime DEFAULT NULL,
  `effectiveStopTime` time DEFAULT NULL,
  `mon` int(1) DEFAULT NULL,
  `tue` int(1) DEFAULT NULL,
  `wed` int(1) DEFAULT NULL,
  `thu` int(1) DEFAULT NULL,
  `fri` int(1) DEFAULT NULL,
  `sat` int(1) DEFAULT NULL,
  `sun` int(1) DEFAULT NULL,
  `week` int(11) DEFAULT NULL,
  `everyNumDays` int(11) DEFAULT NULL,
  `outcomeId` varchar(200) DEFAULT NULL,
  `mandatory` tinyint(4) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `stageGoalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmdailyTasksId` (`cmdailyTasksId`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `dateFinish` (`dateFinish`),
  KEY `dateStart` (`dateStart`),
  KEY `week` (`week`),
  KEY `everyNumDays` (`everyNumDays`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksAssignPermission`;
CREATE TABLE `cmdailyTasksAssignPermission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksAssignTimes`;
CREATE TABLE `cmdailyTasksAssignTimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `cmdailyTasksAssign` int(11) DEFAULT NULL,
  `times` time DEFAULT NULL,
  `timePeriodId` int(11) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `extraTime` int(11) DEFAULT NULL,
  `reasonForAdding` text,
  `day` varchar(20) DEFAULT NULL,
  `week` int(2) DEFAULT NULL,
  `everyNumDays` int(3) DEFAULT NULL,
  `outcomeId` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmdailyTasksAssign` (`cmdailyTasksAssign`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksCategories`;
CREATE TABLE `cmdailyTasksCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `category` (`category`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksClientTags`;
CREATE TABLE `cmdailyTasksClientTags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `taskId` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `tagId` (`tagId`),
  KEY `taskId` (`taskId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksFiles`;
CREATE TABLE `cmdailyTasksFiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(200) DEFAULT NULL,
  `fileSize` varchar(200) DEFAULT NULL,
  `fileType` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksReason`;
CREATE TABLE `cmdailyTasksReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `ddorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `categoryId` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksReasonCategory`;
CREATE TABLE `cmdailyTasksReasonCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `color` varchar(200) DEFAULT NULL,
  `orderby` int(11) DEFAULT NULL,
  `commentRequired` tinyint(4) DEFAULT NULL,
  `replaceCategoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksResults`;
CREATE TABLE `cmdailyTasksResults` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `dateEntered` date DEFAULT NULL,
  `timeEntered` time DEFAULT NULL,
  `taskDone` int(11) DEFAULT NULL,
  `subTaskDone` int(11) DEFAULT NULL,
  `timeSaid` time DEFAULT NULL,
  `comment` text,
  `taskAssignId` int(11) DEFAULT NULL,
  `taskId` int(11) DEFAULT NULL,
  `tasksAssignTimesId` int(11) DEFAULT NULL,
  `editOf` int(11) DEFAULT NULL,
  `outcomeId` varchar(500) DEFAULT NULL,
  `alertId` int(11) DEFAULT NULL,
  `alertSeenBy` int(11) DEFAULT NULL,
  `mandatory` tinyint(4) DEFAULT NULL,
  `scriptLoc` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taskAssignId` (`taskAssignId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `clientId` (`clientId`),
  KEY `tasksAssignTimesId` (`tasksAssignTimesId`),
  KEY `dateEntered` (`dateEntered`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksTags`;
CREATE TABLE `cmdailyTasksTags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` datetime DEFAULT NULL,
  `tag` varchar(300) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmdailyTasksThemes`;
CREATE TABLE `cmdailyTasksThemes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmEmployeePositions`;
CREATE TABLE `cmEmployeePositions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `adminFlag` int(1) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `excludeTagConflict` int(11) DEFAULT NULL,
  `residentialCareFlag` int(11) DEFAULT NULL,
  `nonCareRole` int(11) DEFAULT NULL,
  `orderBy` int(11) DEFAULT NULL,
  `localisedLoc` int(11) DEFAULT '0' COMMENT '0 applies position to whole company',
  `positionCode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmEthnicity`;
CREATE TABLE `cmEthnicity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpenses`;
CREATE TABLE `cmExpenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `timesheetExpenseId` int(11) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `expenseCategory` int(11) DEFAULT NULL,
  `fileId` int(11) DEFAULT NULL,
  `taxed` int(11) DEFAULT NULL,
  `payCarer` int(11) DEFAULT NULL,
  `billClient` int(11) DEFAULT NULL,
  `payCarerAmount` double DEFAULT NULL,
  `billClientAmount` double DEFAULT NULL,
  `confirmed` int(1) DEFAULT NULL,
  `confirmedDate` datetime DEFAULT NULL,
  `confirmedBy` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `walletTransaction` int(1) DEFAULT NULL,
  `lockDown` datetime DEFAULT NULL,
  `lockdownPayroll` datetime DEFAULT NULL,
  `adjustment` int(11) DEFAULT '0',
  `editId` int(11) DEFAULT NULL,
  `statutoryDate` date DEFAULT NULL,
  `statutoryLeaveId` int(11) DEFAULT NULL,
  `statutoryHrs` float DEFAULT NULL,
  `editPercBill` float DEFAULT NULL,
  `expenseAdvType` int(11) DEFAULT '0',
  `isWrap` int(11) DEFAULT '0',
  `wrapParentCode` varchar(50) DEFAULT NULL,
  `purchaseType` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`),
  KEY `jobType` (`jobType`),
  KEY `date` (`date`),
  KEY `billClient` (`billClient`),
  KEY `lockDown` (`lockDown`),
  KEY `timesheetId` (`timesheetId`),
  KEY `timesheetExpenseId` (`timesheetExpenseId`),
  KEY `companyId` (`companyId`),
  KEY `lockdownPayroll` (`lockdownPayroll`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesAdhoc`;
CREATE TABLE `cmExpensesAdhoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `description` varchar(800) DEFAULT NULL,
  `affectiveStart` date DEFAULT '2000-01-01',
  `affectiveFinish` date DEFAULT '2060-01-01',
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `jobtypeId` int(11) DEFAULT NULL,
  `frequencyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesAdv`;
CREATE TABLE `cmExpensesAdv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `code` varchar(40) NOT NULL,
  `fundingCategory` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesAdvSub1`;
CREATE TABLE `cmExpensesAdvSub1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `code` varchar(40) NOT NULL,
  `idparent` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesAdvSub2`;
CREATE TABLE `cmExpensesAdvSub2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `code` varchar(40) NOT NULL,
  `idparent1` int(11) NOT NULL,
  `idparent2` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesExtended`;
CREATE TABLE `cmExpensesExtended` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expenseId` int(11) NOT NULL COMMENT 'Foreign key to cmExpenses.id',
  `prescribedItem` tinyint(1) DEFAULT '0' COMMENT '0=No, 1=Yes',
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `loanedByInv` text,
  `loanedBy` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expenseId` (`expenseId`),
  KEY `idx_expenseId` (`expenseId`),
  KEY `idx_prescribedItem` (`prescribedItem`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesFile`;
CREATE TABLE `cmExpensesFile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(200) DEFAULT NULL,
  `fileSize` varchar(200) DEFAULT NULL,
  `fileType` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesRecurr`;
CREATE TABLE `cmExpensesRecurr` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(10) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(10) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(10) DEFAULT NULL,
  `companyId` int(10) DEFAULT NULL,
  `locationId` int(10) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL COMMENT 'carer or client',
  `idsInclude` text,
  `idsExclude` varchar(100) DEFAULT NULL,
  `cycle` varchar(100) DEFAULT NULL,
  `expenseType` int(10) DEFAULT NULL,
  `expenseDescription` text,
  `expenseValue` decimal(10,5) DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `effectiveFinish` date DEFAULT NULL,
  `jobType` int(10) DEFAULT NULL,
  `dayOfMonth` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `effectiveStart` (`effectiveStart`) USING BTREE,
  KEY `effectiveFinish` (`effectiveFinish`) USING BTREE,
  KEY `locationId_effectiveStart` (`locationId`,`effectiveStart`) USING BTREE,
  KEY `locationId_effectiveFinish` (`locationId`,`effectiveFinish`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesType`;
CREATE TABLE `cmExpensesType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(300) DEFAULT NULL,
  `payCarer` int(11) DEFAULT NULL,
  `billClient` int(11) DEFAULT NULL,
  `taxed` int(11) DEFAULT NULL,
  `expense` int(1) DEFAULT NULL,
  `walletAdjustment` int(1) DEFAULT NULL,
  `walletTransaction` int(1) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `category` varchar(50) DEFAULT 'general' COMMENT 'general, adjustment, invoicegenerate',
  `payPercent` int(11) DEFAULT '100',
  `billPercent` int(11) DEFAULT '100',
  `x3Title` varchar(50) DEFAULT NULL,
  `carerAppView` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `carerAppView` (`carerAppView`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpensesWrap`;
CREATE TABLE `cmExpensesWrap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `code` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmExpenseTimesheets`;
CREATE TABLE `cmExpenseTimesheets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `update` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` mediumtext,
  `clientIdExc` mediumtext,
  `carerId` mediumtext,
  `jobTypeId` varchar(500) DEFAULT NULL,
  `carerPositionId` varchar(500) DEFAULT NULL,
  `carerPositionIdExc` varchar(500) DEFAULT NULL,
  `durationGreated` int(11) DEFAULT NULL,
  `overnight` int(11) DEFAULT NULL,
  `expenseType` int(11) DEFAULT NULL,
  `description` varchar(400) DEFAULT NULL,
  `expense` float DEFAULT NULL,
  `payCarer` int(11) DEFAULT NULL,
  `billClient` int(11) DEFAULT NULL,
  `taxed` int(11) DEFAULT NULL,
  `sqlString` text,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFamily`;
CREATE TABLE `cmFamily` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `sname` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(300) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFamilyConnection`;
CREATE TABLE `cmFamilyConnection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `linkcode` int(11) DEFAULT NULL,
  `activated` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormListName`;
CREATE TABLE `cmFormListName` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(120) DEFAULT NULL,
  `code` varchar(120) DEFAULT NULL,
  `companyId` varchar(120) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `showForm` varchar(20) DEFAULT NULL,
  `userSide` int(11) DEFAULT NULL,
  `showScore` int(11) DEFAULT '1',
  `showNA` int(11) DEFAULT '1',
  `levelId` int(11) DEFAULT NULL COMMENT '1= High 2=Medium 3=Low',
  `localizedLocation` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormQuestion`;
CREATE TABLE `cmFormQuestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(120) DEFAULT NULL,
  `question` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `category` varchar(250) DEFAULT NULL,
  `userSide` int(1) DEFAULT NULL,
  `cmFormQuestionPictureId` int(11) DEFAULT NULL,
  `showPrintPDF` int(11) DEFAULT '1',
  `localizedLocation` int(11) DEFAULT NULL,
  `fileCabLink` varchar(200) DEFAULT NULL,
  `copied` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormQuestionAnswers`;
CREATE TABLE `cmFormQuestionAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answer` varchar(300) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `outcome` varchar(600) DEFAULT NULL,
  `appendFormId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `done` int(11) DEFAULT NULL,
  `alertAnswerLevel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `questionId` (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormQuestionAnswerTable`;
CREATE TABLE `cmFormQuestionAnswerTable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `header1` varchar(200) DEFAULT NULL,
  `header2` varchar(200) DEFAULT NULL,
  `header3` varchar(200) DEFAULT NULL,
  `header4` varchar(200) DEFAULT NULL,
  `header5` varchar(200) DEFAULT NULL,
  `header6` varchar(200) DEFAULT NULL,
  `header7` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `done` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormQuestionPicture`;
CREATE TABLE `cmFormQuestionPicture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `cmFormQuestionId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(100) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `fileSize` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsAnswers`;
CREATE TABLE `cmFormsAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `formsTakenId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `answer` text,
  `score` int(11) DEFAULT NULL,
  `type` varchar(120) DEFAULT NULL,
  `answeredBy` int(11) DEFAULT NULL,
  `answeredPage` int(11) DEFAULT NULL COMMENT '1=takeFormTableComplete',
  `updatedHistory` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `formsTakenId` (`formsTakenId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `questionId` (`questionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsAnswersTable`;
CREATE TABLE `cmFormsAnswersTable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `formsTakenId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `header1` text,
  `header2` text,
  `header3` text,
  `header4` text,
  `header5` text,
  `header6` text,
  `header7` text,
  `type` varchar(50) DEFAULT NULL,
  `answeredBy` int(11) DEFAULT NULL,
  `updatedHistoryTbl` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `formsTakenId` (`formsTakenId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsAnswersUpdated`;
CREATE TABLE `cmFormsAnswersUpdated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `formsTakenId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `answer` text,
  `score` int(11) DEFAULT NULL,
  `type` varchar(120) DEFAULT NULL,
  `answeredBy` int(11) DEFAULT NULL,
  `answeredPage` int(11) DEFAULT NULL COMMENT '1=takeFormTableComplete',
  PRIMARY KEY (`id`),
  KEY `formsTakenId` (`formsTakenId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsOpenAnswers`;
CREATE TABLE `cmFormsOpenAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `formsTakenId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `answer` text,
  `score` int(11) DEFAULT NULL,
  `type` varchar(120) DEFAULT NULL,
  `answeredBy` int(11) DEFAULT NULL,
  `answeredPage` int(11) DEFAULT NULL COMMENT '1=takeFormTableComplete',
  `closed` int(11) DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `closedTime` datetime DEFAULT NULL,
  `locked` int(11) DEFAULT NULL,
  `lockedTime` datetime DEFAULT NULL,
  `lockedTo` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `formsTakenId` (`formsTakenId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `questionId` (`questionId`),
  KEY `closed` (`closed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsOpenAnswersTable`;
CREATE TABLE `cmFormsOpenAnswersTable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `row` int(11) DEFAULT NULL,
  `formsTakenId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `header1` text,
  `header2` text,
  `header3` text,
  `header4` text,
  `header5` text,
  `header6` text,
  `header7` text,
  `type` varchar(50) DEFAULT NULL,
  `answeredBy` int(11) DEFAULT NULL,
  `closed` int(11) DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `closedTime` datetime DEFAULT NULL,
  `locked` int(11) DEFAULT NULL,
  `lockedTime` datetime DEFAULT NULL,
  `lockedTo` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `formsTakenId` (`formsTakenId`),
  KEY `companyId` (`companyId`),
  KEY `deleted` (`deleted`),
  KEY `questionId` (`questionId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsPic`;
CREATE TABLE `cmFormsPic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `formsTakenId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `fileName` varchar(150) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsPlansTaken`;
CREATE TABLE `cmFormsPlansTaken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `completed` datetime DEFAULT NULL,
  `completedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `planId` int(11) DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `nextPlan` int(11) DEFAULT NULL,
  `appendedPlanName` varchar(250) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  `archived` datetime DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `planId` (`planId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsPlansUpdated`;
CREATE TABLE `cmFormsPlansUpdated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `completed` datetime DEFAULT NULL,
  `completedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `planId` int(11) DEFAULT NULL,
  `planTakenId` int(11) DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `nextPlan` int(11) DEFAULT NULL,
  `changeDone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `planId` (`planId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsSignOff`;
CREATE TABLE `cmFormsSignOff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataURL` mediumtext,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedHis` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `planUpdatedId` int(100) DEFAULT NULL,
  `formTakenId` int(11) DEFAULT NULL,
  `person` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  `fundingId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `formTakenId` (`formTakenId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormsTaken`;
CREATE TABLE `cmFormsTaken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `planTakenId` int(11) DEFAULT NULL,
  `formId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `filledBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `closed` int(11) DEFAULT NULL,
  `closedTime` datetime DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  `appendedFormName` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planTakenId` (`planTakenId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFormStructure`;
CREATE TABLE `cmFormStructure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(120) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `questionOrder` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFrequency`;
CREATE TABLE `cmFrequency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `frequencyName` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFutureConflicts`;
CREATE TABLE `cmFutureConflicts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `recurrId1` int(11) DEFAULT NULL,
  `clientId1` int(11) DEFAULT NULL,
  `logDate1` date DEFAULT NULL,
  `startTime1` datetime DEFAULT NULL,
  `finishTime1` datetime DEFAULT NULL,
  `recurrId2` int(11) DEFAULT NULL,
  `clientId2` int(11) DEFAULT NULL,
  `logDate2` date DEFAULT NULL,
  `startTime2` datetime DEFAULT NULL,
  `finishTime2` datetime DEFAULT NULL,
  `ignoreConflict` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFutureStatusChange`;
CREATE TABLE `cmFutureStatusChange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  `updatedFromId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `changeType` varchar(20) DEFAULT NULL,
  `originalState` int(11) DEFAULT NULL,
  `originalStatus` int(11) DEFAULT NULL,
  `originalChangeDate` datetime DEFAULT NULL,
  `originalChangeRan` datetime DEFAULT NULL,
  `changedState` int(11) DEFAULT NULL,
  `changedStatus` int(11) DEFAULT NULL,
  `changedStatusBackDate` datetime DEFAULT NULL,
  `changedStatusBackRan` datetime DEFAULT NULL,
  `comments` text,
  `reasonId` int(11) DEFAULT NULL,
  `completed` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `originalChangeRan` (`originalChangeRan`),
  KEY `changedStatusBackRan` (`changedStatusBackRan`),
  KEY `changedStatusBackDate` (`changedStatusBackDate`),
  KEY `originalChangeDate` (`originalChangeDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFutureStatusChangeCarer`;
CREATE TABLE `cmFutureStatusChangeCarer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  `updatedFromId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `changeType` varchar(20) DEFAULT NULL,
  `originalState` int(11) DEFAULT NULL,
  `originalStatus` int(11) DEFAULT NULL,
  `originalChangeDate` datetime DEFAULT NULL,
  `originalChangeRan` datetime DEFAULT NULL,
  `changedState` int(11) DEFAULT NULL,
  `changedStatus` int(11) DEFAULT NULL,
  `changedStatusBackDate` datetime DEFAULT NULL,
  `changedStatusBackRan` datetime DEFAULT NULL,
  `comments` text,
  `reasonId` int(11) DEFAULT NULL,
  `completed` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmFutureStatusReason`;
CREATE TABLE `cmFutureStatusReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `reason` varchar(250) DEFAULT NULL,
  `side` varchar(60) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmHelp`;
CREATE TABLE `cmHelp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` datetime DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `details` varchar(600) DEFAULT NULL,
  `adminLVL` int(11) DEFAULT '1',
  `videoUrl` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmHelpViewed`;
CREATE TABLE `cmHelpViewed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `videoId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmHolidayRejectedReason`;
CREATE TABLE `cmHolidayRejectedReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmHolidayRequests`;
CREATE TABLE `cmHolidayRequests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `requestStatus` int(1) DEFAULT NULL,
  `actionBy` int(11) DEFAULT NULL,
  `actionTimestamp` datetime DEFAULT NULL,
  `actionComment` varchar(1000) DEFAULT NULL,
  `rejectedReasonId` int(11) DEFAULT NULL,
  `pageLoadedAfterAction` datetime DEFAULT NULL,
  `seenDate` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `leaveType` int(11) DEFAULT NULL,
  `sickLeaveType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`),
  KEY `deleted` (`deleted`),
  KEY `requestStatus` (`requestStatus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmHoursRejectedReason`;
CREATE TABLE `cmHoursRejectedReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmHoursRequests`;
CREATE TABLE `cmHoursRequests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `requestStatus` int(11) DEFAULT NULL,
  `closedStatus` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `actionBy` int(11) DEFAULT NULL,
  `actionTimestamp` datetime DEFAULT NULL,
  `rejectedReasonId` int(11) DEFAULT NULL,
  `actionComment` varchar(1000) DEFAULT NULL,
  `overNight` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recurrId` (`recurrId`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`),
  KEY `deleted` (`deleted`),
  KEY `requestStatus` (`requestStatus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmHoursRequestsClosedStatus`;
CREATE TABLE `cmHoursRequestsClosedStatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInterTravelDetails`;
CREATE TABLE `cmInterTravelDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `confirmed` timestamp NULL DEFAULT NULL,
  `confirmedBy` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `totalTravel` int(11) DEFAULT NULL,
  `totalTravelPay` float(8,2) DEFAULT NULL,
  `canceled` timestamp NULL DEFAULT NULL,
  `canceledBy` int(11) DEFAULT NULL,
  `carerComment` longtext,
  `adminComment` longtext,
  KEY `id` (`id`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `timesheetId` (`timesheetId`) USING BTREE,
  KEY `clientId` (`clientId`) USING BTREE,
  KEY `carerId` (`carerId`) USING BTREE,
  KEY `date` (`date`),
  KEY `confirmed` (`confirmed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInterTravelDetailsAddresses`;
CREATE TABLE `cmInterTravelDetailsAddresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `cmInterTravelDetailsId` int(11) DEFAULT NULL,
  `tag` varchar(250) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `time` varchar(250) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  KEY `id` (`id`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `cmInterTravelDetailsId` (`cmInterTravelDetailsId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInterTravelDetailsItems`;
CREATE TABLE `cmInterTravelDetailsItems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `cmInterTravelDetailsId` int(11) DEFAULT NULL,
  `startLocation` varchar(250) DEFAULT NULL,
  `endLocation` varchar(250) DEFAULT NULL,
  `totalTravel` int(11) DEFAULT NULL,
  `totalTravelPay` float(8,2) DEFAULT NULL,
  KEY `id` (`id`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `cmInterTravelDetailsId` (`cmInterTravelDetailsId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceAmazonStorage`;
CREATE TABLE `cmInvoiceAmazonStorage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `invoiceId` varchar(1500) DEFAULT NULL,
  `fileName` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceCycle`;
CREATE TABLE `cmInvoiceCycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(400) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceDetails`;
CREATE TABLE `cmInvoiceDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `invoiceType` varchar(50) DEFAULT 'invoice',
  `jobTypeId` varchar(200) DEFAULT NULL,
  `jobTypeName` varchar(800) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `split` double DEFAULT NULL,
  `splitType` varchar(50) DEFAULT 'percent' COMMENT 'percent or value',
  `splitValue` decimal(10,5) DEFAULT NULL,
  `invoiceTemplateId` int(11) DEFAULT NULL,
  `invoiceNumber` varchar(20) DEFAULT NULL,
  `invoiceNumberPre` varchar(20) DEFAULT NULL,
  `invoiceNum` int(11) DEFAULT NULL,
  `companyLine1` varchar(400) DEFAULT NULL,
  `companyLine2` varchar(400) DEFAULT NULL,
  `companyLine3` varchar(200) DEFAULT NULL,
  `companyLine4` varchar(200) DEFAULT NULL,
  `companyLine5` varchar(200) DEFAULT NULL,
  `companyLine6` varchar(200) DEFAULT NULL,
  `invoiceInfoLine1` varchar(400) DEFAULT NULL,
  `invoiceInfoLine2` varchar(400) DEFAULT NULL,
  `invoiceInfoLine3` varchar(200) DEFAULT NULL,
  `invoiceInfoLine4` varchar(200) DEFAULT NULL,
  `invoiceInfoLine5` varchar(200) DEFAULT NULL,
  `paymentDue` varchar(200) DEFAULT NULL,
  `periodStart` varchar(200) DEFAULT NULL,
  `periodFinish` varchar(200) DEFAULT NULL,
  `clientName` varchar(200) DEFAULT NULL,
  `clientAddressLine` varchar(250) DEFAULT NULL,
  `invoiceecontactid` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `areaName` varchar(400) DEFAULT NULL,
  `workgroupId` varchar(20) DEFAULT NULL,
  `workgroupName` varchar(400) DEFAULT NULL,
  `branchId` varchar(20) DEFAULT NULL,
  `branchName` varchar(400) DEFAULT NULL,
  `funderName` varchar(400) DEFAULT NULL,
  `managerName` varchar(400) DEFAULT NULL,
  `coordinatorName` varchar(400) DEFAULT NULL,
  `councilId` varchar(400) DEFAULT NULL,
  `currentUnit` varchar(400) DEFAULT NULL,
  `billingCode` varchar(400) DEFAULT NULL,
  `referralReason` varchar(300) DEFAULT NULL,
  `referralBy` varchar(300) DEFAULT NULL,
  `residentId` varchar(100) DEFAULT NULL,
  `issueDate` date DEFAULT NULL,
  `printedDate` date DEFAULT NULL,
  `createInvoice` int(11) DEFAULT NULL,
  `sageDepId` varchar(50) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `codeSplit` varchar(100) DEFAULT NULL,
  `preview` int(11) DEFAULT '0',
  `note` varchar(400) DEFAULT NULL,
  `allocatedHrs` float DEFAULT NULL,
  `timesheetsIds` text,
  `expensesIds` text,
  `originCode` varchar(100) DEFAULT NULL,
  `customerNumber` varchar(100) DEFAULT NULL,
  `recalculateParentId` varchar(400) DEFAULT NULL,
  `recalculateChildId` varchar(250) DEFAULT NULL,
  `creditParentId` int(11) DEFAULT NULL,
  `creditChildId` int(11) DEFAULT NULL,
  `manualInvoice` int(11) DEFAULT NULL,
  `totalPaid` decimal(15,5) DEFAULT NULL,
  `currentBalance` decimal(15,5) DEFAULT NULL,
  `batchId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `referralReason` (`referralReason`),
  KEY `areaId` (`areaId`),
  KEY `preview` (`preview`),
  KEY `created` (`created`),
  KEY `invoiceNumber` (`invoiceNumber`),
  KEY `invoiceTemplateId` (`invoiceTemplateId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`),
  KEY `referralBy` (`referralBy`),
  CONSTRAINT `cmInvoiceDetails_ibfk_2` FOREIGN KEY (`areaId`) REFERENCES `area` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceDetails24022021`;
CREATE TABLE `cmInvoiceDetails24022021` (
  `id` int(11) NOT NULL DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `invoiceType` varchar(50) DEFAULT 'invoice',
  `jobTypeId` varchar(200) DEFAULT NULL,
  `jobTypeName` varchar(800) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `split` int(11) DEFAULT NULL,
  `invoiceTemplateId` int(11) DEFAULT NULL,
  `invoiceNumber` varchar(20) DEFAULT NULL,
  `invoiceNumberPre` varchar(20) DEFAULT NULL,
  `invoiceNum` int(11) DEFAULT NULL,
  `companyLine1` varchar(400) DEFAULT NULL,
  `companyLine2` varchar(400) DEFAULT NULL,
  `companyLine3` varchar(200) DEFAULT NULL,
  `companyLine4` varchar(200) DEFAULT NULL,
  `companyLine5` varchar(200) DEFAULT NULL,
  `companyLine6` varchar(200) DEFAULT NULL,
  `invoiceInfoLine1` varchar(400) DEFAULT NULL,
  `invoiceInfoLine2` varchar(400) DEFAULT NULL,
  `invoiceInfoLine3` varchar(200) DEFAULT NULL,
  `invoiceInfoLine4` varchar(200) DEFAULT NULL,
  `invoiceInfoLine5` varchar(200) DEFAULT NULL,
  `paymentDue` varchar(200) DEFAULT NULL,
  `periodStart` varchar(200) DEFAULT NULL,
  `periodFinish` varchar(200) DEFAULT NULL,
  `clientName` varchar(200) DEFAULT NULL,
  `clientAddressLine` varchar(250) DEFAULT NULL,
  `invoiceecontactid` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `areaName` varchar(400) DEFAULT NULL,
  `workgroupId` varchar(20) DEFAULT NULL,
  `workgroupName` varchar(400) DEFAULT NULL,
  `branchId` varchar(20) DEFAULT NULL,
  `branchName` varchar(400) DEFAULT NULL,
  `funderName` varchar(400) DEFAULT NULL,
  `managerName` varchar(400) DEFAULT NULL,
  `coordinatorName` varchar(400) DEFAULT NULL,
  `councilId` varchar(400) DEFAULT NULL,
  `currentUnit` varchar(400) DEFAULT NULL,
  `billingCode` varchar(400) DEFAULT NULL,
  `referralReason` varchar(300) DEFAULT NULL,
  `residentId` varchar(100) DEFAULT NULL,
  `issueDate` date DEFAULT NULL,
  `printedDate` date DEFAULT NULL,
  `createInvoice` int(11) DEFAULT NULL,
  `sageDepId` int(11) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `codeSplit` varchar(100) DEFAULT NULL,
  `preview` int(11) DEFAULT '0',
  `note` varchar(400) DEFAULT NULL,
  `allocatedHrs` float DEFAULT NULL,
  `timesheetsIds` text,
  `expensesIds` text,
  `originCode` varchar(100) DEFAULT NULL,
  `customerNumber` varchar(100) DEFAULT NULL,
  `recalculateParentId` varchar(250) DEFAULT NULL,
  `recalculateChildId` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceDetailsItems`;
CREATE TABLE `cmInvoiceDetailsItems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT 'timesheet' COMMENT 'timesheet | expense | credit',
  `subtype` varchar(50) DEFAULT NULL COMMENT 'adjustment',
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `invoiceId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `expenseId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `schedStart` datetime DEFAULT NULL,
  `schedFinish` datetime DEFAULT NULL,
  `overnight` int(1) DEFAULT NULL,
  `schedDuration` time DEFAULT NULL,
  `actualStart` time DEFAULT NULL,
  `actualFinish` time DEFAULT NULL,
  `actualDuration` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `jobtypeId` int(11) DEFAULT NULL,
  `billing` decimal(15,5) DEFAULT NULL,
  `billingDecimals` decimal(15,5) DEFAULT NULL,
  `billingAllocatedLimited` float DEFAULT NULL,
  `billingCalled` varchar(100) DEFAULT NULL,
  `billingRate` varchar(100) DEFAULT NULL,
  `billingScaleId` int(11) DEFAULT NULL,
  `billingScaleName` varchar(200) DEFAULT NULL,
  `pay` float DEFAULT NULL,
  `payCalled` varchar(100) DEFAULT NULL,
  `payRate` varchar(100) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  `payScaleName` varchar(200) DEFAULT NULL,
  `invoiceShortDate` varchar(100) DEFAULT NULL COMMENT 'Ex. 06-01-2020',
  `invoiceWeekDate` varchar(100) DEFAULT NULL COMMENT 'Ex. Mon 06-01-2020',
  `invoiceTimeActual` varchar(100) DEFAULT NULL COMMENT 'Ex: 10:00-12:00',
  `invoiceTimeSched` varchar(100) DEFAULT NULL COMMENT 'Ex: 10:02-11:58',
  `invoiceCarerName` varchar(100) DEFAULT NULL,
  `jobTypeName` varchar(100) DEFAULT NULL,
  `invoiceJobTypeName` varchar(100) DEFAULT NULL COMMENT 'Band',
  `invoicePO` varchar(600) DEFAULT NULL COMMENT 'Reference',
  `invoiceCarerPosition` varchar(100) DEFAULT NULL,
  `invoiceHrs` float DEFAULT NULL,
  `invoiceAllocatedLimitedHrs` float DEFAULT NULL,
  `discountPercent` float DEFAULT NULL,
  `discountTotal` float DEFAULT NULL,
  `invoiceSplitArray` varchar(1000) DEFAULT NULL,
  `invoiceSplitArrayPay` varchar(1000) DEFAULT NULL,
  `invoiceAdminSignID` int(11) DEFAULT NULL,
  `invoiceAdminSignName` varchar(100) DEFAULT NULL,
  `invoiceCarerSign` int(11) DEFAULT NULL,
  `invoiceTravelMetric` varchar(10) DEFAULT NULL,
  `invoiceTravelDistance` float DEFAULT NULL,
  `invoiceTravelDeduction` float DEFAULT NULL,
  `invoiceTravelRate` float DEFAULT NULL,
  `invoiceTravelValue` float DEFAULT NULL,
  `expenseDescription` varchar(200) DEFAULT NULL,
  `wtrAmountValue` float DEFAULT NULL,
  `wtrAmountPercent` float DEFAULT NULL,
  `comissionValue` float DEFAULT NULL,
  `comissionTotal` float DEFAULT NULL,
  `employersNiValue` float DEFAULT NULL,
  `employersNiPercent` float DEFAULT NULL,
  `preview` int(11) DEFAULT '0',
  `invoiceBreakMinutes` int(11) DEFAULT NULL,
  `invoiceBreakPaid` int(11) DEFAULT NULL,
  `numberInvoicePage` varchar(50) DEFAULT NULL,
  `billingFiscalMonth` varchar(7) DEFAULT NULL,
  `billingWeekEnding` date DEFAULT NULL,
  `earnedFiscalMonth` varchar(7) DEFAULT NULL,
  `earnedFiscalWeek` date DEFAULT NULL,
  `JobtypeGroupId` int(11) DEFAULT NULL,
  `JobtypeGroupName` varchar(200) DEFAULT NULL,
  `JobtypeGroupCode` varchar(50) DEFAULT NULL,
  `manualInvoice` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoiceId` (`invoiceId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `timesheetId` (`timesheetId`),
  KEY `deleted` (`deleted`),
  KEY `idx_carerId` (`carerId`),
  KEY `idx_clientId` (`clientId`),
  KEY `idx_logDate` (`logDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceDetailsItemsSummary`;
CREATE TABLE `cmInvoiceDetailsItemsSummary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `invoiceId` int(11) NOT NULL,
  `jobTypeId` int(11) NOT NULL,
  `jobTypeName` varchar(250) NOT NULL,
  `val1` double NOT NULL,
  `val2` double NOT NULL,
  `val3` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceDetailsRecalculate`;
CREATE TABLE `cmInvoiceDetailsRecalculate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `invoiceId` int(11) DEFAULT NULL,
  `invoiceNumber` varchar(50) DEFAULT NULL,
  `jobTypeId` int(11) DEFAULT NULL,
  `jobTypeName` varchar(100) DEFAULT NULL,
  `hrs` float DEFAULT NULL,
  `valueBilling` double DEFAULT NULL,
  `valuePay` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  CONSTRAINT `cmInvoiceDetailsRecalculate_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceEmail`;
CREATE TABLE `cmInvoiceEmail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `clientEmail` char(200) NOT NULL,
  `clientId` int(11) NOT NULL,
  `code` varchar(100) NOT NULL,
  `data` text NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `invoiceId` int(11) NOT NULL,
  `lastView` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoicePaymentReceived`;
CREATE TABLE `cmInvoicePaymentReceived` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `invoiceId` int(11) DEFAULT NULL,
  `invoiceAmount` decimal(15,5) DEFAULT NULL,
  `paymentReceived` decimal(15,5) DEFAULT NULL,
  `paymentSource` int(11) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoicePaymentSource`;
CREATE TABLE `cmInvoicePaymentSource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `source` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceRecord`;
CREATE TABLE `cmInvoiceRecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `invoiceNumber` varchar(20) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `jobTypes` varchar(600) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `paymentDue` date DEFAULT NULL,
  `totalHrs` float DEFAULT NULL,
  `totalBilling` float DEFAULT NULL,
  `paidAmount` int(11) DEFAULT NULL,
  `numberEvents` int(11) DEFAULT NULL,
  `paid` int(11) DEFAULT NULL,
  `invoiceTypeId` int(11) DEFAULT NULL,
  `signOff` int(11) DEFAULT '0',
  `bankDetails` int(11) DEFAULT NULL,
  `clientAddress` int(11) DEFAULT NULL,
  `reference` text,
  `issue` varchar(20) DEFAULT NULL,
  `jtname` varchar(500) DEFAULT NULL,
  `VAT` float DEFAULT NULL,
  `invoiceRan` datetime DEFAULT NULL,
  `invoiceRanBy` int(11) DEFAULT NULL,
  `lastPrintDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `userPrintDate` int(11) DEFAULT NULL,
  `directDebit` int(11) DEFAULT NULL,
  `totalBillingOld` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `invoiceNumber` (`invoiceNumber`),
  KEY `dateFinish` (`dateFinish`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceSpecialDay`;
CREATE TABLE `cmInvoiceSpecialDay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `dateDay` date DEFAULT NULL,
  `factor` float DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceTemplates`;
CREATE TABLE `cmInvoiceTemplates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `templateName` varchar(100) DEFAULT NULL,
  `templateType` varchar(50) DEFAULT NULL,
  `templateSplit` varchar(50) DEFAULT NULL,
  `c1Column` int(11) DEFAULT NULL,
  `c1Title` varchar(50) DEFAULT NULL,
  `c2Column` int(11) DEFAULT NULL,
  `c2Title` varchar(50) DEFAULT NULL,
  `c3Column` int(11) DEFAULT NULL,
  `c3Title` varchar(50) DEFAULT NULL,
  `c4Column` int(11) DEFAULT NULL,
  `c4Title` varchar(50) DEFAULT NULL,
  `c5Column` int(11) DEFAULT NULL,
  `c5Title` varchar(50) DEFAULT NULL,
  `c6Column` int(11) DEFAULT NULL,
  `c6Title` varchar(50) DEFAULT NULL,
  `c7Column` int(11) DEFAULT NULL,
  `c7Title` varchar(50) DEFAULT NULL,
  `c8Column` int(11) DEFAULT NULL,
  `c8Title` varchar(50) DEFAULT NULL,
  `invoiceTitle` varchar(50) DEFAULT 'Invoice',
  `vatPercent` float DEFAULT '0',
  `showExpenses` int(11) DEFAULT '0',
  `showClientAddress` int(11) DEFAULT '0',
  `showClientName` int(11) DEFAULT '0',
  `showCancellations` int(11) DEFAULT '1',
  `invoiceSignoff` varchar(50) DEFAULT 'none',
  `footerMessage1` varchar(125) DEFAULT NULL,
  `footerMessage2` varchar(125) DEFAULT NULL,
  `footerMessage3` varchar(125) DEFAULT NULL,
  `bankDetails1` varchar(125) DEFAULT NULL,
  `bankDetails2` varchar(125) DEFAULT NULL,
  `lineCarerName` varchar(50) DEFAULT NULL,
  `lineCarerPosition` varchar(50) DEFAULT NULL,
  `linePO` varchar(50) DEFAULT NULL COMMENT 'Reference',
  `lineJobType` varchar(50) DEFAULT NULL,
  `lineRates` varchar(50) DEFAULT NULL,
  `lineTravel` varchar(50) DEFAULT NULL,
  `lineDiscount` varchar(50) DEFAULT NULL,
  `lineWTR` varchar(50) DEFAULT NULL,
  `lineCommission` varchar(50) DEFAULT NULL,
  `lineEmployersNi` varchar(50) DEFAULT NULL,
  `lineInvoiceJobTypeName` varchar(50) DEFAULT NULL COMMENT 'Band',
  `idCompanyLogo` int(11) DEFAULT NULL,
  `scaleType` varchar(15) DEFAULT NULL COMMENT 'pay or billing',
  `lineBreak` varchar(50) DEFAULT NULL,
  `showAllocatedHours` int(11) DEFAULT '0' COMMENT 'Display',
  `limitAllocatedHours` int(11) DEFAULT '0' COMMENT 'Limit',
  `summaryJobType` int(11) DEFAULT '0',
  `showCode` int(11) DEFAULT '1',
  `showOriginalCode` int(11) DEFAULT '1',
  `drBacs` varchar(200) DEFAULT NULL COMMENT 'Detail Remmitance',
  `drCard` varchar(200) DEFAULT NULL COMMENT 'Detail Remmitance',
  `drDirectDebt` varchar(200) DEFAULT NULL COMMENT 'Detail Remmitance',
  `drCheque1` varchar(200) DEFAULT NULL COMMENT 'Detail Remmitance',
  `drCheque2` varchar(200) DEFAULT NULL COMMENT 'Detail Remmitance',
  `drCheque3` varchar(200) DEFAULT NULL COMMENT 'Detail Remmitance',
  `weekStart` int(11) DEFAULT '1' COMMENT '1 = Monday 0 = Sunday',
  `showBillingCode` int(11) DEFAULT '0',
  `footerImage` longblob,
  `textCouncil` varchar(50) DEFAULT NULL,
  `textBillingCode` varchar(50) DEFAULT NULL,
  `showTimesheetLines` int(11) DEFAULT '1',
  `showNumberPageInvoice` int(11) DEFAULT '1',
  `showNumberInvoice` int(11) DEFAULT '1',
  `weekStartPersonalized` int(11) DEFAULT '0',
  `companyName` varchar(400) DEFAULT NULL,
  `companyAddress1` varchar(400) DEFAULT NULL,
  `companyAddress2` varchar(400) DEFAULT NULL,
  `companyAddress3` varchar(400) DEFAULT NULL,
  `companyPostcode` varchar(400) DEFAULT NULL,
  `companyPhone` varchar(250) DEFAULT NULL,
  `showPaymentDue` int(11) DEFAULT '1',
  `showTextInBlankSignature` int(11) DEFAULT '1',
  `showCreditNoteDate` int(11) DEFAULT '0',
  `showInterTravel` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `deleted` (`deleted`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceTemplatesColumns`;
CREATE TABLE `cmInvoiceTemplatesColumns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(150) DEFAULT NULL,
  `fixed` int(11) NOT NULL,
  `field` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmInvoiceType`;
CREATE TABLE `cmInvoiceType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmJobtypeReportingCategory`;
CREATE TABLE `cmJobtypeReportingCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `categoryCode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmLevelAccess`;
CREATE TABLE `cmLevelAccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `accessBranch` varchar(500) DEFAULT NULL,
  `accessWorkgroup` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmLevelAreaWorkgroup`;
CREATE TABLE `cmLevelAreaWorkgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `workgroupId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `areaId` (`areaId`),
  KEY `workgroupId` (`workgroupId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmLevelBranch`;
CREATE TABLE `cmLevelBranch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `defaultTemplateId` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmLevelWorkgroup`;
CREATE TABLE `cmLevelWorkgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `sageDepId` varchar(30) DEFAULT NULL,
  `x3ServiceType` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmLevelWorkgroupBranch`;
CREATE TABLE `cmLevelWorkgroupBranch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `workgroupId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workgroupId` (`workgroupId`),
  KEY `branchId` (`branchId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmLogCareApp`;
CREATE TABLE `cmLogCareApp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` varchar(30) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmMultipleQualifications`;
CREATE TABLE `cmMultipleQualifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `cmQualificationsId` int(11) NOT NULL,
  `fileName` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deleted` (`deleted`),
  KEY `deletedBy` (`deletedBy`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `cmQualificationsId` (`cmQualificationsId`),
  CONSTRAINT `cmMultipleQualifications_ibfk_2` FOREIGN KEY (`deletedBy`) REFERENCES `deleted` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmMultipleQualificationsArchive`;
CREATE TABLE `cmMultipleQualificationsArchive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `cmQualificationsArchiveId` int(11) NOT NULL,
  `fileName` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `cmQualificationsArchiveId` (`cmQualificationsArchiveId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmNoticeboardAssign`;
CREATE TABLE `cmNoticeboardAssign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `cmNoticeboardMessageId` int(11) DEFAULT NULL,
  `expired` int(1) DEFAULT NULL,
  `seen` datetime DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `areaId` (`areaId`),
  KEY `cmNoticeboardMessageId` (`cmNoticeboardMessageId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmNoticeboardCategory`;
CREATE TABLE `cmNoticeboardCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmNoticeboardMessage`;
CREATE TABLE `cmNoticeboardMessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` text,
  `message` text,
  `expireDate` date DEFAULT NULL,
  `expired` int(1) DEFAULT NULL,
  `template` int(1) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expireDate` (`expireDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmNoticeboardSeen`;
CREATE TABLE `cmNoticeboardSeen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `cmNoticeboardMessageId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `hideMessage` int(1) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy_cmNoticeboardMessageId` (`createdBy`,`cmNoticeboardMessageId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmNotificationsCategory`;
CREATE TABLE `cmNotificationsCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmNumbers`;
CREATE TABLE `cmNumbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `date` date DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `permissionId` int(11) DEFAULT NULL,
  `side` varchar(10) DEFAULT NULL,
  `ids` longtext,
  `linkedAccountsIds` longtext,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `statusId` (`statusId`),
  KEY `state` (`state`),
  KEY `side` (`side`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPainAssessment`;
CREATE TABLE `cmPainAssessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `painLocation` varchar(200) DEFAULT NULL,
  `painColour` varchar(200) DEFAULT NULL,
  `problem` varchar(1000) DEFAULT NULL,
  `cause` varchar(1000) DEFAULT NULL,
  `treatment` varchar(1000) DEFAULT NULL,
  `painIntensity` int(3) DEFAULT NULL,
  `worstPain` int(3) DEFAULT NULL,
  `bestPain` int(3) DEFAULT NULL,
  `painDescription` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPayPeriodPersonInCharge`;
CREATE TABLE `cmPayPeriodPersonInCharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `payPeriodId` int(11) DEFAULT NULL,
  `personInChargeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_companyId` (`companyId`),
  KEY `idx_locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPayPeriods`;
CREATE TABLE `cmPayPeriods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateEnd` date DEFAULT NULL,
  `payDate` date DEFAULT NULL,
  `periodNumber` int(11) DEFAULT NULL,
  `periodYear` year(4) DEFAULT NULL,
  `taxYear` year(4) DEFAULT NULL,
  `taxWeek` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_companyId` (`companyId`),
  KEY `idx_locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPayrollCycle`;
CREATE TABLE `cmPayrollCycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(400) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPayrollDetails`;
CREATE TABLE `cmPayrollDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `jobTypeId` varchar(200) DEFAULT NULL,
  `jobTypeName` varchar(800) DEFAULT NULL,
  `carertId` int(11) DEFAULT NULL,
  `carerReference` varchar(20) DEFAULT NULL,
  `payrollTemplateId` int(11) DEFAULT NULL,
  `payrollNumber` varchar(20) DEFAULT NULL,
  `companyLine1` varchar(400) DEFAULT NULL,
  `companyLine2` varchar(400) DEFAULT NULL,
  `companyLine3` varchar(200) DEFAULT NULL,
  `companyLine4` varchar(200) DEFAULT NULL,
  `companyLine5` varchar(200) DEFAULT NULL,
  `companyLine6` varchar(200) DEFAULT NULL,
  `periodStart` varchar(200) DEFAULT NULL,
  `periodFinish` varchar(200) DEFAULT NULL,
  `carerName` varchar(200) DEFAULT NULL,
  `carerAddressLine` varchar(250) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `areaName` varchar(400) DEFAULT NULL,
  `workgroupId` varchar(20) DEFAULT NULL,
  `workgroupName` varchar(400) DEFAULT NULL,
  `branchId` varchar(20) DEFAULT NULL,
  `branchName` varchar(400) DEFAULT NULL,
  `carertIdNumber` varchar(100) DEFAULT NULL,
  `issueDate` date DEFAULT NULL,
  `printedDate` date DEFAULT NULL,
  `sageDepId` int(11) DEFAULT NULL,
  `preview` int(11) DEFAULT '0',
  `note` varchar(400) DEFAULT NULL,
  `contractHrs` float DEFAULT NULL,
  `timesheetsIds` text,
  `expensesIds` text,
  `travelDeductionDistance` float DEFAULT NULL,
  `travelDeductionValue` float DEFAULT NULL,
  `papiDeduction` float DEFAULT NULL,
  `totTravelTime` float DEFAULT NULL,
  `totTravelPay` float DEFAULT NULL,
  `nwmTopUp` float DEFAULT NULL,
  `HTSDeductionSubsistence` float DEFAULT NULL,
  `HTSDeductionMileage` float DEFAULT NULL,
  `totStatutorySickPay` float DEFAULT NULL,
  `rolledUpHols` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `areaId` (`areaId`),
  KEY `preview` (`preview`),
  KEY `created` (`created`),
  KEY `invoiceNumber` (`payrollNumber`),
  KEY `invoiceTemplateId` (`payrollTemplateId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPayrollDetailsItems`;
CREATE TABLE `cmPayrollDetailsItems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT 'timesheet' COMMENT 'timesheet | expense | credit | leave',
  `leaveType` varchar(50) DEFAULT NULL COMMENT 'adjustment',
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `payrollId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `expenseId` int(11) DEFAULT NULL,
  `holidayId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL COMMENT 'empty por leave type',
  `carerId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `schedStart` time DEFAULT NULL,
  `schedFinish` time DEFAULT NULL,
  `overnight` int(1) DEFAULT NULL,
  `schedDuration` time DEFAULT NULL,
  `actualStart` datetime DEFAULT NULL,
  `actualFinish` datetime DEFAULT NULL,
  `actualDuration` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `jobtypeId` int(11) DEFAULT NULL,
  `pay` float DEFAULT NULL,
  `payCalled` varchar(100) DEFAULT NULL,
  `payRate` varchar(100) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  `payScaleName` varchar(200) DEFAULT NULL,
  `invoiceClientName` varchar(100) DEFAULT NULL,
  `jobTypeName` varchar(100) DEFAULT NULL,
  `invoiceCarerPosition` varchar(100) DEFAULT NULL,
  `invoiceHrs` float DEFAULT NULL,
  `payrollSplitArrayPay` varchar(1000) DEFAULT NULL,
  `payrollTravelMetric` varchar(10) DEFAULT NULL,
  `payrollTravelDistance` float DEFAULT NULL,
  `payrollTravelDeduction` float DEFAULT NULL,
  `payrollTravelRate` float DEFAULT NULL,
  `payrollTravelValue` float DEFAULT NULL,
  `expenseTypeId` int(11) DEFAULT NULL,
  `expenseDescription` varchar(400) DEFAULT NULL,
  `expenseTax` int(11) DEFAULT NULL,
  `holsDays` varchar(200) DEFAULT NULL,
  `holsHours` varchar(200) DEFAULT NULL,
  `holsPay` varchar(200) DEFAULT NULL,
  `wtrAmountValue` float DEFAULT NULL,
  `wtrAmountPercent` float DEFAULT NULL,
  `employersNiValue` float DEFAULT NULL,
  `employersNiPercent` float DEFAULT NULL,
  `preview` int(11) DEFAULT '0',
  `payrollBreakMinutes` int(11) DEFAULT NULL,
  `payrollBreakPaid` int(11) DEFAULT NULL,
  `externalId` varchar(100) DEFAULT NULL,
  `averageDailyHours` int(50) DEFAULT NULL,
  `travelTime` float DEFAULT NULL,
  `travelTimePay` decimal(10,5) DEFAULT NULL,
  `statutorySickPay` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoiceId` (`payrollId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `timesheetId` (`timesheetId`),
  KEY `deleted` (`deleted`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPayrollJobtypeGroupItems`;
CREATE TABLE `cmPayrollJobtypeGroupItems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jobtypeGroupNameId` int(11) DEFAULT NULL,
  `jobTypeId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jobtypeGroupNameId` (`jobtypeGroupNameId`),
  CONSTRAINT `cmPayrollJobtypeGroupItems_ibfk_1` FOREIGN KEY (`jobtypeGroupNameId`) REFERENCES `jobtypeGroupName` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPayrollJobtypeGroupName`;
CREATE TABLE `cmPayrollJobtypeGroupName` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPayrollTemplate`;
CREATE TABLE `cmPayrollTemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `showTimesheet` int(11) DEFAULT '0',
  `showExpense` int(11) DEFAULT '0',
  `showCredit` int(11) DEFAULT '0',
  `showDistance` int(11) DEFAULT '0',
  `showTravel` int(11) DEFAULT '0',
  `showTravelTime` int(11) DEFAULT '0',
  `showNMW` int(11) DEFAULT '0',
  `showPAI` int(11) DEFAULT '0',
  `showHTS` int(11) DEFAULT '0',
  `showHours` int(11) DEFAULT '0',
  `showAverageDailyHours` int(11) DEFAULT '0',
  `showStart` int(11) DEFAULT '1',
  `showEnd` int(11) DEFAULT '1',
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `callTopUp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `showTravelDeduction` int(11) DEFAULT NULL,
  `callShift` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `cmPlanAppend`;
CREATE TABLE `cmPlanAppend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `planTakenId` int(11) DEFAULT NULL,
  `formId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `outcomeAppend` int(1) DEFAULT NULL,
  `appendedAfter` int(1) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planTakenId` (`planTakenId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPlanCategories`;
CREATE TABLE `cmPlanCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `userSide` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPlans`;
CREATE TABLE `cmPlans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `userSide` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `documentRef` varchar(200) DEFAULT NULL,
  `version` varchar(100) DEFAULT NULL,
  `replaces` varchar(200) DEFAULT NULL,
  `scope` varchar(250) DEFAULT NULL,
  `releaseDate` date DEFAULT NULL,
  `createdByNames` varchar(250) DEFAULT NULL,
  `approvedBy` varchar(250) DEFAULT NULL,
  `implementation` varchar(250) DEFAULT NULL,
  `review` varchar(250) DEFAULT NULL,
  `effectiveDate` date DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `notes` varchar(5000) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `showPlan` int(11) DEFAULT NULL,
  `addAssignedHours` int(1) DEFAULT NULL,
  `addContacts` int(1) DEFAULT NULL,
  `addTags` int(1) DEFAULT NULL,
  `adminOnly` int(1) DEFAULT NULL,
  `favourite` int(1) DEFAULT NULL,
  `recurrLength` varchar(100) DEFAULT NULL,
  `mandatoryReviewDate` int(11) DEFAULT NULL,
  `featureAsModal` varchar(8) DEFAULT NULL,
  `mandatorySignOff` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `showFamilyApp` int(11) DEFAULT NULL,
  `familyAppDashboard` int(11) DEFAULT NULL,
  `localizedLocation` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPlansAnnonymised`;
CREATE TABLE `cmPlansAnnonymised` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `planId` int(11) DEFAULT NULL,
  `cmformsplanstakenId` int(11) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `dateExpiration` datetime DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `token` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPlansAnnonymisedAccess`;
CREATE TABLE `cmPlansAnnonymisedAccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cmPlansAnnonymisedId` int(11) DEFAULT NULL,
  `accessedIn` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPlanStructure`;
CREATE TABLE `cmPlanStructure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `planId` int(11) DEFAULT NULL,
  `formId` int(11) DEFAULT NULL,
  `formOrder` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `planId` (`planId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPositionQualifications`;
CREATE TABLE `cmPositionQualifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `positionId` int(11) DEFAULT NULL,
  `qualificationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `positionId` (`positionId`),
  KEY `qualificationId` (`qualificationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmPrivateNotes`;
CREATE TABLE `cmPrivateNotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmQualifications`;
CREATE TABLE `cmQualifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `qualificationId` int(11) DEFAULT NULL,
  `fileId` int(11) DEFAULT NULL,
  `fileName` varchar(300) DEFAULT NULL,
  `awardDate` date DEFAULT NULL,
  `expireDate` date DEFAULT NULL,
  `comment` text,
  `outcomeId` int(11) DEFAULT NULL,
  `multiple` int(1) DEFAULT NULL,
  `archived` datetime DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `carerId` (`carerId`),
  KEY `deleted` (`deleted`),
  KEY `expireDate` (`expireDate`),
  KEY `qualificationId` (`qualificationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmQualificationsArchive`;
CREATE TABLE `cmQualificationsArchive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `qualificationId` int(11) DEFAULT NULL,
  `fileId` int(11) DEFAULT NULL,
  `fileName` varchar(300) DEFAULT NULL,
  `awardDate` date DEFAULT NULL,
  `expireDate` date DEFAULT NULL,
  `submitType` varchar(100) DEFAULT NULL,
  `submitDate` date DEFAULT NULL,
  `submitTime` time DEFAULT NULL,
  `submitBy` int(11) DEFAULT NULL,
  `comment` text,
  `multiple` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`),
  KEY `qualificationId` (`qualificationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmQualificationsOutcome`;
CREATE TABLE `cmQualificationsOutcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmQualificationsPending`;
CREATE TABLE `cmQualificationsPending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `qualificationId` int(11) DEFAULT NULL,
  `fileId` int(11) DEFAULT NULL,
  `fileName` varchar(300) DEFAULT NULL,
  `awardDate` date DEFAULT NULL,
  `expireDate` date DEFAULT NULL,
  `comment` text,
  `outcomeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmQualificationsSuperTags`;
CREATE TABLE `cmQualificationsSuperTags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `qualTypes` varchar(500) DEFAULT NULL,
  `superTag` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `superTag` (`superTag`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmQualificationsType`;
CREATE TABLE `cmQualificationsType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `defaultLength` varchar(30) DEFAULT NULL,
  `colour` varchar(10) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `alertBefore` varchar(30) DEFAULT NULL,
  `qualOutcomes` int(11) DEFAULT NULL,
  `qualTags` int(11) DEFAULT NULL,
  `appView` int(1) DEFAULT NULL,
  `appUpdate` int(1) DEFAULT NULL,
  `appArchive` int(1) DEFAULT NULL,
  `qualSuperTag` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmQuestionPicPRSB`;
CREATE TABLE `cmQuestionPicPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `careplanTakenId` int(11) DEFAULT NULL,
  `riskAssessmentId` int(11) DEFAULT NULL,
  `question` varchar(100) DEFAULT NULL,
  `fileName` varchar(150) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmReasonStatus`;
CREATE TABLE `cmReasonStatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `reasonId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `side` varchar(60) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmRecruitmentSource`;
CREATE TABLE `cmRecruitmentSource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedby` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `recruiterName` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmRecurrComments`;
CREATE TABLE `cmRecurrComments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `recurrDate` date DEFAULT NULL,
  `comment` text,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `recurrId` (`recurrId`),
  KEY `recurrDate` (`recurrDate`),
  KEY `deleted` (`deleted`),
  KEY `created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmRouteDistances`;
CREATE TABLE `cmRouteDistances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `route` varchar(1000) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId_route` (`locationId`,`route`(767))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSchedulePermissions`;
CREATE TABLE `cmSchedulePermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `compSettings` int(11) DEFAULT NULL,
  `scheduleCreate` int(11) DEFAULT NULL,
  `scheduleEdit` int(11) DEFAULT NULL,
  `scheduleDelete` int(11) DEFAULT NULL,
  `scheduleSwap` int(11) DEFAULT NULL,
  `scheduleCancel` int(11) DEFAULT NULL,
  `deleteScale` int(11) DEFAULT NULL,
  `editScale` int(11) DEFAULT NULL,
  `createScale` int(11) DEFAULT NULL,
  `createForm` int(11) DEFAULT NULL,
  `editForm` int(11) DEFAULT NULL,
  `deleteForm` int(11) DEFAULT NULL,
  `hrAccess` int(11) DEFAULT '1',
  `hrPrivate` int(11) DEFAULT NULL,
  `hrConfidential` int(11) DEFAULT NULL,
  `managePPE` int(11) DEFAULT NULL,
  `topLevelPPE` int(11) DEFAULT NULL,
  `viewPageLoads` int(11) DEFAULT NULL,
  `bufferOverwrite` int(11) DEFAULT NULL,
  `editFinance` int(11) DEFAULT NULL,
  `editTimesheetRef` int(11) DEFAULT NULL,
  `deleteFinance` int(11) DEFAULT NULL,
  `addInvoicee` int(11) DEFAULT '1',
  `addMedication` int(11) DEFAULT NULL,
  `editMedication` int(11) DEFAULT NULL,
  `deleteMedication` int(11) DEFAULT NULL,
  `scheduleCreatePast` int(11) DEFAULT NULL,
  `scheduleEditPast` int(11) DEFAULT NULL,
  `createBuckets` int(11) DEFAULT NULL,
  `editBuckets` int(11) DEFAULT NULL,
  `groupRemove` int(11) DEFAULT NULL,
  `tagConflictOverwrite` int(11) DEFAULT NULL,
  `editCancelled` int(11) DEFAULT NULL,
  `addTag` int(11) DEFAULT '1',
  `addClientCarerTag` int(11) DEFAULT NULL,
  `deleteTag` int(11) DEFAULT '1',
  `addTask` int(11) DEFAULT '1',
  `editTask` int(11) DEFAULT '1',
  `deleteTask` int(11) DEFAULT '1',
  `deleteHRFiles` int(11) DEFAULT '1',
  `extendLeave` int(11) DEFAULT NULL,
  `customEffectedDays` int(11) DEFAULT NULL,
  `editExpenses` int(11) DEFAULT NULL,
  `deleteExpenses` int(11) DEFAULT NULL,
  `overwriteRequest` int(11) DEFAULT NULL,
  `topLevelAccess` int(11) DEFAULT NULL,
  `branchAccess` int(11) DEFAULT NULL,
  `addEditAdmin` int(11) DEFAULT NULL,
  `locAccessSetup` int(11) DEFAULT NULL,
  `jobTypeSetup` int(11) DEFAULT NULL,
  `deleteBodyAssess` int(11) DEFAULT NULL,
  `addJobType` int(11) DEFAULT NULL,
  `editJobType` int(11) DEFAULT NULL,
  `deleteJobType` int(11) DEFAULT NULL,
  `assignJobtype` int(11) DEFAULT '1',
  `fc_deleteFile` int(11) DEFAULT '1',
  `fc_customizeFile` int(11) DEFAULT '1',
  `fc_customizeFolder` int(11) DEFAULT '1',
  `pi_assignStatus` int(11) DEFAULT '1',
  `pi_assignTask` int(11) DEFAULT '1',
  `pi_masterUser` int(11) DEFAULT NULL,
  `pi_assignList` int(11) DEFAULT '1',
  `fixedRangeDuration` int(11) DEFAULT NULL,
  `showUnreadMessages` int(11) DEFAULT NULL,
  `disableDownload` int(11) DEFAULT NULL,
  `availabilityConflictOverwrite` int(11) DEFAULT NULL,
  `carerAreaEdit` int(11) DEFAULT '1',
  `clientAreaEdit` int(11) DEFAULT '1',
  `editActions` int(11) DEFAULT NULL,
  `deleteActions` int(11) DEFAULT NULL,
  `editHrFileType` int(11) DEFAULT NULL,
  `deleteDocuments` int(11) DEFAULT NULL,
  `deleteFamilyAccess` int(11) DEFAULT NULL,
  `changeClientStatus` int(11) DEFAULT '1',
  `changeCarerStatus` int(11) DEFAULT '1',
  `saveColumnVisibility` int(11) DEFAULT NULL,
  `editAreas` int(11) DEFAULT NULL,
  `createAreas` int(11) DEFAULT NULL,
  `updateBankHolidays` int(11) DEFAULT NULL,
  `unlockTimesheet` int(11) DEFAULT NULL,
  `editCarerId` int(11) DEFAULT '1',
  `editClientId` int(11) DEFAULT '1',
  `governanceAccess` int(11) DEFAULT NULL,
  `governanceSetup` int(11) DEFAULT NULL,
  `diversity` int(11) DEFAULT NULL,
  `mfa_admin` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmScheduleRuns`;
CREATE TABLE `cmScheduleRuns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `runNumber` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmShiftDetails`;
CREATE TABLE `cmShiftDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `overNight` int(1) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `colour` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `wardId` int(11) DEFAULT NULL,
  `week` int(11) DEFAULT NULL,
  `days` varchar(200) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSignOffUpdated`;
CREATE TABLE `cmSignOffUpdated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `planUpdatedId` int(11) DEFAULT NULL,
  `planTakenId` int(11) DEFAULT NULL,
  `signOffId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSkinAssessments`;
CREATE TABLE `cmSkinAssessments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `classificationId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `woundDateFirstIdentified` date DEFAULT NULL,
  `woundDescription` longtext,
  `woundLocation` varchar(250) DEFAULT NULL,
  `woundLength` varchar(50) DEFAULT NULL,
  `woundWidth` varchar(50) DEFAULT NULL,
  `woundSurfaceArea` varchar(10) DEFAULT NULL,
  `woundDepth` varchar(10) DEFAULT NULL,
  `appearance` varchar(250) DEFAULT NULL,
  `exudate` varchar(250) DEFAULT NULL,
  `discharge` varchar(250) DEFAULT NULL,
  `odour` varchar(250) DEFAULT NULL,
  `gradeId` int(11) DEFAULT NULL,
  `cause` longtext,
  `painIntensityId` int(11) DEFAULT NULL,
  `painDescription` longtext,
  `painLocation` varchar(200) DEFAULT NULL,
  `painScore` int(11) DEFAULT NULL,
  `typeDressingApplied` varchar(250) DEFAULT NULL,
  `typeDressingRemoved` varchar(250) DEFAULT NULL,
  `dressingChanged` varchar(50) DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `comment` longtext,
  `treatment` longtext,
  `healed` int(11) DEFAULT '0',
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmSkinAssessments_client_id_fk` (`clientId`),
  KEY `cmSkinAssessments_cmSkinClassifications_id_fk` (`classificationId`),
  KEY `cmSkinAssessments_cmSkinGrades_id_fk` (`gradeId`),
  KEY `cmSkinAssessments_cmSkinIntensities_id_fk` (`painIntensityId`),
  KEY `cmSkinAssessments_cmSkinTypes_id_fk` (`typeId`),
  KEY `cmSkinAssessments_company_id_fk` (`companyId`),
  KEY `cmSkinAssessments_location_id_fk` (`locationId`),
  CONSTRAINT `cmSkinAssessments_client_id_fk` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `cmSkinAssessments_cmSkinClassifications_id_fk` FOREIGN KEY (`classificationId`) REFERENCES `cmSkinClassifications` (`id`),
  CONSTRAINT `cmSkinAssessments_cmSkinGrades_id_fk` FOREIGN KEY (`gradeId`) REFERENCES `cmSkinGrades` (`id`),
  CONSTRAINT `cmSkinAssessments_cmSkinIntensities_id_fk` FOREIGN KEY (`painIntensityId`) REFERENCES `cmSkinIntensities` (`id`),
  CONSTRAINT `cmSkinAssessments_cmSkinTypes_id_fk` FOREIGN KEY (`typeId`) REFERENCES `cmSkinTypes` (`id`),
  CONSTRAINT `cmSkinAssessments_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `cmSkinAssessments_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSkinClassifications`;
CREATE TABLE `cmSkinClassifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmSkinClassifications_company_id_fk` (`companyId`),
  KEY `cmSkinClassifications_location_id_fk` (`locationId`),
  CONSTRAINT `cmSkinClassifications_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `cmSkinClassifications_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSkinFiles`;
CREATE TABLE `cmSkinFiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assessmentId` int(11) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `file` longblob,
  `path` varchar(255) DEFAULT NULL,
  `type` varchar(250) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmSkinFiles_cmSkinAssessments_id_fk` (`assessmentId`),
  CONSTRAINT `cmSkinFiles_cmSkinAssessments_id_fk` FOREIGN KEY (`assessmentId`) REFERENCES `cmSkinAssessments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSkinGrades`;
CREATE TABLE `cmSkinGrades` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmSkinGrades_company_id_fk` (`companyId`),
  KEY `cmSkinGrades_location_id_fk` (`locationId`),
  CONSTRAINT `cmSkinGrades_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `cmSkinGrades_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSkinIntensities`;
CREATE TABLE `cmSkinIntensities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ordination` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmSkinIntensities_company_id_fk` (`companyId`),
  KEY `cmSkinIntensities_location_id_fk` (`locationId`),
  CONSTRAINT `cmSkinIntensities_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `cmSkinIntensities_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSkinTypes`;
CREATE TABLE `cmSkinTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `image` longblob,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmSkinTypes_company_id_fk` (`companyId`),
  KEY `cmSkinTypes_location_id_fk` (`locationId`),
  CONSTRAINT `cmSkinTypes_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `cmSkinTypes_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmSpeed`;
CREATE TABLE `cmSpeed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` varchar(100) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTabCarer`;
CREATE TABLE `cmTabCarer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `editedId` int(11) DEFAULT NULL,
  `tabName` varchar(200) DEFAULT NULL,
  `tabTitle` text,
  `tabDescription` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `accessOfficeAdmin` int(11) DEFAULT NULL,
  `accessCarer` int(11) DEFAULT NULL,
  `accessCarerPosition` varchar(1000) DEFAULT NULL,
  `accessClient` int(11) DEFAULT NULL,
  `accessFamily` int(11) DEFAULT NULL,
  `accessFileUpload` int(11) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTabCarerComments`;
CREATE TABLE `cmTabCarerComments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `editedId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `comment` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `tabid` int(11) DEFAULT NULL,
  `cmTabFileUploadId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `tabid` (`tabid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTabClient`;
CREATE TABLE `cmTabClient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `editedId` int(11) DEFAULT NULL,
  `tabName` varchar(200) DEFAULT NULL,
  `tabTitle` text,
  `tabDescription` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `accessOfficeAdmin` int(11) DEFAULT NULL,
  `accessCarer` int(1) DEFAULT NULL,
  `accessCarerPosition` varchar(1000) DEFAULT NULL,
  `accessClient` int(1) DEFAULT NULL,
  `accessFamily` int(1) DEFAULT NULL,
  `accessFileUpload` int(11) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTabClientComments`;
CREATE TABLE `cmTabClientComments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `editedId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `comment` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `tabId` int(11) DEFAULT NULL,
  `cmTabFileUploadId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `tabId` (`tabId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTabFileUpload`;
CREATE TABLE `cmTabFileUpload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(200) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `fileSize` varchar(100) DEFAULT NULL,
  `tags` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTableUpdate`;
CREATE TABLE `cmTableUpdate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `tableName` varchar(100) DEFAULT NULL,
  `columnName` varchar(100) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `oldValue` text,
  `newValue` text,
  `rowId` int(11) DEFAULT NULL,
  `scaleNameId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTimesheetPhoto`;
CREATE TABLE `cmTimesheetPhoto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `file` longblob,
  `fileSize` varchar(200) DEFAULT NULL,
  `fileType` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTraining`;
CREATE TABLE `cmTraining` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `trainingSectionId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `adminSide` int(1) DEFAULT NULL,
  `carerSide` int(1) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trainingSection` (`trainingSectionId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTrainingSection`;
CREATE TABLE `cmTrainingSection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `details` varchar(500) DEFAULT NULL,
  `tags` varchar(500) DEFAULT NULL,
  `adminSide` int(1) DEFAULT NULL,
  `carerSide` int(1) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTransportType`;
CREATE TABLE `cmTransportType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `travelExpenses` int(1) DEFAULT NULL,
  `travelTimeCategory` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmTravelSettings`;
CREATE TABLE `cmTravelSettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `metric` varchar(50) DEFAULT NULL,
  `excludeFirst` int(1) DEFAULT NULL,
  `excludeLast` int(1) DEFAULT NULL,
  `excludeBreakTravel` int(1) DEFAULT '1',
  `startLocation` varchar(50) DEFAULT NULL,
  `minusType` varchar(50) DEFAULT NULL,
  `minusTotal` varchar(50) DEFAULT NULL,
  `expenseRate` varchar(50) DEFAULT NULL,
  `payRate` varchar(50) DEFAULT NULL,
  `break` varchar(50) DEFAULT '90',
  `travelTimeRate` float DEFAULT NULL,
  `travelTimeSpeed` float DEFAULT '20',
  `travelTimeSpeedBike` float DEFAULT '12',
  `travelTimeSpeedWalk` float DEFAULT '3',
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientTravelRate` float DEFAULT NULL,
  `maxWaitNMW` float DEFAULT '20',
  `splitShiftNMW` float DEFAULT '90',
  `splitShiftIncludeNMW` int(1) DEFAULT NULL,
  `splitShiftJourney` int(1) DEFAULT '3',
  `includeFirstTripNMW` int(1) DEFAULT NULL,
  `includeLastTripNMW` int(1) DEFAULT NULL,
  `expenseRateBike` varchar(50) DEFAULT NULL,
  `expenseRateWalk` varchar(50) DEFAULT NULL,
  `expenseRateBus` varchar(50) DEFAULT NULL,
  `transportTypeCategoryBill` varchar(100) DEFAULT '1',
  `includeBreakHome` int(1) DEFAULT NULL,
  `includeBreakBack` int(1) DEFAULT NULL,
  `includeBreakHomeTime` int(1) DEFAULT NULL,
  `includeBreakBackTime` int(1) DEFAULT NULL,
  `includeFirstTripTime` int(1) DEFAULT NULL,
  `includeLastTripTime` int(1) DEFAULT NULL,
  `includeBreakTime` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmUserBio`;
CREATE TABLE `cmUserBio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `invoiceeId` int(11) DEFAULT NULL,
  `bio` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmWageRates`;
CREATE TABLE `cmWageRates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` datetime DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `rate_23_plus` decimal(10,2) DEFAULT NULL,
  `rate_21_22` decimal(10,2) DEFAULT NULL,
  `rate_18_20` decimal(10,2) DEFAULT NULL,
  `rate_under_18` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmWardDetails`;
CREATE TABLE `cmWardDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmWardRequiredStaff`;
CREATE TABLE `cmWardRequiredStaff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `employeePosition` int(11) DEFAULT NULL,
  `numberRequired` int(11) DEFAULT NULL,
  `shiftId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `areaId` (`areaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmWeeklyWorkingSummary`;
CREATE TABLE `cmWeeklyWorkingSummary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `weekCommencing` date DEFAULT NULL,
  `days` double DEFAULT NULL,
  `hours` double DEFAULT NULL,
  `holidaysTaken` double DEFAULT NULL,
  `numOfEvents` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cmWorkweekNoShow`;
CREATE TABLE `cmWorkweekNoShow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` date DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateNoShow` date DEFAULT NULL,
  `workweekId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `availabilityId` (`workweekId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address1` varchar(150) DEFAULT NULL,
  `town` varchar(150) DEFAULT NULL,
  `county` varchar(150) DEFAULT NULL,
  `postCode` varchar(150) DEFAULT NULL,
  `country` varchar(150) DEFAULT NULL,
  `phone` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `client` varchar(50) NOT NULL DEFAULT 'Client',
  `carer` varchar(50) NOT NULL DEFAULT 'Carer',
  `admin` varchar(50) NOT NULL DEFAULT 'Admin',
  `event` varchar(50) NOT NULL DEFAULT 'event',
  `postit` varchar(50) NOT NULL DEFAULT 'Post-It',
  `post` varchar(50) NOT NULL DEFAULT 'post',
  `preferred` varchar(50) NOT NULL DEFAULT 'Preferred',
  `firstContact` varchar(50) DEFAULT 'First Contact Date',
  `serviceCommenced` varchar(50) DEFAULT 'Service Commenced',
  `blacklist` varchar(50) DEFAULT 'Not Compatible',
  `geoLocation` varchar(5) DEFAULT NULL,
  `adminLevel` int(11) DEFAULT '0',
  `password` varchar(60) DEFAULT '6af97d7deea1a1d2c76c5c512e66700b',
  `privateNotePin` varchar(100) DEFAULT 'care',
  `privateNotePinCarerApp` varchar(100) DEFAULT NULL,
  `concurrentClockIn` int(11) DEFAULT '0',
  `carerEnterTravel` int(11) DEFAULT '0',
  `fullDay` int(11) DEFAULT '8',
  `holidaysAllocatedAdmin` int(11) DEFAULT '20',
  `holidaysAllocatedCarer` float DEFAULT '8',
  `holidayEntitlementMultiplier` float DEFAULT '5',
  `holidayYearStart` date DEFAULT '2020-04-01',
  `holidayYearEnd` date DEFAULT '2021-03-31',
  `holidayWeekCount` int(11) DEFAULT '52',
  `holidaysDisableScheduleConflicts` int(1) DEFAULT NULL,
  `conflictDisable` int(11) DEFAULT '1',
  `qualification` varchar(100) DEFAULT 'HR File',
  `acctv` varchar(500) DEFAULT NULL,
  `wardName` varchar(50) DEFAULT 'Ward',
  `crossoverShow` int(1) DEFAULT '1',
  `crossoverShowNumber` int(1) DEFAULT '1',
  `runsShow` int(1) DEFAULT NULL,
  `runCall` varchar(100) DEFAULT 'Run',
  `customPages` int(1) DEFAULT NULL,
  `smsAvailable` int(1) DEFAULT NULL,
  `wallet` int(1) DEFAULT NULL,
  `multipleClockIn` int(1) DEFAULT NULL,
  `ppsCall` varchar(100) DEFAULT 'NI Number',
  `printUnassigned` int(1) DEFAULT NULL,
  `showContractHours` int(1) DEFAULT NULL,
  `showAvailable` int(1) DEFAULT NULL,
  `showRequestedHours` int(1) DEFAULT NULL,
  `showHolidayRequest` int(1) DEFAULT NULL,
  `showMedication` int(1) DEFAULT NULL,
  `fContactSCommenceMandatory` int(1) DEFAULT NULL,
  `showPosition` int(1) DEFAULT NULL,
  `offlineMode` int(1) DEFAULT '0',
  `addPlanAdminAbilities` int(1) DEFAULT NULL,
  `noticeboard` int(1) DEFAULT NULL,
  `billingCodeCall` varchar(100) DEFAULT 'Billing Code',
  `adminPin` int(11) DEFAULT NULL,
  `serverURL` varchar(100) DEFAULT NULL,
  `companyCode` varchar(10) DEFAULT NULL,
  `schedulePastPassword` int(1) DEFAULT '7272',
  `payrollTemplate` int(11) DEFAULT NULL,
  `franchise` int(2) DEFAULT NULL,
  `uniqueCustomerNo` varchar(20) DEFAULT NULL,
  `ottBilling` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `companyAccess`;
CREATE TABLE `companyAccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `irePostCode` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `company_invoicing_details`;
CREATE TABLE `company_invoicing_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `account_manager` varchar(200) DEFAULT NULL,
  `invoicing_notes` longtext,
  `sla_issued_date` date DEFAULT NULL,
  `sla_signed_date` date DEFAULT NULL,
  `breakdown_invoice_by_location` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance`;
CREATE TABLE `compliance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `priority` varchar(10) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `issue` varchar(10) DEFAULT NULL,
  `issueFrom` varchar(200) DEFAULT NULL,
  `issueFromPhone` varchar(100) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `subject` text,
  `details` text,
  `createdBy` int(11) DEFAULT NULL,
  `adminId` int(11) DEFAULT NULL,
  `notified` varchar(500) DEFAULT NULL,
  `datepickerDue` date DEFAULT NULL,
  `timeDue` time DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `progress` varchar(3) DEFAULT NULL,
  `actionsTook` text,
  `dateClosed` date DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(500) DEFAULT NULL,
  `fileSize` varchar(100) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `seen` varchar(10) DEFAULT NULL,
  `medicationAssignId` int(11) DEFAULT NULL,
  `medicationAssignTimesId` int(11) DEFAULT NULL,
  `medicationResultsId` int(11) DEFAULT NULL,
  `incidentDate` datetime DEFAULT NULL,
  `issuePrefix` varchar(10) DEFAULT NULL,
  `todoSeq` varchar(20) DEFAULT NULL,
  `todoNumber` varchar(50) DEFAULT NULL,
  `sendMail` tinyint(4) DEFAULT '1',
  `reason` int(11) DEFAULT NULL,
  `reasonLearning` text,
  `categoryId` int(11) DEFAULT NULL,
  `levelHarmId` int(11) DEFAULT NULL,
  `notifierId` int(11) DEFAULT NULL,
  `acknowledgment` varchar(250) DEFAULT NULL,
  `dateAcknowledgment` date DEFAULT NULL,
  `outcomeLetter` varchar(250) DEFAULT NULL,
  `dateOutcomeLetter` date DEFAULT NULL,
  `textSentOmbudsman` varchar(250) DEFAULT NULL,
  `sentOmbudsmanId` int(11) DEFAULT NULL,
  `textCQCnotified` varchar(250) DEFAULT NULL,
  `dateCQCnotified` date DEFAULT NULL,
  `allegedPerpetratorId` int(11) DEFAULT NULL,
  `enquiryId` int(11) DEFAULT NULL,
  `conclusionId` int(11) DEFAULT NULL,
  `nextDateSendEmail` date DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL COMMENT 'Reference to Care home in Residential',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `complianceHistory`;
CREATE TABLE `complianceHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `assignedTo` int(11) DEFAULT NULL,
  `progress` varchar(10) DEFAULT NULL,
  `priority` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `actionsTaken` text,
  `notifiedCarer` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliancelog`;
CREATE TABLE `compliancelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `complianceSignOff`;
CREATE TABLE `complianceSignOff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataURL` mediumtext NOT NULL,
  `comment` mediumtext NOT NULL,
  `complianceId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_associated`;
CREATE TABLE `compliance_associated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `firstView` datetime DEFAULT NULL,
  `lastView` datetime DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `associatedId` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `todoId` (`todoId`),
  KEY `carerId` (`associatedId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_category`;
CREATE TABLE `compliance_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_conclusion`;
CREATE TABLE `compliance_conclusion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_details_history`;
CREATE TABLE `compliance_details_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `todoId` int(11) NOT NULL COMMENT 'Compliance id reference',
  `updated` datetime NOT NULL COMMENT 'When the details was changed',
  `updatedBy` int(11) NOT NULL COMMENT 'Who changed details',
  `detailsOld` text NOT NULL COMMENT 'Original details before changed',
  PRIMARY KEY (`id`),
  KEY `FK_complianceId` (`todoId`),
  CONSTRAINT `FK_complianceId` FOREIGN KEY (`todoId`) REFERENCES `compliance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Maintain the history of changes in field details of compliance';


DROP TABLE IF EXISTS `compliance_enquiry`;
CREATE TABLE `compliance_enquiry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_issue`;
CREATE TABLE `compliance_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `prefix` varchar(5) DEFAULT NULL,
  `prefixNumber` int(11) DEFAULT NULL,
  `mandatoryCarer` int(11) DEFAULT NULL,
  `mandatoryClient` int(11) DEFAULT NULL,
  `email` text,
  `carerNotify` varchar(200) DEFAULT NULL,
  `daysNotify` int(11) DEFAULT '30',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_issue_permission`;
CREATE TABLE `compliance_issue_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issueId` int(11) NOT NULL DEFAULT '0',
  `idField` int(11) DEFAULT NULL,
  `showField` int(11) NOT NULL DEFAULT '1',
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_issue_subtask`;
CREATE TABLE `compliance_issue_subtask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `issueId` int(11) DEFAULT NULL,
  `orderByTask` int(11) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `showTask` int(11) NOT NULL DEFAULT '1',
  `days` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_issue_subtask_items`;
CREATE TABLE `compliance_issue_subtask_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `firstView` datetime DEFAULT NULL,
  `lastView` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `orderByTask` int(11) DEFAULT NULL,
  `subtaskId` int(11) DEFAULT NULL,
  `details` text,
  `deadline` date DEFAULT NULL,
  `notes` text,
  `assignId` int(11) DEFAULT NULL COMMENT 'admin',
  `status` int(11) DEFAULT NULL COMMENT 'new, open, not required, closed',
  PRIMARY KEY (`id`),
  KEY `todoId` (`todoId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_issue_subtask_status`;
CREATE TABLE `compliance_issue_subtask_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `sequence` int(5) DEFAULT NULL,
  `closed` int(11) DEFAULT '0' COMMENT '1= Selected',
  `new` int(11) DEFAULT '0' COMMENT '1= Selected',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_level_harm`;
CREATE TABLE `compliance_level_harm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_notes`;
CREATE TABLE `compliance_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `todoId` int(11) DEFAULT NULL,
  `note` text,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_notifier`;
CREATE TABLE `compliance_notifier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_perpetrator`;
CREATE TABLE `compliance_perpetrator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_reason`;
CREATE TABLE `compliance_reason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `compliance_subject_history`;
CREATE TABLE `compliance_subject_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `todoId` int(11) NOT NULL COMMENT 'Todo id reference',
  `updated` datetime NOT NULL COMMENT 'When the subject was changed',
  `updatedBy` int(11) NOT NULL COMMENT 'Who changed subject',
  `subjectOld` text NOT NULL COMMENT 'Original subject before changed',
  PRIMARY KEY (`id`),
  KEY `FK_todoId` (`todoId`),
  CONSTRAINT `FK_Compliance_Subject_todoId` FOREIGN KEY (`todoId`) REFERENCES `compliance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Maintain the history of changes in field subject of todo';


DROP TABLE IF EXISTS `compliance_upload`;
CREATE TABLE `compliance_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `typeLocation` varchar(100) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(500) DEFAULT NULL,
  `fileSize` varchar(100) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `todoId` (`typeId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactLink`;
CREATE TABLE `contactLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contactsId` int(11) DEFAULT NULL,
  `contactsContactId` int(11) DEFAULT NULL,
  `contactTypeId` int(11) DEFAULT NULL,
  `contactsSharedId` int(11) DEFAULT NULL,
  `sharedGroupId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `fname` varchar(500) DEFAULT NULL,
  `sname` varchar(200) DEFAULT NULL,
  `address1` varchar(500) DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  `county` varchar(60) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `postCode` varchar(60) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `relation` varchar(500) DEFAULT NULL,
  `contactNight` varchar(3) DEFAULT NULL,
  `invoiceeJobtype` varchar(150) DEFAULT NULL,
  `invoiceeJobtypeNew` mediumtext,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contactSavedId` int(11) DEFAULT NULL,
  `splitBilling` double DEFAULT NULL,
  `splitCode` varchar(150) DEFAULT NULL,
  `templateId` int(11) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `originCode` varchar(100) DEFAULT NULL,
  `splitValue` double DEFAULT NULL,
  `splitValueOrder` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `details` varchar(250) DEFAULT NULL,
  `nhs` int(1) DEFAULT NULL,
  `activeGP` int(1) DEFAULT NULL,
  `gpPracticeDetails` varchar(500) DEFAULT NULL,
  `phone2` varchar(200) DEFAULT NULL,
  `gpCodeDefaultDisplay` varchar(500) DEFAULT NULL,
  `gpCodeDefault` varchar(50) DEFAULT NULL,
  `gpPracticeId` varchar(50) DEFAULT NULL,
  `proJobRoleFHIR` varchar(500) DEFAULT NULL,
  `proJobCodeFHIR` varchar(50) DEFAULT NULL,
  `proNHSSpecialty` varchar(500) DEFAULT NULL,
  `proNHSSpecialCode` varchar(50) DEFAULT NULL,
  `proTeam` varchar(500) DEFAULT NULL,
  `proOrganisation` varchar(500) DEFAULT NULL,
  `proOdsCode` varchar(50) DEFAULT NULL,
  `proKeyWorker` int(1) DEFAULT NULL,
  `perRelationshipType` varchar(500) DEFAULT NULL,
  `perFHIRRelationship` varchar(500) DEFAULT NULL,
  `perFHIRRelationCode` varchar(50) DEFAULT NULL,
  `perComments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `contactSavedId` (`contactSavedId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`),
  KEY `typeId` (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactsFull`;
CREATE TABLE `contactsFull` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `fname` varchar(500) DEFAULT NULL,
  `sname` varchar(30) DEFAULT NULL,
  `address1` varchar(500) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `county` varchar(30) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `postCode` varchar(60) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `relation` varchar(500) DEFAULT NULL,
  `contactNight` varchar(3) DEFAULT NULL,
  `invoiceeJobtype` varchar(150) DEFAULT NULL,
  `invoiceeJobtypeNew` varchar(150) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contactSavedId` int(11) DEFAULT NULL,
  `splitBilling` int(11) DEFAULT NULL,
  `splitCode` varchar(150) DEFAULT NULL,
  `templateId` int(11) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `originCode` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactsJ`;
CREATE TABLE `contactsJ` (
  `id` int(11) NOT NULL DEFAULT '0',
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `fname` varchar(500) DEFAULT NULL,
  `sname` varchar(30) DEFAULT NULL,
  `address1` varchar(500) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `county` varchar(30) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `postCode` varchar(60) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `relation` varchar(500) DEFAULT NULL,
  `contactNight` varchar(3) DEFAULT NULL,
  `invoiceeJobtype` varchar(150) DEFAULT NULL,
  `invoiceeJobtypeNew` varchar(150) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contactSavedId` int(11) DEFAULT NULL,
  `splitBilling` double DEFAULT NULL,
  `splitCode` varchar(150) DEFAULT NULL,
  `templateId` int(11) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `originCode` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactsPending`;
CREATE TABLE `contactsPending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `fname` varchar(500) DEFAULT NULL,
  `sname` varchar(30) DEFAULT NULL,
  `address1` varchar(500) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `county` varchar(30) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `postCode` varchar(60) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `relation` varchar(500) DEFAULT NULL,
  `contactNight` varchar(3) DEFAULT NULL,
  `invoiceeJobtype` varchar(150) DEFAULT NULL,
  `invoiceeJobtypeNew` varchar(150) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contactSavedId` int(11) DEFAULT NULL,
  `splitBilling` int(11) DEFAULT NULL,
  `splitCode` varchar(150) DEFAULT NULL,
  `templateId` int(11) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `contactSavedId` (`contactSavedId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`),
  KEY `typeId` (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactsPowerOfAttorney`;
CREATE TABLE `contactsPowerOfAttorney` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `fname` varchar(500) DEFAULT NULL,
  `sname` varchar(30) DEFAULT NULL,
  `address1` varchar(500) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `county` varchar(30) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `postCode` varchar(60) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `relation` varchar(500) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contactSavedId` int(11) DEFAULT NULL,
  `powerOfAttorney` longtext NOT NULL,
  `actingStatus` varchar(250) NOT NULL,
  `restrictions` longtext,
  `details` longtext,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `contactSavedId` (`contactSavedId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactsSaved`;
CREATE TABLE `contactsSaved` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientSide` int(11) DEFAULT NULL,
  `carerSide` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `fname` varchar(500) DEFAULT NULL,
  `sname` varchar(200) DEFAULT NULL,
  `address1` varchar(500) DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  `county` varchar(30) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `postCode` varchar(60) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  `relation` varchar(600) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `invoiceeJobtype` varchar(150) DEFAULT NULL,
  `invoiceeJobtypeNew` longtext,
  `templateId` int(11) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `originCode` varchar(100) DEFAULT NULL,
  `updateJobType` int(11) DEFAULT '1',
  `updateCodes` int(11) DEFAULT NULL,
  `sharedGroupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `templateId` (`templateId`),
  KEY `deleted` (`deleted`),
  KEY `idx_sharedGroupId` (`sharedGroupId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactsVisible`;
CREATE TABLE `contactsVisible` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contactTypeId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contacts_import`;
CREATE TABLE `contacts_import` (
  `﻿ClientID` text,
  `ClientRef` int(11) DEFAULT NULL,
  `FirstNames` text,
  `Surname` text,
  `Mobile` text,
  `MainTel` text,
  `OtherTel` text,
  `Addr1` text,
  `Addr2` text,
  `Addr3` text,
  `Addr4` text,
  `Town` text,
  `County` text,
  `Email` text,
  `Postcode` text,
  `Relationship` text,
  `UserRelationshipID` text,
  `Keys` text,
  `ContactNo` int(11) DEFAULT NULL,
  `ContactType` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contactType`;
CREATE TABLE `contactType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `carerSide` int(11) DEFAULT NULL,
  `clientSide` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carePlanSign` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `contingencyPlanPRSB`;
CREATE TABLE `contingencyPlanPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `riskAssessmentId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `triggerFactors` text,
  `whatShouldHappen` text,
  `contactName` varchar(100) DEFAULT NULL,
  `contactRole` varchar(100) DEFAULT NULL,
  `contactDetails` varchar(100) DEFAULT NULL,
  `copingStategies` text,
  `dateStart` date DEFAULT NULL,
  `timeStart` time DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `relapeSigns` text,
  `anticipatoryEquip` text,
  `contRevDate` date DEFAULT NULL,
  `anyAdvanceStatement` varchar(100) DEFAULT NULL,
  `statementLocationMade` text,
  `statementCreateDate` date DEFAULT NULL,
  `statementLocationHeld` text,
  `statementRevDate` date DEFAULT NULL,
  `statementLastUpdate` date DEFAULT NULL,
  `createNameAS` varchar(100) DEFAULT NULL,
  `createRoleAS` varchar(100) DEFAULT NULL,
  `createGradeAS` varchar(100) DEFAULT NULL,
  `createSpecialityAS` varchar(100) DEFAULT NULL,
  `createIdentifierAS` varchar(100) DEFAULT NULL,
  `createOrganisationAS` varchar(100) DEFAULT NULL,
  `createCompletedAS` date DEFAULT NULL,
  `createContactAS` varchar(100) DEFAULT NULL,
  `completeNameAS` varchar(100) DEFAULT NULL,
  `completeRoleAS` varchar(100) DEFAULT NULL,
  `completeGradeAS` varchar(100) DEFAULT NULL,
  `completeSpecialityAS` varchar(100) DEFAULT NULL,
  `completeIdentifierAS` varchar(100) DEFAULT NULL,
  `completeOrganisationAS` varchar(100) DEFAULT NULL,
  `completedAS` date DEFAULT NULL,
  `completeContactAS` varchar(100) DEFAULT NULL,
  `performNameCP` varchar(100) DEFAULT NULL,
  `performRoleCP` varchar(100) DEFAULT NULL,
  `performGradeCP` varchar(100) DEFAULT NULL,
  `performSpecialityCP` varchar(100) DEFAULT NULL,
  `performIdentifierCP` varchar(100) DEFAULT NULL,
  `performOrganisationCP` varchar(100) DEFAULT NULL,
  `performContactCP` varchar(100) DEFAULT NULL,
  `completingNameCP` varchar(100) DEFAULT NULL,
  `completingRoleCP` varchar(100) DEFAULT NULL,
  `completingGradeCP` varchar(100) DEFAULT NULL,
  `completingSpecialityCP` varchar(100) DEFAULT NULL,
  `completingIdentifierCP` varchar(100) DEFAULT NULL,
  `completingOrganisationCP` varchar(100) DEFAULT NULL,
  `completingDateCP` date DEFAULT NULL,
  `completingContactCP` varchar(100) DEFAULT NULL,
  `originalId` int(11) DEFAULT NULL,
  `signedOff` timestamp NULL DEFAULT NULL,
  `signedOffBy` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carePlanTakenId` (`carePlanTakenId`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cqcCategories`;
CREATE TABLE `cqcCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tabId` int(11) DEFAULT NULL,
  `qualityStatement` varchar(1000) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `defaultVersion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cqcCategoryPages`;
CREATE TABLE `cqcCategoryPages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `pageName` varchar(200) DEFAULT NULL,
  `linkPage` varchar(200) DEFAULT NULL,
  `description` text,
  `categoryId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoryId` (`categoryId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cqcTabs`;
CREATE TABLE `cqcTabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `nextReviewDate` date DEFAULT NULL,
  `reviewedBy` int(11) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `defaultVersion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deletedBy` (`deletedBy`),
  KEY `name` (`name`),
  CONSTRAINT `cqcTabs_ibfk_1` FOREIGN KEY (`deletedBy`) REFERENCES `deleted` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cqcTabsHistory`;
CREATE TABLE `cqcTabsHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL,
  `tabId` varchar(500) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `note` (`note`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmCallLog`;
CREATE TABLE `crmCallLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `contactsId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `description` text,
  `callSubject` text,
  `callType` varchar(50) DEFAULT NULL,
  `callDate` date DEFAULT NULL,
  `callTime` time DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  `editId` int(11) DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `contactsId` (`contactsId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmContactBio`;
CREATE TABLE `crmContactBio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `contactsId` int(11) DEFAULT NULL,
  `bio` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contactsSharedId` int(11) DEFAULT NULL,
  `sharedGroupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contactsId` (`contactsId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmContactsContact`;
CREATE TABLE `crmContactsContact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contactsId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fName` varchar(500) DEFAULT NULL,
  `sName` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  `county` varchar(30) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `contactTypeName` varchar(60) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updateId` int(11) DEFAULT NULL,
  `contactTypeId` int(11) DEFAULT NULL,
  `contactsSharedId` int(11) DEFAULT NULL,
  `sharedGroupId` int(11) DEFAULT NULL,
  `bio` text,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `contactsId` (`contactsId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmContactsContactType`;
CREATE TABLE `crmContactsContactType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmDocuments`;
CREATE TABLE `crmDocuments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `uploadedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fileName` varchar(100) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `fileSize` varchar(20) DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `recordId` (`recordId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmMeetingNotes`;
CREATE TABLE `crmMeetingNotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `contactsId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `meetingTitle` text,
  `attendees` varchar(200) DEFAULT NULL,
  `meetingTime` time DEFAULT NULL,
  `meetingDate` date DEFAULT NULL,
  `meetingNotes` text,
  `editId` int(11) DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `contactsId` (`contactsId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmRecords`;
CREATE TABLE `crmRecords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `contactsId` int(11) DEFAULT NULL,
  `contactsSharedId` int(11) DEFAULT NULL,
  `sharedContactsGroupId` int(11) DEFAULT NULL,
  `description` longtext,
  `recordTypeId` int(11) DEFAULT NULL,
  `recordDate` date DEFAULT NULL,
  `recordTime` time DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  `editId` int(11) DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  `recordSubject` text,
  `recordContactsContactId` int(11) DEFAULT NULL,
  `fileUploaded` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmRecordType`;
CREATE TABLE `crmRecordType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmSharedContactGroup`;
CREATE TABLE `crmSharedContactGroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `sharedGroupTypeId` int(11) DEFAULT NULL,
  `fname` varchar(300) DEFAULT NULL,
  `sname` varchar(300) DEFAULT NULL,
  `address1` varchar(500) DEFAULT NULL,
  `town` varchar(300) DEFAULT NULL,
  `county` varchar(30) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `postCode` varchar(60) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `email` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sharedGroupTypeId` (`sharedGroupTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crmSharedContactGroupType`;
CREATE TABLE `crmSharedContactGroupType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `cronRunRecords`;
CREATE TABLE `cronRunRecords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientFutureStatus` datetime DEFAULT NULL,
  `carerFutureStatus` datetime DEFAULT NULL,
  `clientNumbers` datetime DEFAULT NULL,
  `carerNumbers` datetime DEFAULT NULL,
  `adminNumbers` datetime DEFAULT NULL,
  `unassignHolidays` datetime DEFAULT NULL,
  `medMissedScript` datetime DEFAULT NULL,
  `TaskMissedScript` datetime DEFAULT NULL,
  `medicationTasksMissed` datetime DEFAULT NULL,
  `late` datetime DEFAULT NULL,
  `concurrent` datetime DEFAULT NULL,
  `overNightTravel` timestamp NULL DEFAULT NULL,
  `TaskMissedScriptA` timestamp NULL DEFAULT NULL,
  `TaskMissedScriptB` timestamp NULL DEFAULT NULL,
  `TaskMissedScriptC` timestamp NULL DEFAULT NULL,
  `TaskMissedScriptD` timestamp NULL DEFAULT NULL,
  `TaskMissedScriptE` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crontabLog`;
CREATE TABLE `crontabLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `scriptName` varchar(100) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `finish` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `crumlinUnpublished`;
CREATE TABLE `crumlinUnpublished` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `clientId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `jobType` varchar(10) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `lateLogginIn` date DEFAULT NULL,
  `keepRecur` int(2) DEFAULT NULL,
  `firstEvent` date DEFAULT NULL,
  `lastEvent` date DEFAULT NULL,
  `numEvents` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `CSVInvoice`;
CREATE TABLE `CSVInvoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceNumber` varchar(50) NOT NULL,
  `totalPay` float DEFAULT NULL,
  `totalBilling` float DEFAULT NULL,
  `council` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `databasePerformance`;
CREATE TABLE `databasePerformance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requestId` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `section` varchar(250) DEFAULT NULL,
  `tag` varchar(250) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `time` float(20,10) DEFAULT NULL,
  `rows` int(11) DEFAULT NULL,
  `sql` longtext,
  `sqlNormalized` longtext,
  `url` varchar(500) DEFAULT NULL,
  `script` varchar(500) DEFAULT NULL,
  `callerFile` varchar(500) DEFAULT NULL,
  `callerLine` int(11) DEFAULT NULL,
  `backtrace` longtext,
  `fixed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `requestId` (`requestId`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `userId` (`userId`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `sqlNormalized` (`sqlNormalized`(255)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `databasePerformanceConfig`;
CREATE TABLE `databasePerformanceConfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saveUltraSlow` tinyint(1) NOT NULL DEFAULT '0',
  `saveVerySlow` tinyint(1) NOT NULL DEFAULT '0',
  `saveSlow` tinyint(1) NOT NULL DEFAULT '0',
  `saveFast` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `datatablesCustom`;
CREATE TABLE `datatablesCustom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `page` varchar(255) NOT NULL,
  `preferences` text,
  `created_at` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `defaultNames`;
CREATE TABLE `defaultNames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `overview` varchar(200) DEFAULT NULL,
  `overviewTitle` text,
  `notes` varchar(200) DEFAULT NULL,
  `notesTitle` text,
  `comments` varchar(200) DEFAULT NULL,
  `commentsTitle` text,
  `tasks` varchar(200) DEFAULT NULL,
  `tasksTitle` text,
  `documents` varchar(200) DEFAULT NULL,
  `documentsTitle` text,
  `postIts` varchar(200) DEFAULT NULL,
  `postItsTitle` text,
  `forms` varchar(200) DEFAULT NULL,
  `formsTitle` text,
  `expenses` varchar(200) DEFAULT NULL,
  `expensesTitle` text,
  `taskSheets` varchar(200) DEFAULT NULL,
  `taskSheetsTitle` text,
  `taskSheetTagCall` varchar(100) DEFAULT NULL,
  `taskCall` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `defaultNamesHistory`;
CREATE TABLE `defaultNamesHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `columnName` varchar(100) DEFAULT NULL,
  `changedTo` varchar(100) DEFAULT NULL,
  `changedToTitle` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `deleted`;
CREATE TABLE `deleted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `tableName` varchar(100) DEFAULT NULL,
  `details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `deleted_medicationResults`;
CREATE TABLE `deleted_medicationResults` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resultId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedReason` varchar(200) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `dateEntered` date DEFAULT NULL,
  `timeEntered` time DEFAULT NULL,
  `taskDone` int(11) DEFAULT NULL,
  `subTaskDone` int(11) DEFAULT NULL,
  `timeSaid` time DEFAULT NULL,
  `comment` text,
  `medAssignId` int(11) DEFAULT NULL,
  `medAssignTimesId` int(11) DEFAULT NULL,
  `medId` int(11) DEFAULT NULL,
  `amountGiven` double DEFAULT NULL,
  `amountShouldBe` double DEFAULT NULL,
  `required` int(11) DEFAULT NULL,
  `editOf` int(11) DEFAULT NULL,
  `outcomeId` varchar(200) DEFAULT NULL,
  `alertId` int(11) DEFAULT NULL,
  `alertSeenBy` int(11) DEFAULT NULL,
  `painLocationPercent` varchar(500) DEFAULT NULL,
  `painSeverity` varchar(100) DEFAULT NULL,
  `mandatory` tinyint(4) DEFAULT NULL,
  `medScriptLoc` int(11) DEFAULT NULL,
  `missedTimestamp` timestamp NULL DEFAULT NULL,
  `signOff` int(11) DEFAULT NULL,
  `medDue` datetime DEFAULT NULL,
  `medMiss` datetime DEFAULT NULL,
  `missHideApp` datetime DEFAULT NULL,
  `missEmail` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medAssignId` (`medAssignId`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `medAssignTimesId` (`medAssignTimesId`),
  KEY `medId` (`medId`),
  KEY `dateEntered` (`dateEntered`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `documents`;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `uploadedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fileId` int(11) DEFAULT NULL,
  `fileName` varchar(200) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `fileSize` varchar(20) DEFAULT NULL,
  `tags` varchar(100) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`),
  KEY `folderId` (`folderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `documentsFolders`;
CREATE TABLE `documentsFolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `carerApp` int(1) DEFAULT NULL,
  `familyApp` int(1) DEFAULT NULL,
  `carerSide` int(1) DEFAULT NULL,
  `clientSide` int(1) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) NOT NULL,
  `locationVisible` int(2) DEFAULT '0',
  `updateId` int(11) DEFAULT NULL,
  `passwordFld` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `documentUploadTags`;
CREATE TABLE `documentUploadTags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientSide` int(11) DEFAULT NULL,
  `carerSide` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `document_duplicate_queue`;
CREATE TABLE `document_duplicate_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` text NOT NULL,
  `amount` int(11) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `email`;
CREATE TABLE `email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` varchar(60) NOT NULL,
  `locationId` varchar(20) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `carerId` int(11) DEFAULT NULL,
  `aws_id` varchar(80) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `sendTo` varchar(200) NOT NULL,
  `subject` varchar(250) DEFAULT NULL,
  `message` text,
  `sent` timestamp NULL DEFAULT NULL,
  `delivered` timestamp NULL DEFAULT NULL,
  `opened` timestamp NULL DEFAULT NULL,
  `bounced` timestamp NULL DEFAULT NULL,
  `complaint` timestamp NULL DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `info` text,
  `cmInvoiceRecordId` int(11) DEFAULT NULL,
  `cmInvoiceDetailsId` int(11) DEFAULT NULL,
  `medResultId` int(11) DEFAULT NULL,
  `lettersSentId` int(11) DEFAULT NULL,
  `cmPlansAnnonymisedId` int(11) DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `complianceId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cmInvoiceRecordId` (`cmInvoiceRecordId`),
  KEY `cmInvoiceDetailsId` (`cmInvoiceDetailsId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`),
  KEY `email_com_loc_inv` (`companyId`,`locationId`,`cmInvoiceDetailsId`),
  KEY `email_com_loc_ts` (`companyId`,`locationId`,`timestamp`),
  KEY `email_loc_carer_ts` (`locationId`,`carerId`,`timestamp`),
  KEY `email_aws_id` (`aws_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `emailQueue`;
CREATE TABLE `emailQueue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `content` text,
  `resultId` int(11) DEFAULT NULL,
  `sent` timestamp NULL DEFAULT NULL,
  `updatedAlertsFlag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `emailSendGrid`;
CREATE TABLE `emailSendGrid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `type` varchar(60) DEFAULT NULL,
  `locationId` varchar(20) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `sendTo` varchar(40) DEFAULT NULL,
  `permissionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `emailTemplateInvoice`;
CREATE TABLE `emailTemplateInvoice` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `subjectMail` varchar(70) DEFAULT NULL,
  `description` text,
  `companyId` int(10) DEFAULT NULL,
  `locationId` int(10) DEFAULT NULL,
  `status` tinyint(3) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `createdBy` int(10) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(10) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `email_events`;
CREATE TABLE `email_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aws_id` varchar(80) NOT NULL,
  `details` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `aws_id` (`aws_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EmployeePositionsJobTypes`;
CREATE TABLE `EmployeePositionsJobTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` date NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` date DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `EmployeePositionId` int(11) NOT NULL,
  `jobTypes` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageChat`;
CREATE TABLE `EngageChat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `messageTo` int(11) DEFAULT NULL,
  `messageFrom` int(11) DEFAULT NULL,
  `message` text,
  `messageRead` varchar(20) DEFAULT NULL,
  `dateRead` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageFamily`;
CREATE TABLE `EngageFamily` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `rights` int(11) DEFAULT NULL,
  `fname` varbinary(200) DEFAULT NULL,
  `sname` varbinary(200) DEFAULT NULL,
  `username` varbinary(200) DEFAULT NULL,
  `password` varbinary(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL,
  `addressLine1` varchar(200) DEFAULT NULL,
  `addressLine2` varchar(200) DEFAULT NULL,
  `addressLine3` varchar(200) DEFAULT NULL,
  `country` varchar(200) DEFAULT NULL,
  `postCode` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageFamilyLinks`;
CREATE TABLE `EngageFamilyLinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  `familyLevel` int(11) DEFAULT NULL,
  `linkConfirmed` datetime DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageGallery`;
CREATE TABLE `EngageGallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `picId` int(11) DEFAULT NULL,
  `details` varchar(1000) DEFAULT NULL,
  `tags` int(11) DEFAULT NULL,
  `uploadedBy` int(11) DEFAULT NULL,
  `removedBy` int(11) DEFAULT NULL,
  `slideShow` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageGoal`;
CREATE TABLE `EngageGoal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `picLink` varchar(250) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageGoalComplete`;
CREATE TABLE `EngageGoalComplete` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `completed` datetime DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageGoalRecurr`;
CREATE TABLE `EngageGoalRecurr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `finishDate` date DEFAULT NULL,
  `dayPick` varchar(5) DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL,
  `timePicked` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageLogs`;
CREATE TABLE `EngageLogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(100) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `page` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageNotifications`;
CREATE TABLE `EngageNotifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  `say` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngagePhone`;
CREATE TABLE `EngagePhone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `clientId` varchar(20) DEFAULT NULL,
  `pic` longblob,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngagePictures`;
CREATE TABLE `EngagePictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` longblob,
  `filename` varchar(1000) DEFAULT NULL,
  `filetype` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngagePopup`;
CREATE TABLE `EngagePopup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `note` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngagePrefCategories`;
CREATE TABLE `EngagePrefCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `fontAwesome` varchar(150) DEFAULT NULL,
  `fullName` varchar(150) DEFAULT NULL,
  `category` varchar(150) DEFAULT NULL,
  `country` varchar(150) DEFAULT NULL,
  `url` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngagePreferences`;
CREATE TABLE `EngagePreferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `health` int(11) DEFAULT NULL,
  `games` int(11) DEFAULT NULL,
  `sport` int(11) DEFAULT NULL,
  `music` int(11) DEFAULT NULL,
  `film` int(11) DEFAULT NULL,
  `women` int(11) DEFAULT NULL,
  `news` int(11) DEFAULT NULL,
  `animals` int(11) DEFAULT NULL,
  `knitting` int(11) DEFAULT NULL,
  `weather` int(11) DEFAULT NULL,
  `events` int(11) DEFAULT NULL,
  `travel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageQuestions`;
CREATE TABLE `EngageQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `createdQuestion` int(11) DEFAULT NULL,
  `question` varchar(200) DEFAULT NULL,
  `option1` varchar(60) DEFAULT NULL,
  `option2` varchar(60) DEFAULT NULL,
  `option3` varchar(60) DEFAULT NULL,
  `option4` varchar(60) DEFAULT NULL,
  `option5` varchar(60) DEFAULT NULL,
  `hour` varchar(60) DEFAULT NULL,
  `showQuestion` varchar(10) DEFAULT NULL,
  `sound` varchar(100) DEFAULT NULL,
  `requiredDaily` varchar(20) DEFAULT NULL,
  `lastAsked` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `EngageWellness`;
CREATE TABLE `EngageWellness` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `questionId` varchar(10) NOT NULL,
  `answerValue` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `serviceDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `equipmentType`;
CREATE TABLE `equipmentType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `eventAlert`;
CREATE TABLE `eventAlert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `cmdailyTasksAssignId` int(11) DEFAULT NULL,
  `medicationAssignId` int(11) DEFAULT NULL,
  `alertId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `notifyCarerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `eventAlertSetup`;
CREATE TABLE `eventAlertSetup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `workGroupId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `dailyTasksAssignId` int(11) DEFAULT NULL,
  `medicationAssignId` int(11) DEFAULT NULL,
  `alertTypeId` int(11) DEFAULT NULL,
  `notifyCarerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medicationAlert` (`companyId`,`locationId`,`branchId`,`workGroupId`,`areaId`,`clientId`,`medicationAssignId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `expenses`;
CREATE TABLE `expenses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `descr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float(9,2) DEFAULT '0.00',
  `time` date DEFAULT NULL,
  `purpose` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `exportButtonLog`;
CREATE TABLE `exportButtonLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `exportname` varchar(255) DEFAULT NULL,
  `pagename` varchar(255) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `locationid` int(11) DEFAULT NULL,
  `companyid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `externalLinks`;
CREATE TABLE `externalLinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `page` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `externalLinksProfile`;
CREATE TABLE `externalLinksProfile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `page` varchar(500) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `failedAttemptLog`;
CREATE TABLE `failedAttemptLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `ipAddress` varchar(100) DEFAULT NULL,
  `lockedOut` int(11) DEFAULT NULL,
  `successfulLogin` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `familyAppLevels`;
CREATE TABLE `familyAppLevels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `recordLocation` int(11) DEFAULT NULL,
  `forceLocation` int(11) DEFAULT NULL,
  `overview` tinyint(1) DEFAULT '0',
  `comments` tinyint(1) DEFAULT '0',
  `documents` tinyint(1) DEFAULT '0',
  `post_its` tinyint(1) DEFAULT '0',
  `clocking_times` tinyint(1) DEFAULT NULL,
  `assesments` tinyint(1) DEFAULT '1',
  `notes` tinyint(1) DEFAULT '0',
  `respite_booking` tinyint(1) DEFAULT NULL,
  `chat` tinyint(1) DEFAULT '0',
  `pic_on_schedule` tinyint(1) DEFAULT NULL,
  `schedule_visibility` int(5) DEFAULT NULL,
  `medication_details` tinyint(1) DEFAULT '0',
  `task_details` tinyint(1) DEFAULT '0',
  `show_cancelled_calls` tinyint(1) DEFAULT NULL,
  `live_chat` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `familyAppMemberLevel`;
CREATE TABLE `familyAppMemberLevel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `familyId` int(11) DEFAULT NULL,
  `levelId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `familyId` (`familyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `familyPhotos`;
CREATE TABLE `familyPhotos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `fileName` text NOT NULL,
  `title` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  CONSTRAINT `familyPhotos_ibfk_1` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `familyPhotos_ibfk_2` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fileCabinet`;
CREATE TABLE `fileCabinet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `tags` varchar(200) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `view` varchar(50) DEFAULT NULL,
  `accessCarers` int(11) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  `fileId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fileCabinetAccess`;
CREATE TABLE `fileCabinetAccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fileId` int(11) DEFAULT NULL,
  `accessGivenBy` int(11) DEFAULT NULL,
  `viewed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fileCabinetFolder`;
CREATE TABLE `fileCabinetFolder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `accessCarers` int(11) DEFAULT NULL,
  `localFolder` int(11) DEFAULT '0',
  `parentFolderId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fileCabinetHistory`;
CREATE TABLE `fileCabinetHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `userId` int(11) NOT NULL,
  `action` int(11) NOT NULL COMMENT '1 = Download',
  `fileId` int(11) NOT NULL,
  `httpUserAgent` text NOT NULL,
  `remoteAddr` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fileCabinetTags`;
CREATE TABLE `fileCabinetTags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fileUpload`;
CREATE TABLE `fileUpload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(200) DEFAULT NULL,
  `fileSize` varchar(200) DEFAULT NULL,
  `fileType` varchar(200) DEFAULT NULL,
  `dataUsed` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `FileUpload`;
CREATE TABLE `FileUpload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `uploadedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(100) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `fileSize` varchar(100) DEFAULT NULL,
  `tags` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `financeAnalisysCSV`;
CREATE TABLE `financeAnalisysCSV` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` varchar(250) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updated` varchar(250) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` varchar(250) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `option` json NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `financeUpdateRecord`;
CREATE TABLE `financeUpdateRecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  `billingScaleId` int(11) DEFAULT NULL,
  `percentageIncrease` double DEFAULT NULL,
  `effectiveDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `firstPageImages`;
CREATE TABLE `firstPageImages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locationId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `imageName` varchar(255) DEFAULT NULL,
  `filenameS3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `firstPageSettings`;
CREATE TABLE `firstPageSettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locationId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `headerImageId` int(11) DEFAULT NULL,
  `watermarkImageId` int(11) DEFAULT NULL,
  `imageHeaderState` enum('NO_IMAGE','USE_LOGO','CUSTOM_IMAGE') DEFAULT 'NO_IMAGE',
  `imageWatermarkState` enum('NO_IMAGE','USE_LOGO','CUSTOM_IMAGE') DEFAULT 'NO_IMAGE',
  `body` text,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `branches` text,
  `name` varchar(255) DEFAULT NULL,
  `all_location` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fluidBalanceDetails`;
CREATE TABLE `fluidBalanceDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `fluidRestriction` float DEFAULT NULL,
  `fluidGoal` float DEFAULT NULL,
  `startReason` longtext,
  `startDate` date DEFAULT NULL,
  `reviewReason` longtext,
  `reviewDate` date DEFAULT NULL,
  `hourlyGoalRange1` float DEFAULT NULL,
  `hourlyGoalRange2` float DEFAULT NULL,
  `hourlyGoalRange3` float DEFAULT NULL,
  `hourlyGoalRange4` float DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fluidIntakes`;
CREATE TABLE `fluidIntakes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `reportRelevant` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `finishTime` time DEFAULT NULL,
  `note` longtext,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `fluidOutputs`;
CREATE TABLE `fluidOutputs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `reportRelevant` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `finishTime` time DEFAULT NULL,
  `description` longtext,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `form`;
CREATE TABLE `form` (
  `idSurvey` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(120) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `questionOrder` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSurvey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `formAnswer`;
CREATE TABLE `formAnswer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answer` varchar(300) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `formBoxes`;
CREATE TABLE `formBoxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `boxColor` varchar(100) DEFAULT 'success',
  `showApp` int(1) DEFAULT NULL,
  `showFamilyApp` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `formInfo`;
CREATE TABLE `formInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `surveyId` int(11) DEFAULT NULL,
  `info` text,
  `title` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `formName`;
CREATE TABLE `formName` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(120) DEFAULT NULL,
  `code` varchar(120) DEFAULT NULL,
  `companyId` varchar(120) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `showForm` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `formPopupSubmissions`;
CREATE TABLE `formPopupSubmissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `planId` varchar(50) NOT NULL,
  `formCode` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `formQuestion`;
CREATE TABLE `formQuestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `type` varchar(120) DEFAULT NULL,
  `question` text,
  `ans1` text,
  `ans2` text,
  `ans3` text,
  `ans4` text,
  `ans5` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `formQuestionBoxes`;
CREATE TABLE `formQuestionBoxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `boxId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `boxId` (`boxId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `formTaken`;
CREATE TABLE `formTaken` (
  `idTaken` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `surveyId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `answer` text,
  `personName` varchar(120) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `comments` text,
  `filledBy` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTaken`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `futureStatusChange`;
CREATE TABLE `futureStatusChange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `oldState` int(11) DEFAULT NULL,
  `oldStatusId` int(11) DEFAULT NULL,
  `dateChange` date DEFAULT NULL,
  `stateChange` int(11) DEFAULT NULL,
  `statusIdChange` int(11) DEFAULT NULL,
  `changeBack` date DEFAULT NULL,
  `note` varchar(150) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gcm_blacklist`;
CREATE TABLE `gcm_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gcm_regid` text,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `authCode` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gcm_offline`;
CREATE TABLE `gcm_offline` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gcm_id` varchar(150) DEFAULT NULL,
  `array` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gcm_users`;
CREATE TABLE `gcm_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gcm_regid` text,
  `name` varchar(50) DEFAULT NULL,
  `carerId` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `workPhoneId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gender`;
CREATE TABLE `gender` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prefix` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdby` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updateBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleteBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `goal`;
CREATE TABLE `goal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `picLink` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalActions`;
CREATE TABLE `goalActions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `responsiblePerson` varchar(200) DEFAULT NULL,
  `timescale` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `completionPercent` int(11) DEFAULT NULL,
  `completionDate` timestamp NULL DEFAULT NULL,
  `completedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalActionsHistory`;
CREATE TABLE `goalActionsHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `actionId` int(11) DEFAULT NULL,
  `actionName` varchar(100) DEFAULT NULL,
  `timescale` timestamp NULL DEFAULT NULL,
  `responsiblePerson` varchar(200) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `completionPercent` double DEFAULT NULL,
  `completionDate` timestamp NULL DEFAULT NULL,
  `completedBy` int(11) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalActionSnapShot`;
CREATE TABLE `goalActionSnapShot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `goalHistoryId` int(11) DEFAULT NULL,
  `actionId` int(11) DEFAULT NULL,
  `actionName` varchar(100) DEFAULT NULL,
  `timescale` timestamp NULL DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `completionPercent` double DEFAULT NULL,
  `completionDate` timestamp NULL DEFAULT NULL,
  `completedBy` int(11) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalComment`;
CREATE TABLE `goalComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `actionHistoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalHistory`;
CREATE TABLE `goalHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `timescale` varchar(50) DEFAULT NULL,
  `themeId` int(11) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `overallProgress` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalRecurr`;
CREATE TABLE `goalRecurr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `finishDate` date DEFAULT NULL,
  `dayPick` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalsSectionPRSB`;
CREATE TABLE `goalsSectionPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `needId` int(11) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  `goalDetails` text,
  `importanceDetails` text,
  `importanceLevel` int(11) DEFAULT NULL,
  `questionImgId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carePlanTakenId` (`carePlanTakenId`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `needId` (`needId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalTag`;
CREATE TABLE `goalTag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `tag` varchar(200) DEFAULT NULL,
  `themeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `goalTheme`;
CREATE TABLE `goalTheme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `govClientAddress`;
CREATE TABLE `govClientAddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `address1` varchar(250) DEFAULT NULL,
  `address2` varchar(250) DEFAULT NULL,
  `address3` varchar(250) DEFAULT NULL,
  `address4` varchar(250) DEFAULT NULL,
  `address5` varchar(250) DEFAULT NULL,
  `addressType` varchar(250) DEFAULT NULL,
  `postCode` varchar(10) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `default` int(2) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `clientId` (`clientId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `govClientContact`;
CREATE TABLE `govClientContact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `preferedContactMethod` int(11) DEFAULT NULL,
  `telephoneNumber` varchar(25) DEFAULT NULL,
  `telephoneNumberType` varchar(25) DEFAULT NULL,
  `telephoneNumberPreference` varchar(25) DEFAULT NULL,
  `emailAddress` varchar(200) DEFAULT NULL,
  `emailAddressType` varchar(25) DEFAULT NULL,
  `emailAddressPreference` varchar(25) DEFAULT NULL,
  `otherContact` varchar(200) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `clientId` (`clientId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `govClientDetails`;
CREATE TABLE `govClientDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `personPreferedName` varchar(35) DEFAULT NULL,
  `personFullName` varchar(250) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `ethnicity` varchar(5) DEFAULT NULL,
  `religion` varchar(5) DEFAULT NULL,
  `identifierType` varchar(250) DEFAULT NULL,
  `address2` varchar(250) DEFAULT NULL,
  `address3` varchar(250) DEFAULT NULL,
  `address4` varchar(250) DEFAULT NULL,
  `address5` varchar(250) DEFAULT NULL,
  `addressType` varchar(250) DEFAULT NULL,
  `localPatientIdentifier` varchar(200) DEFAULT NULL,
  `healthAndCarerNo` varchar(200) DEFAULT NULL,
  `communityHealthIndexNo` varchar(200) DEFAULT NULL,
  `otherIdentifierNo` varchar(200) DEFAULT NULL,
  `dvacolour` varchar(20) DEFAULT NULL,
  `careRecipientId` varchar(250) DEFAULT NULL,
  `dvaNumber` varchar(15) DEFAULT NULL,
  `govPensionNumber` varchar(15) DEFAULT NULL,
  `govPensionRates` varchar(20) DEFAULT NULL,
  `govPensionTypes` varchar(25) DEFAULT NULL,
  `macId` varchar(15) DEFAULT NULL,
  `privateHealthCare` varchar(25) DEFAULT NULL,
  `medicareIRN` varchar(2) DEFAULT NULL,
  `medicareCardNumber` varchar(15) DEFAULT NULL,
  `placeBirth` varchar(12) DEFAULT NULL,
  `psuffix` varchar(50) DEFAULT NULL,
  `ppname` varchar(50) DEFAULT NULL,
  `pfname` varchar(50) DEFAULT NULL,
  `swiftNumber` varchar(50) DEFAULT NULL,
  `dataSharing` varchar(250) DEFAULT NULL,
  `privateHealthFundNumber` varchar(25) DEFAULT NULL,
  `ndisSelect` varchar(2) DEFAULT '0',
  `ndisNumber` varchar(50) DEFAULT NULL,
  `pronouns` smallint(6) DEFAULT NULL,
  `sexualOrientation` varchar(100) DEFAULT NULL,
  `estimatedDOB` tinyint(1) DEFAULT NULL,
  `diversity` varchar(100) DEFAULT NULL,
  `culturalBackground` varchar(100) DEFAULT NULL,
  `enrolledVote` varchar(50) DEFAULT NULL,
  `requireSupportVote` varchar(50) DEFAULT NULL,
  `primaryLanguage` varchar(100) DEFAULT NULL,
  `primaryLanguageInterpreterRequired` tinyint(1) DEFAULT NULL,
  `prefferedLanguage` varchar(100) DEFAULT NULL,
  `prefferedLanguageInterpreterRequired` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `govClientEmail`;
CREATE TABLE `govClientEmail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `emailType` varchar(20) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `govClientTelephone`;
CREATE TABLE `govClientTelephone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `telephoneType` varchar(35) DEFAULT NULL,
  `telephoneNumber` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `govPersonalContacts`;
CREATE TABLE `govPersonalContacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `contactId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `relationship` varchar(250) DEFAULT NULL,
  `relationshipType` varchar(250) DEFAULT NULL,
  `comments` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `govProfessionalContacts`;
CREATE TABLE `govProfessionalContacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `contactId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `keyWorker` varchar(250) DEFAULT NULL,
  `speciality` varchar(250) DEFAULT NULL,
  `team` varchar(250) DEFAULT NULL,
  `codedValue` varchar(250) DEFAULT NULL,
  `freeText` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gpc_configurations`;
CREATE TABLE `gpc_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `odsCode` varchar(50) DEFAULT NULL,
  `asid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `update` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `town` varchar(250) DEFAULT NULL,
  `county` varchar(250) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `area` (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hasteeHalesConfiguration`;
CREATE TABLE `hasteeHalesConfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `branchId` int(11) NOT NULL,
  `account` varchar(50) NOT NULL,
  `active` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hasteeImport`;
CREATE TABLE `hasteeImport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carerId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `value` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `help`;
CREATE TABLE `help` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(600) DEFAULT NULL,
  `details` varchar(600) DEFAULT NULL,
  `tags` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `helpSlides`;
CREATE TABLE `helpSlides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `helpId` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(200) DEFAULT NULL,
  `fileSize` varchar(200) DEFAULT NULL,
  `fileType` varchar(200) DEFAULT NULL,
  `slideOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `holidayCalculations`;
CREATE TABLE `holidayCalculations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `entitlementMultiplier` float DEFAULT NULL,
  `holsSet` int(11) DEFAULT NULL,
  `fullDay` int(11) DEFAULT NULL,
  `holsDue` double DEFAULT NULL,
  `holsUsed` double DEFAULT NULL,
  `holsBooked` double DEFAULT NULL,
  `holsMonthEst` double DEFAULT NULL,
  `holsYearEst` double DEFAULT NULL,
  `holsLastYear` double DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `holidayEventsRemoved`;
CREATE TABLE `holidayEventsRemoved` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `leaveType` int(11) DEFAULT NULL,
  `leaveId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `recurrDate` date DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `rcRecurrId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `holidayEventType`;
CREATE TABLE `holidayEventType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `bradfordFactor` int(11) DEFAULT NULL,
  `accrualInclude` int(1) DEFAULT NULL,
  `typeCode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `holidayNotifications`;
CREATE TABLE `holidayNotifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `holidayId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `eventType` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `holidayPayments`;
CREATE TABLE `holidayPayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `holidayId` int(11) NOT NULL,
  `paymentDate` date NOT NULL,
  `paymentValue` double DEFAULT NULL,
  `daysValue` float DEFAULT NULL,
  `hoursValue` float DEFAULT NULL,
  `batchId` int(11) DEFAULT NULL,
  `averageRate` double DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `lockDown` timestamp NULL DEFAULT NULL,
  `lockdownPayroll` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `holidays`;
CREATE TABLE `holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `totalHours` float DEFAULT NULL,
  `eventType` int(2) DEFAULT NULL,
  `paid` int(2) DEFAULT NULL,
  `payRate` int(11) DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `eventsTotal` int(11) DEFAULT NULL,
  `eventsDays` float DEFAULT NULL,
  `eventsDaysUnpaid` float DEFAULT NULL,
  `confirmAccrued` int(11) DEFAULT NULL,
  `rollingEndDate` int(2) DEFAULT NULL,
  `requestId` int(11) DEFAULT NULL,
  `lockdownPayroll` datetime DEFAULT NULL,
  `sickLeaveType` int(11) DEFAULT NULL,
  `weekPaid` float DEFAULT NULL,
  `weekUnpaid` float DEFAULT NULL,
  `avgWeek` float DEFAULT NULL,
  `avgWeeklyHrs` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`),
  KEY `paid` (`paid`),
  KEY `startDate` (`startDate`),
  KEY `endDate` (`endDate`),
  KEY `lockdownPayroll` (`lockdownPayroll`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `holidaysPending`;
CREATE TABLE `holidaysPending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `totalHours` float DEFAULT NULL,
  `eventType` int(2) DEFAULT NULL,
  `paid` int(2) DEFAULT NULL,
  `payRate` int(11) DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `eventsTotal` int(11) DEFAULT NULL,
  `eventsDays` float DEFAULT NULL,
  `eventsDaysUnpaid` float DEFAULT NULL,
  `confirmAccrued` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `carerId` (`carerId`),
  KEY `paid` (`paid`),
  KEY `startDate` (`startDate`),
  KEY `endDate` (`endDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `holidaysStartingBalance`;
CREATE TABLE `holidaysStartingBalance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `balanceHours` double DEFAULT NULL,
  `averageDailyHours` double DEFAULT NULL,
  `daysEntered` double DEFAULT NULL,
  `yearBalanceAdd` year(4) DEFAULT NULL,
  `yearBalanceAddDate` date DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `balanceValue` double DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `yearAdded` (`yearBalanceAdd`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hours`;
CREATE TABLE `hours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `assignId` int(11) DEFAULT NULL,
  `minutes` double DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hr`;
CREATE TABLE `hr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `carerId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `hr_name` varchar(100) NOT NULL,
  `hr_file` longblob NOT NULL,
  `hr_fileName` varchar(100) NOT NULL,
  `hr_size` int(11) NOT NULL,
  `hr_type` varchar(100) NOT NULL,
  `hr_dateExpired` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hrtype`;
CREATE TABLE `hrtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `hr_type_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hseLtiConditions`;
CREATE TABLE `hseLtiConditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted_at` datetime DEFAULT NULL,
  `name` varchar(80) CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `hubspot_mappings`;
CREATE TABLE `hubspot_mappings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hubspot_id` varchar(30) NOT NULL,
  `type` varchar(20) NOT NULL,
  `onetouch_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `idPrefix`;
CREATE TABLE `idPrefix` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `prefixName` varchar(50) DEFAULT NULL,
  `clientSide` int(11) DEFAULT NULL,
  `carerSide` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `id_mappings_kinetic`;
CREATE TABLE `id_mappings_kinetic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_table` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_id` bigint(20) unsigned NOT NULL,
  `destination_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `source_table_source_id_unique` (`source_table`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `id_mappings_rlo`;
CREATE TABLE `id_mappings_rlo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_table` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_id` bigint(20) unsigned NOT NULL,
  `destination_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `source_table_source_id_unique` (`source_table`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `id_mappings_sdw`;
CREATE TABLE `id_mappings_sdw` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_table` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_id` bigint(20) unsigned NOT NULL,
  `destination_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `source_table_source_id_unique` (`source_table`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `id_mappings_surecare`;
CREATE TABLE `id_mappings_surecare` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_table` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_id` bigint(20) unsigned NOT NULL,
  `destination_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `source_table_source_id_unique` (`source_table`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `ihcontract`;
CREATE TABLE `ihcontract` (
  `clientid` text,
  `BuyerID` text,
  `ClientRef` text,
  `BuyerRef` text,
  `ContractStart` text,
  `ContractEnd` text,
  `ContractHrs` text,
  `ContractNotes` text,
  `ContractRef` text,
  `LineRef` text,
  `TypeRef` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `inNewMeds`;
CREATE TABLE `inNewMeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locationId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  CONSTRAINT `inNewMeds_ibfk_1` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`),
  CONSTRAINT `inNewMeds_ibfk_2` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `inNewTasks`;
CREATE TABLE `inNewTasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locationId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `integrated_carers`;
CREATE TABLE `integrated_carers` (
  `carer_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `external_id` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `integrityv2`;
CREATE TABLE `integrityv2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `hour` time NOT NULL,
  `error` varchar(500) NOT NULL,
  `sql` longtext NOT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hour` (`hour`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `intergrityTest`;
CREATE TABLE `intergrityTest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `errors` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `invoiceeContact`;
CREATE TABLE `invoiceeContact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceeId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fName` varchar(500) DEFAULT NULL,
  `sName` varchar(500) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  `county` varchar(30) DEFAULT NULL,
  `country` varchar(60) DEFAULT NULL,
  `contactTypeName` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `invoiceeId` (`invoiceeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `invoiceItemExtraFields`;
CREATE TABLE `invoiceItemExtraFields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldKey` varchar(65) NOT NULL,
  `label` varchar(128) NOT NULL,
  `dataType` enum('string','text','int','decimal','date','datetime','bool') NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `field_key` (`fieldKey`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `invoice_history_exports`;
CREATE TABLE `invoice_history_exports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) DEFAULT NULL,
  `button` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `invoice_history_exports_buttons`;
CREATE TABLE `invoice_history_exports_buttons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ipRestriction`;
CREATE TABLE `ipRestriction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `ipAdress` varchar(200) DEFAULT NULL,
  `exception` int(1) DEFAULT NULL,
  `permissionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `jobtype`;
CREATE TABLE `jobtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `invoiceName` varchar(100) DEFAULT NULL,
  `acronym` varchar(35) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `entitlementInclude` int(1) DEFAULT '1',
  `includeNMW` int(1) DEFAULT '1',
  `sleepIn` int(1) DEFAULT NULL,
  `exportName` varchar(100) DEFAULT NULL,
  `excludeTagConflict` int(11) DEFAULT NULL,
  `payActual` int(11) DEFAULT NULL,
  `billActual` int(11) DEFAULT NULL,
  `payMaxPlanned` int(11) DEFAULT NULL,
  `archived` datetime DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `serviceType` int(11) DEFAULT NULL,
  `reportingCategory` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `jobTypeAdd`;
CREATE TABLE `jobTypeAdd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `jobTypeId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `jobtypeGroupName`;
CREATE TABLE `jobtypeGroupName` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` varchar(200) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `jobTypeList` longtext,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `budgetCategory` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `jobtypeServiceTypes`;
CREATE TABLE `jobtypeServiceTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext,
  `cancelled_at` int(10) unsigned DEFAULT NULL,
  `created_at` int(10) unsigned NOT NULL,
  `finished_at` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `keywordCategoryId` int(11) DEFAULT '3',
  `clientCarer` varchar(20) DEFAULT NULL,
  `keyword` varchar(100) DEFAULT NULL,
  `carerSide` int(11) DEFAULT NULL,
  `clientSide` int(11) DEFAULT NULL,
  `color` varchar(100) DEFAULT 'success',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `late_text`;
CREATE TABLE `late_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `lateClocking` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `letters`;
CREATE TABLE `letters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `letterId` int(11) DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `letter` mediumtext,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `letterId` (`letterId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `letterSignOff`;
CREATE TABLE `letterSignOff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataURL` mediumtext,
  `name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `letterId` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `person` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `letterId` (`letterId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `lettersSent`;
CREATE TABLE `lettersSent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `letterId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `emailSent` int(11) DEFAULT NULL,
  `appSent` int(11) DEFAULT NULL,
  `signOff` int(11) DEFAULT NULL,
  `signOffIdCarer` int(11) DEFAULT NULL,
  `signOffId` int(11) DEFAULT NULL,
  `signOffDateCarer` datetime DEFAULT NULL,
  `signOffDate` datetime DEFAULT NULL,
  `acceptSignOff` varchar(20) DEFAULT NULL,
  `letterSeen` datetime DEFAULT NULL,
  `archivedDate` datetime DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `idSingle` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `extraSignOff` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `letterTemplates`;
CREATE TABLE `letterTemplates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `carerSide` int(11) DEFAULT NULL,
  `clientSide` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `letter` mediumtext,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `completed` int(11) DEFAULT NULL,
  `carerDefault` int(11) DEFAULT NULL,
  `clientDefault` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `levelFt`;
CREATE TABLE `levelFt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `apikey` mediumtext,
  `secretKey` mediumtext,
  `companyIdLevel` mediumtext,
  `locations` mediumtext,
  `homes` mediumtext,
  `payrollCycle` varchar(50) DEFAULT NULL,
  `startCycle` varchar(10) DEFAULT NULL,
  `endCycle` varchar(10) DEFAULT NULL,
  `anchorDate` date DEFAULT NULL,
  `snippetId` mediumtext,
  `snippetDeploymentId` mediumtext,
  `active` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `levelFtCohort`;
CREATE TABLE `levelFtCohort` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `levelFtId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `lineManager`;
CREATE TABLE `lineManager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `managerId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `created` varchar(250) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updated` varchar(250) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` varchar(250) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `link`;
CREATE TABLE `link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `carerId` int(11) NOT NULL,
  `familyId` int(11) NOT NULL DEFAULT '0',
  `companyId` int(11) NOT NULL,
  `code` varchar(30) NOT NULL,
  `linkConfirm` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `linkAccountLogs`;
CREATE TABLE `linkAccountLogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `accountUsedCarerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `localAdminAccess`;
CREATE TABLE `localAdminAccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `addAdmin` int(11) DEFAULT NULL,
  `adminAuthorization` int(11) DEFAULT NULL,
  `branchSetup` int(11) DEFAULT NULL,
  `branchSetupOverall` int(11) DEFAULT NULL,
  `locationSettings` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `address1` varchar(150) DEFAULT NULL,
  `town` varchar(150) DEFAULT NULL,
  `county` varchar(130) DEFAULT NULL,
  `postCode` varchar(30) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `abn` varchar(100) DEFAULT NULL,
  `acn` varchar(100) DEFAULT NULL,
  `emailCarers` varchar(30) NOT NULL DEFAULT 'No',
  `sendPush` int(1) NOT NULL DEFAULT '0',
  `emailAdminCC` varchar(1000) DEFAULT NULL,
  `emailAdminOnly` varchar(30) NOT NULL DEFAULT 'No',
  `emailSchedule` varchar(30) NOT NULL DEFAULT 'No',
  `invoiceEmailCC` varchar(150) DEFAULT NULL,
  `newCarerStatus` int(1) DEFAULT NULL,
  `newClientStatus` int(1) DEFAULT NULL,
  `lateEmailsAfter` int(1) DEFAULT '5',
  `adminSessionTimeout` int(5) DEFAULT NULL,
  `carerSessionTimeout` int(5) DEFAULT NULL,
  `upcomingEventsTime` int(2) DEFAULT '5',
  `caring` int(1) DEFAULT '1',
  `currency` varchar(20) DEFAULT '&pound;',
  `wardAccessLinks` int(1) DEFAULT NULL,
  `buffer` int(1) DEFAULT NULL,
  `bufferShow` int(1) DEFAULT NULL,
  `breakShow` int(1) DEFAULT NULL,
  `blockShiftCall` varchar(100) DEFAULT 'Block-Shift',
  `blockShiftShow` int(1) DEFAULT NULL,
  `timeFreezeShow` int(1) DEFAULT NULL,
  `digitalTaskCall` varchar(100) DEFAULT 'Digital TaskSheet',
  `tagCall` varchar(100) DEFAULT 'Tag',
  `hrPrivateCall` varchar(100) DEFAULT 'Private Requirement',
  `hrConfidentialCall` varchar(100) DEFAULT 'Confidential Requirement',
  `pinCode` int(11) DEFAULT NULL,
  `assocRequired` int(11) DEFAULT NULL,
  `referralCall` varchar(100) DEFAULT 'Referral Reason',
  `noticeBoardLoc` int(11) DEFAULT NULL,
  `letters` int(11) DEFAULT NULL,
  `passwordDeleteTimesheet` varchar(60) DEFAULT '6af97d7deea1a1d2c76c5c512e66700b',
  `passwordAssignHrs` varchar(60) DEFAULT NULL,
  `passwordEditJobType` varchar(60) DEFAULT NULL,
  `holidayEntitlementMultiplier` float DEFAULT NULL,
  `holidaysAllocatedCarer` float DEFAULT NULL,
  `calcHolidays` varchar(60) DEFAULT 'Days',
  `holidayPayDisable` int(1) DEFAULT NULL,
  `maxEntitlement` float DEFAULT NULL,
  `requestBlock` float DEFAULT '5',
  `timefreezeOverwrite` varchar(60) DEFAULT '6af97d7deea1a1d2c76c5c512e66700b',
  `logoId` int(11) DEFAULT NULL,
  `defaultTemplateId` int(11) DEFAULT NULL,
  `payPerClient` int(11) DEFAULT NULL,
  `logoSizeInvoice` int(11) DEFAULT '25',
  `medication` int(11) DEFAULT NULL,
  `prnMed` int(11) DEFAULT '1',
  `mandatoryMed` int(11) DEFAULT NULL,
  `mandatoryRequiredMed` int(11) DEFAULT NULL,
  `medTimePeriod` int(11) DEFAULT NULL,
  `medBlockBankHol` int(11) DEFAULT NULL,
  `digitalTask` int(11) DEFAULT NULL,
  `mandatoryTask` int(11) DEFAULT NULL,
  `mandatoryRequiredTask` int(11) DEFAULT NULL,
  `digitalTaskBlockBankHol` int(11) DEFAULT NULL,
  `outcomes` int(11) DEFAULT NULL,
  `officeManagedPPE` int(11) DEFAULT NULL,
  `carerAllocatedPPE` int(11) DEFAULT NULL,
  `clientRequiredTags` varchar(60) DEFAULT NULL,
  `groupCall` varchar(200) DEFAULT 'Group',
  `groupAccess` int(11) DEFAULT NULL,
  `addClientLite` int(11) DEFAULT '1',
  `clientBuckets` int(11) DEFAULT NULL,
  `clientBillingV2` int(11) DEFAULT NULL,
  `medicationScript` int(11) DEFAULT '1',
  `digitalTaskScript` int(11) DEFAULT '1',
  `medicationAccess` int(11) DEFAULT NULL,
  `digitalTaskAccess` int(11) DEFAULT NULL,
  `carerIdDupCheck` int(11) DEFAULT '1',
  `clientIdDupCheck` int(11) DEFAULT '1',
  `privateNotePin` varchar(100) DEFAULT 'care',
  `conflictcheckEdit` int(11) DEFAULT '6',
  `maxExpenses` int(11) DEFAULT NULL,
  `wallet` int(11) DEFAULT NULL,
  `clockOutEventWindow` int(11) DEFAULT '3',
  `clockOutWindowUpcoming` int(11) DEFAULT '30',
  `scheduleFooter` varchar(250) DEFAULT NULL,
  `payrollFooter` longtext,
  `conflictDisableAvailability` int(1) DEFAULT NULL,
  `conflictDisable` int(11) DEFAULT '1',
  `holidaysDisableScheduleConflicts` int(1) DEFAULT NULL,
  `confirmLowerLimit` int(11) DEFAULT '-5',
  `confirmUpperLimit` int(11) DEFAULT '15',
  `confirmColorLimit` varchar(25) DEFAULT 'green,yellow',
  `preferredCarersPostion` int(11) DEFAULT NULL,
  `preferredCarersLength` int(11) NOT NULL DEFAULT '30',
  `holidayYearStartLocation` date DEFAULT NULL,
  `holidayYearEndLocation` date DEFAULT NULL,
  `deleteLockdownTimesheets` int(11) DEFAULT NULL,
  `adminId` int(1) DEFAULT NULL,
  `payrollTemplate` int(11) DEFAULT NULL,
  `skinSurfaceMeasure` varchar(10) DEFAULT 'cm',
  `nameGovernance` varchar(100) DEFAULT 'Governance',
  `runsShow` int(11) DEFAULT NULL,
  `prefixIds` int(11) DEFAULT NULL,
  `retentionShow` int(11) DEFAULT NULL,
  `residentialCare` int(1) DEFAULT NULL,
  `editEventWindowFutureMiss` int(11) DEFAULT NULL,
  `clockOutWindowMiss` int(11) DEFAULT NULL,
  `requestedHoursShow` int(11) DEFAULT NULL,
  `approvePlanSwitch` int(1) DEFAULT NULL,
  `travelIncludeHols` int(1) DEFAULT NULL,
  `uniqueCustomerNo` varchar(20) DEFAULT NULL,
  `recurringExpensesShow` int(11) DEFAULT NULL,
  `vatRate` int(11) DEFAULT NULL,
  `wallchartConflictDisable` int(11) DEFAULT NULL,
  `flagsSwitch` int(1) DEFAULT '0',
  `ottBilling` int(11) DEFAULT NULL,
  `banding_over_planned` int(11) DEFAULT '0',
  `paymentReceived` int(11) DEFAULT '0',
  `numberDecimalPlaces` int(11) DEFAULT '2',
  `gpConnectAccess` int(11) DEFAULT NULL,
  `clientAiComments` int(11) DEFAULT NULL,
  `holidayIncludeAccrual` int(1) DEFAULT NULL,
  `newCarerAppShow` int(11) DEFAULT NULL,
  `timeConfirmComment` int(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `sendPush` (`sendPush`),
  KEY `emailCarers` (`emailCarers`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `locationDetails`;
CREATE TABLE `locationDetails` (
  `officeHours` varchar(80) DEFAULT NULL,
  `outofofficeHours` varchar(80) DEFAULT NULL,
  `outofofficeEmergencyNumber` varchar(30) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `locationPasswords`;
CREATE TABLE `locationPasswords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `passwordDeleteTimesheet` varchar(100) NOT NULL DEFAULT '6af97d7deea1a1d2c76c5c512e66700b',
  `passwordAssignHrs` varchar(100) DEFAULT NULL,
  `passwordEditJobType` varchar(100) DEFAULT NULL,
  `timefreezeOverwrite` varchar(100) NOT NULL DEFAULT '6af97d7deea1a1d2c76c5c512e66700b',
  `passwordPastEvents` varchar(100) NOT NULL DEFAULT 'd2a1e34d86293cb12f959f89dddf263e',
  `passwordStatusChangeClient` varchar(100) DEFAULT NULL,
  `passwordStatusChangeCarer` varchar(100) DEFAULT NULL,
  `passwordDeleteHoliday` varchar(100) DEFAULT '1b36ea1c9b7a1c3ad668b8bb5df7963f',
  `passwordDeleteTraining` varchar(100) DEFAULT 'd47268e9db2e9aa3827bba3afb7ff94a',
  `passwordDeleteOther` varchar(100) DEFAULT '65fc52ed8f88c81323a418ca94cec2ed',
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `location_invoicing_details`;
CREATE TABLE `location_invoicing_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `invoicing_notes` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carerId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `locationName` varchar(50) NOT NULL,
  `companyId` int(11) NOT NULL,
  `companyName` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `browser` varchar(500) DEFAULT NULL,
  `ipAddress` varchar(200) DEFAULT NULL,
  `carerApp` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `companyId` (`companyId`),
  KEY `location_id` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `logEngage`;
CREATE TABLE `logEngage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `clientId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `page` varchar(50) NOT NULL,
  `carerId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `logErrors`;
CREATE TABLE `logErrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `errorInfo` text,
  `page` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `loginFails`;
CREATE TABLE `loginFails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `ipAddress` varchar(100) DEFAULT NULL,
  `side` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `loginPin`;
CREATE TABLE `loginPin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `pin` varchar(250) DEFAULT NULL,
  `attempts` int(11) DEFAULT NULL,
  `lock_time` timestamp NULL DEFAULT NULL,
  `block` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `loginStatus`;
CREATE TABLE `loginStatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `recurrDate` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `jobType` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `logIn` datetime DEFAULT NULL,
  `logOut` datetime DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `tasksDone` text,
  `latitudeIn` varchar(20) DEFAULT NULL,
  `longitudeIn` varchar(20) DEFAULT NULL,
  `latitudeOut` varchar(20) DEFAULT NULL,
  `longitudeOut` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recurrId` (`recurrId`),
  KEY `timesheetId` (`timesheetId`),
  KEY `locationId` (`locationId`),
  KEY `recurrDate` (`recurrDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `logoutReason`;
CREATE TABLE `logoutReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `earlyFlag` int(11) DEFAULT NULL,
  `lateFlag` int(11) DEFAULT NULL,
  `orderBy` int(11) DEFAULT NULL,
  `reasonCode` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `logPageCMFamily`;
CREATE TABLE `logPageCMFamily` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `familyId` int(11) DEFAULT NULL,
  `page` varchar(100) DEFAULT NULL,
  `menu` varchar(100) DEFAULT NULL,
  `person` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `log_PageCM_2025`;
CREATE TABLE `log_PageCM_2025` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `page` varchar(100) DEFAULT NULL,
  `menu` varchar(100) DEFAULT NULL,
  `person` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `magicLink`;
CREATE TABLE `magicLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carerId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `hash` longtext NOT NULL,
  `companyId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `managementAutoTimesheets`;
CREATE TABLE `managementAutoTimesheets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `managementLocationAccess`;
CREATE TABLE `managementLocationAccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` varchar(200) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` varchar(200) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` varchar(200) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `access` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `managementLocationFullAdmins`;
CREATE TABLE `managementLocationFullAdmins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mandatoryEventReasons`;
CREATE TABLE `mandatoryEventReasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mandatorySkipReason`;
CREATE TABLE `mandatorySkipReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `comment` text,
  `clientId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `medicationIdsSkipped` text,
  `taskIdsSkipped` text,
  PRIMARY KEY (`id`),
  KEY `idx_mandatorySkipReason_created_location_company_client` (`created`,`locationId`,`companyId`,`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationAssign`;
CREATE TABLE `medicationAssign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `keepRecurring` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `medicationListId` int(11) DEFAULT NULL,
  `medicationNumber` double DEFAULT NULL,
  `medTime` time DEFAULT NULL,
  `details` text,
  `required` int(11) DEFAULT NULL,
  `reasonStop` text,
  `stoppedBy` int(11) DEFAULT NULL,
  `stoppedDate` datetime DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `weeks` varchar(10) DEFAULT NULL,
  `daysCount` varchar(10) DEFAULT NULL,
  `cloneOf` int(11) DEFAULT NULL,
  `effectiveStopTime` time DEFAULT NULL,
  `mon` int(1) DEFAULT NULL,
  `tue` int(1) DEFAULT NULL,
  `wed` int(1) DEFAULT NULL,
  `thu` int(1) DEFAULT NULL,
  `fri` int(1) DEFAULT NULL,
  `sat` int(1) DEFAULT NULL,
  `sun` int(1) DEFAULT NULL,
  `week` int(1) DEFAULT NULL,
  `everyNumDays` int(11) DEFAULT NULL,
  `outcomeId` varchar(200) DEFAULT NULL,
  `dueRequired` int(1) DEFAULT NULL,
  `painLocationPercent` varchar(200) DEFAULT NULL,
  `painSeverity` varchar(200) DEFAULT NULL,
  `mandatory` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `dateStart` (`dateStart`),
  KEY `dateFinish` (`dateFinish`),
  KEY `week` (`week`),
  KEY `everyNumDays` (`everyNumDays`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationAssignTimes`;
CREATE TABLE `medicationAssignTimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `medicationAssign` int(11) DEFAULT NULL,
  `times` time DEFAULT NULL,
  `timePeriodId` int(11) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `extraTime` int(11) DEFAULT NULL,
  `reasonForAdding` text,
  `outcomeId` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medicationAssign` (`medicationAssign`),
  KEY `outcomeId` (`outcomeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationBalance`;
CREATE TABLE `medicationBalance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `medicationId` int(11) DEFAULT NULL,
  `wardId` int(11) DEFAULT NULL,
  `reconcile` float DEFAULT NULL,
  `newStock` float DEFAULT NULL,
  `wardIn` int(11) DEFAULT NULL,
  `wardInFrom` int(11) DEFAULT NULL,
  `wardOut` int(11) DEFAULT NULL,
  `wardOutTo` int(11) DEFAULT NULL,
  `administered` double DEFAULT NULL,
  `disposed` double DEFAULT NULL,
  `details` text,
  `clientId` int(11) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `activeBalance` float DEFAULT NULL,
  `secondSignature` int(11) DEFAULT NULL,
  `signed` timestamp NULL DEFAULT NULL,
  `signedBy` int(11) DEFAULT NULL,
  `signedState` varchar(20) DEFAULT NULL,
  `referenceId` int(11) DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `archivedDate` datetime DEFAULT NULL,
  `archivedReason` text,
  `cancelAmount` varchar(20) DEFAULT NULL,
  `disposalInfo` varchar(500) DEFAULT NULL,
  `resultId` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `wardId` (`wardId`),
  KEY `medicationId` (`medicationId`),
  KEY `activeBalance` (`activeBalance`),
  KEY `secondSignature` (`secondSignature`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationEmailLog`;
CREATE TABLE `medicationEmailLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `emailId` int(11) DEFAULT NULL,
  `resultId` int(11) DEFAULT NULL,
  `carerIdNofifyArr` varchar(500) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationEmarSignOff`;
CREATE TABLE `medicationEmarSignOff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `month` varchar(20) DEFAULT NULL,
  `monthDate` date DEFAULT NULL,
  `namePrinted` varchar(100) DEFAULT NULL,
  `signatureImg` longblob,
  `comment` varchar(500) DEFAULT NULL,
  `fileNameS3` varchar(500) DEFAULT NULL,
  `gpFlag` tinyint(4) DEFAULT NULL,
  `allergiesFlag` tinyint(4) DEFAULT NULL,
  `postItTableFlag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationForm`;
CREATE TABLE `medicationForm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationList`;
CREATE TABLE `medicationList` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `medicationName` varchar(200) DEFAULT NULL,
  `medicationDose` varchar(200) DEFAULT NULL,
  `totalDose` varchar(200) DEFAULT NULL,
  `medicationForm` varchar(100) DEFAULT NULL,
  `medicationRoute` varchar(100) DEFAULT NULL,
  `nhs_med_id` int(11) DEFAULT NULL,
  `nhs_med_url` varchar(200) DEFAULT NULL,
  `nhs_med_info` longtext,
  `nhs_med_created` timestamp NULL DEFAULT NULL,
  `nhs_med_updated` timestamp NULL DEFAULT NULL,
  `archivedReason` text,
  `editOf` int(11) DEFAULT NULL,
  `protected` tinyint(4) DEFAULT NULL,
  `strength` varchar(200) DEFAULT NULL,
  `method` varchar(200) DEFAULT NULL,
  `methodUnit` varchar(200) DEFAULT NULL,
  `maxFrequency` smallint(6) DEFAULT NULL,
  `freqUnit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationOfflineUpdates`;
CREATE TABLE `medicationOfflineUpdates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `clockOutTime` datetime DEFAULT NULL,
  `medAssignId` int(11) DEFAULT NULL,
  `medAssignTimesId` int(11) DEFAULT NULL,
  `dateEntered` date NOT NULL,
  `amount` varchar(10) NOT NULL,
  `comment` text NOT NULL,
  `reason` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `recurrId` int(11) NOT NULL,
  `synced` timestamp NULL DEFAULT NULL,
  `conflict` int(11) DEFAULT NULL,
  `resultId` int(11) DEFAULT NULL,
  `timeSaid` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationReason`;
CREATE TABLE `medicationReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `ddorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `categoryId` (`categoryId`),
  KEY `deleted` (`deleted`),
  KEY `ddorder` (`ddorder`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationReasonCategory`;
CREATE TABLE `medicationReasonCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `color` varchar(200) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `commentRequired` tinyint(4) DEFAULT NULL,
  `code` varchar(3) DEFAULT NULL,
  `replaceCategoryId` int(11) DEFAULT NULL,
  `signOffRequired` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `replaceCategoryId` (`replaceCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationResults`;
CREATE TABLE `medicationResults` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedReason` varchar(200) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `dateEntered` date DEFAULT NULL,
  `timeEntered` time DEFAULT NULL,
  `taskDone` int(11) DEFAULT NULL,
  `subTaskDone` int(11) DEFAULT NULL,
  `timeSaid` time DEFAULT NULL,
  `comment` text,
  `medAssignId` int(11) DEFAULT NULL,
  `medAssignTimesId` int(11) DEFAULT NULL,
  `medId` int(11) DEFAULT NULL,
  `amountGiven` double DEFAULT NULL,
  `amountShouldBe` double DEFAULT NULL,
  `required` int(11) DEFAULT NULL,
  `editOf` int(11) DEFAULT NULL,
  `outcomeId` varchar(200) DEFAULT NULL,
  `alertId` int(11) DEFAULT NULL,
  `alertSeenBy` int(11) DEFAULT NULL,
  `painLocationPercent` varchar(500) DEFAULT NULL,
  `painSeverity` varchar(100) DEFAULT NULL,
  `mandatory` tinyint(4) DEFAULT NULL,
  `medScriptLoc` int(11) DEFAULT NULL,
  `missedTimestamp` timestamp NULL DEFAULT NULL,
  `signOff` int(11) DEFAULT NULL,
  `medDue` datetime DEFAULT NULL,
  `medMiss` datetime DEFAULT NULL,
  `missHideApp` datetime DEFAULT NULL,
  `missEmail` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medAssignId` (`medAssignId`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `medAssignTimesId` (`medAssignTimesId`),
  KEY `medId` (`medId`),
  KEY `dateEntered` (`dateEntered`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `medicationRoute`;
CREATE TABLE `medicationRoute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `menuItemId` int(11) DEFAULT NULL,
  `under` varchar(20) DEFAULT NULL,
  `new` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `menuItem`;
CREATE TABLE `menuItem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `nameBefore` varchar(50) DEFAULT NULL,
  `page` varchar(200) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `shortName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `menuItemCarer`;
CREATE TABLE `menuItemCarer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `messageTo` int(11) DEFAULT NULL,
  `messageToType` varchar(10) DEFAULT NULL,
  `messageFrom` int(11) DEFAULT NULL,
  `requiredView` int(11) DEFAULT NULL,
  `messageFromType` varchar(10) DEFAULT NULL,
  `message` text,
  `messageRead` datetime DEFAULT NULL,
  `seen` varchar(4) DEFAULT NULL,
  `seenBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `messageTo` (`messageTo`),
  KEY `messageFrom` (`messageFrom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mfa_tokens`;
CREATE TABLE `mfa_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `token` varchar(80) NOT NULL,
  `verified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`),
  KEY `company_location_user` (`companyId`,`locationId`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `mmrReports`;
CREATE TABLE `mmrReports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` char(1) NOT NULL COMMENT '(B = Branch, L = Location)',
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `branchId` int(11) DEFAULT NULL,
  `monthReference` varchar(2) NOT NULL,
  `yearReference` varchar(4) NOT NULL,
  `numberInvoices` int(11) DEFAULT NULL,
  `numberTimesheets` int(11) DEFAULT NULL,
  `customers` int(11) DEFAULT NULL,
  `carers` int(11) DEFAULT NULL,
  `totalHours` decimal(10,2) DEFAULT NULL,
  `totalBilling` decimal(10,2) DEFAULT NULL,
  `totalPay` decimal(10,2) DEFAULT NULL,
  `expensePay` decimal(10,2) DEFAULT NULL,
  `grossProfit` decimal(10,2) DEFAULT NULL,
  `mfExclVat` decimal(10,2) DEFAULT NULL,
  `mfInclVat` decimal(10,2) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  `createdTime` time DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `modal_popups`;
CREATE TABLE `modal_popups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `session` text NOT NULL,
  `referrer` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `myhomecare_clients`;
CREATE TABLE `myhomecare_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `internal_id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `surname` varchar(1000) NOT NULL,
  `file_id` int(11) NOT NULL,
  `filename` varchar(1000) NOT NULL,
  `created` varchar(1000) NOT NULL,
  `folder_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `myhomecare_staff`;
CREATE TABLE `myhomecare_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `internal_id` int(11) NOT NULL,
  `carer_id` int(11) NOT NULL,
  `first_name` varchar(500) NOT NULL,
  `last_name` varchar(500) NOT NULL,
  `type` varchar(100) NOT NULL,
  `file_id` int(11) NOT NULL,
  `filename` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `needsSectionPRSB`;
CREATE TABLE `needsSectionPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `details` text,
  `questionImgId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carePlanTakenId` (`carePlanTakenId`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `newEnviroments`;
CREATE TABLE `newEnviroments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `forceNewApp` int(1) NOT NULL,
  `forceNewUI` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `news2Alerts`;
CREATE TABLE `news2Alerts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `suggested` longtext,
  `observation` longtext,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `news2ObservationParameter`;
CREATE TABLE `news2ObservationParameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `observationId` int(11) DEFAULT NULL,
  `parameterId` int(11) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `news2Observations`;
CREATE TABLE `news2Observations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `repeat` int(11) DEFAULT NULL,
  `agreeActions` int(11) DEFAULT NULL,
  `reasonActions` varchar(250) DEFAULT NULL,
  `reasonFrequency` varchar(250) DEFAULT NULL,
  `scaleToResidents` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `news2ParameterRanges`;
CREATE TABLE `news2ParameterRanges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameterId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `news2ParameterRangeValues`;
CREATE TABLE `news2ParameterRangeValues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rangeId` int(11) DEFAULT NULL,
  `formatId` int(11) DEFAULT NULL,
  `scoreId` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `value` float DEFAULT NULL,
  `min` float DEFAULT NULL,
  `max` float DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `news2Parameters`;
CREATE TABLE `news2Parameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(50) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `subtitle` varchar(150) DEFAULT NULL,
  `description` longtext,
  `observation` longtext,
  `measure` varchar(100) DEFAULT NULL,
  `precision` varchar(10) DEFAULT NULL,
  `min` float DEFAULT NULL,
  `max` float DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `news2ParameterScores`;
CREATE TABLE `news2ParameterScores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(11) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `news2Types`;
CREATE TABLE `news2Types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaCarePlan`;
CREATE TABLE `nhaCarePlan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `planName` varchar(100) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `initialAssessment` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaCarePlanTaken`;
CREATE TABLE `nhaCarePlanTaken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carePlanId` int(11) DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `modified` int(11) DEFAULT '0',
  `reviewReason` varchar(100) DEFAULT NULL,
  `reviewClassification` int(11) DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAllergies`;
CREATE TABLE `nhAllergies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `reasonId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `statusId` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` longtext,
  `severityComment` longtext,
  `descriptionCausativeAgent` varchar(255) DEFAULT NULL,
  `routeExposure` varchar(255) DEFAULT NULL,
  `onsetDate` date DEFAULT NULL,
  `severityId` int(11) DEFAULT NULL,
  `treatment` longtext,
  `resultInvestigation` longtext,
  `dateFirstReaction` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `professionalName` varchar(255) DEFAULT NULL,
  `professionalRole` varchar(255) DEFAULT NULL,
  `professionalGrade` varchar(255) DEFAULT NULL,
  `professionalSpeciality` varchar(255) DEFAULT NULL,
  `professionalIdentifierName` varchar(255) DEFAULT NULL,
  `professionalIdentifierRole` varchar(255) DEFAULT NULL,
  `professionalIdentifierGrade` varchar(255) DEFAULT NULL,
  `professionalIdentifierSpecialityId` int(11) DEFAULT NULL,
  `professionalIdentifier` varchar(255) DEFAULT NULL,
  `professionalIdentifierOrganization` varchar(255) DEFAULT NULL,
  `professionalIdentifierContact` varchar(255) DEFAULT NULL,
  `comment` longtext,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deleteBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAllergyHistories`;
CREATE TABLE `nhAllergyHistories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `allergyId` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `cause` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `symptoms` longtext,
  `comments` longtext,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAllergyHistoryFiles`;
CREATE TABLE `nhAllergyHistoryFiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `historyId` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAllergyProfessionalSpecialities`;
CREATE TABLE `nhAllergyProfessionalSpecialities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAllergyTypeQuestions`;
CREATE TABLE `nhAllergyTypeQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeId` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAllergyTypes`;
CREATE TABLE `nhAllergyTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAnswerActions`;
CREATE TABLE `nhAnswerActions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` text,
  `questionId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAnswers`;
CREATE TABLE `nhAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `formId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `dateReview` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAnswersCheckbox`;
CREATE TABLE `nhAnswersCheckbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `questionOptionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answerId` (`answerId`),
  CONSTRAINT `nhAnswersCheckbox_ibfk_1` FOREIGN KEY (`answerId`) REFERENCES `nhAnswers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAnswersDate`;
CREATE TABLE `nhAnswersDate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `responseDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answerId` (`answerId`),
  KEY `questionId` (`questionId`),
  CONSTRAINT `nhAnswersDate_ibfk_1` FOREIGN KEY (`answerId`) REFERENCES `nhAnswers` (`id`),
  CONSTRAINT `nhAnswersDate_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `nhFormQuestions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAnswersOptions`;
CREATE TABLE `nhAnswersOptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `questionOptionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answerId` (`answerId`),
  CONSTRAINT `nhAnswersOptions_ibfk_1` FOREIGN KEY (`answerId`) REFERENCES `nhAnswers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAnswersText`;
CREATE TABLE `nhAnswersText` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `responseText` text,
  PRIMARY KEY (`id`),
  KEY `answerId` (`answerId`),
  KEY `questionId` (`questionId`),
  CONSTRAINT `nhAnswersText_ibfk_1` FOREIGN KEY (`answerId`) REFERENCES `nhAnswers` (`id`),
  CONSTRAINT `nhAnswersText_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `nhFormQuestions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAnswersTime`;
CREATE TABLE `nhAnswersTime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `responseTime` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answerId` (`answerId`),
  KEY `questionId` (`questionId`),
  CONSTRAINT `nhAnswersTime_ibfk_1` FOREIGN KEY (`answerId`) REFERENCES `nhAnswers` (`id`),
  CONSTRAINT `nhAnswersTime_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `nhFormQuestions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaPrepopSentences`;
CREATE TABLE `nhaPrepopSentences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `sentence` varchar(100) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaQuestionAnswers`;
CREATE TABLE `nhaQuestionAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `answer` varchar(600) NOT NULL,
  `appendedQ` int(11) DEFAULT NULL,
  `flagId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaQuestions`;
CREATE TABLE `nhaQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `question` varchar(250) NOT NULL,
  `headerText` text,
  `assessmentId` int(11) DEFAULT NULL,
  `sectionId` int(11) DEFAULT NULL,
  `primaryQ` int(11) DEFAULT NULL,
  `secondaryQ` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `fileCabLink` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaSections`;
CREATE TABLE `nhaSections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `section` varchar(100) NOT NULL,
  `subSectionOf` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAssessmentCarePlanLink`;
CREATE TABLE `nhAssessmentCarePlanLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `carePlanId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `signedOff` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAssessmentDemographicLink`;
CREATE TABLE `nhAssessmentDemographicLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `assessmentLinkId` int(11) DEFAULT NULL,
  `demographic` varchar(100) DEFAULT NULL,
  `listOrder` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAssessmentGoalLink`;
CREATE TABLE `nhAssessmentGoalLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `assessmentLinkId` int(11) DEFAULT NULL,
  `goalId` int(11) DEFAULT NULL,
  `displayOption` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAssessmentGroups`;
CREATE TABLE `nhAssessmentGroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAssessments`;
CREATE TABLE `nhAssessments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `assessment` varchar(100) NOT NULL,
  `assessmentGroup` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `saved` timestamp NULL DEFAULT NULL,
  `savedBy` int(11) DEFAULT NULL,
  `updateOf` int(11) DEFAULT NULL,
  `originalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhAssessmentTaken`;
CREATE TABLE `nhAssessmentTaken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` datetime DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `opened` datetime DEFAULT NULL,
  `openedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `closed` int(11) DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `closedOn` datetime DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaTakenAnswers`;
CREATE TABLE `nhaTakenAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answered` datetime DEFAULT NULL,
  `answeredBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `optionAnsId` int(11) DEFAULT NULL,
  `textAns` text,
  `confirmed` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaTakenAnswersLOCKED`;
CREATE TABLE `nhaTakenAnswersLOCKED` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answered` datetime DEFAULT NULL,
  `answeredBy` int(11) DEFAULT NULL,
  `archived` datetime DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `assessmentTakenId` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `optionAnsId` int(11) DEFAULT NULL,
  `textAns` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaTemplateAssessment`;
CREATE TABLE `nhaTemplateAssessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `templateId` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaTemplateFolder`;
CREATE TABLE `nhaTemplateFolder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `templateId` int(11) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhaTemplates`;
CREATE TABLE `nhaTemplates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhbmiCategories`;
CREATE TABLE `nhbmiCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `valueUpperLimit` float DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhCarePlanCalls`;
CREATE TABLE `nhCarePlanCalls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) NOT NULL,
  `residentId` int(11) NOT NULL,
  `voiceAiCallId` varchar(250) DEFAULT NULL,
  `carerName` varchar(250) DEFAULT NULL,
  `residentName` varchar(250) DEFAULT NULL,
  `questions` longtext,
  `phoneNumber` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `carerId` (`carerId`) USING BTREE,
  KEY `residentId` (`residentId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhCarePlanCallsMultiplePlans`;
CREATE TABLE `nhCarePlanCallsMultiplePlans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanId` int(11) NOT NULL,
  `carePlanCallsId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `carePlanId` (`carePlanId`) USING BTREE,
  KEY `carePlanCallsId` (`carePlanCallsId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhCarePlanSignatures`;
CREATE TABLE `nhCarePlanSignatures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `signingPerson` int(11) DEFAULT NULL,
  `contactTypeId` int(11) DEFAULT NULL,
  `careplanTakenId` int(11) DEFAULT NULL,
  `signatureImg` longblob,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhCarePlanUpdates`;
CREATE TABLE `nhCarePlanUpdates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carePlanId` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `sectionId` int(11) DEFAULT NULL,
  `content` longtext,
  `color` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhDefaultAssessmentPrepopSentences`;
CREATE TABLE `nhDefaultAssessmentPrepopSentences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `sentence` varchar(100) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhDefaultAssessmentQuestionAnswers`;
CREATE TABLE `nhDefaultAssessmentQuestionAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `answer` varchar(600) NOT NULL,
  `appendedQ` int(11) DEFAULT NULL,
  `flagId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhDefaultAssessmentQuestions`;
CREATE TABLE `nhDefaultAssessmentQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `question` varchar(250) NOT NULL,
  `headerText` text,
  `assessmentId` int(11) DEFAULT NULL,
  `sectionId` int(11) DEFAULT NULL,
  `primaryQ` int(11) DEFAULT NULL,
  `secondaryQ` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhDefaultAssessments`;
CREATE TABLE `nhDefaultAssessments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `assessment` varchar(100) NOT NULL,
  `assessmentGroup` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `saved` timestamp NULL DEFAULT NULL,
  `savedBy` int(11) DEFAULT NULL,
  `updateOf` int(11) DEFAULT NULL,
  `originalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhDefaultChartQuestionAnswers`;
CREATE TABLE `nhDefaultChartQuestionAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answer` varchar(250) DEFAULT NULL,
  `appendedQues` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhDefaultChartQuestions`;
CREATE TABLE `nhDefaultChartQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `question` varchar(500) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `updated_id` int(11) NOT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhDefaultCharts`;
CREATE TABLE `nhDefaultCharts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `saved` timestamp NULL DEFAULT NULL,
  `savedBy` int(11) DEFAULT NULL,
  `updateOf` int(11) DEFAULT NULL,
  `originalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhDiagnosis`;
CREATE TABLE `nhDiagnosis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(10) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(10) DEFAULT NULL,
  `companyId` int(10) NOT NULL,
  `locationId` int(10) NOT NULL,
  `clientId` int(10) DEFAULT NULL,
  `type` varchar(150) NOT NULL,
  `details` text NOT NULL,
  `dateOfDiagnosis` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nhDiagnosis_carer_id_fk` (`created_by`),
  KEY `nhDiagnosis_carer_id_fk_2` (`updated_by`),
  KEY `nhDiagnosis_carer_id_fk_3` (`deleted_by`),
  KEY `nhDiagnosis_client_id_fk` (`clientId`),
  KEY `nhDiagnosis_company_id_fk` (`companyId`),
  KEY `nhDiagnosis_location_id_fk` (`locationId`),
  CONSTRAINT `nhDiagnosis_carer_id_fk` FOREIGN KEY (`created_by`) REFERENCES `carer` (`id`),
  CONSTRAINT `nhDiagnosis_carer_id_fk_2` FOREIGN KEY (`updated_by`) REFERENCES `carer` (`id`),
  CONSTRAINT `nhDiagnosis_carer_id_fk_3` FOREIGN KEY (`deleted_by`) REFERENCES `carer` (`id`),
  CONSTRAINT `nhDiagnosis_client_id_fk` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `nhDiagnosis_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `nhDiagnosis_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhEntryTypeSetup`;
CREATE TABLE `nhEntryTypeSetup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL COMMENT 'assessment collection id rather than actual id',
  `stdAssessmentId` int(11) DEFAULT NULL,
  `careplanId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhFlagCategory`;
CREATE TABLE `nhFlagCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `subCatOf` int(11) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhFlags`;
CREATE TABLE `nhFlags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `subCategory` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhFollowUps`;
CREATE TABLE `nhFollowUps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `actionTaken` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhFormQuestions`;
CREATE TABLE `nhFormQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `formId` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `groupId` int(11) DEFAULT NULL,
  `isNotAccountable` int(11) DEFAULT '0',
  `overTitle` varchar(255) DEFAULT NULL,
  `questionType` enum('options','text','date','time','checkbox') NOT NULL DEFAULT 'options',
  PRIMARY KEY (`id`),
  KEY `formId` (`formId`),
  KEY `fk_groupId` (`groupId`),
  CONSTRAINT `fk_groupId` FOREIGN KEY (`groupId`) REFERENCES `nhFormQuestionsGroups` (`id`),
  CONSTRAINT `nhFormQuestions_ibfk_1` FOREIGN KEY (`formId`) REFERENCES `nhForms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhFormQuestionsGroups`;
CREATE TABLE `nhFormQuestionsGroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `formId` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `formId` (`formId`),
  CONSTRAINT `nhFormQuestionsGroups_ibfk_1` FOREIGN KEY (`formId`) REFERENCES `nhForms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhFormQuestionsOptions`;
CREATE TABLE `nhFormQuestionsOptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionId` (`questionId`),
  CONSTRAINT `nhFormQuestionsOptions_ibfk_1` FOREIGN KEY (`questionId`) REFERENCES `nhFormQuestions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhForms`;
CREATE TABLE `nhForms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `movementDuePeriod` int(11) DEFAULT NULL,
  `movementOffset` int(11) DEFAULT NULL,
  `reviewDuePeriod` int(11) DEFAULT NULL,
  `defaultClientReviewFreq` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhFormScore`;
CREATE TABLE `nhFormScore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `formId` int(11) DEFAULT NULL,
  `from` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `resultText` varchar(255) NOT NULL,
  `resultColor` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `formId` (`formId`),
  CONSTRAINT `nhFormScore_ibfk_1` FOREIGN KEY (`formId`) REFERENCES `nhForms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhGoals`;
CREATE TABLE `nhGoals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `areaId` int(11) NOT NULL,
  `idClient` int(11) NOT NULL,
  `idCategory` int(11) NOT NULL,
  `idStatus` int(11) NOT NULL,
  `planned` text NOT NULL,
  `date` date NOT NULL,
  `review` date NOT NULL,
  `outcome` text,
  `idGoalSuperseded` int(11) DEFAULT NULL COMMENT 'If filled, represents the new goal id from this one',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhGoalsCategory`;
CREATE TABLE `nhGoalsCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhGoalsStatus`;
CREATE TABLE `nhGoalsStatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhHandoverNotes`;
CREATE TABLE `nhHandoverNotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `chartId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `uuid` char(36) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `seen` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhMedicalHistory`;
CREATE TABLE `nhMedicalHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `companyId` int(10) NOT NULL,
  `locationId` int(10) NOT NULL,
  `clientId` int(10) NOT NULL,
  `furtherDetails` text NOT NULL,
  `medicalDate` date NOT NULL,
  `medicalProcedure` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nhMedicalHistory_client_id_fk` (`clientId`),
  KEY `nhMedicalHistory_company_id_fk` (`companyId`),
  KEY `nhMedicalHistory_location_id_fk` (`locationId`),
  CONSTRAINT `nhMedicalHistory_client_id_fk` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `nhMedicalHistory_company_id_fk` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `nhMedicalHistory_location_id_fk` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhMessages`;
CREATE TABLE `nhMessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `sent_by` int(11) NOT NULL,
  `sent_to` int(11) DEFAULT NULL,
  `residentId` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `replyMessageId` int(11) DEFAULT NULL COMMENT 'stores the id of the message is being replied',
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `nhMessages_companyId_index` (`companyId`) USING BTREE,
  KEY `nhMessages_locationId_index` (`locationId`) USING BTREE,
  KEY `nhMessages_sent_by_index` (`sent_by`) USING BTREE,
  KEY `nhMessages_sent_to_index` (`sent_to`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhmustAssessment`;
CREATE TABLE `nhmustAssessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `weightMetric` float DEFAULT NULL,
  `weightStone` float DEFAULT NULL,
  `weightLbs` float DEFAULT NULL,
  `heightMetric` float DEFAULT NULL,
  `heightImperialInches` float DEFAULT NULL,
  `heightImperialFeet` float DEFAULT NULL,
  `weightLogMetric` float DEFAULT NULL,
  `weightLogStone` float DEFAULT NULL,
  `weightLogLbs` float DEFAULT NULL,
  `weightLossScore` int(11) DEFAULT NULL,
  `weightLossPlanned` varchar(3) DEFAULT NULL,
  `bmi` float DEFAULT NULL,
  `bmiScore` int(11) DEFAULT NULL,
  `ade` varchar(255) DEFAULT NULL,
  `adeScore` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `deletedAt` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhNotificationCategory`;
CREATE TABLE `nhNotificationCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhNotifications`;
CREATE TABLE `nhNotifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `showMenu` int(11) DEFAULT '1',
  `linkedId` int(11) DEFAULT NULL,
  `say` varchar(300) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhPhotoGalleryCategories`;
CREATE TABLE `nhPhotoGalleryCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhPhotoGalleryItems`;
CREATE TABLE `nhPhotoGalleryItems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `fileName` text NOT NULL,
  `fileNameThumbnail` text,
  `title` tinytext,
  `description` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `clientId` (`clientId`) USING BTREE,
  KEY `categoryId` (`categoryId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhPin`;
CREATE TABLE `nhPin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pin` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhProfileSections`;
CREATE TABLE `nhProfileSections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  `secOrder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhProgressNotes`;
CREATE TABLE `nhProgressNotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `areaId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `reasonId` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `note` text,
  `status` varchar(50) DEFAULT NULL,
  `priority` varchar(50) DEFAULT NULL,
  `dateCompleted` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ProgressNotes_Category` (`categoryId`),
  KEY `FK_ProgressNotes_Reason` (`reasonId`),
  KEY `FK_ProgressNotes_Company` (`companyId`),
  KEY `FK_ProgressNotes_Location` (`locationId`),
  KEY `FK_ProgressNotes_Client` (`clientId`),
  KEY `FK_ProgressNotes_Area` (`areaId`),
  CONSTRAINT `FK_ProgressNotes_Area` FOREIGN KEY (`areaId`) REFERENCES `area` (`id`),
  CONSTRAINT `FK_ProgressNotes_Category` FOREIGN KEY (`categoryId`) REFERENCES `nhProgressNotesCategory` (`id`),
  CONSTRAINT `FK_ProgressNotes_Client` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `FK_ProgressNotes_Company` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `FK_ProgressNotes_Location` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_ProgressNotes_Reason` FOREIGN KEY (`reasonId`) REFERENCES `nhProgressNotesReason` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhProgressNotesCategory`;
CREATE TABLE `nhProgressNotesCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `areaId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `folderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ProgressNotesCategory_Company` (`companyId`),
  KEY `FK_ProgressNotesCategory_Location` (`locationId`),
  KEY `FK_ProgressNotesCategory_Area` (`areaId`),
  CONSTRAINT `FK_ProgressNotesCategory_Area` FOREIGN KEY (`areaId`) REFERENCES `area` (`id`),
  CONSTRAINT `FK_ProgressNotesCategory_Company` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `FK_ProgressNotesCategory_Location` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhProgressNotesReason`;
CREATE TABLE `nhProgressNotesReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL COMMENT 'Link with nhProgressNoteCategory',
  `areaId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `daysToNotify` int(11) DEFAULT NULL COMMENT 'Days to send email notification',
  `emailToNotify` varchar(100) DEFAULT NULL COMMENT 'Email to send notification',
  PRIMARY KEY (`id`),
  KEY `FK_ProgressNotesReason_Company` (`companyId`),
  KEY `FK_ProgressNotesReason_Location` (`locationId`),
  KEY `FK_ProgressNotesReason_Category` (`categoryId`),
  KEY `FK_ProgressNotesReason_Area` (`areaId`),
  CONSTRAINT `FK_ProgressNotesReason_Area` FOREIGN KEY (`areaId`) REFERENCES `area` (`id`),
  CONSTRAINT `FK_ProgressNotesReason_Category` FOREIGN KEY (`categoryId`) REFERENCES `nhProgressNotesCategory` (`id`),
  CONSTRAINT `FK_ProgressNotesReason_Company` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `FK_ProgressNotesReason_Location` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhProgressNotesSubtasks`;
CREATE TABLE `nhProgressNotesSubtasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `areaId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `progressNoteId` int(11) NOT NULL,
  `progressNoteTaskId` int(10) NOT NULL,
  `assignTo` int(11) DEFAULT NULL,
  `due` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `details` text,
  `uploadedFileS3` varchar(100) DEFAULT NULL,
  `uploadedFileOriginalName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ProgressNotesSubtasks_ProgressNotes` (`progressNoteId`),
  KEY `FK_ProgressNotesSubtasks_Company` (`companyId`),
  KEY `FK_ProgressNotesSubtasks_Location` (`locationId`),
  KEY `FK_ProgressNotesSubtasks_Client` (`clientId`),
  KEY `FK_ProgressNotesSubtasks_Carer` (`assignTo`),
  KEY `FK_progressNotesSubtasks_Area` (`areaId`),
  KEY `FK_ProgressNotesSubtasks_ProgressNotesTask` (`progressNoteTaskId`),
  CONSTRAINT `FK_ProgressNotesSubtasks_Carer` FOREIGN KEY (`assignTo`) REFERENCES `carer` (`id`),
  CONSTRAINT `FK_ProgressNotesSubtasks_Client` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `FK_ProgressNotesSubtasks_Company` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `FK_ProgressNotesSubtasks_Location` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_ProgressNotesSubtasks_ProgressNotes` FOREIGN KEY (`progressNoteId`) REFERENCES `nhProgressNotes` (`id`),
  CONSTRAINT `FK_ProgressNotesSubtasks_ProgressNotesTask` FOREIGN KEY (`progressNoteTaskId`) REFERENCES `nhProgressNotesTasks` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_progressNotesSubtasks_Area` FOREIGN KEY (`areaId`) REFERENCES `area` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhProgressNotesSubtasksActions`;
CREATE TABLE `nhProgressNotesSubtasksActions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `progressNotesSubtaskId` int(11) NOT NULL,
  `actionType` varchar(10) NOT NULL,
  `mandatory` enum('y','n') NOT NULL,
  `daysToComplete` int(11) DEFAULT NULL,
  `hourToNotify` time DEFAULT NULL,
  `recommendations` text,
  `dueDate` date DEFAULT NULL,
  `dueTime` time DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ProgressNotesActions_ProgressNotesSubtasks` (`progressNotesSubtaskId`),
  CONSTRAINT `FK_ProgressNotesActions_ProgressNotesSubtasks` FOREIGN KEY (`progressNotesSubtaskId`) REFERENCES `nhProgressNotesSubtasks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhProgressNotesTaskActions`;
CREATE TABLE `nhProgressNotesTaskActions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `progressNotesTasksId` int(11) NOT NULL,
  `actionType` varchar(10) NOT NULL,
  `actionFrom` varchar(20) NOT NULL,
  `mandatory` enum('y','n') NOT NULL,
  `daysToComplete` int(11) DEFAULT NULL,
  `hourToNotify` time DEFAULT NULL,
  `recommendations` text,
  `chartSchedulePermission` enum('y','n') DEFAULT NULL COMMENT 'Enable user to edit schedule',
  `chartDirectivesPermission` enum('y','n') DEFAULT NULL COMMENT 'Enable user to change directive',
  PRIMARY KEY (`id`),
  KEY `FK_ProgressNotesTasksActions_ProgressNotesTasks` (`progressNotesTasksId`),
  CONSTRAINT `FK_ProgressNotesTasksActions_ProgressNotesTasks` FOREIGN KEY (`progressNotesTasksId`) REFERENCES `nhProgressNotesTasks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhProgressNotesTasks`;
CREATE TABLE `nhProgressNotesTasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL COMMENT 'Link with nhProgressNoteCategory',
  `reasonId` int(11) NOT NULL COMMENT 'Link with nhProgressNoteReason',
  `areaId` int(11) NOT NULL,
  `task` varchar(100) NOT NULL,
  `daysToComplete` int(11) DEFAULT NULL COMMENT 'Days to complete',
  `hourToNotify` time DEFAULT NULL COMMENT 'Hour to notify',
  PRIMARY KEY (`id`),
  KEY `FKCategory` (`categoryId`),
  KEY `FKReason` (`reasonId`),
  KEY `FK_ProgressNotesTasks_Company` (`companyId`),
  KEY `FK_ProgressNotesTasks_Location` (`locationId`),
  KEY `FK_ProgressNotesTasks_Area` (`areaId`),
  CONSTRAINT `FK_ProgressNotesTasks_Area` FOREIGN KEY (`areaId`) REFERENCES `area` (`id`),
  CONSTRAINT `FK_ProgressNotesTasks_Category` FOREIGN KEY (`categoryId`) REFERENCES `nhProgressNotesCategory` (`id`),
  CONSTRAINT `FK_ProgressNotesTasks_Company` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `FK_ProgressNotesTasks_Location` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_ProgressNotesTasks_Reason` FOREIGN KEY (`reasonId`) REFERENCES `nhProgressNotesReason` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhQuickNotes`;
CREATE TABLE `nhQuickNotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `note` text,
  `userId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhQuickNotesCategories`;
CREATE TABLE `nhQuickNotesCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nhQuickNotesCategories_company_index` (`company`),
  KEY `nhQuickNotesCategories_location_index` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhReviewDates`;
CREATE TABLE `nhReviewDates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `itemType` int(11) DEFAULT NULL,
  `itemId` int(11) DEFAULT NULL,
  `takenId` int(11) DEFAULT NULL,
  `reviewType` varchar(100) DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `completedDate` datetime DEFAULT NULL,
  `completedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhReviewItemTypes`;
CREATE TABLE `nhReviewItemTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhReviewReasons`;
CREATE TABLE `nhReviewReasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhSign`;
CREATE TABLE `nhSign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhs_medicine_list`;
CREATE TABLE `nhs_medicine_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `url` varchar(1000) NOT NULL,
  `info` longtext,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `nhTabletLogin`;
CREATE TABLE `nhTabletLogin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `areaId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `tabletName` varchar(100) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `activated` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `showMenu` int(11) DEFAULT '1',
  `say` varchar(300) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `locationId_showMenu` (`locationId`,`showMenu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `notificationsAdmin`;
CREATE TABLE `notificationsAdmin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `say` varchar(300) DEFAULT NULL,
  `permission` varchar(10) DEFAULT NULL,
  `areaSystem` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `notifications_PO`;
CREATE TABLE `notifications_PO` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `notification` varchar(500) DEFAULT NULL,
  `reasonForAccess` varchar(500) DEFAULT '1',
  `seen` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `old_holidayCalculations`;
CREATE TABLE `old_holidayCalculations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `holsSet` int(11) DEFAULT NULL,
  `fullDay` int(11) DEFAULT NULL,
  `holsDue` double DEFAULT NULL,
  `holsUsed` double DEFAULT NULL,
  `holsBooked` double DEFAULT NULL,
  `holsMonthEst` double DEFAULT NULL,
  `holsYearEst` double DEFAULT NULL,
  `holsLastYear` double DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `OLD_holidays`;
CREATE TABLE `OLD_holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `addedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `totalHours` float DEFAULT NULL,
  `eventType` int(2) DEFAULT NULL,
  `paid` int(2) DEFAULT NULL,
  `payRate` int(11) DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `othFunctions`;
CREATE TABLE `othFunctions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `callFunction` varchar(250) DEFAULT NULL,
  `example` varchar(250) DEFAULT NULL,
  `littleInfo` varchar(250) DEFAULT NULL,
  `location` varchar(250) DEFAULT NULL,
  `parameters` text,
  `resultFunction` text,
  `seq` int(11) DEFAULT '10',
  `link` varchar(550) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `outcome`;
CREATE TABLE `outcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `details` text,
  `originalOutcomeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `outcomeClientLink`;
CREATE TABLE `outcomeClientLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `outcomeId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `eventsAssigned` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `outcomeSectionPRSB`;
CREATE TABLE `outcomeSectionPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `needId` int(11) DEFAULT NULL,
  `outcome` text,
  `questionImgId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carePlanTakenId` (`carePlanTakenId`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`),
  KEY `needId` (`needId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `outcomeTaskLink`;
CREATE TABLE `outcomeTaskLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `outcomeId` int(11) DEFAULT NULL,
  `dailyTasksId` int(11) DEFAULT NULL,
  `medicationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `OverlapBlockshifts`;
CREATE TABLE `OverlapBlockshifts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `blockshiftId` int(11) NOT NULL,
  `timesheetId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `date` date NOT NULL,
  `deleted` date DEFAULT NULL,
  `deletedBy` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `package`;
CREATE TABLE `package` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `budget` decimal(15,5) DEFAULT NULL,
  `totalManagementFee` decimal(15,5) DEFAULT NULL,
  `previous` int(11) DEFAULT NULL,
  `budgetStartDate` datetime DEFAULT NULL,
  `budgetEndDate` datetime DEFAULT NULL,
  `partStatus` int(1) DEFAULT NULL,
  `grandfathered` int(1) DEFAULT NULL,
  `budgetCategory` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `packageBalanceHistory`;
CREATE TABLE `packageBalanceHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `budgetCategory` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `authorityBudgetId` varchar(50) DEFAULT NULL,
  `budgetTypeCode` varchar(10) DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `available` decimal(15,2) DEFAULT NULL,
  `used` decimal(15,2) DEFAULT NULL,
  `effectiveDate` date DEFAULT NULL,
  `claimDate` date DEFAULT NULL,
  `sourceFile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_client_cat` (`clientId`,`budgetCategory`,`effectiveDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `packageBreakdown`;
CREATE TABLE `packageBreakdown` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `total` decimal(15,5) DEFAULT NULL,
  `fee` int(1) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `optionSelect` varchar(50) DEFAULT NULL,
  `approvalLevel` int(1) DEFAULT NULL,
  `budgetCategory` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `packageFees`;
CREATE TABLE `packageFees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `effectiveFinish` date DEFAULT NULL,
  `cmDaily1` float DEFAULT NULL,
  `cmDaily2` float DEFAULT NULL,
  `cmDaily3` float DEFAULT NULL,
  `cmDaily4` float DEFAULT NULL,
  `pmDaily1` float DEFAULT NULL,
  `pmDaily2` float DEFAULT NULL,
  `pmDaily3` float DEFAULT NULL,
  `pmDaily4` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `packageOpeningBalance`;
CREATE TABLE `packageOpeningBalance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `commonwealthFunds` double DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `budgetCategory` int(11) DEFAULT NULL,
  `edlStart` datetime DEFAULT NULL,
  `edlEnd` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `packageSubsidies`;
CREATE TABLE `packageSubsidies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `effectiveFinish` date DEFAULT NULL,
  `hcpDaily1` float DEFAULT NULL,
  `hcpDaily2` float DEFAULT NULL,
  `hcpDaily3` float DEFAULT NULL,
  `hcpDaily4` float DEFAULT NULL,
  `dcvSupDaily1` float DEFAULT NULL,
  `dcvSupDaily2` float DEFAULT NULL,
  `dcvSupDaily3` float DEFAULT NULL,
  `dcvSupDaily4` float DEFAULT NULL,
  `oxSupDaily` float DEFAULT NULL,
  `efBolusSupDaily` float DEFAULT NULL,
  `efNonBolusSupDaily` float DEFAULT NULL,
  `eachdSupDaily` float DEFAULT NULL,
  `MMML123Daily` float DEFAULT NULL,
  `MMML4Daily` float DEFAULT NULL,
  `MMML5Daily` float DEFAULT NULL,
  `MMML6Daily` float DEFAULT NULL,
  `MMML7Daily` float DEFAULT NULL,
  `itcfCapDaily` float DEFAULT NULL,
  `bdcfDaily1` float DEFAULT NULL,
  `bdcfDaily2` float DEFAULT NULL,
  `bdcfDaily3` float DEFAULT NULL,
  `bdcfDaily4` float DEFAULT NULL,
  `sahL1` float DEFAULT NULL,
  `sahL2` float DEFAULT NULL,
  `sahL3` float DEFAULT NULL,
  `sahL4` float DEFAULT NULL,
  `sahL5` float DEFAULT NULL,
  `sahL6` float DEFAULT NULL,
  `sahL7` float DEFAULT NULL,
  `sahL8` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pageAccess`;
CREATE TABLE `pageAccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `page` varchar(150) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pagesInfo`;
CREATE TABLE `pagesInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` varchar(150) NOT NULL,
  `pageTitle` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `video1Link` varchar(200) NOT NULL,
  `video1Label` varchar(200) NOT NULL,
  `video2Link` varchar(200) NOT NULL,
  `video2Label` varchar(200) NOT NULL,
  `video3Link` varchar(200) NOT NULL,
  `video3Label` varchar(200) NOT NULL,
  `video4Link` varchar(200) NOT NULL,
  `video4Label` varchar(200) NOT NULL,
  `video5Link` varchar(200) NOT NULL,
  `video5Label` varchar(200) NOT NULL,
  `releaseNotes` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participationEvent`;
CREATE TABLE `participationEvent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `locationId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `participationId` int(11) NOT NULL,
  `note` text,
  `dateEvent` date DEFAULT NULL,
  `timeEvent` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participationEventFilePivot`;
CREATE TABLE `participationEventFilePivot` (
  `participationEventId` int(11) NOT NULL,
  `fileUploadId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participationEventThemePivot`;
CREATE TABLE `participationEventThemePivot` (
  `participationEventId` int(11) NOT NULL,
  `participationThemeId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participationKeyTbl`;
CREATE TABLE `participationKeyTbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `participationId` int(11) DEFAULT NULL,
  `keywordId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participationKeywords`;
CREATE TABLE `participationKeywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `keyword` varchar(100) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participationNames`;
CREATE TABLE `participationNames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `tes` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participationThemes`;
CREATE TABLE `participationThemes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `themeName` varchar(100) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participationThemeTbl`;
CREATE TABLE `participationThemeTbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `participationId` int(11) DEFAULT NULL,
  `themeId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `PASScarers`;
CREATE TABLE `PASScarers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `externalId` varchar(200) DEFAULT NULL,
  `passCarerId` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `PASSclients`;
CREATE TABLE `PASSclients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `externalId` varchar(200) DEFAULT NULL,
  `passClientId` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `PASSschedules`;
CREATE TABLE `PASSschedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `externalId` varchar(20) DEFAULT NULL,
  `dateEvent` date DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `timesheetBack` int(11) DEFAULT NULL,
  `passId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `passwordRequirements`;
CREATE TABLE `passwordRequirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `passwordLengthCarer` int(100) DEFAULT NULL,
  `lowerCaseCarer` int(11) DEFAULT NULL,
  `upperCaseCarer` int(11) DEFAULT NULL,
  `numberCarer` int(11) DEFAULT NULL,
  `carerExpiryLength` varchar(20) DEFAULT NULL,
  `passwordLengthAdmin` int(100) DEFAULT NULL,
  `lowerCaseAdmin` int(11) DEFAULT NULL,
  `upperCaseAdmin` int(11) DEFAULT NULL,
  `numberAdmin` int(11) DEFAULT NULL,
  `adminExpiryLength` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pastScheduleEvent`;
CREATE TABLE `pastScheduleEvent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `scheduleId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pausedScheduled`;
CREATE TABLE `pausedScheduled` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `eventStatus` varchar(20) DEFAULT NULL,
  `pausedDate` date DEFAULT NULL,
  `pausedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `jobType` varchar(10) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` int(11) DEFAULT NULL,
  `billingRate` int(11) DEFAULT NULL,
  `travelRate` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `reasonOff` varchar(50) DEFAULT NULL,
  `carerCovering` int(11) DEFAULT NULL,
  `taskId` int(11) DEFAULT NULL,
  `recurr` date DEFAULT NULL,
  `profileSide` int(1) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `payRollSettings`;
CREATE TABLE `payRollSettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `appStartView` date DEFAULT NULL,
  `appEndView` date DEFAULT NULL,
  `travelDeduction` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `payScaleUpdates`;
CREATE TABLE `payScaleUpdates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `pre_Scale` int(100) DEFAULT NULL,
  `driver` int(11) DEFAULT NULL,
  `weekEnd` int(11) DEFAULT NULL,
  `bankHol` int(11) DEFAULT NULL,
  `xmasDay` int(11) DEFAULT NULL,
  `boxingDay` int(11) DEFAULT NULL,
  `newYrs` int(11) DEFAULT NULL,
  `scale_Code` int(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deletedBy` (`deletedBy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionsName` varchar(50) NOT NULL,
  `landingPage` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionCategories`;
CREATE TABLE `permissionCategories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `systemDefault` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `permissionDefaultTemplate`;
CREATE TABLE `permissionDefaultTemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `templateId` int(11) DEFAULT NULL,
  `homeId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  `createdBy` timestamp NULL DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `deletedBy` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionList`;
CREATE TABLE `permissionList` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoryId` bigint(20) unsigned NOT NULL,
  `action` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actived` int(11) DEFAULT '1',
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `createdBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inputType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `deleted_at` (`deleted_at`),
  KEY `actived` (`actived`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `permissionLog`;
CREATE TABLE `permissionLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carerId` varchar(50) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `page` varchar(200) DEFAULT NULL,
  `found` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionRoleCarer`;
CREATE TABLE `permissionRoleCarer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `carerId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `codeRole` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Admin or App',
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `permissionRoles`;
CREATE TABLE `permissionRoles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permitionId` bigint(20) unsigned NOT NULL,
  `codeRole` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `permissionsCarer`;
CREATE TABLE `permissionsCarer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `value` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionsLocation`;
CREATE TABLE `permissionsLocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `areaId` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionsModules`;
CREATE TABLE `permissionsModules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `areaId` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionsRolesName`;
CREATE TABLE `permissionsRolesName` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `codeRole` varchar(250) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deletedBy` (`deletedBy`),
  CONSTRAINT `permissionsRolesName_ibfk_1` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `permissionsRolesName_ibfk_2` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`),
  CONSTRAINT `permissionsRolesName_ibfk_3` FOREIGN KEY (`deletedBy`) REFERENCES `deleted` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionsTemplate`;
CREATE TABLE `permissionsTemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionsTemplateCarer`;
CREATE TABLE `permissionsTemplateCarer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `templateId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissionsTemplates`;
CREATE TABLE `permissionsTemplates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `templateId` int(11) NOT NULL,
  `permissionId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `value` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `pic`;
CREATE TABLE `pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `image` longblob NOT NULL,
  `description` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pics`;
CREATE TABLE `pics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `userId` int(11) NOT NULL,
  `image` longblob NOT NULL,
  `details` varchar(100) NOT NULL,
  `picType` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `planCareParsings`;
CREATE TABLE `planCareParsings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateUpload` datetime DEFAULT NULL,
  `idClient` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fileUpload` varchar(500) DEFAULT NULL,
  `fileExtension` varchar(50) DEFAULT NULL,
  `jobId` varchar(500) DEFAULT NULL,
  `outputText` text,
  `status` varchar(20) DEFAULT NULL COMMENT 'new / parsing / parsed / completed',
  `dt_updated` datetime DEFAULT NULL,
  `id_userUpdate` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jobid` (`jobId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `planCareTasks`;
CREATE TABLE `planCareTasks` (
  `idPlanCareTask` int(11) NOT NULL AUTO_INCREMENT,
  `idTaskType` int(11) NOT NULL,
  `idPlanCare` int(11) DEFAULT NULL,
  `dtTask` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `taskDescription` longtext NOT NULL,
  `IdMedicine` int(11) DEFAULT NULL,
  `IdPosology1` int(11) DEFAULT NULL,
  `IdPosology2` int(11) DEFAULT NULL,
  `IdPosology3` int(11) DEFAULT NULL,
  `IdPosology4` int(11) DEFAULT NULL,
  `IdPosology5` int(11) DEFAULT NULL,
  `idGoal1` int(11) NOT NULL,
  `idGoal2` int(11) DEFAULT NULL,
  `idGoal3` int(11) DEFAULT NULL,
  `idGoal4` int(11) DEFAULT NULL,
  `idGoal5` int(11) DEFAULT NULL,
  `editedAt` datetime DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPlanCareTask`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `planCareTaskTypes`;
CREATE TABLE `planCareTaskTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskName` varchar(200) NOT NULL DEFAULT '0',
  `taksType` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `planCareVisitPeriods`;
CREATE TABLE `planCareVisitPeriods` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pediod` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `planTaskGoals`;
CREATE TABLE `planTaskGoals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskName` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `planTaskPosology`;
CREATE TABLE `planTaskPosology` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicineName` varchar(400) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `postJob`;
CREATE TABLE `postJob` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `closedBy` int(11) DEFAULT NULL,
  `eventId` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `overnight` int(11) DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eventId` (`eventId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `postJobOffers`;
CREATE TABLE `postJobOffers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `postJobId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `code` varchar(30) DEFAULT NULL,
  `linkfollowed` datetime DEFAULT NULL,
  `getJob` int(11) DEFAULT NULL,
  `jobSent` varchar(10) DEFAULT NULL,
  `jobDeclined` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `powerOfAttorney`;
CREATE TABLE `powerOfAttorney` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) NOT NULL,
  `powerOfAttorney` longtext NOT NULL,
  `actingStatus` varchar(250) NOT NULL,
  `restrictions` longtext NOT NULL,
  `details` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeBranchSplit`;
CREATE TABLE `ppeBranchSplit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `splitPercent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeBranchStock`;
CREATE TABLE `ppeBranchStock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `productId` varchar(200) DEFAULT NULL,
  `quantity` varchar(200) DEFAULT NULL,
  `lastDeliveryDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeCarerLog`;
CREATE TABLE `ppeCarerLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `reusable` int(11) DEFAULT NULL,
  `oldQty` int(11) DEFAULT NULL,
  `piecesUsed` int(11) DEFAULT NULL,
  `newQty` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `ppeCarerStockId` int(11) DEFAULT NULL,
  `pageName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeCarerStock`;
CREATE TABLE `ppeCarerStock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `alertLimit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeClientBalance`;
CREATE TABLE `ppeClientBalance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `ppeClientBranchBalanceId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `amount` (`amount`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeClientBranchBalance`;
CREATE TABLE `ppeClientBranchBalance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `productId` varchar(200) DEFAULT NULL,
  `transferDate` date DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `details` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `amount` (`amount`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeDeliveryHistory`;
CREATE TABLE `ppeDeliveryHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `ppeBranchStockId` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `deliveryDate` date DEFAULT NULL,
  `totalPieces` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeDistributionHistory`;
CREATE TABLE `ppeDistributionHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `piecesAdded` int(11) DEFAULT NULL,
  `totalPiecesCarer` int(11) DEFAULT NULL,
  `totalPiecesBranch` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeInventoryEdit`;
CREATE TABLE `ppeInventoryEdit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `ppeQty_Old` int(11) DEFAULT NULL,
  `ppeQty_New` int(11) DEFAULT NULL,
  `reason` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeProduct`;
CREATE TABLE `ppeProduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `productUniqueId` varchar(50) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `details` varchar(200) DEFAULT NULL,
  `reusable` int(11) DEFAULT NULL,
  `officeLowerLimit` int(11) DEFAULT NULL,
  `carerLowerLimit` int(11) DEFAULT NULL,
  `alertLimit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ppeTransferLog`;
CREATE TABLE `ppeTransferLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `fromBranchId` int(11) DEFAULT NULL,
  `toBranchId` int(11) DEFAULT NULL,
  `ppeProductId` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `transferDate` date DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `preferredCarers`;
CREATE TABLE `preferredCarers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `monthOne` int(11) DEFAULT NULL,
  `monthTwo` int(11) DEFAULT NULL,
  `monthThree` int(11) DEFAULT NULL,
  `lastEvent` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `prefixNumber`;
CREATE TABLE `prefixNumber` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `perfix` varchar(100) DEFAULT NULL,
  `companyName` varchar(200) DEFAULT NULL,
  `companyAddress1` varchar(200) DEFAULT NULL,
  `companyAddress2` varchar(200) DEFAULT NULL,
  `companyAddress3` varchar(200) DEFAULT NULL,
  `companyEmail` varchar(200) DEFAULT NULL,
  `companyPhone` varchar(200) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `areaId` (`areaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pricing`;
CREATE TABLE `pricing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `holidays` varchar(200) DEFAULT NULL,
  `day` varchar(200) DEFAULT NULL,
  `start` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `timesBy` float DEFAULT NULL,
  `called` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `printScreen`;
CREATE TABLE `printScreen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `info` varchar(100) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pushKey`;
CREATE TABLE `pushKey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `pushKey` varchar(400) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `pushNotificationLog`;
CREATE TABLE `pushNotificationLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `message` text,
  `failure` int(1) DEFAULT NULL,
  `error` varchar(200) DEFAULT NULL,
  `success` int(1) DEFAULT NULL,
  `page` varchar(200) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `qrClocking`;
CREATE TABLE `qrClocking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `qrcode` varchar(100) DEFAULT NULL,
  `qrcodeActive` varchar(100) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clockType` varchar(10) DEFAULT NULL,
  `alert` varchar(10) DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timesheetId` (`timesheetId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `qrGenerate`;
CREATE TABLE `qrGenerate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `dateCode` int(11) DEFAULT NULL,
  `qrCode` varchar(100) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `qualificationtypes`;
CREATE TABLE `qualificationtypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `questionnaireAnswers`;
CREATE TABLE `questionnaireAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionId` int(11) NOT NULL,
  `optionId` int(11) NOT NULL,
  `textOption` text COLLATE utf8mb4_unicode_ci,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `carerId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `questionnaireOptions`;
CREATE TABLE `questionnaireOptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionId` int(11) NOT NULL,
  `option` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `questionnaireQuestions`;
CREATE TABLE `questionnaireQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `questionnaireQuestionsCompany`;
CREATE TABLE `questionnaireQuestionsCompany` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `rcAreaHistory`;
CREATE TABLE `rcAreaHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `previousAreaId` int(11) DEFAULT NULL,
  `updatedAreaId` int(11) DEFAULT NULL,
  `effectiveStart` date DEFAULT NULL,
  `effectiveFinish` date DEFAULT '2060-01-01',
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `idx_locationId` (`locationId`),
  KEY `idx_companyId` (`companyId`),
  KEY `idx_carerId` (`carerId`),
  KEY `idx_clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcBed`;
CREATE TABLE `rcBed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `bedTypeId` int(11) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `occupancyStatus` int(11) DEFAULT NULL,
  `blockedFlag` tinyint(4) DEFAULT NULL,
  `blockedDetails` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`),
  KEY `roomId` (`roomId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcCareHome`;
CREATE TABLE `rcCareHome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `address2` varchar(200) DEFAULT NULL,
  `address3` varchar(200) DEFAULT NULL,
  `address4` varchar(200) DEFAULT NULL,
  `postcode` varchar(200) DEFAULT NULL,
  `contactNo` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `legalName` varchar(200) DEFAULT NULL,
  `CQC_regNo` int(11) DEFAULT NULL,
  `bankDetails` varchar(200) DEFAULT NULL,
  `managerId` int(11) DEFAULT NULL,
  `deputyManagerId` int(11) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `geoRange` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`),
  KEY `areaId` (`areaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcClientSchedule`;
CREATE TABLE `rcClientSchedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `wardId` int(11) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  `bedId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `finishDate` date DEFAULT NULL,
  `jobTypeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcLog`;
CREATE TABLE `rcLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `page` varchar(500) DEFAULT NULL,
  `notification` varchar(500) DEFAULT NULL,
  `tableName` varchar(200) DEFAULT NULL,
  `tableId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `sql_` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcRequestedHours`;
CREATE TABLE `rcRequestedHours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `eventId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `comment` text,
  `actionOn` datetime DEFAULT NULL,
  `actionBy` int(11) DEFAULT NULL,
  `actionComment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `areaId` (`areaId`),
  KEY `eventId` (`eventId`),
  KEY `carerId` (`carerId`),
  KEY `deleted` (`deleted`),
  KEY `statusId` (`statusId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcRoles`;
CREATE TABLE `rcRoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `wingId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `roleType` int(11) DEFAULT NULL,
  `orderBy` int(11) DEFAULT NULL,
  `associateJobtype` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `deleted` (`deleted`),
  KEY `areaId` (`areaId`),
  KEY `roleType` (`roleType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcRoom`;
CREATE TABLE `rcRoom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `wingId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `bedCap` int(11) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `orderBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `wingId` (`wingId`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcShift`;
CREATE TABLE `rcShift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `finishTime` time DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `jobTypeId` int(11) DEFAULT NULL,
  `colour` varchar(200) DEFAULT NULL,
  `dayRange` varchar(500) DEFAULT NULL,
  `occurance` int(11) DEFAULT NULL,
  `tea` int(11) DEFAULT NULL,
  `teaPay` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `areaId` (`areaId`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcShiftSchedule`;
CREATE TABLE `rcShiftSchedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `wingId` int(11) DEFAULT NULL,
  `rosterId` int(11) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `roleType` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `shiftId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `finishTime` time DEFAULT NULL,
  `careDependencyRating` double DEFAULT NULL,
  `nonCareFlag` int(11) DEFAULT NULL,
  `upskillReasonId` int(11) DEFAULT NULL,
  `timesheetFlag` int(11) DEFAULT NULL,
  `tea` int(11) DEFAULT NULL,
  `teaPay` int(11) DEFAULT NULL,
  `outsideHome` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `areaId` (`areaId`),
  KEY `carerId` (`carerId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `roleType` (`roleType`),
  KEY `wingId` (`wingId`),
  KEY `deleted` (`deleted`),
  KEY `shiftId` (`shiftId`),
  KEY `roleId` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcShiftScheduleDeleted`;
CREATE TABLE `rcShiftScheduleDeleted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcShiftScheduleId` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `wingId` int(11) DEFAULT NULL,
  `rosterId` int(11) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `roleType` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `shiftId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `finishTime` time DEFAULT NULL,
  `careDependencyRating` double DEFAULT NULL,
  `nonCareFlag` int(11) DEFAULT NULL,
  `upskillReasonId` int(11) DEFAULT NULL,
  `timesheetFlag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `carerId` (`carerId`),
  KEY `areaId` (`areaId`),
  KEY `rosterId` (`rosterId`),
  KEY `groupId` (`groupId`),
  KEY `shiftId` (`shiftId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcUpskillReason`;
CREATE TABLE `rcUpskillReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rcWing`;
CREATE TABLE `rcWing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `areaId` (`areaId`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reasonCancel`;
CREATE TABLE `reasonCancel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `branchId` int(11) DEFAULT NULL,
  `clientBilling` int(1) DEFAULT NULL,
  `carerPay` int(1) DEFAULT NULL,
  `cancelCode` varchar(200) DEFAULT NULL,
  `defaultSelected` int(1) DEFAULT NULL,
  `percentagePay` double DEFAULT NULL,
  `percentageBill` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `branchId` (`branchId`),
  KEY `deleted` (`deleted`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recordSchedule`;
CREATE TABLE `recordSchedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `oldCarerId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `oldRecurrId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `details` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deleted` (`deleted`),
  KEY `oldRecurrId` (`oldRecurrId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurModified`;
CREATE TABLE `recurModified` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modified` datetime NOT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `modifiedId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `jobType` varchar(10) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `shiftId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deletedId` (`modifiedId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurr`;
CREATE TABLE `recurr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `published` datetime DEFAULT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `recurrTypeId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `lateLogginIn` date DEFAULT NULL,
  `keepRecur` int(2) DEFAULT NULL,
  `firstEvent` date DEFAULT NULL,
  `lastEvent` date DEFAULT NULL,
  `numEvents` int(11) DEFAULT NULL,
  `hasTimesheets` int(11) DEFAULT NULL,
  `recurrStateId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT '1',
  `commentId` int(11) DEFAULT NULL,
  `taskId` int(11) DEFAULT NULL,
  `paid` int(11) DEFAULT NULL,
  `recurr` date DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `offBankHolidays` int(1) DEFAULT '0',
  `checked` date DEFAULT NULL,
  `shiftId` int(11) DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  `tea` int(11) DEFAULT NULL,
  `teaPay` int(11) DEFAULT NULL,
  `blockShift` int(11) DEFAULT NULL,
  `timeFreeze` int(11) DEFAULT NULL,
  `flagId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `dateStart` (`dateStart`),
  KEY `dateFinish` (`dateFinish`),
  KEY `timeStart` (`timeStart`),
  KEY `locationId_dateStart` (`locationId`,`dateStart`),
  KEY `locationId_dateFinish` (`locationId`,`dateFinish`),
  KEY `recurr_search` (`locationId`,`clientId`,`deleted`),
  KEY `recurr_idx_locat_confi_delet_statu_clien_carer` (`locationId`,`confirmSch`,`deleted`,`statusId`,`clientId`,`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrBufferOff`;
CREATE TABLE `recurrBufferOff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `valueOn` int(1) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_locationId` (`locationId`),
  KEY `idx_companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrCancel`;
CREATE TABLE `recurrCancel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `reasonCancelId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `oldReason` int(11) DEFAULT NULL,
  `timesheetPay` int(11) DEFAULT NULL,
  `timesheetBill` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `recurrId` (`recurrId`),
  KEY `reasonCancelId` (`reasonCancelId`),
  KEY `clientId` (`clientId`),
  KEY `deleted` (`deleted`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrDeleted`;
CREATE TABLE `recurrDeleted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` datetime NOT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedId` int(11) DEFAULT NULL,
  `deletedDate` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `jobType` varchar(10) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deletedId` (`deletedId`),
  KEY `location_id` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrDeletedBackup`;
CREATE TABLE `recurrDeletedBackup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recurrId` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `published` datetime DEFAULT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `recurrTypeId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `lateLogginIn` date DEFAULT NULL,
  `keepRecur` int(2) DEFAULT NULL,
  `firstEvent` date DEFAULT NULL,
  `lastEvent` date DEFAULT NULL,
  `numEvents` int(11) DEFAULT NULL,
  `hasTimesheets` int(11) DEFAULT NULL,
  `recurrStateId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT '1',
  `commentId` int(11) DEFAULT NULL,
  `taskId` int(11) DEFAULT NULL,
  `recurr` date DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrExtend`;
CREATE TABLE `recurrExtend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `oldEnd` date DEFAULT NULL,
  `newEndTime` date DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `schedule_end` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrJobtypeChange`;
CREATE TABLE `recurrJobtypeChange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `oldRecurrId` int(11) DEFAULT NULL,
  `oldJobType` int(11) DEFAULT NULL,
  `newRecurrId` int(11) DEFAULT NULL,
  `newJobType` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrNotifications`;
CREATE TABLE `recurrNotifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recurrNum` int(11) DEFAULT NULL,
  `parentNum` int(11) DEFAULT NULL,
  `page` varchar(50) DEFAULT NULL,
  `side` varchar(10) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `notifications` varchar(200) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `published` datetime DEFAULT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `recurrStateId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT '1',
  `commentId` int(11) DEFAULT NULL,
  `taskId` int(11) DEFAULT NULL,
  `paid` int(11) DEFAULT NULL,
  `recurr` date DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `offBankHolidays` int(1) DEFAULT '0',
  `checked` date DEFAULT NULL,
  `shiftId` int(11) DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  `tea` int(11) DEFAULT NULL,
  `teaPay` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `dateStart` (`dateStart`),
  KEY `dateFinish` (`dateFinish`),
  KEY `timeStart` (`timeStart`),
  KEY `locationId_dateStart` (`locationId`,`dateStart`),
  KEY `locationId_dateFinish` (`locationId`,`dateFinish`),
  KEY `recurrNum` (`recurrNum`),
  KEY `parentNum` (`parentNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrRemoved`;
CREATE TABLE `recurrRemoved` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` datetime NOT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `deletedId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `wasRecurr` int(11) DEFAULT NULL,
  `reason` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deletedId` (`deletedId`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrScheduleHistory`;
CREATE TABLE `recurrScheduleHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `recurrIdDeleted` int(11) DEFAULT NULL,
  `published` datetime DEFAULT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `recurrTypeId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `days2` varchar(100) DEFAULT NULL,
  `week` varchar(10) DEFAULT NULL,
  `tasks` text,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `confirmSch` varchar(10) DEFAULT NULL,
  `dateNoShow` text NOT NULL COMMENT 'Dont Set To Null',
  `payRate` varchar(10) DEFAULT NULL,
  `billingRate` varchar(10) DEFAULT NULL,
  `travelRate` varchar(10) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `lateLogginIn` date DEFAULT NULL,
  `keepRecur` int(2) DEFAULT NULL,
  `firstEvent` date DEFAULT NULL,
  `lastEvent` date DEFAULT NULL,
  `numEvents` int(11) DEFAULT NULL,
  `hasTimesheets` int(11) DEFAULT NULL,
  `recurrStateId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT '1',
  `commentId` int(11) DEFAULT NULL,
  `taskId` int(11) DEFAULT NULL,
  `paid` int(11) DEFAULT NULL,
  `recurr` date DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `offBankHolidays` int(1) DEFAULT '0',
  `checked` date DEFAULT NULL,
  `shiftId` int(11) DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  `comment` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`),
  KEY `dateStart` (`dateStart`),
  KEY `dateFinish` (`dateFinish`),
  KEY `timeStart` (`timeStart`),
  KEY `locationId_dateStart` (`locationId`,`dateStart`),
  KEY `locationId_dateFinish` (`locationId`,`dateFinish`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrState`;
CREATE TABLE `recurrState` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrType`;
CREATE TABLE `recurrType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `recurrWeekCode`;
CREATE TABLE `recurrWeekCode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `referralBy`;
CREATE TABLE `referralBy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `referralByName` varchar(300) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `referralReason`;
CREATE TABLE `referralReason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `rememberMe_tokens`;
CREATE TABLE `rememberMe_tokens` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `selector` mediumtext NOT NULL,
  `validator` mediumtext NOT NULL,
  `expiresAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reportsBackground`;
CREATE TABLE `reportsBackground` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` varchar(250) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `deleted` varchar(250) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `reportType` varchar(250) NOT NULL,
  `status` int(11) NOT NULL,
  `input` longtext,
  `link` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reportsBackgroundSeen`;
CREATE TABLE `reportsBackgroundSeen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reportId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) NOT NULL,
  `seen` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `requiredActions`;
CREATE TABLE `requiredActions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `side` varchar(6) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `LocationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `side` (`side`),
  KEY `companyId` (`companyId`),
  KEY `LocationId` (`LocationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `requiredActionsComment`;
CREATE TABLE `requiredActionsComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `side` varchar(6) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `comment` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `requiredActionsPick`;
CREATE TABLE `requiredActionsPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `requiredActionsId` int(11) DEFAULT NULL,
  `side` varchar(6) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `done` varchar(20) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `actionDate` date DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `done` (`done`),
  KEY `deleted` (`deleted`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `respiteBookingRequest`;
CREATE TABLE `respiteBookingRequest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `startDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `clientId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `comments` varchar(100) NOT NULL,
  `seen` date DEFAULT NULL,
  `seenBy` int(11) DEFAULT NULL,
  `verdict` tinyint(4) DEFAULT NULL,
  `response` varchar(100) DEFAULT NULL,
  `pageLoadedAfterSeen` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reviewReasonsPRSB`;
CREATE TABLE `reviewReasonsPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `riskAssessmentPRSB`;
CREATE TABLE `riskAssessmentPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `peopleAtRisk` text,
  `likelihoodPreRisk` int(11) DEFAULT NULL,
  `severityPreRisk` int(11) DEFAULT NULL,
  `preRiskScore` varchar(100) DEFAULT NULL,
  `riskManagement` text,
  `likelihoodPostRisk` int(11) DEFAULT NULL,
  `severityPostRisk` int(11) DEFAULT NULL,
  `postRiskScore` varchar(100) DEFAULT NULL,
  `raRevDate` date DEFAULT NULL,
  `originalId` int(11) DEFAULT NULL,
  `signedOff` timestamp NULL DEFAULT NULL,
  `signedOffBy` int(11) DEFAULT NULL,
  `signOffId` int(11) DEFAULT NULL,
  `archived` int(11) DEFAULT NULL,
  `questionImgId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carePlanTakenId` (`carePlanTakenId`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `riskCategoriesPRSB`;
CREATE TABLE `riskCategoriesPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `name` varchar(100) CHARACTER SET eucjpms DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `saveTravelFullTimes`;
CREATE TABLE `saveTravelFullTimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `travel` double DEFAULT NULL,
  `expensive` double DEFAULT NULL,
  `pay` double DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `scheduledGroupReportTemp`;
CREATE TABLE `scheduledGroupReportTemp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `companyId` int(10) DEFAULT NULL,
  `locationId` int(10) DEFAULT NULL,
  `clientId` int(10) DEFAULT NULL,
  `nameClient` varchar(110) DEFAULT NULL,
  `nameCarer` varchar(110) DEFAULT NULL,
  `carerId` int(10) DEFAULT NULL,
  `dataRecurr` date DEFAULT NULL,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `hours` time DEFAULT NULL,
  `jobType` int(10) DEFAULT NULL,
  `overNight` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `durationDecimal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `scheduleFlags`;
CREATE TABLE `scheduleFlags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `side` varchar(200) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  CONSTRAINT `scheduleFlags_ibfk_1` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`),
  CONSTRAINT `scheduleFlags_ibfk_2` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `scheduleFlagsEvents`;
CREATE TABLE `scheduleFlagsEvents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recurrId` int(11) NOT NULL,
  `flagId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recurrId` (`recurrId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `screening`;
CREATE TABLE `screening` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `allergies` text,
  `history` text,
  `alerts` text,
  `staffKeyHolder` varchar(3) DEFAULT NULL,
  `panicAlarm` varchar(3) DEFAULT NULL,
  `bleedingRisk` varchar(3) DEFAULT NULL,
  `fallRisk` varchar(3) DEFAULT NULL,
  `infection` varchar(3) DEFAULT NULL,
  `daysOfCare` text,
  `mondayCare` text,
  `tuesdayCare` text,
  `wednesdayCare` text,
  `thursdayCare` text,
  `fridayCare` text,
  `saturdayCare` text,
  `sundayCare` text,
  `adl` varchar(3) DEFAULT NULL,
  `ironing` varchar(3) DEFAULT NULL,
  `shopping` varchar(3) DEFAULT NULL,
  `companionship` varchar(3) DEFAULT NULL,
  `palliativeCare` varchar(3) DEFAULT NULL,
  `fire` varchar(3) DEFAULT NULL,
  `mealsPreparation` varchar(3) DEFAULT NULL,
  `deliveryMeals` varchar(3) DEFAULT NULL,
  `collectionMedication` varchar(3) DEFAULT NULL,
  `walking` varchar(3) DEFAULT NULL,
  `hoistTransfer` varchar(3) DEFAULT NULL,
  `promptMedications` varchar(3) DEFAULT NULL,
  `cleaning` varchar(3) DEFAULT NULL,
  `accompanyClient` varchar(3) DEFAULT NULL,
  `duties` varchar(400) DEFAULT NULL,
  `admissionDetailsOfCare` text,
  `religion` varchar(100) DEFAULT NULL,
  `culture` varchar(100) DEFAULT NULL,
  `speak_english` varchar(100) DEFAULT NULL,
  `firstLanguage` varchar(100) DEFAULT NULL,
  `discussClientHospital` varchar(3) DEFAULT NULL,
  `discussClientGp` varchar(3) DEFAULT NULL,
  `discussClientPHN` varchar(3) DEFAULT NULL,
  `discussClientHSC` varchar(3) DEFAULT NULL,
  `consentSigned` varchar(3) DEFAULT NULL,
  `consentSignedBy` varchar(15) DEFAULT NULL,
  `consentSignedByRelationship` varchar(60) DEFAULT NULL,
  `nokVerifiedHospital` varchar(3) DEFAULT NULL,
  `nokVerifiedGP` varchar(3) DEFAULT NULL,
  `nokVerifiedPHN` varchar(3) DEFAULT NULL,
  `nokVerifiedHSC` varchar(3) DEFAULT NULL,
  `infoGivenNOK` varchar(10) DEFAULT NULL,
  `infoNOKSpecify` varchar(250) DEFAULT NULL,
  `infoGivenCOE` varchar(10) DEFAULT NULL,
  `infoGivenCOESpecify` varchar(250) DEFAULT NULL,
  `infoGivenCOEComments` varchar(250) DEFAULT NULL,
  `comRequired` varchar(3) DEFAULT NULL,
  `comVisual` varchar(3) DEFAULT NULL,
  `comHearing` varchar(3) DEFAULT NULL,
  `comCogitative` varchar(3) DEFAULT NULL,
  `comAids` varchar(250) DEFAULT NULL,
  `interpreter` varchar(3) DEFAULT NULL,
  `bungalow` varchar(3) DEFAULT NULL,
  `twoStory` varchar(3) DEFAULT NULL,
  `flat` varchar(3) DEFAULT NULL,
  `frontSmooth` varchar(3) DEFAULT NULL,
  `frontSteps` varchar(3) DEFAULT NULL,
  `frontLift` varchar(3) DEFAULT NULL,
  `frontComments` varchar(250) DEFAULT NULL,
  `accessBed` varchar(3) DEFAULT NULL,
  `accessBedDetails` varchar(250) DEFAULT NULL,
  `accessBath` varchar(3) DEFAULT NULL,
  `accessBathDetails` varchar(250) DEFAULT NULL,
  `accessToilet` varchar(3) DEFAULT NULL,
  `fullTimeCare` varchar(3) DEFAULT NULL,
  `homeHelp` varchar(3) DEFAULT NULL,
  `familyAssistance` varchar(250) DEFAULT NULL,
  `stepsInHome` varchar(3) DEFAULT NULL,
  `livingAlone` varchar(3) DEFAULT NULL,
  `clientHome` text,
  `accessPhone` varchar(3) DEFAULT NULL,
  `accessPhoneDetails` varchar(250) DEFAULT NULL,
  `accessToiletDetails` varchar(250) DEFAULT NULL,
  `answerDoor` varchar(3) DEFAULT NULL,
  `answerPhone` varchar(3) DEFAULT NULL,
  `useStairs` varchar(3) DEFAULT NULL,
  `grabRail` varchar(3) DEFAULT NULL,
  `healthCentreName` varchar(250) DEFAULT NULL,
  `healthCentreAddress` varchar(250) DEFAULT NULL,
  `healthCentreTown` varchar(100) DEFAULT NULL,
  `healthCentreCounty` varchar(100) DEFAULT NULL,
  `healthCentrePostCode` varchar(50) DEFAULT NULL,
  `healthCentrePhone` varchar(50) DEFAULT NULL,
  `otherAgencies` text,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `screeningTable`;
CREATE TABLE `screeningTable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `consentKey` int(11) DEFAULT NULL,
  `consentShopping` int(11) DEFAULT NULL,
  `consentFinance` int(11) DEFAULT NULL,
  `nonEnglish` int(11) DEFAULT NULL,
  `shower` int(11) DEFAULT NULL,
  `bedBath` int(11) DEFAULT NULL,
  `painPatch` int(11) DEFAULT NULL,
  `promptingMedication` int(11) DEFAULT NULL,
  `requiredPromptMed` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `screening_status`;
CREATE TABLE `screening_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientName` varchar(100) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `comments` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `screening_three`;
CREATE TABLE `screening_three` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `oxygen` varchar(3) DEFAULT NULL,
  `smoking` varchar(3) DEFAULT NULL,
  `animals` varchar(3) DEFAULT NULL,
  `animalsSpecify` varchar(250) DEFAULT NULL,
  `childrenInHome` varchar(3) DEFAULT NULL,
  `childrenInHomeDetails` varchar(250) DEFAULT NULL,
  `vulnerablePerson` varchar(3) DEFAULT NULL,
  `vulnerablePersonDetails` varchar(250) DEFAULT NULL,
  `vulnerablePolicy` varchar(3) DEFAULT NULL,
  `childrenGuidelines` varchar(3) DEFAULT NULL,
  `childrenGuidelinesDetails` varchar(250) DEFAULT NULL,
  `policies` varchar(3) DEFAULT NULL,
  `policiesDetails` varchar(250) DEFAULT NULL,
  `sideRails` varchar(3) DEFAULT NULL,
  `sideRailsDetails` varchar(250) DEFAULT NULL,
  `bedService` varchar(50) DEFAULT NULL,
  `bedNextService` varchar(20) DEFAULT NULL,
  `careHealthAndSafety` text,
  `consentCompleted` varchar(3) DEFAULT NULL,
  `emergencyContact` varchar(3) DEFAULT NULL,
  `detailsSupervisor` varchar(3) DEFAULT NULL,
  `clientGuide` varchar(3) DEFAULT NULL,
  `surveyLeft` varchar(3) DEFAULT NULL,
  `abusePrevention` varchar(3) DEFAULT NULL,
  `complaintManagement` varchar(3) DEFAULT NULL,
  `finances` varchar(3) DEFAULT NULL,
  `emergencies` varchar(3) DEFAULT NULL,
  `endofLifeCare` varchar(3) DEFAULT NULL,
  `consent` varchar(3) DEFAULT NULL,
  `keyHolders` varchar(3) DEFAULT NULL,
  `hospitalTransfer` varchar(3) DEFAULT NULL,
  `additionalNeeds` varchar(250) DEFAULT NULL,
  `careDocumentation` text,
  `consentFormSigned` varchar(3) DEFAULT NULL,
  `keysHeldBy` text,
  `careKeys` text,
  `shoppingConsent` varchar(3) DEFAULT NULL,
  `nonEnglishSpeaking` varchar(3) DEFAULT NULL,
  `hsePrivateSupport` varchar(3) DEFAULT NULL,
  `otherSupports` varchar(3) DEFAULT NULL,
  `referralSource` varchar(4) DEFAULT NULL,
  `shower` varchar(3) DEFAULT NULL,
  `bedBath` varchar(3) DEFAULT NULL,
  `aidsHoist` varchar(3) DEFAULT NULL,
  `hoist` varchar(3) DEFAULT NULL,
  `hoistDetails` varchar(200) DEFAULT NULL,
  `standService` varchar(20) DEFAULT NULL,
  `standNextService` varchar(20) DEFAULT NULL,
  `hotWater` varchar(3) DEFAULT NULL,
  `exercise` varchar(3) DEFAULT NULL,
  `reportChange` varchar(3) DEFAULT NULL,
  `noCareNeeded` varchar(3) DEFAULT NULL,
  `inHospital` varchar(3) DEFAULT NULL,
  `cutNails` varchar(3) DEFAULT NULL,
  `keyHoldingPolicy` varchar(3) DEFAULT NULL,
  `insurance` varchar(3) DEFAULT NULL,
  `carPolicy` varchar(3) DEFAULT NULL,
  `timesheets` varchar(3) DEFAULT NULL,
  `heatingPads` varchar(3) DEFAULT NULL,
  `infoPainPatch` varchar(3) DEFAULT NULL,
  `knownAs` varchar(30) DEFAULT NULL,
  `currentAddress1` varchar(250) DEFAULT NULL,
  `currentTown` varchar(250) DEFAULT NULL,
  `postCode` varchar(10) DEFAULT NULL,
  `currentCounty` varchar(60) DEFAULT NULL,
  `phoneHome` varchar(30) DEFAULT NULL,
  `phoneMobile` varchar(30) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `maritalStatus` varchar(20) DEFAULT NULL,
  `aidsCane` varchar(3) DEFAULT NULL,
  `aidsZimmer` varchar(3) DEFAULT NULL,
  `aidsCrutches` varchar(3) DEFAULT NULL,
  `aidsTripod` varchar(3) DEFAULT NULL,
  `speech` varchar(12) DEFAULT NULL,
  `aidsGrabber` varchar(3) DEFAULT NULL,
  `denturesNone` varchar(3) DEFAULT NULL,
  `aidsOther` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `denturesUpper` varchar(3) DEFAULT NULL,
  `denturesLower` varchar(3) DEFAULT NULL,
  `sight` varchar(20) DEFAULT NULL,
  `hearing` varchar(20) DEFAULT NULL,
  `hearingAid` varchar(20) DEFAULT NULL,
  `denturesPartial` varchar(3) DEFAULT NULL,
  `likes` text,
  `glasses` varchar(20) DEFAULT NULL,
  `aidsWheelchair` varchar(3) DEFAULT NULL,
  `completedBy` varchar(200) DEFAULT NULL,
  `dateSigned` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deleted` (`deleted`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `screening_two`;
CREATE TABLE `screening_two` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `painScore` varchar(10) DEFAULT NULL,
  `painSeverity` varchar(15) DEFAULT NULL,
  `painSite` varchar(250) DEFAULT NULL,
  `painLong` varchar(250) DEFAULT NULL,
  `painCare` text,
  `cardiacHistory` varchar(3) DEFAULT NULL,
  `cardiacDetails` varchar(250) DEFAULT NULL,
  `paceMaker` varchar(3) DEFAULT NULL,
  `paceMakerDetails` varchar(250) DEFAULT NULL,
  `cardiacCare` text,
  `urinarySystem` varchar(10) DEFAULT NULL,
  `catheter` varchar(3) DEFAULT NULL,
  `incontinence` varchar(3) DEFAULT NULL,
  `reordering` varchar(250) DEFAULT NULL,
  `clientPreference` varchar(250) DEFAULT NULL,
  `bowelPattern` varchar(10) DEFAULT NULL,
  `frequencyBowel` varchar(250) DEFAULT NULL,
  `constipation` varchar(3) DEFAULT NULL,
  `laxative` varchar(3) DEFAULT NULL,
  `careUrinary` text,
  `careBowel` text,
  `familyAssist` varchar(3) DEFAULT NULL,
  `familyAssistDetails` varchar(250) DEFAULT NULL,
  `questionnaire` varchar(3) DEFAULT NULL,
  `weightBearing` varchar(3) DEFAULT NULL,
  `bedMobility` varchar(10) DEFAULT NULL,
  `transfers` varchar(10) DEFAULT NULL,
  `walking` varchar(10) DEFAULT NULL,
  `careMobility` text,
  `wheelchairService` varchar(20) DEFAULT NULL,
  `wheelchairNextService` varchar(20) DEFAULT NULL,
  `hoistService` varchar(20) DEFAULT NULL,
  `hoistNextService` varchar(20) DEFAULT NULL,
  `MSRAStatus` varchar(10) DEFAULT NULL,
  `MSRAStatusDate` varchar(20) DEFAULT NULL,
  `infectionHistory` text,
  `careInfections` text,
  `signLanguage` varchar(3) DEFAULT NULL,
  `communicationAids` varchar(250) DEFAULT NULL,
  `careCommunication` text,
  `hobbiesDetails` text,
  `mealPrepare` varchar(10) DEFAULT NULL,
  `mealsOnWheels` varchar(3) DEFAULT NULL,
  `mealsWeekend` text,
  `homeHelpMeals` varchar(3) DEFAULT NULL,
  `modifiedDiet` varchar(3) DEFAULT NULL,
  `modifiedDietDetails` text,
  `salt` varchar(3) DEFAULT NULL,
  `saltDetails` text,
  `thickEasy` varchar(3) DEFAULT NULL,
  `thickEasyDetails` text,
  `enteralFeeding` varchar(3) DEFAULT NULL,
  `mealBreakfast` varchar(60) DEFAULT NULL,
  `mealLunch` varchar(60) DEFAULT NULL,
  `mealDinner` varchar(60) DEFAULT NULL,
  `foodPreferences` text,
  `drinkPreferences` text,
  `takeMedication` varchar(3) DEFAULT NULL,
  `familyMedication` varchar(3) DEFAULT NULL,
  `promptMedication` varchar(3) DEFAULT NULL,
  `giveMedication` varchar(3) DEFAULT NULL,
  `diabetic` varchar(3) DEFAULT NULL,
  `diabeticType` varchar(3) DEFAULT NULL,
  `diabeticNurse` varchar(3) DEFAULT NULL,
  `diabeticNurseName` varchar(250) DEFAULT NULL,
  `bloodThinner` varchar(3) DEFAULT NULL,
  `bloodThinnerName` varchar(250) DEFAULT NULL,
  `localPharmacy` varchar(250) DEFAULT NULL,
  `medicationBreakfast` varchar(250) DEFAULT NULL,
  `medicationLunch` varchar(250) DEFAULT NULL,
  `medicationDinner` varchar(250) DEFAULT NULL,
  `timeMedication` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` longtext NOT NULL,
  `last_activity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `businessName` varchar(50) NOT NULL,
  `adminTelephone` varchar(20) NOT NULL,
  `adminEmail` varchar(30) NOT NULL,
  `serverURL` varchar(200) DEFAULT NULL,
  `recurrEndDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `sharedBookmarks`;
CREATE TABLE `sharedBookmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folderId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `SickEventType`;
CREATE TABLE `SickEventType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `signOffGeneral`;
CREATE TABLE `signOffGeneral` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataURL` longtext,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `signOffNames`;
CREATE TABLE `signOffNames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `side` varchar(150) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `signOffSettings`;
CREATE TABLE `signOffSettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` varchar(100) DEFAULT NULL,
  `footer` varchar(600) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `SMS`;
CREATE TABLE `SMS` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `details` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `SMSLog`;
CREATE TABLE `SMSLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `smsId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `sentBy` int(11) DEFAULT NULL,
  `personTypeTo` varchar(5) DEFAULT NULL,
  `sentTo` int(11) DEFAULT NULL,
  `sentToDetails` varchar(200) DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL,
  `messageType` varchar(10) DEFAULT NULL,
  `eventId` int(11) DEFAULT NULL,
  `code` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `SMSLogSent`;
CREATE TABLE `SMSLogSent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `sentBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `smsId` int(11) DEFAULT NULL,
  `phoneNumber` varchar(100) DEFAULT NULL,
  `sms` varchar(200) DEFAULT NULL,
  `smsType` varchar(50) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `smsTags`;
CREATE TABLE `smsTags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `tag` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `smsTemplatesSaved`;
CREATE TABLE `smsTemplatesSaved` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `sms` text,
  `tags` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `sortPreferred`;
CREATE TABLE `sortPreferred` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `distance` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `sqlLog`;
CREATE TABLE `sqlLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `page` varchar(200) DEFAULT NULL,
  `sqlRequest` varchar(1000) DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `sso_configurations`;
CREATE TABLE `sso_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` varchar(4) DEFAULT NULL,
  `tenantId` varchar(100) DEFAULT NULL,
  `clientId` varchar(100) DEFAULT NULL,
  `clientSecret` varchar(200) DEFAULT NULL,
  `slug` varchar(250) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `logo` varchar(250) DEFAULT NULL,
  `emails_enabled` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `stageGoalSectionPRSB`;
CREATE TABLE `stageGoalSectionPRSB` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carePlanTakenId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `actionsId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `comments` text,
  `outcome` text,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `staticEvents`;
CREATE TABLE `staticEvents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recurrId` int(11) DEFAULT NULL,
  `recurrDate` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recurrId` (`recurrId`),
  KEY `recurrDate` (`recurrDate`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `staticInfo`;
CREATE TABLE `staticInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientActiveNo` int(11) DEFAULT NULL,
  `carerActiveNo` int(11) DEFAULT NULL,
  `adminActiveNo` int(11) DEFAULT NULL,
  `eventsTodayNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `type` varchar(60) DEFAULT NULL,
  `colour` varchar(40) DEFAULT NULL,
  `side` varchar(40) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `statusLeave` int(11) DEFAULT NULL,
  `returnDate` varchar(30) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `alert` varchar(100) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `statusChangeEventsRemoved`;
CREATE TABLE `statusChangeEventsRemoved` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  `changeType` varchar(20) DEFAULT NULL,
  `futureStatusId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `recurrDate` date DEFAULT NULL,
  `recurrTimeStart` time DEFAULT NULL,
  `recurrTimeFinish` time DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `eventMinutes` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recurrDate` (`recurrDate`),
  KEY `locationId` (`locationId`),
  KEY `clientId` (`clientId`),
  KEY `eventMinutes` (`eventMinutes`),
  KEY `recurrId` (`recurrId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `statusChangeEventsRemovedCarer`;
CREATE TABLE `statusChangeEventsRemovedCarer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `edited` datetime DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  `changeType` varchar(20) DEFAULT NULL,
  `futureStatusId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `recurrDate` date DEFAULT NULL,
  `recurrTimeStart` time DEFAULT NULL,
  `recurrTimeFinish` time DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `eventMinutes` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `statusChangeHrsCal`;
CREATE TABLE `statusChangeHrsCal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `statusChangeTableId` int(11) DEFAULT NULL,
  `futureStatusTableId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `totalHoursWorked` float DEFAULT NULL,
  `totalWorkedPerWeek` float DEFAULT NULL,
  `percentageCal` float DEFAULT NULL,
  `annualLeaveEntitlement` float DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `statusChangeDate` datetime DEFAULT NULL,
  `leaveCalculationDate` date DEFAULT NULL,
  `day1` float DEFAULT NULL,
  `day2` float DEFAULT NULL,
  `day3` float DEFAULT NULL,
  `day4` float DEFAULT NULL,
  `day5` float DEFAULT NULL,
  `day6` float DEFAULT NULL,
  `day7` float DEFAULT NULL,
  `numOfWeeksOff` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `statusChangesSet`;
CREATE TABLE `statusChangesSet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `statusIdChange` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `statusPick`;
CREATE TABLE `statusPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `dateChange` date DEFAULT NULL,
  `changeBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `previousStatusId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `statusChangeReasonId` int(11) DEFAULT NULL,
  `statusClientTableId` int(11) DEFAULT NULL,
  `statusCarerTableId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `systemLabels`;
CREATE TABLE `systemLabels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `holidayRequestCommentTitle` varchar(500) DEFAULT 'Comments:',
  `holidayRequestCommentPlaceholder` varchar(500) DEFAULT 'Enter Comment Here',
  `clientKnownAs` varchar(500) DEFAULT 'Known As',
  `clientID` varchar(500) DEFAULT NULL,
  `councilIDNo` varchar(500) DEFAULT 'Council ID No.',
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `clientCall` varchar(200) DEFAULT NULL,
  `carerCall` varchar(200) DEFAULT NULL,
  `eventCall` varchar(200) DEFAULT NULL,
  `assessmentsCall` varchar(200) DEFAULT NULL,
  `commissioningAuthorityCall` varchar(50) DEFAULT 'Commissioning Authority',
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tabPermissionCustom`;
CREATE TABLE `tabPermissionCustom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `tabId` int(11) DEFAULT NULL,
  `value` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tabPermissionGeneral`;
CREATE TABLE `tabPermissionGeneral` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `overview` int(11) DEFAULT '1',
  `comments` int(11) DEFAULT '1',
  `notes` int(11) DEFAULT '1',
  `tasks` int(11) DEFAULT '1',
  `document` int(11) DEFAULT '1',
  `postits` int(11) DEFAULT '1',
  `forms` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tabPermissionLog`;
CREATE TABLE `tabPermissionLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `typeIdGeneral` varchar(50) DEFAULT NULL,
  `typeIdCustom` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  `createddate` datetime DEFAULT NULL,
  `command` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `tagCategoryId` int(11) DEFAULT '3',
  `clientCarer` varchar(20) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `carerSide` int(11) DEFAULT NULL,
  `clientSide` int(11) DEFAULT NULL,
  `color` varchar(100) DEFAULT 'success',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tagCategory`;
CREATE TABLE `tagCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `tagCategoryName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tagOutcomeLink`;
CREATE TABLE `tagOutcomeLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `outcomeId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tagPick`;
CREATE TABLE `tagPick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `qualId` int(11) DEFAULT NULL,
  `qualTag` int(11) DEFAULT NULL,
  `superTag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tagPickPending`;
CREATE TABLE `tagPickPending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `tagId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `teaSetup`;
CREATE TABLE `teaSetup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `eventMins` int(11) DEFAULT NULL,
  `tea` int(11) DEFAULT NULL,
  `teaPay` int(1) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timePeriods`;
CREATE TABLE `timePeriods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheet`;
CREATE TABLE `timesheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logIn` datetime DEFAULT NULL,
  `logOut` datetime DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `dueIn` time DEFAULT NULL,
  `dueOut` time DEFAULT NULL,
  `time` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `timeType` varchar(50) DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `timeConfirmed` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `tasksDone` text,
  `comments` varchar(150) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `latitudeIn` varchar(25) DEFAULT NULL,
  `longitudeIn` varchar(25) DEFAULT NULL,
  `accuracyIn` varchar(25) DEFAULT NULL,
  `latitudeOut` varchar(25) DEFAULT NULL,
  `longitudeOut` varchar(25) DEFAULT NULL,
  `accuracyOut` varchar(25) DEFAULT NULL,
  `payRate` varchar(20) DEFAULT NULL,
  `billingRate` varchar(20) DEFAULT NULL,
  `travelRate` varchar(20) DEFAULT NULL,
  `travelMtr` float DEFAULT NULL,
  `travelId` int(11) DEFAULT NULL,
  `travelExpenses` decimal(10,5) DEFAULT NULL,
  `travelPay` decimal(10,5) DEFAULT NULL,
  `dontPay` int(11) DEFAULT NULL,
  `dontBill` int(11) DEFAULT NULL,
  `lateLogginOut` date DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `confirmed` datetime DEFAULT NULL,
  `confirmedBy` int(11) DEFAULT NULL,
  `lockDown` datetime DEFAULT NULL,
  `lockdownPayroll` datetime DEFAULT NULL,
  `billableTime` time DEFAULT NULL,
  `residential` int(11) DEFAULT NULL,
  `overnight` int(11) DEFAULT NULL,
  `driver` int(11) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  `invoiceId` int(11) DEFAULT NULL,
  `tea` int(11) DEFAULT NULL,
  `teaPay` int(11) DEFAULT NULL,
  `percentPay` int(3) DEFAULT NULL,
  `percentBill` int(3) DEFAULT NULL,
  `refPO` varchar(50) DEFAULT NULL,
  `cancelledReason` int(11) DEFAULT NULL,
  `logReason` int(11) DEFAULT NULL,
  `flagId` int(11) DEFAULT NULL,
  `travelTime` float DEFAULT NULL,
  `travelTimePay` decimal(10,5) DEFAULT NULL,
  `edited` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `recurrId` (`recurrId`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`),
  KEY `status` (`status`),
  KEY `timeType` (`timeType`),
  KEY `timeConfirmed` (`timeConfirmed`),
  KEY `logDate` (`logDate`),
  KEY `jobType` (`jobType`),
  KEY `locationId_logDate` (`locationId`,`logDate`),
  KEY `lockDown` (`lockDown`),
  KEY `recurrId_2` (`recurrId`,`logDate`),
  KEY `lockdownPayroll` (`lockdownPayroll`) USING BTREE,
  KEY `residential` (`residential`) USING BTREE,
  KEY `idx_timesheet_composite` (`locationId`,`companyId`,`timeConfirmed`,`carerId`,`lockdownPayroll`,`logDate`,`dontPay`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetBatch`;
CREATE TABLE `timesheetBatch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timesheetId` int(11) NOT NULL,
  `batchId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_timesheetId` (`timesheetId`),
  KEY `idx_batchId` (`batchId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetCustomId`;
CREATE TABLE `timesheetCustomId` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timesheetId` int(11) NOT NULL,
  `timesheetCustomId` int(7) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_timesheetCustomId` (`timesheetCustomId`),
  KEY `idx_timesheetId` (`timesheetId`),
  CONSTRAINT `fk_timesheetCustomId_timesheet` FOREIGN KEY (`timesheetId`) REFERENCES `timesheet` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetDelete`;
CREATE TABLE `timesheetDelete` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletedDate` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `logIn` datetime DEFAULT NULL,
  `logOut` datetime DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `dueIn` time DEFAULT NULL,
  `dueOut` time DEFAULT NULL,
  `time` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `timeType` varchar(50) DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `timeConfirmed` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `tasksDone` text,
  `comments` varchar(150) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `latitudeIn` varchar(20) DEFAULT NULL,
  `longitudeIn` varchar(20) DEFAULT NULL,
  `accuracyIn` varchar(20) DEFAULT NULL,
  `latitudeOut` varchar(20) DEFAULT NULL,
  `longitudeOut` varchar(20) DEFAULT NULL,
  `accuracyOut` varchar(20) DEFAULT NULL,
  `payRate` varchar(20) DEFAULT NULL,
  `billingRate` varchar(20) DEFAULT NULL,
  `travelRate` varchar(20) DEFAULT NULL,
  `travelMtr` float DEFAULT NULL,
  `travelId` int(11) DEFAULT NULL,
  `travelExpenses` decimal(10,0) DEFAULT NULL,
  `travelPay` decimal(10,0) DEFAULT NULL,
  `dontPay` int(11) DEFAULT NULL,
  `dontBill` int(11) DEFAULT NULL,
  `lateLogginOut` date DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `confirmed` datetime DEFAULT NULL,
  `confirmedBy` int(11) DEFAULT NULL,
  `driver` int(11) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  `invoiceId` int(11) DEFAULT NULL,
  `pageDone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetDetails`;
CREATE TABLE `timesheetDetails` (
  `id` int(11) NOT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `lastUpdatedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `statusId` int(11) DEFAULT NULL,
  `schedStart` time DEFAULT NULL,
  `schedFinish` time DEFAULT NULL,
  `schedDuration` time DEFAULT NULL,
  `actualStart` time DEFAULT NULL,
  `actualFinish` time DEFAULT NULL,
  `actualDuration` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `JobtypeId` int(11) DEFAULT NULL,
  `billing` int(11) DEFAULT NULL,
  `pay` int(11) DEFAULT NULL,
  `billingRate` varchar(20) DEFAULT NULL,
  `payRate` varchar(20) DEFAULT NULL,
  `dontBill` int(11) DEFAULT NULL,
  `dontPay` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetEdit`;
CREATE TABLE `timesheetEdit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logIn` datetime DEFAULT NULL,
  `logOut` datetime DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `dueIn` time DEFAULT NULL,
  `dueOut` time DEFAULT NULL,
  `time` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `timeType` varchar(50) DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `timeConfirmed` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `tasksDone` text,
  `comments` text,
  `recurrId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `latitudeIn` varchar(20) DEFAULT NULL,
  `longitudeIn` varchar(20) DEFAULT NULL,
  `latitudeOut` varchar(20) DEFAULT NULL,
  `longitudeOut` varchar(20) DEFAULT NULL,
  `payRate` varchar(20) DEFAULT NULL,
  `billingRate` varchar(20) DEFAULT NULL,
  `travelRate` varchar(20) DEFAULT NULL,
  `lateLogginOut` date DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `editedId` int(11) DEFAULT NULL,
  `editedBy` int(11) DEFAULT NULL,
  `editedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `recurrId` (`recurrId`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetInvestigation`;
CREATE TABLE `timesheetInvestigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `notifiedCarerId` int(11) DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `resolved` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `resolvedBy` int(11) DEFAULT NULL,
  `resolvedComment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetJobtypeChange`;
CREATE TABLE `timesheetJobtypeChange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `oldJobType` int(11) DEFAULT NULL,
  `newJobType` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `comment` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetLocationAccuracy`;
CREATE TABLE `timesheetLocationAccuracy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `accuracy` double DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetSignOff`;
CREATE TABLE `timesheetSignOff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataURL` mediumtext,
  `person` varchar(20) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetSignOffDetails`;
CREATE TABLE `timesheetSignOffDetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `carerSignatureId` int(11) DEFAULT NULL,
  `adminSignatureId` int(11) DEFAULT NULL,
  `adminName` varchar(30) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timesheetId` (`timesheetId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetToday`;
CREATE TABLE `timesheetToday` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timesheetId` int(11) DEFAULT NULL,
  `timesheetDate` date DEFAULT NULL,
  `logIn` datetime DEFAULT NULL,
  `logOut` datetime DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `dueIn` time DEFAULT NULL,
  `dueOut` time DEFAULT NULL,
  `time` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `timeType` varchar(50) DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `timeConfirmed` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `tasksDone` text,
  `recurrId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `latitudeIn` varchar(20) DEFAULT NULL,
  `longitudeIn` varchar(20) DEFAULT NULL,
  `latitudeOut` varchar(20) DEFAULT NULL,
  `longitudeOut` varchar(20) DEFAULT NULL,
  `payRate` varchar(20) DEFAULT NULL,
  `billingRate` varchar(20) DEFAULT NULL,
  `travelRate` varchar(20) DEFAULT NULL,
  `lateLogginOut` date DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetTravel`;
CREATE TABLE `timesheetTravel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `travelMtr` float DEFAULT NULL,
  `travelId` int(11) DEFAULT NULL,
  `travelExpenses` decimal(10,5) DEFAULT NULL,
  `travelPay` decimal(10,5) DEFAULT NULL,
  `startLatitude` varchar(30) DEFAULT NULL,
  `startLongitude` varchar(30) DEFAULT NULL,
  `finishLatitude` varchar(30) DEFAULT NULL,
  `finishLongitude` varchar(30) DEFAULT NULL,
  `startClient` int(11) DEFAULT NULL,
  `finishClient` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `manual` int(11) DEFAULT NULL,
  `travelTimePay` decimal(10,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `startClient` (`startClient`),
  KEY `finishClient` (`finishClient`),
  KEY `location_id` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetTravelUpdated`;
CREATE TABLE `timesheetTravelUpdated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `timesheetId` int(11) DEFAULT NULL,
  `travelMtr` float DEFAULT NULL,
  `travelId` int(11) DEFAULT NULL,
  `travelExpenses` decimal(10,5) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `travelTimePay` decimal(10,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timesheetId` (`timesheetId`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheet_bill_pay`;
CREATE TABLE `timesheet_bill_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timesheetId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `generated_date` datetime DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `payableTime` time DEFAULT NULL,
  `timeType` varchar(200) DEFAULT NULL,
  `durationMinutes` int(11) DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `jobType` varchar(50) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `bill_text` varchar(255) DEFAULT NULL,
  `bill_billing` varchar(200) DEFAULT NULL,
  `bill_durationHrs` float DEFAULT NULL,
  `bill_billingRatesJson` text,
  `bill_breakDownAntiJson` text,
  `bill_breakDownSocialJson` text,
  `bill_pecentageIncrease` varchar(255) DEFAULT NULL,
  `bill_warning` varchar(255) DEFAULT NULL,
  `bill_billingBreakDownJson` text,
  `bill_breakDownGroupJson` text,
  `bill_dayType` varchar(255) DEFAULT NULL,
  `bill_billingScaleId` varchar(255) DEFAULT NULL,
  `bill_billingScaleName` varchar(255) DEFAULT NULL,
  `bill_showTotBilling` varchar(255) DEFAULT NULL,
  `pay_text` varchar(255) DEFAULT NULL,
  `pay_pay` varchar(200) DEFAULT NULL,
  `pay_durationHrs` float DEFAULT NULL,
  `pay_payRatesJson` text,
  `pay_breakDownAntiJson` text,
  `pay_breakDownSocialJson` text,
  `pay_pecentageIncrease` varchar(255) DEFAULT NULL,
  `pay_warning` varchar(255) DEFAULT NULL,
  `pay_payBreakDownJson` text,
  `pay_commissionTotal` varchar(200) DEFAULT NULL,
  `pay_commission` varchar(200) DEFAULT NULL,
  `pay_breakDownGroupJson` text,
  `pay_cmCarerPayID` varchar(255) DEFAULT NULL,
  `pay_exportName` varchar(255) DEFAULT NULL,
  `pay_dayType` varchar(255) DEFAULT NULL,
  `pay_payScaleId` varchar(255) DEFAULT NULL,
  `pay_payScaleName` varchar(255) DEFAULT NULL,
  `pay_showTotPaying` varchar(255) DEFAULT NULL,
  `pay_totalPay` decimal(10,2) DEFAULT NULL,
  `pay_totTravelRate` varchar(255) DEFAULT NULL,
  `cmCarerPayID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `timesheetId` (`timesheetId`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `bill_billingScaleId` (`bill_billingScaleId`),
  KEY `pay_payScaleId` (`pay_payScaleId`),
  KEY `generated_date` (`generated_date`),
  KEY `logDate` (`logDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheet_saturn_ids`;
CREATE TABLE `timesheet_saturn_ids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timesheet_id` varchar(11) DEFAULT NULL,
  `saturn_id` varchar(11) DEFAULT NULL,
  `companyId` varchar(11) DEFAULT NULL,
  `locationId` varchar(11) DEFAULT NULL,
  `created` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timesheet_id` (`timesheet_id`),
  KEY `saturn_id` (`saturn_id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todo`;
CREATE TABLE `todo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `priority` varchar(10) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `issue` varchar(10) DEFAULT NULL,
  `issueFrom` varchar(200) DEFAULT NULL,
  `issueFromPhone` varchar(100) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `subject` text,
  `details` text,
  `createdBy` int(11) DEFAULT NULL,
  `adminId` int(11) DEFAULT NULL,
  `notified` varchar(500) DEFAULT NULL,
  `datepickerDue` date DEFAULT NULL,
  `timeDue` time DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `progress` varchar(3) DEFAULT NULL,
  `actionsTook` text,
  `dateClosed` date DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(500) DEFAULT NULL,
  `fileSize` varchar(100) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `seen` varchar(10) DEFAULT NULL,
  `medicationAssignId` int(11) DEFAULT NULL,
  `medicationAssignTimesId` int(11) DEFAULT NULL,
  `medicationResultsId` int(11) DEFAULT NULL,
  `incidentDate` datetime DEFAULT NULL,
  `issuePrefix` varchar(10) DEFAULT NULL,
  `todoSeq` varchar(20) DEFAULT NULL,
  `todoNumber` varchar(50) DEFAULT NULL,
  `sendMail` tinyint(4) DEFAULT '1',
  `areaId` int(11) DEFAULT NULL COMMENT 'Reference to Care home in Residential',
  PRIMARY KEY (`id`),
  KEY `locationId` (`locationId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todoHistory`;
CREATE TABLE `todoHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `assignedTo` int(11) DEFAULT NULL,
  `progress` varchar(10) DEFAULT NULL,
  `priority` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `actionsTaken` text,
  `notifiedCarer` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todoLog`;
CREATE TABLE `todoLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todo_associated`;
CREATE TABLE `todo_associated` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `firstView` datetime DEFAULT NULL,
  `lastView` datetime DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `associatedId` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `todoId` (`todoId`),
  KEY `carerId` (`associatedId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todo_details_history`;
CREATE TABLE `todo_details_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `todoId` int(11) NOT NULL COMMENT 'Todo id reference',
  `updated` datetime NOT NULL COMMENT 'When the details was changed',
  `updatedBy` int(11) NOT NULL COMMENT 'Who changed details',
  `detailsOld` text NOT NULL COMMENT 'Original details before changed',
  PRIMARY KEY (`id`),
  KEY `FK_todoId` (`todoId`),
  CONSTRAINT `FK_todoId` FOREIGN KEY (`todoId`) REFERENCES `todo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Maintain the history of changes in field details of todo';


DROP TABLE IF EXISTS `todo_issue`;
CREATE TABLE `todo_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `prefix` varchar(5) DEFAULT NULL,
  `prefixNumber` int(11) DEFAULT NULL,
  `mandatoryCarer` int(11) DEFAULT NULL,
  `mandatoryClient` int(11) DEFAULT NULL,
  `email` text,
  `carerNotify` varchar(200) DEFAULT NULL,
  `daysNotify` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todo_issue_subtask`;
CREATE TABLE `todo_issue_subtask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `issueId` int(11) DEFAULT NULL,
  `orderByTask` int(11) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `showTask` int(11) NOT NULL DEFAULT '1',
  `days` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todo_issue_subtask_items`;
CREATE TABLE `todo_issue_subtask_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `firstView` datetime DEFAULT NULL,
  `lastView` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `todoId` int(11) DEFAULT NULL,
  `orderByTask` int(11) DEFAULT NULL,
  `subtaskId` int(11) DEFAULT NULL,
  `details` text,
  `deadline` date DEFAULT NULL,
  `notes` text,
  `assignId` int(11) DEFAULT NULL COMMENT 'admin',
  `status` int(11) DEFAULT NULL COMMENT 'new, open, not required, closed',
  PRIMARY KEY (`id`),
  KEY `todoId` (`todoId`),
  CONSTRAINT `todo_issue_subtask_items_ibfk_1` FOREIGN KEY (`todoId`) REFERENCES `todo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todo_issue_subtask_status`;
CREATE TABLE `todo_issue_subtask_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `sequence` int(5) DEFAULT NULL,
  `closed` int(11) DEFAULT '0' COMMENT '1= Selected',
  `new` int(11) DEFAULT '0' COMMENT '1= Selected',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todo_notes`;
CREATE TABLE `todo_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `todoId` int(11) DEFAULT NULL,
  `note` text,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `todo_subject_history`;
CREATE TABLE `todo_subject_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `todoId` int(11) NOT NULL COMMENT 'Todo id reference',
  `updated` datetime NOT NULL COMMENT 'When the subject was changed',
  `updatedBy` int(11) NOT NULL COMMENT 'Who changed subject',
  `subjectOld` text NOT NULL COMMENT 'Original subject before changed',
  PRIMARY KEY (`id`),
  KEY `FK_todoId` (`todoId`),
  CONSTRAINT `FK_Subject_todoId` FOREIGN KEY (`todoId`) REFERENCES `todo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Maintain the history of changes in field subject of todo';


DROP TABLE IF EXISTS `todo_upload`;
CREATE TABLE `todo_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `typeLocation` varchar(100) DEFAULT NULL,
  `file` longblob,
  `fileName` varchar(500) DEFAULT NULL,
  `fileSize` varchar(100) DEFAULT NULL,
  `fileType` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `todoId` (`typeId`) USING BTREE,
  KEY `locationId` (`locationId`) USING BTREE,
  KEY `companyId` (`companyId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `trainingSession`;
CREATE TABLE `trainingSession` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `trainingSessionId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dateStart` date DEFAULT NULL,
  `dateFinish` date DEFAULT NULL,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `comments` mediumtext,
  `signedofBy` varchar(100) DEFAULT NULL,
  `sessionBy` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `trainingSessions`;
CREATE TABLE `trainingSessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fields` json NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `travel`;
CREATE TABLE `travel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `travelDistance`;
CREATE TABLE `travelDistance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `startClient` int(11) DEFAULT NULL,
  `startLatitude` varchar(30) DEFAULT NULL,
  `startLongitude` varchar(30) DEFAULT NULL,
  `finishClient` int(11) DEFAULT NULL,
  `finishLatitude` varchar(30) DEFAULT NULL,
  `finishLongitude` varchar(30) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `travelMtr` float DEFAULT NULL,
  `manual` int(11) DEFAULT NULL,
  `oldTravelMtr` float DEFAULT NULL,
  `transportCategory` int(2) DEFAULT NULL,
  `travelTime` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `startClient` (`startClient`),
  KEY `finishClient` (`finishClient`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `travelDistanceCarerBaseClient`;
CREATE TABLE `travelDistanceCarerBaseClient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `carerLatitude` varchar(25) DEFAULT NULL,
  `carerLongitude` varchar(25) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `clientLatitude` varchar(25) DEFAULT NULL,
  `clientLongitude` varchar(25) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `travelMtr` float DEFAULT NULL,
  `manual` int(11) DEFAULT NULL,
  `oldTravelMtr` float DEFAULT NULL,
  `transportCategory` int(2) DEFAULT NULL,
  `travelTime` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `travelDistanceCarerClient`;
CREATE TABLE `travelDistanceCarerClient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `carerLatitude` varchar(25) DEFAULT NULL,
  `carerLongitude` varchar(25) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `clientLatitude` varchar(25) DEFAULT NULL,
  `clientLongitude` varchar(25) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `travelMtr` float DEFAULT NULL,
  `manual` int(11) DEFAULT NULL,
  `oldTravelMtr` float DEFAULT NULL,
  `transportCategory` int(2) DEFAULT NULL,
  `travelTime` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`),
  KEY `clientId` (`clientId`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `travelTimeSchedule`;
CREATE TABLE `travelTimeSchedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `time` float DEFAULT NULL,
  `transport` varchar(30) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_locationId` (`locationId`),
  KEY `idx_companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `uniqueCode`;
CREATE TABLE `uniqueCode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `code` varchar(100) NOT NULL,
  `codeUsed` int(11) DEFAULT NULL,
  `codeUsedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `updatedField`;
CREATE TABLE `updatedField` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedFieldTypeId` int(11) DEFAULT NULL,
  `updatedId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `oldValue` text,
  `newValue` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `updatedFieldType`;
CREATE TABLE `updatedFieldType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(200) DEFAULT NULL,
  `table` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `upload`;
CREATE TABLE `upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `size` int(11) NOT NULL,
  `content` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AnswerAssessmentLink`;
CREATE TABLE `v2AnswerAssessmentLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `assessmentType` varchar(100) DEFAULT NULL,
  `assessmentOriginalId` int(11) DEFAULT NULL,
  `allocationOption` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AnswerChartLink`;
CREATE TABLE `v2AnswerChartLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `chartOriginalId` int(11) DEFAULT NULL COMMENT 'Original id incase chart gets updated',
  `scheduleMode` varchar(100) DEFAULT NULL,
  `directiveMode` varchar(100) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AnswerProgressNoteLink`;
CREATE TABLE `v2AnswerProgressNoteLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `progressNoteCategory` int(11) DEFAULT NULL,
  `progressNoteReason` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentAnsFlagLink`;
CREATE TABLE `v2AssessmentAnsFlagLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `flagId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentAnsTaken`;
CREATE TABLE `v2AssessmentAnsTaken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `deselected` int(11) DEFAULT NULL,
  `assessmentTakenId` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `answerId` int(11) DEFAULT NULL,
  `textAnswer` text,
  `sharedQ` int(11) DEFAULT NULL,
  `locked` datetime DEFAULT NULL,
  `lockedBy` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentAnswers`;
CREATE TABLE `v2AssessmentAnswers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `answer` varchar(300) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `action` text,
  `prepopSentence` text,
  `score` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentQCategories`;
CREATE TABLE `v2AssessmentQCategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `category` char(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentQuestionLink`;
CREATE TABLE `v2AssessmentQuestionLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `sectionId` int(11) DEFAULT NULL,
  `linkedAssessment` int(11) DEFAULT NULL,
  `sharedOption` varchar(100) DEFAULT NULL,
  `answerRequire` varchar(100) DEFAULT NULL,
  `questionOrder` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentQuestions`;
CREATE TABLE `v2AssessmentQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `question` varchar(300) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  `riskLevel` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `scoreLocked` datetime DEFAULT NULL,
  `shared` tinyint(4) DEFAULT NULL,
  `restrictByRole` tinyint(4) DEFAULT NULL,
  `primaryQ` int(11) DEFAULT NULL,
  `fqPosition` tinyint(4) DEFAULT NULL,
  `fileCabLink` varchar(100) DEFAULT NULL,
  `headerText` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  `archived` datetime DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `originalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentQuesTypes`;
CREATE TABLE `v2AssessmentQuesTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentRoles`;
CREATE TABLE `v2AssessmentRoles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2Assessments`;
CREATE TABLE `v2Assessments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `archived` datetime DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `versionGroupId` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `assessment` varchar(100) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  `scoring` int(11) DEFAULT NULL,
  `movementDuePeriod` int(11) DEFAULT NULL,
  `movementOffset` int(11) DEFAULT NULL,
  `reviewDuePeriod` int(11) DEFAULT NULL,
  `defaultClientReviewFreq` int(11) DEFAULT NULL COMMENT 'days',
  `version` varchar(100) DEFAULT NULL,
  `assessmentReview` date DEFAULT NULL COMMENT 'review date of the actual assessment',
  `author` varchar(100) DEFAULT NULL,
  `approver` varchar(100) DEFAULT NULL,
  `saved` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentScoreThresholds`;
CREATE TABLE `v2AssessmentScoreThresholds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `toVal` int(11) DEFAULT NULL,
  `fromVal` int(11) DEFAULT NULL,
  `msgVal` text,
  `descVal` text,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentSectionTypes`;
CREATE TABLE `v2AssessmentSectionTypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `section` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentTaken`;
CREATE TABLE `v2AssessmentTaken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `archived` datetime DEFAULT NULL,
  `archivedBy` int(11) DEFAULT NULL,
  `assessmentId` int(11) DEFAULT NULL,
  `versionGroupId` int(11) DEFAULT NULL,
  `assignType` varchar(100) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `opened` datetime DEFAULT NULL,
  `openedBy` int(11) DEFAULT NULL,
  `locked` datetime DEFAULT NULL,
  `lockedBy` int(11) DEFAULT NULL,
  `reviewDate` date DEFAULT NULL,
  `reviewDone` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2AssessmentTakenSnapshot`;
CREATE TABLE `v2AssessmentTakenSnapshot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assessmentTakenId` int(11) NOT NULL,
  `fileName` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1 = complete / 2 = signature added  / 3 =  resident contact signature added ',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `deltedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `v2AssessmentTakenSnapshot_carer_id_fk` (`createdBy`),
  KEY `v2AssessmentTakenSnapshot_v2AssessmentTaken_id_fk` (`assessmentTakenId`),
  CONSTRAINT `v2AssessmentTakenSnapshot_carer_id_fk` FOREIGN KEY (`createdBy`) REFERENCES `carer` (`id`),
  CONSTRAINT `v2AssessmentTakenSnapshot_v2AssessmentTaken_id_fk` FOREIGN KEY (`assessmentTakenId`) REFERENCES `v2AssessmentTaken` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2FollowOnQuestions`;
CREATE TABLE `v2FollowOnQuestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `triggerAnswerId` int(11) DEFAULT NULL,
  `followOnId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2QuestionRolesLink`;
CREATE TABLE `v2QuestionRolesLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `v2QuestionScoreThresholds`;
CREATE TABLE `v2QuestionScoreThresholds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `questionId` int(11) DEFAULT NULL,
  `fromVal` int(11) DEFAULT NULL,
  `toVal` int(11) DEFAULT NULL,
  `scoreVal` int(11) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `areaId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `video_sessions`;
CREATE TABLE `video_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meetingId` int(20) NOT NULL,
  `created` datetime NOT NULL,
  `expires` datetime NOT NULL,
  `host` int(11) NOT NULL,
  `host_type` varchar(100) NOT NULL,
  `clientId` int(11) NOT NULL,
  `hostUrl` varchar(1000) NOT NULL,
  `roomUrl` varchar(1000) NOT NULL,
  `companyId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `view_events`;
CREATE TABLE `view_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `recurrId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `recurrDate` date DEFAULT NULL,
  `timeStart` time DEFAULT NULL,
  `timeFinish` time DEFAULT NULL,
  `durationTime` time DEFAULT NULL,
  `durationDecimal` double DEFAULT NULL,
  `jobType` int(11) DEFAULT NULL,
  `overnight` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`),
  KEY `locationId` (`locationId`),
  KEY `recurrId` (`recurrId`),
  KEY `recurrDate` (`recurrDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `view_finance`;
CREATE TABLE `view_finance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `generated_date` date DEFAULT NULL,
  `generated_time` time DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `EventId` int(11) DEFAULT NULL,
  `timesheetrecurrId` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `client_name` varchar(500) DEFAULT NULL,
  `carer_id` int(11) DEFAULT NULL,
  `carer_name` varchar(500) DEFAULT NULL,
  `branch_id` varchar(100) DEFAULT NULL,
  `Branch` varchar(500) DEFAULT NULL,
  `workgroup_id` varchar(100) DEFAULT NULL,
  `WorkGroup` varchar(500) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `area_name` varchar(250) DEFAULT NULL,
  `Shift_Status` varchar(50) DEFAULT NULL,
  `Cancelled_Reason` varchar(500) DEFAULT NULL,
  `cancelled_comment` text,
  `notes` text,
  `Sched_Start` time DEFAULT NULL,
  `Sched_Finish` time DEFAULT NULL,
  `Actual_Start` time DEFAULT NULL,
  `Actual_Finish` time DEFAULT NULL,
  `Sched_Duration` time DEFAULT NULL,
  `JobtypeId` int(11) DEFAULT NULL,
  `JobtypeName` varchar(500) DEFAULT NULL,
  `Billing` decimal(10,2) DEFAULT NULL,
  `Pay` decimal(10,2) DEFAULT NULL,
  `billingRate` decimal(10,2) DEFAULT NULL,
  `payRate` decimal(10,2) DEFAULT NULL,
  `travelPay` decimal(10,2) DEFAULT NULL,
  `travelRate` decimal(10,2) DEFAULT NULL,
  `dontBill` int(11) DEFAULT NULL,
  `dontPay` int(11) DEFAULT NULL,
  `extraPay` float DEFAULT NULL COMMENT 'Events Topped Up',
  `coordinator` varchar(200) DEFAULT NULL,
  `billingCode` varchar(200) DEFAULT NULL,
  `referralReason` varchar(200) DEFAULT NULL,
  `unitId` varchar(200) DEFAULT NULL,
  `councilId` varchar(200) DEFAULT NULL,
  `careManager` varchar(200) DEFAULT NULL,
  `funder` varchar(200) DEFAULT NULL,
  `invoiceSplitArray` varchar(1000) DEFAULT NULL,
  `invoiceSplitArrayPay` varchar(1000) DEFAULT NULL,
  `billingScaleId` int(11) DEFAULT NULL,
  `billingScaleName` varchar(200) DEFAULT NULL,
  `payScaleId` int(11) DEFAULT NULL,
  `payScaleName` varchar(200) DEFAULT NULL,
  `fullSched_Start` datetime DEFAULT NULL,
  `fullSched_Finish` datetime DEFAULT NULL,
  `overnight` int(11) DEFAULT NULL,
  `serviceType` varchar(200) DEFAULT NULL,
  `clientPostalCode` varchar(100) DEFAULT NULL,
  `billingFiscalMonth` varchar(7) DEFAULT NULL,
  `billingWeekEnding` date DEFAULT NULL,
  `earnedFiscalMonth` varchar(7) DEFAULT NULL,
  `earnedFiscalWeek` date DEFAULT NULL,
  `updateDate` date DEFAULT NULL,
  `JobtypeGroupId` int(11) DEFAULT NULL,
  `JobtypeGroupName` varchar(200) DEFAULT NULL,
  `JobtypeGroupCode` varchar(50) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  `runName` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generated_date` (`generated_date`),
  KEY `companyId` (`companyId`),
  KEY `date` (`date`),
  KEY `area_id` (`area_id`),
  KEY `EventId` (`EventId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `view_finance_error_log`;
CREATE TABLE `view_finance_error_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `dateStart` date NOT NULL,
  `dateFinish` date NOT NULL,
  `totalTimesheet` int(11) NOT NULL,
  `totalViewFinance` int(11) NOT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `missingInTimesheet` varchar(10000) DEFAULT NULL,
  `missingInViewFinance` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `view_finance_log`;
CREATE TABLE `view_finance_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_date` date NOT NULL,
  `created_time` time NOT NULL,
  `date_start` date NOT NULL,
  `date_finish` date NOT NULL,
  `companyId` int(11) NOT NULL,
  `total_records` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `finish_date` date DEFAULT NULL,
  `finish_time` time DEFAULT NULL,
  `test` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companyId` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `vpn_whitelist`;
CREATE TABLE `vpn_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(100) NOT NULL,
  `user` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `walletSignOff`;
CREATE TABLE `walletSignOff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataURL` mediumtext NOT NULL,
  `person` varchar(20) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `clientId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `workPhone`;
CREATE TABLE `workPhone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  `workNumber` varchar(50) DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `activationLink` varchar(10) DEFAULT NULL,
  `txtSent` datetime DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `yearCalculations`;
CREATE TABLE `yearCalculations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `logDate` date DEFAULT NULL,
  `carerId` int(11) DEFAULT NULL,
  `clienId` int(11) DEFAULT NULL,
  `miles` float DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_yearCalculations_locationId` (`locationId`),
  KEY `idx_yearCalculations_logDate` (`logDate`),
  KEY `idx_yearCalculations_carerId` (`carerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `zone`;
CREATE TABLE `zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `contactName` varchar(200) DEFAULT NULL,
  `contactAddress` varchar(200) DEFAULT NULL,
  `contactPhone` varchar(200) DEFAULT NULL,
  `companyId` int(11) DEFAULT NULL,
  `locationId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `deletedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- 2026-04-13 14:37:56 UTC
