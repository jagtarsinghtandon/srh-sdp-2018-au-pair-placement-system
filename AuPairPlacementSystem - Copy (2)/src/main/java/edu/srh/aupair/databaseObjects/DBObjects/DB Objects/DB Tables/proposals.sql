CREATE TABLE `proposals` (
  `PROPOSAL_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ACTIVE_INTERVIEW_ID` int(10) unsigned NOT NULL,
  `TASKS_FOR_AU_PAIR` varchar(45) DEFAULT NULL,
  `WORKING_HOURS_PROPOSED` varchar(45) DEFAULT NULL,
  `REMUNERATIONS_PROPOSED` varchar(45) DEFAULT NULL,
  `HOLIDAYS_PROPOSED` varchar(45) DEFAULT NULL,
  `TRAVEL_COSTS` bit(1) DEFAULT NULL,
  PRIMARY KEY (`PROPOSAL_ID`),
  KEY `ACTIVE_INTERVIEW_ID_idx` (`ACTIVE_INTERVIEW_ID`),
  CONSTRAINT `FK_PROPOSALS_ACTIVE_INTERVIEW_ID` FOREIGN KEY (`ACTIVE_INTERVIEW_ID`) REFERENCES `active_interviews` (`active_interview_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


ALTER TABLE `au_pair_management`.`active_interviews` 
CHANGE COLUMN `JOB_ACCEPTED_BY_AU-PAIR` `JOB_ACCEPTED_BY_AU_PAIR` BIT(1) NULL DEFAULT NULL ;
ALTER TABLE `au_pair_management`.`active_interviews` 
CHANGE COLUMN `PROPOSALS_OFFERS` `PROPOSALS_OFFERS` VARCHAR(50) NULL DEFAULT NULL ;
ALTER TABLE `au_pair_management`.`active_interviews` 
CHANGE COLUMN `JOB_OFFERED_BY_HOSTS` `JOB_OFFERED_BY_HOSTS` VARCHAR(50) NULL DEFAULT NULL ;
ALTER TABLE `au_pair_management`.`active_interviews` 
CHANGE COLUMN `JOB_ACCEPTED_BY_AU_PAIR` `JOB_ACCEPTED_BY_AU_PAIR` VARCHAR(50) NULL DEFAULT NULL ;