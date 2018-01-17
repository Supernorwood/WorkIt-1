-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema workitdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `workitdb` ;

-- -----------------------------------------------------
-- Schema workitdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `workitdb` DEFAULT CHARACTER SET utf8 ;
USE `workitdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NOT NULL,
  `street2` VARCHAR(100) NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(9) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `address` (`id` ASC);


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `pwd` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `address_id` INT UNSIGNED NULL,
  `permission_level` INT UNSIGNED NOT NULL DEFAULT 1,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_date` DATE NULL,
  `last_update` DATE NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `email_UNIQUE` ON `user` (`email` ASC);

CREATE UNIQUE INDEX `id_UNIQUE` ON `user` (`id` ASC);

CREATE INDEX `fk_user-address-id_address-id_idx` ON `user` (`address_id` ASC);


-- -----------------------------------------------------
-- Table `job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job` ;

CREATE TABLE IF NOT EXISTS `job` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `company` VARCHAR(100) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `link` TEXT NULL,
  `address_id` INT UNSIGNED NULL,
  `salary` INT UNSIGNED NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_date` DATE NULL,
  `closing_date` DATE NULL,
  `last_update` DATE NULL,
  `note` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_job_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_job_address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `job` (`id` ASC);

CREATE INDEX `fk_job_user_id_idx` ON `job` (`user_id` ASC);

CREATE INDEX `fk_job_address_id_idx` ON `job` (`address_id` ASC);


-- -----------------------------------------------------
-- Table `skills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `skills` ;

CREATE TABLE IF NOT EXISTS `skills` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `skill` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`, `skill`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `skills` (`id` ASC);


-- -----------------------------------------------------
-- Table `benefit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `benefit` ;

CREATE TABLE IF NOT EXISTS `benefit` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `benefit` (`id` ASC);


-- -----------------------------------------------------
-- Table `job_benefits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_benefits` ;

CREATE TABLE IF NOT EXISTS `job_benefits` (
  `job_id` INT UNSIGNED NOT NULL,
  `benefit_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`job_id`, `benefit_id`),
  CONSTRAINT `fk_job_benefits_job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_job_benefits_benefits_id`
    FOREIGN KEY (`benefit_id`)
    REFERENCES `benefit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_job_benefits_benefits_id_idx` ON `job_benefits` (`benefit_id` ASC);


-- -----------------------------------------------------
-- Table `schedule_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `schedule_types` ;

CREATE TABLE IF NOT EXISTS `schedule_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `schedule_types` (`id` ASC);


-- -----------------------------------------------------
-- Table `job_schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_schedule` ;

CREATE TABLE IF NOT EXISTS `job_schedule` (
  `job_id` INT UNSIGNED NOT NULL,
  `schedule_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`job_id`, `schedule_id`),
  CONSTRAINT `fk_job_schedule_job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_job_schedule_schedule_types_id`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `schedule_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_job_schedule_schedule_types_id_idx` ON `job_schedule` (`schedule_id` ASC);


-- -----------------------------------------------------
-- Table `user_skills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_skills` ;

CREATE TABLE IF NOT EXISTS `user_skills` (
  `user_id` INT UNSIGNED NOT NULL,
  `skill_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `skill_id`),
  CONSTRAINT `fk_user_skills_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_skills_skills_id`
    FOREIGN KEY (`skill_id`)
    REFERENCES `skills` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_user_skills_skills_id_idx` ON `user_skills` (`skill_id` ASC);

CREATE INDEX `fk_user_skills_user_id_idx` ON `user_skills` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `job_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_notes` ;

CREATE TABLE IF NOT EXISTS `job_notes` (
  `job_id` INT UNSIGNED NOT NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`job_id`),
  CONSTRAINT `fk_job_notes_job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `job_id_UNIQUE` ON `job_notes` (`job_id` ASC);


-- -----------------------------------------------------
-- Table `job_skills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_skills` ;

CREATE TABLE IF NOT EXISTS `job_skills` (
  `job_id` INT UNSIGNED NOT NULL,
  `skill_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`job_id`, `skill_id`),
  CONSTRAINT `fk_job_skills_job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_job_skills_skill_id`
    FOREIGN KEY (`skill_id`)
    REFERENCES `skills` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_job_skills_skill_id_idx` ON `job_skills` (`skill_id` ASC);


-- -----------------------------------------------------
-- Table `contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contact` ;

CREATE TABLE IF NOT EXISTS `contact` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `title` VARCHAR(100) NULL,
  `company` VARCHAR(100) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(100) NULL,
  `address_id` INT UNSIGNED NULL,
  `contact_count` INT UNSIGNED NULL DEFAULT 0,
  `last_contact_date` DATE NULL,
  `create_date` DATE NULL,
  `last_update` DATE NULL,
  `note` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_contact_address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_contact_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `contact` (`id` ASC);

CREATE INDEX `fk_contacts_address_id_idx` ON `contact` (`address_id` ASC);

CREATE INDEX `fk_contacts_user_id_idx` ON `contact` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `job_contacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_contacts` ;

CREATE TABLE IF NOT EXISTS `job_contacts` (
  `job_id` INT UNSIGNED NOT NULL,
  `contact_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`job_id`, `contact_id`),
  CONSTRAINT `fk_job_contacts_job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_job_contacts_contact_id`
    FOREIGN KEY (`contact_id`)
    REFERENCES `contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_job_contacts_contacts_id_idx` ON `job_contacts` (`contact_id` ASC);


-- -----------------------------------------------------
-- Table `event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event` ;

CREATE TABLE IF NOT EXISTS `event` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `event_date` DATE NULL,
  `description` TEXT NULL,
  `address_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_event_address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `event` (`id` ASC);

CREATE INDEX `fk_event_address_id_idx` ON `event` (`address_id` ASC);


-- -----------------------------------------------------
-- Table `user_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_events` ;

CREATE TABLE IF NOT EXISTS `user_events` (
  `user_id` INT UNSIGNED NOT NULL,
  `event_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `event_id`),
  CONSTRAINT `fk_user_events_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_events_event_id`
    FOREIGN KEY (`event_id`)
    REFERENCES `event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_user_events_event_id_idx` ON `user_events` (`event_id` ASC);


-- -----------------------------------------------------
-- Table `interview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `interview` ;

CREATE TABLE IF NOT EXISTS `interview` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `interview_date` DATE NOT NULL,
  `contact_id` INT UNSIGNED NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_interview_contact_id`
    FOREIGN KEY (`contact_id`)
    REFERENCES `contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_interview_address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_interview_contact_id_idx` ON `interview` (`contact_id` ASC);

CREATE INDEX `fk_interview_address_id_idx` ON `interview` (`address_id` ASC);


-- -----------------------------------------------------
-- Table `job_interviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_interviews` ;

CREATE TABLE IF NOT EXISTS `job_interviews` (
  `job_id` INT UNSIGNED NOT NULL,
  `interview_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`job_id`, `interview_id`),
  CONSTRAINT `fk_job_interviews_job_id`
    FOREIGN KEY (`job_id`)
    REFERENCES `job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_job_interviews_interview_id`
    FOREIGN KEY (`interview_id`)
    REFERENCES `interview` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_job_interviews_interview_id_idx` ON `job_interviews` (`interview_id` ASC);


-- -----------------------------------------------------
-- Table `quotes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quotes` ;

CREATE TABLE IF NOT EXISTS `quotes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quote` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `quotes` (`id` ASC);

SET SQL_MODE = '';
GRANT USAGE ON *.* TO workit@localhost;
 DROP USER workit@localhost;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'workit'@'localhost' IDENTIFIED BY 'password';

GRANT SELECT ON TABLE * TO 'workit'@'localhost';
GRANT SELECT, INSERT, TRIGGER ON TABLE * TO 'workit'@'localhost';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'workit'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (1, '123 6th St', NULL, 'Melbourne', 'Florida', '32904', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (2, '71 Pilgrim Ave', NULL, 'Chevy Chase', 'Maryland', '20815', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (3, '70 Bowman St', NULL, 'South WIndsor', 'Connecticut', '06074', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (4, '4 Goldfield Rd', NULL, 'Honolulu', 'Hawaii', '96815', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (5, '44 Shirley Ave', NULL, 'West Chicago', 'Illinois', '60185', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (6, '514 S Magnolia St', NULL, 'Orlando', 'Florida', '32806', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (7, '9159 Studebaker Dr', NULL, 'Indianapolis', 'Indiana', '46201', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (8, '27 N Harvey Dr', NULL, 'Dundalk', 'MD', '21222', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (9, '324 Glen Creek Ct', NULL, 'Owensboro', 'Kentucky', '42301', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (10, '9199 Beach Ave', NULL, 'North Andover', 'Massachusetts', '01845', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (11, '330 Shirley St', NULL, 'Norfolk', 'Virginia', '23053', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (12, '643 Lookout Ave', NULL, 'Downers Grove', 'Illinois', '60515', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (13, '74 Pineknoll Dr', NULL, 'Ambler', 'Pennsylvania', '19002', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (14, '8669 Gartner Rd', NULL, 'Elk Grove Village', 'Illinois', '60007', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (15, '22 Border St', NULL, 'Harlingen', 'Texas', '78552', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (16, '9 N Johnson Ln', NULL, 'Williamstown', 'New Jersey', '08094', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (17, '27 High Point Ct', NULL, 'Grand Rapids', 'Michigan', '49503', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (18, '46 E Homestead Ave', NULL, 'Paramus', 'New Jersey', '07652', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (19, '16 El Dorado Ln', NULL, 'Xenia', 'Ohio', '45385', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (20, '9334 Bellevue St', NULL, 'Hagerstown', 'Maryland', '21740', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (21, '725 Market St', NULL, 'West Bend', 'Wisconsin', '53095', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (22, '747 San Juan Cir', NULL, 'Vineland', 'New Jersey', '08360', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (23, '307 N Hudson Dr', NULL, 'Sterling Heights', 'Michigan', '48310', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (24, '9031 Shadow Brook Dr', NULL, 'Laurel', 'Maryland', '20707', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (25, '7595 NE Heather Ave', NULL, 'Marshalltown', 'Iowa', '50158', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (26, '8385 E Race Ct', NULL, 'Sugar Land', 'Texas', '77478', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (27, '19 Helen Ct', NULL, 'Yuma', 'Arizona', '85365', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (28, '51 W Strawberry St', NULL, 'Lacey', 'Washington', '98503', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (29, '9308 W Marsh Ave', NULL, 'Sarasota', 'Florida', '34231', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (30, '9961 Ann St', NULL, 'Stow', 'Ohio', '44224', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (31, '80 6th Way', NULL, 'Fresno', 'California', '93762', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (32, '98819 Heath Center', NULL, 'Helena', 'Montana', '59623', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (33, '2 Lerdahl Crossing', NULL, 'Washington', 'District of Columbia', '20260', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (34, '86 Morning Pass', NULL, 'Dayton', 'Ohio', '45419', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (35, '741 Meadow Vale Park', NULL, 'Lansing', 'Michigan', '48930', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (36, '85 Dottie Alley', NULL, 'El Paso', 'Texas', '79934', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (37, '26791 Larry Avenue', NULL, 'San Francisco', 'California', '94110', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (38, '111 Gale Trail', NULL, 'Gastonia', 'North Carolina', '28055', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (39, '38097 Pleasure Lane', NULL, 'Boise', 'Idaho', '83705', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (40, '09 Jackson Park', NULL, 'Elizabeth', 'New Jersey', '07208', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (41, '250 Maple Wood Street', NULL, 'Arlington', 'Virginia', '22244', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (42, '6163 Huxley Junction', NULL, 'Tampa', 'Florida', '33605', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (43, '6053 Forest Run Point', NULL, 'Wichita', 'Kansas', '67236', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (44, '40 5th Plaza', NULL, 'San Jose', 'California', '95123', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (45, '1 Rowland Road', NULL, 'Providence', 'Rhode Island', '02905', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (46, '64833 Corscot Parkway', NULL, 'Saint Louis', 'Missouri', '63196', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (47, '3 Mifflin Center', NULL, 'Tuscaloosa', 'Alabama', '35487', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (48, '0 7th Street', NULL, 'Salt Lake City', 'Utah', '84189', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (49, '8 Monica Hill', NULL, 'Arlington', 'Virginia', '22212', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (50, '8937 Ilene Junction', NULL, 'Louisville', 'Kentucky', '40225', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (51, '8 Forster Place', NULL, 'Louisville', 'Kentucky', '40256', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (52, '26323 Vidon Alley', NULL, 'Grand Rapids', 'Michigan', '49505', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (53, '8 Raven Court', NULL, 'Tallahassee', 'Florida', '32309', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (54, '75367 Farwell Way', NULL, 'Mesquite', 'Texas', '75185', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (55, '029 Jay Street', NULL, 'Englewood', 'Colorado', '80150', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (56, '01640 Clemons Court', NULL, 'Peoria', 'Arizona', '85383', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (57, '78346 Mcguire Parkway', NULL, 'Seattle', 'Washington', '98158', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (58, '5 Shasta Plaza', NULL, 'Arlington', 'Virginia', '22225', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (59, '43188 Mccormick Lane', NULL, 'Atlanta', 'Georgia', '30358', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (60, '308 Corry Terrace', NULL, 'Boston', 'Massachusetts', '02298', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (61, '028 Esker Place', NULL, 'Reno', 'Nevada', '89510', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (62, '9648 Bluestem Plaza', NULL, 'Santa Cruz', 'California', '95064', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (63, '3710 Vidon Court', NULL, 'Tampa', 'Florida', '33610', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (64, '31282 Carioca Place', NULL, 'Akron', 'Ohio', '44329', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (65, '7 Sunfield Lane', NULL, 'Jackson', 'Mississippi', '39296', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (66, '25577 Lake View Terrace', NULL, 'Houston', 'Texas', '77015', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (67, '86099 Monument Court', NULL, 'Knoxville', 'Tennessee', '37914', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (68, '8559 Sutteridge Drive', NULL, 'San Jose', 'California', '95108', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (69, '5006 Fairfield Avenue', NULL, 'Odessa', 'Texas', '79764', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (70, '1153 Evergreen Place', NULL, 'Jamaica', 'New York', '11480', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (71, '3547 Buhler Circle', NULL, 'Shreveport', 'Louisiana', '71115', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (72, '274 High Crossing Junction', NULL, 'Chicago', 'Illinois', '60604', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (73, '1 Stang Hill', NULL, 'Reno', 'Nevada', '89519', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (74, '71580 Prairie Rose Drive', NULL, 'Arlington', 'Virginia', '22212', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (75, '50 Crest Line Parkway', NULL, 'Louisville', 'Kentucky', '40233', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (76, '7870 Forster Court', NULL, 'Chicago', 'Illinois', '60624', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (77, '70 Grayhawk Terrace', NULL, 'Miami', 'Florida', '33245', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (78, '210 Magdeline Way', NULL, 'Phoenix', 'Arizona', '85040', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (79, '35 Kingsford Junction', NULL, 'Evansville', 'Indiana', '47732', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (80, '27829 Messerschmidt Terrace', NULL, 'Miami', 'Florida', '33185', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (81, '37916 Fairfield Trail', NULL, 'New York City', 'New York', '10009', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (82, '166 Manley Avenue', NULL, 'San Diego', 'California', '92186', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (83, '61733 Eliot Hill', NULL, 'Sacramento', 'California', '94297', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (84, '13 2nd Alley', NULL, 'Pittsburgh', 'Pennsylvania', '15261', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (85, '91691 Mandrake Court', NULL, 'San Francisco', 'California', '94147', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (86, '9 Thompson Point', NULL, 'Cincinnati', 'Ohio', '45213', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (87, '555 Rusk Alley', NULL, 'Albany', 'New York', '12210', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (88, '363 Prairie Rose Terrace', NULL, 'Pasadena', 'California', '91199', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (89, '50633 Carpenter Road', NULL, 'Tampa', 'Florida', '33694', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (90, '19205 Namekagon Center', NULL, 'Atlanta', 'Georgia', '30323', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (91, '827 Hollow Ridge Parkway', NULL, 'Jacksonville', 'Florida', '32259', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (92, '513 Bartelt Crossing', NULL, 'Port Saint Lucie', 'Florida', '34985', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (93, '43 Nobel Center', NULL, 'Atlanta', 'Georgia', '30356', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (94, '53 Manitowish Crossing', NULL, 'Pasadena', 'California', '91103', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (95, '9 Trailsway Parkway', NULL, 'Asheville', 'North Carolina', '28805', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (96, '6 Canary Hill', NULL, 'Tyler', 'Texas', '75705', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (97, '05 Schurz Way', NULL, 'Charlotte', 'North Carolina', '28278', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (98, '9 Sugar Road', NULL, 'San Diego', 'California', '92170', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (99, '12629 Brentwood Circle', NULL, 'Reno', 'Nevada', '89505', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (100, '1 Dottie Road', NULL, 'San Jose', 'California', '95150', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (101, '9812 Hollow Ridge Plaza', NULL, 'Albany', 'New York', '12205', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (102, '461 Goodland Place', NULL, 'North Las Vegas', 'Nevada', '89036', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (103, '50396 Knutson Court', NULL, 'Springfield', 'Illinois', '62794', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (104, '978 Riverside Point', NULL, 'Chicago', 'Illinois', '60674', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (105, '7 Vernon Point', NULL, 'Monticello', 'Minnesota', '55565', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (106, '129 Hallows Park', NULL, 'Corpus Christi', 'Texas', '78465', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (107, '8 Mcbride Pass', NULL, 'Schenectady', 'New York', '12325', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (108, '84618 Westport Parkway', NULL, 'Washington', 'District of Columbia', '20226', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (109, '8 Hauk Alley', NULL, 'Boise', 'Idaho', '83727', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (110, '199 Myrtle Avenue', NULL, 'Moreno Valley', 'California', '92555', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (111, '252 Burning Wood Terrace', NULL, 'Yakima', 'Washington', '98907', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (112, '0 Schlimgen Place', NULL, 'Salt Lake City', 'Utah', '84120', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (113, '008 Jenna Trail', NULL, 'Austin', 'Texas', '78703', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (114, '41192 Pennsylvania Plaza', NULL, 'Charlotte', 'North Carolina', '28215', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (115, '564 Pond Hill', NULL, 'Charleston', 'South Carolina', '29424', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (116, '80984 Artisan Trail', NULL, 'Sacramento', 'California', '94291', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (117, '8 5th Junction', NULL, 'Houston', 'Texas', '77005', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (118, '431 Old Gate Court', NULL, 'Colorado Springs', 'Colorado', '80905', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (119, '7 Summit Way', NULL, 'Rochester', 'New York', '14624', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (120, '9 Anthes Place', NULL, 'Buffalo', 'New York', '14269', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (121, '0 Hallows Circle', NULL, 'West Palm Beach', 'Florida', '33405', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (122, '15129 Fieldstone Lane', NULL, 'Stockton', 'California', '95205', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (123, '7428 Center Plaza', NULL, 'Silver Spring', 'Maryland', '20918', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (124, '6 Artisan Point', NULL, 'Schaumburg', 'Illinois', '60193', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (125, '937 Golden Leaf Street', NULL, 'Miami', 'Florida', '33190', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (126, '657 Logan Court', NULL, 'Springfield', 'Missouri', '65805', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (127, '9 Maywood Street', NULL, 'Topeka', 'Kansas', '66606', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (128, '466 Sunnyside Pass', NULL, 'Reno', 'Nevada', '89505', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (129, '459 Mariners Cove Street', NULL, 'Atlanta', 'Georgia', '31165', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (130, '6 Granby Pass', NULL, 'Shreveport', 'Louisiana', '71130', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (131, '53974 Pepper Wood Crossing', NULL, 'Kansas City', 'Missouri', '64130', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (132, '16759 Jenifer Avenue', NULL, 'Washington', 'District of Columbia', '20062', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (133, '40 Pine View Lane', NULL, 'Modesto', 'California', '95354', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (134, '01 Fordem Park', NULL, 'Berkeley', 'California', '94712', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (135, '591 Aberg Pass', NULL, 'Philadelphia', 'Pennsylvania', '19146', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (136, '580 Sachtjen Hill', NULL, 'Roanoke', 'Virginia', '24004', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (137, '9 Goodland Court', NULL, 'Fresno', 'California', '93709', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (138, '1568 American Park', NULL, 'Dallas', 'Texas', '75260', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (139, '4 Brentwood Alley', NULL, 'Rochester', 'New York', '14639', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (140, '83181 Farwell Hill', NULL, 'Peoria', 'Arizona', '85383', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (141, '3185 Clyde Gallagher Center', NULL, 'Arlington', 'Texas', '76096', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (142, '58 Beilfuss Parkway', NULL, 'Lexington', 'Kentucky', '40576', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (143, '289 Bayside Circle', NULL, 'Tucson', 'Arizona', '85720', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (144, '384 Boyd Point', NULL, 'Atlanta', 'Georgia', '30351', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (145, '0 Namekagon Way', NULL, 'Dearborn', 'Michigan', '48126', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (146, '0 Springview Pass', NULL, 'Charlotte', 'North Carolina', '28263', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (147, '27 Duke Pass', NULL, 'Atlanta', 'Georgia', '30323', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (148, '90891 Mockingbird Pass', NULL, 'Athens', 'Georgia', '30605', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (149, '0794 Butternut Road', NULL, 'Carlsbad', 'California', '92013', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (150, '60688 Talisman Court', NULL, 'North Las Vegas', 'Nevada', '89036', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (151, '44 North Center', NULL, 'Baltimore', 'Maryland', '21281', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (152, '6 Sachtjen Street', NULL, 'Wichita', 'Kansas', '67220', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (153, '3 Milwaukee Center', NULL, 'Huntington', 'West Virginia', '25770', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (154, '74496 Butternut Point', NULL, 'Hot Springs National Park', 'Arkansas', '71914', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (155, '826 Banding Hill', NULL, 'Baton Rouge', 'Louisiana', '70820', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (156, '7446 Jay Park', NULL, 'Duluth', 'Minnesota', '55805', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (157, '1 Elgar Avenue', NULL, 'El Paso', 'Texas', '88584', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (158, '6793 Erie Pass', NULL, 'Charleston', 'West Virginia', '25336', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (159, '47 Eastlawn Lane', NULL, 'Portland', 'Oregon', '97221', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (160, '8323 Cody Point', NULL, 'San Antonio', 'Texas', '78215', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (161, '988 Blaine Junction', NULL, 'San Jose', 'California', '95150', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (162, '666 Thackeray Park', NULL, 'Detroit', 'Michigan', '48258', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (163, '5 Crownhardt Lane', NULL, 'El Paso', 'Texas', '88514', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (164, '6 Roxbury Center', NULL, 'Minneapolis', 'Minnesota', '55423', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (165, '377 Fremont Center', NULL, 'Tulsa', 'Oklahoma', '74116', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (166, '18027 Merry Plaza', NULL, 'Berkeley', 'California', '94705', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (167, '4 Autumn Leaf Street', NULL, 'Pittsburgh', 'Pennsylvania', '15240', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (168, '4330 Transport Crossing', NULL, 'Phoenix', 'Arizona', '85062', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (169, '57108 Knutson Crossing', NULL, 'Waco', 'Texas', '76796', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (170, '602 Erie Way', NULL, 'Roanoke', 'Virginia', '24029', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (171, '29070 Banding Street', NULL, 'San Diego', 'California', '92160', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (172, '2 John Wall Point', NULL, 'Woburn', 'Massachusetts', '01813', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (173, '12364 Talmadge Drive', NULL, 'Houston', 'Texas', '77080', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (174, '2118 Boyd Way', NULL, 'Escondido', 'California', '92030', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (175, '5553 Banding Drive', NULL, 'Tallahassee', 'Florida', '32304', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (176, '9722 Jenna Street', NULL, 'El Paso', 'Texas', '79999', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (177, '67 Anthes Terrace', NULL, 'New Orleans', 'Louisiana', '70149', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (178, '0307 Prairie Rose Center', NULL, 'Fayetteville', 'North Carolina', '28314', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (179, '8700 Manitowish Plaza', NULL, 'Saint Louis', 'Missouri', '63104', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (180, '03 1st Parkway', NULL, 'Detroit', 'Michigan', '48232', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (181, '2 Mcguire Hill', NULL, 'Orange', 'California', '92668', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (182, '43 Prairieview Plaza', NULL, 'Orlando', 'Florida', '32854', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (183, '09 Westport Lane', NULL, 'Erie', 'Pennsylvania', '16550', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (184, '523 Lien Park', NULL, 'El Paso', 'Texas', '88574', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (185, '21 Dakota Way', NULL, 'Virginia Beach', 'Virginia', '23471', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (186, '3 Maywood Park', NULL, 'Cincinnati', 'Ohio', '45233', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (187, '8 Harper Street', NULL, 'Denver', 'Colorado', '80249', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (188, '85 Eliot Road', NULL, 'Brooklyn', 'New York', '11205', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (189, '049 West Park', NULL, 'Sacramento', 'California', '94263', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (190, '5802 Melrose Pass', NULL, 'Spokane', 'Washington', '99215', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (191, '11 8th Court', NULL, 'San Jose', 'California', '95133', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (192, '015 Crowley Parkway', NULL, 'College Station', 'Texas', '77844', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (193, '90 Raven Center', NULL, 'Detroit', 'Michigan', '48232', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (194, '70 Golden Leaf Hill', NULL, 'Asheville', 'North Carolina', '28815', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (195, '6814 Northview Terrace', NULL, 'San Antonio', 'Texas', '78205', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (196, '288 Swallow Way', NULL, 'Washington', 'District of Columbia', '20005', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (197, '0847 Kedzie Center', NULL, 'Cincinnati', 'Ohio', '45218', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (198, '41 Towne Crossing', NULL, 'Trenton', 'New Jersey', '08608', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (199, '75625 Fordem Avenue', NULL, 'Champaign', 'Illinois', '61825', 'United States');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (200, '08 Daystar Point', NULL, 'Boise', 'Idaho', '83716', 'United States');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (1, 'vivian@gmail.com', 'vivian', 'Vivian', 'Caethe', 1, 2, 1, '2013-05-08 06:47:43', '2014-02-09 09:48:56');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (2, 'alexis@gmail.com', 'alexis', 'Alexis', 'Low', 2, 2, 1, '2013-05-08 06:47:43', '2014-02-09 09:48:56');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (3, 'jen@gmail.com', 'jen', 'Jen', 'Veigel', 3, 2, 1, '2013-05-08 06:47:43', '2014-02-09 09:48:56');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (4, 'greg@gmail.com', 'greg', 'Greg', 'Norwood', 4, 2, 1, '2013-05-08 06:47:43', '2014-02-09 09:48:56');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (5, 'oollington0@rambler.ru', '111111', 'Olag', 'Ollington', 6, 1, 0, '2013-05-08 06:47:43', '2014-02-09 09:48:56');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (6, 'msoftley1@umich.edu', '123456', 'Madeleine', 'Softley', 20, 1, 0, '2010-10-18 23:13:48', '2015-09-20 18:43:17');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (7, 'jbrice2@pcworld.com', '123456', 'Jeannette', 'Brice', 17, 1, 0, '2017-11-01 09:13:26', '2016-12-05 23:17:22');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (8, 'kprobyn3@hubpages.com', '12345678', 'Koren', 'Probyn', 10, 1, 1, '2016-10-14 20:59:46', '2014-04-27 18:31:18');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (9, 'hhaller4@digg.com', 'password', 'Hilde', 'Haller', 27, 1, 0, '2015-05-09 00:43:39', '2011-07-29 12:35:32');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (10, 'vcottisford5@yolasite.com', '111111', 'Virge', 'Cottisford', 5, 1, 0, '2014-02-17 23:31:52', '2012-07-19 19:10:37');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (11, 'cpenbarthy6@forbes.com', '111111', 'Clea', 'Penbarthy', 4, 1, 0, '2013-07-07 22:57:20', '2011-02-25 22:40:10');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (12, 'gbonnin7@aboutads.info', 'dragon', 'Gran', 'Bonnin', 13, 1, 0, '2013-09-24 03:09:04', '2011-05-12 02:08:11');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (13, 'jhalbard8@army.mil', '123456', 'Joe', 'Halbard', 30, 1, 1, '2014-09-17 04:14:40', '2010-08-08 17:32:45');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (14, 'dspeedin9@linkedin.com', '1234567', 'Dre', 'Speedin', 26, 1, 1, '2012-01-13 22:36:31', '2013-06-01 23:55:24');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (15, 'daustinga@surveymonkey.com', 'password', 'Dory', 'Austing', 2, 1, 0, '2015-05-07 01:33:52', '2017-01-18 19:39:36');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (16, 'jwellesleyb@photobucket.com', '123456', 'Jennee', 'Wellesley', 30, 1, 1, '2015-03-11 07:03:02', '2013-03-05 07:12:16');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (17, 'iriepelc@rediff.com', 'qwerty', 'Ichabod', 'Riepel', 13, 1, 0, '2017-09-13 06:29:41', '2011-08-12 19:48:12');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (18, 'focarrand@walmart.com', '1234567', 'Fiona', 'O\'Carran', 27, 1, 0, '2016-04-19 12:52:02', '2013-02-13 19:02:49');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (19, 'vllewelline@lycos.com', '12345', 'Vick', 'Llewellin', 1, 1, 1, '2010-12-15 07:21:13', '2014-04-10 12:03:58');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (20, 'klazenburyf@e-recht24.de', 'qwerty', 'Kathy', 'Lazenbury', 16, 1, 1, '2014-12-13 06:46:10', '2017-05-07 23:38:07');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (21, 'tperrygog@sphinn.com', '12345', 'Thorpe', 'Perrygo', 13, 1, 1, '2017-04-12 07:17:41', '2015-01-01 07:23:44');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (22, 'acorrieah@epa.gov', '123456789', 'Agnese', 'Corriea', 13, 1, 1, '2011-12-06 20:00:44', '2017-08-05 22:38:18');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (23, 'erawei@discuz.net', 'dragon', 'Elianora', 'Rawe', 11, 1, 1, '2010-12-21 04:11:37', '2013-11-27 13:04:07');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (24, 'cmacterrellyj@nbcnews.com', '1234', 'Colly', 'MacTerrelly', 9, 1, 0, '2012-04-28 01:28:38', '2014-07-07 10:06:46');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (25, 'swrigleyk@sphinn.com', '123456789', 'Seth', 'Wrigley', 3, 1, 1, '2017-08-03 00:59:38', '2014-09-25 23:41:22');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (26, 'cgodberl@fema.gov', '123456789', 'Chrystal', 'Godber', 16, 1, 0, '2013-10-22 04:17:54', '2011-09-09 21:30:42');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (27, 'ljonesm@dion.ne.jp', 'dragon', 'Lissi', 'Jones', 21, 1, 0, '2013-09-04 03:51:21', '2012-12-27 04:10:05');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (28, 'dphizackarleyn@wired.com', 'qwerty', 'Demetris', 'Phizackarley', 28, 1, 0, '2011-12-16 15:32:14', '2017-09-01 10:54:02');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (29, 'amansello@163.com', '12345678', 'Amby', 'Mansell', 10, 1, 0, '2011-05-25 08:16:56', '2014-09-07 14:17:44');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (30, 'dwoodyerp@ezinearticles.com', '12345678', 'Dyane', 'Woodyer', 15, 1, 1, '2013-09-29 23:27:20', '2015-09-11 03:32:30');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (31, 'ashadrachq@goodreads.com', 'dragon', 'Arin', 'Shadrach', 22, 1, 1, '2011-03-11 09:07:48', '2011-08-07 03:37:12');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (32, 'doleksinskir@irs.gov', '123456', 'Dev', 'Oleksinski', 8, 1, 0, '2012-03-26 01:47:21', '2017-06-08 18:29:14');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (33, 'reklesss@hugedomains.com', 'password', 'Rosabel', 'Ekless', 23, 1, 0, '2012-06-24 14:23:11', '2014-05-21 01:46:28');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (34, 'cwanstallt@4shared.com', 'dragon', 'Corny', 'Wanstall', 17, 1, 1, '2016-04-08 19:12:20', '2010-05-01 07:54:49');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (35, 'trobbinsu@jugem.jp', '123456', 'Theresita', 'Robbins', 30, 1, 1, '2010-07-15 17:06:38', '2014-07-16 18:44:16');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (36, 'ftretterv@sitemeter.com', 'dragon', 'Flemming', 'Tretter', 22, 1, 1, '2016-06-18 10:49:28', '2017-07-05 07:21:27');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (37, 'jollew@mlb.com', 'dragon', 'Jameson', 'Olle', 10, 1, 0, '2012-07-03 10:22:32', '2012-02-28 01:30:51');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (38, 'apyffex@usatoday.com', '12345678', 'Alley', 'Pyffe', 2, 1, 1, '2013-06-08 21:53:53', '2013-03-24 20:28:13');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (39, 'npenswicky@auda.org.au', '1234', 'Naomi', 'Penswick', 5, 1, 0, '2017-08-07 09:28:09', '2011-06-11 22:44:58');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (40, 'gcrumbleholmez@spotify.com', '12345678', 'Gail', 'Crumbleholme', 1, 1, 1, '2012-03-18 08:23:55', '2010-03-23 23:43:00');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (41, 'pflux10@moonfruit.com', 'password', 'Pippy', 'Flux', 13, 1, 0, '2011-01-28 00:31:24', '2015-10-04 10:55:39');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (42, 'aludwikiewicz11@smh.com.au', 'dragon', 'Aurthur', 'Ludwikiewicz', 14, 1, 1, '2013-01-04 07:09:26', '2011-09-08 17:12:12');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (43, 'fjosselsohn12@twitpic.com', 'password', 'Fairleigh', 'Josselsohn', 26, 1, 0, '2010-05-17 21:09:55', '2016-09-03 14:14:03');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (44, 'dslyne13@nymag.com', '111111', 'Dael', 'Slyne', 8, 1, 1, '2010-04-22 09:03:16', '2016-11-12 10:10:33');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (45, 'awogden14@hugedomains.com', '1234', 'Alejandra', 'Wogden', 10, 1, 0, '2016-11-04 12:56:31', '2011-04-22 13:06:27');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (46, 'lkerley15@feedburner.com', 'password', 'Luke', 'Kerley', 23, 1, 0, '2013-07-07 04:13:48', '2014-01-14 20:30:36');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (47, 'ddoddridge16@ebay.com', 'qwerty', 'Dame', 'Doddridge', 13, 1, 0, '2013-03-10 13:41:08', '2015-11-10 15:06:41');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (48, 'droche17@xrea.com', '123456789', 'Deny', 'Roche', 10, 1, 1, '2016-10-18 07:12:53', '2016-02-12 06:20:34');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (49, 'vmichieli18@ihg.com', '123456789', 'Vin', 'Michieli', 1, 1, 1, '2010-05-20 21:24:41', '2014-10-07 00:49:24');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (50, 'rrawls19@studiopress.com', '1234567', 'Rene', 'Rawls', 7, 1, 1, '2012-04-12 19:26:33', '2011-04-22 00:03:40');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (51, 'sedington1a@blinklist.com', 'qwerty', 'Stu', 'Edington', 19, 1, 0, '2011-01-17 19:09:17', '2014-05-15 02:59:40');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (52, 'bisaacs1b@salon.com', '123456', 'Barbra', 'Isaacs', 5, 1, 1, '2016-08-15 15:11:26', '2012-03-25 21:14:56');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (53, 'dpoveleye1c@weebly.com', '12345', 'Dukie', 'Poveleye', 30, 1, 0, '2012-12-03 06:03:03', '2013-11-22 11:05:32');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (54, 'sfallowes1d@plala.or.jp', '1234', 'Samantha', 'Fallowes', 1, 1, 1, '2014-01-03 06:40:16', '2015-05-21 07:42:47');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (55, 'fklainer1e@wufoo.com', '12345678', 'Frances', 'Klainer', 13, 1, 1, '2017-10-05 17:47:17', '2013-07-14 15:01:08');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (56, 'lleeson1f@livejournal.com', '123456789', 'Lynnett', 'Leeson', 6, 1, 0, '2010-11-10 06:15:37', '2014-01-19 17:55:23');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (57, 'aambrogini1g@deliciousdays.com', 'dragon', 'Andee', 'Ambrogini', 8, 1, 0, '2017-09-11 06:29:13', '2013-11-07 04:57:17');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (58, 'vfells1h@123-reg.co.uk', '12345', 'Vally', 'Fells', 20, 1, 1, '2013-03-04 00:31:55', '2013-02-18 20:21:00');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (59, 'sgoulborne1i@netlog.com', '123456', 'Shela', 'Goulborne', 12, 1, 1, '2015-10-10 13:28:05', '2013-06-10 00:46:30');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (60, 'fcorr1j@amazonaws.com', 'dragon', 'Fee', 'Corr', 15, 1, 1, '2012-04-08 02:26:43', '2010-06-11 11:26:53');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (61, 'mbackshill1k@bandcamp.com', 'password', 'Marian', 'Backshill', 1, 1, 0, '2017-05-02 12:49:33', '2010-07-13 02:16:58');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (62, 'mlloydwilliams1l@360.cn', '1234', 'Monika', 'Lloyd-Williams', 30, 1, 0, '2015-09-28 03:59:47', '2017-01-07 00:16:39');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (63, 'hschankelborg1m@1und1.de', '123456789', 'Holli', 'Schankelborg', 8, 1, 0, '2010-09-18 16:15:45', '2012-04-19 14:36:14');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (64, 'fdrysdell1n@nydailynews.com', 'dragon', 'Frederich', 'Drysdell', 25, 1, 0, '2012-07-13 01:58:26', '2015-11-05 22:33:07');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (65, 'cgammill1o@qq.com', '1234', 'Cynthie', 'Gammill', 28, 1, 1, '2015-10-03 01:30:09', '2010-02-25 06:43:42');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (66, 'bcoe1p@nature.com', '111111', 'Byrann', 'Coe', 24, 1, 0, '2010-07-21 02:11:55', '2017-08-20 06:09:03');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (67, 'bpoyntz1q@scientificamerican.com', '111111', 'Brandise', 'Poyntz', 25, 1, 0, '2012-02-01 17:17:49', '2012-01-08 06:09:15');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (68, 'wtootal1r@independent.co.uk', '1234', 'Warden', 'Tootal', 16, 1, 0, '2013-09-19 04:13:09', '2017-02-08 00:38:54');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (69, 'cwestoff1s@accuweather.com', '123456789', 'Chrissy', 'Westoff', 24, 1, 0, '2013-10-18 23:58:03', '2010-01-15 11:13:59');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (70, 'wslarke1t@woothemes.com', '1234', 'Waylon', 'Slarke', 2, 1, 0, '2015-07-01 07:44:55', '2011-05-26 12:36:16');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (71, 'jscramage1u@hexun.com', 'password', 'Johannah', 'Scramage', 28, 1, 0, '2017-07-26 16:25:09', '2015-06-28 09:17:14');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (72, 'fgierth1v@bloomberg.com', '123456', 'Fanechka', 'Gierth', 27, 1, 0, '2017-11-03 22:22:06', '2016-06-19 05:35:49');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (73, 'kabramski1w@51.la', '123456', 'Kym', 'Abramski', 18, 1, 0, '2016-11-22 14:25:34', '2013-07-15 15:52:16');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (74, 'mmitskevich1x@census.gov', '1234567', 'Mattie', 'Mitskevich', 14, 1, 0, '2015-11-23 00:27:50', '2015-09-18 00:16:00');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (75, 'wlathe1y@psu.edu', '12345678', 'Worthy', 'Lathe', 9, 1, 1, '2013-11-09 22:56:12', '2016-07-16 13:25:32');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (76, 'bhenighan1z@admin.ch', '1234567', 'Bobbette', 'Henighan', 15, 1, 0, '2011-11-30 21:12:18', '2013-12-14 13:55:09');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (77, 'wspooner20@unicef.org', 'dragon', 'Wrennie', 'Spooner', 19, 1, 0, '2016-10-04 00:45:14', '2015-02-18 05:02:54');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (78, 'mvalenssmith21@wikipedia.org', '12345', 'Merrick', 'Valens-Smith', 7, 1, 1, '2012-11-17 06:33:40', '2017-01-19 07:05:28');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (79, 'vgleadhell22@time.com', 'password', 'Vic', 'Gleadhell', 2, 1, 0, '2017-11-09 19:33:33', '2016-08-08 21:39:29');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (80, 'bkaradzas23@51.la', '111111', 'Boone', 'Karadzas', 4, 1, 0, '2013-05-29 17:51:57', '2014-03-17 06:10:32');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (81, 'abruni24@instagram.com', '123456', 'Ariadne', 'Bruni', 19, 1, 1, '2017-05-19 05:02:40', '2017-06-06 19:24:20');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (82, 'bchamberlin25@shinystat.com', '123456', 'Bradford', 'Chamberlin', 30, 1, 0, '2016-03-25 10:38:37', '2016-07-08 21:09:06');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (83, 'ckuzma26@liveinternet.ru', '111111', 'Christel', 'Kuzma', 25, 1, 1, '2011-11-18 11:12:37', '2014-07-28 23:36:21');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (84, 'khanbridge27@gizmodo.com', '12345', 'Kippie', 'Hanbridge', 17, 1, 1, '2010-07-29 19:58:39', '2012-05-17 07:34:20');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (85, 'wschroter28@amazon.co.uk', 'qwerty', 'Wenonah', 'Schroter', 20, 1, 0, '2013-04-02 03:39:30', '2016-04-27 13:03:50');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (86, 'brough29@aboutads.info', '1234567', 'Barr', 'Rough', 4, 1, 1, '2014-11-21 13:28:42', '2017-01-18 10:20:50');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (87, 'gjedrasik2a@salon.com', '12345', 'Gabriell', 'Jedrasik', 2, 1, 1, '2012-02-23 14:46:57', '2015-12-09 12:45:58');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (88, 'zwasmer2b@reuters.com', '123456789', 'Zondra', 'Wasmer', 9, 1, 1, '2011-09-05 09:44:47', '2016-01-26 08:21:59');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (89, 'mcowitz2c@sbwire.com', 'dragon', 'Mabel', 'Cowitz', 22, 1, 0, '2015-07-12 16:12:36', '2011-12-17 12:19:44');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (90, 'fbachelar2d@devhub.com', '12345678', 'Federico', 'Bachelar', 16, 1, 1, '2015-03-10 18:19:14', '2016-04-02 02:50:03');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (91, 'mdanilov2e@noaa.gov', 'password', 'Miguela', 'Danilov', 21, 1, 0, '2014-02-07 14:49:47', '2010-02-21 09:12:14');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (92, 'jweatherdon2f@nature.com', '111111', 'Joscelin', 'Weatherdon', 14, 1, 0, '2010-06-06 03:52:13', '2013-05-24 10:35:33');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (93, 'jvaughton2g@squidoo.com', '12345', 'Jenelle', 'Vaughton', 26, 1, 1, '2013-12-01 05:39:23', '2012-04-26 00:42:14');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (94, 'ebarday2h@twitter.com', 'qwerty', 'Egon', 'Barday', 6, 1, 0, '2017-04-07 22:27:21', '2014-05-12 20:57:53');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (95, 'bdonaghie2i@yelp.com', 'dragon', 'Boy', 'Donaghie', 12, 1, 0, '2012-03-27 02:31:46', '2011-09-19 13:45:25');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (96, 'spigdon2j@e-recht24.de', '123456', 'Starlene', 'Pigdon', 22, 1, 0, '2013-05-17 11:39:26', '2017-02-23 19:02:08');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (97, 'vonge2k@goo.gl', '1234', 'Virgil', 'Onge', 20, 1, 0, '2013-11-02 13:12:09', '2012-04-17 17:57:18');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (98, 'kebdon2l@1und1.de', '111111', 'Kameko', 'Ebdon', 25, 1, 0, '2015-04-20 06:28:33', '2013-12-22 02:31:25');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (99, 'nsacco2m@vkontakte.ru', '1234', 'Nedda', 'Sacco', 12, 1, 1, '2010-10-07 13:51:56', '2010-11-17 23:33:36');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (100, 'sbullingham2n@mysql.com', '1234', 'Stefa', 'Bullingham', 8, 1, 1, '2011-04-11 12:07:30', '2011-03-28 03:41:50');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (101, 'dmithan2o@mlb.com', 'qwerty', 'Dunstan', 'Mithan', 1, 1, 1, '2013-05-28 11:36:54', '2013-09-17 13:25:50');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (102, 'tkibbye2p@microsoft.com', '1234', 'Tiphani', 'Kibbye', 20, 1, 1, '2017-06-23 10:18:42', '2012-03-13 18:45:19');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (103, 'gbean2q@odnoklassniki.ru', '123456', 'Grata', 'Bean', 9, 1, 0, '2017-08-09 08:57:12', '2016-01-17 22:15:07');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (104, 'ptyrrell2r@globo.com', '12345678', 'Peyter', 'Tyrrell', 28, 1, 1, '2010-10-15 17:17:04', '2010-12-15 23:48:09');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (105, 'anani2s@sciencedirect.com', 'qwerty', 'Astra', 'Nani', 2, 1, 1, '2016-09-01 18:50:26', '2016-09-27 18:14:16');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (106, 'klonergan2t@whitehouse.gov', 'dragon', 'Keefe', 'Lonergan', 12, 1, 0, '2013-10-19 06:22:53', '2015-04-09 05:07:24');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (107, 'ocapstick2u@tinyurl.com', '12345678', 'Osborn', 'Capstick', 29, 1, 0, '2015-06-23 15:53:24', '2014-11-14 12:18:17');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (108, 'jwilmut2v@so-net.ne.jp', 'dragon', 'Joyous', 'Wilmut', 14, 1, 1, '2015-05-02 21:55:27', '2014-01-15 21:20:01');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (109, 'carkow2w@craigslist.org', '123456', 'Celia', 'Arkow', 12, 1, 1, '2014-07-15 03:55:31', '2012-06-19 09:26:02');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (110, 'lriseborough2x@multiply.com', '123456', 'Lynsey', 'Riseborough', 2, 1, 0, '2013-05-08 21:50:03', '2010-09-20 23:34:00');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (111, 'gullett2y@harvard.edu', '1234', 'Gunner', 'Ullett', 10, 1, 0, '2016-06-23 18:43:15', '2016-03-24 12:16:15');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (112, 'qmorrilly2z@360.cn', '1234567', 'Quinlan', 'Morrilly', 11, 1, 1, '2011-08-07 07:32:01', '2017-12-30 17:52:15');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (113, 'jolive30@nbcnews.com', 'dragon', 'Jacinthe', 'Olive', 13, 1, 0, '2013-08-16 00:12:52', '2016-12-05 05:55:43');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (114, 'gmellodey31@cyberchimps.com', '123456789', 'Giraldo', 'Mellodey', 18, 1, 1, '2010-07-09 18:17:42', '2014-08-03 17:20:33');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (115, 'fhindrick32@artisteer.com', 'qwerty', 'Fidelity', 'Hindrick', 29, 1, 1, '2011-11-01 22:39:56', '2016-02-27 07:11:45');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (116, 'fallchorne33@blinklist.com', '111111', 'Flora', 'Allchorne', 3, 1, 1, '2012-01-04 11:05:50', '2010-06-19 15:59:15');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (117, 'wastbury34@goodreads.com', 'dragon', 'Wilbur', 'Astbury', 18, 1, 1, '2014-05-18 20:51:58', '2012-03-11 00:01:16');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (118, 'vturney35@nifty.com', '123456', 'Virgina', 'Turney', 11, 1, 0, '2015-11-29 19:58:09', '2013-02-20 06:34:40');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (119, 'ginnocenti36@phpbb.com', '12345', 'Griff', 'Innocenti', 25, 1, 0, '2012-02-02 19:55:36', '2010-03-25 20:35:29');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (120, 'hshillaker37@squarespace.com', '12345678', 'Hope', 'Shillaker', 18, 1, 0, '2011-05-06 23:23:00', '2016-05-03 12:57:13');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (121, 'wburkwood38@cisco.com', '1234567', 'Winnifred', 'Burkwood', 7, 1, 1, '2015-10-18 08:30:24', '2017-03-19 21:41:05');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (122, 'orosenblatt39@smh.com.au', '123456', 'Olivia', 'Rosenblatt', 2, 1, 0, '2011-02-12 11:32:35', '2016-06-23 22:06:07');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (123, 'thowardgater3a@tiny.cc', '12345', 'Tracy', 'Howard - Gater', 4, 1, 1, '2015-02-01 17:25:54', '2015-02-10 22:10:39');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (124, 'kputtrell3b@infoseek.co.jp', '123456', 'Kaye', 'Puttrell', 23, 1, 1, '2015-11-21 10:28:51', '2017-09-01 21:25:37');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (125, 'ggrestie3c@theatlantic.com', '1234567', 'Gearalt', 'Grestie', 21, 1, 1, '2017-07-27 20:50:34', '2014-03-21 20:55:12');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (126, 'zcarillo3d@studiopress.com', 'password', 'Zebulon', 'Carillo', 18, 1, 0, '2012-03-22 23:52:23', '2010-07-16 12:01:24');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (127, 'rgillooly3e@addthis.com', '1234567', 'Robbie', 'Gillooly', 9, 1, 1, '2012-04-20 13:53:12', '2017-09-20 10:26:09');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (128, 'ctolliday3f@thetimes.co.uk', '1234567', 'Culley', 'Tolliday', 17, 1, 0, '2013-03-29 13:16:47', '2011-06-19 21:17:46');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (129, 'cchiene3g@stumbleupon.com', '1234567', 'Christiane', 'Chiene', 18, 1, 1, '2015-07-02 14:41:42', '2016-01-10 15:30:14');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (130, 'hglason3h@umich.edu', 'qwerty', 'Helene', 'Glason', 23, 1, 0, '2011-04-08 20:15:12', '2011-01-14 07:07:26');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (131, 'wmosby3i@w3.org', '123456789', 'Westley', 'Mosby', 3, 1, 1, '2016-10-02 11:17:20', '2012-01-02 06:29:59');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (132, 'sgillian3j@nhs.uk', '1234567', 'Suzie', 'Gillian', 22, 1, 0, '2013-10-30 02:43:10', '2015-06-29 23:14:19');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (133, 'dsanchiz3k@jugem.jp', 'password', 'Donny', 'Sanchiz', 1, 1, 1, '2014-01-08 13:09:20', '2010-08-14 20:23:53');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (134, 'kleynton3l@friendfeed.com', 'qwerty', 'Kristofor', 'Leynton', 30, 1, 0, '2011-03-28 21:29:05', '2012-10-04 05:56:45');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (135, 'bdwelly3m@squidoo.com', '111111', 'Bebe', 'Dwelly', 26, 1, 1, '2015-05-08 07:51:23', '2012-06-22 12:47:10');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (136, 'jbulfoy3n@angelfire.com', '1234567', 'Jonell', 'Bulfoy', 18, 1, 1, '2016-01-14 00:36:54', '2010-02-22 03:51:54');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (137, 'jkeysall3o@hao123.com', '12345', 'Jaquenette', 'Keysall', 3, 1, 0, '2013-02-03 07:05:55', '2011-04-17 00:07:28');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (138, 'ldrinkwater3p@imdb.com', 'qwerty', 'Lars', 'Drinkwater', 7, 1, 0, '2016-10-19 02:31:21', '2017-01-23 03:08:56');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (139, 'vpressey3q@cpanel.net', '111111', 'Valaria', 'Pressey', 23, 1, 1, '2014-08-04 02:44:06', '2013-05-27 20:22:40');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (140, 'cwayte3r@slate.com', '12345678', 'Carlie', 'Wayte', 10, 1, 1, '2013-07-20 08:49:25', '2010-03-20 06:00:47');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (141, 'asidaway3s@macromedia.com', '123456789', 'Arney', 'Sidaway', 13, 1, 1, '2014-05-31 20:50:05', '2013-08-21 19:33:10');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (142, 'dpayne3t@uol.com.br', 'qwerty', 'Dniren', 'Payne', 21, 1, 1, '2011-08-15 17:34:22', '2012-02-24 00:24:11');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (143, 'cbickell3u@about.me', '123456', 'Chrysa', 'Bickell', 14, 1, 0, '2011-06-24 09:07:47', '2014-11-05 05:06:09');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (144, 'adutnall3v@google.fr', '1234567', 'Andie', 'Dutnall', 19, 1, 1, '2015-03-22 07:14:08', '2012-10-23 05:21:25');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (145, 'olauritsen3w@prlog.org', '123456789', 'Obed', 'Lauritsen', 21, 1, 0, '2011-12-10 10:50:45', '2014-09-03 07:00:47');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (146, 'wbatrop3x@ca.gov', '123456789', 'Winny', 'Batrop', 16, 1, 1, '2014-05-19 13:25:10', '2010-03-08 04:20:38');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (147, 'shand3y@quantcast.com', '12345678', 'Shirline', 'Hand', 3, 1, 1, '2015-08-03 10:08:22', '2010-01-21 19:00:24');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (148, 'astockow3z@redcross.org', '12345', 'Annabelle', 'Stockow', 9, 1, 0, '2015-03-18 02:57:02', '2012-02-26 16:12:27');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (149, 'dkalvin40@nps.gov', '1234567', 'Doyle', 'Kalvin', 9, 1, 1, '2010-07-28 00:25:14', '2014-08-12 17:31:45');
INSERT INTO `user` (`id`, `email`, `pwd`, `first_name`, `last_name`, `address_id`, `permission_level`, `active`, `created_date`, `last_update`) VALUES (150, 'sfeavearyear41@loc.gov', '123456789', 'Stephie', 'Feavearyear', 11, 1, 1, '2013-05-13 20:02:55', '2011-10-17 15:08:05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `job`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (1, 43, 'Kare', 'Developer II', 'http://cornell.edu/eget/eros/elementum/pellentesque/quisque/porta.aspx', 18, 67674, 1, '2010-04-27 17:10:14', '2018-05-16', '2017-06-23 20:28:57', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (2, 41, 'Tambee', 'Statistician IV', 'http://newsvine.com/libero/nam.aspx', 27, 63275, 1, '2010-12-12 12:48:24', '2018-09-26', '2017-08-29 13:46:05', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (3, 30, 'Quinu', 'Food Chemist', 'https://nature.com/nulla/pede/ullamcorper/augue/a/suscipit.png', 3, 45923, 1, '2010-04-11 09:08:56', '2018-01-25', '2017-12-26 19:06:20', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (4, 69, 'Jaxbean', 'Clinical Specialist', 'http://slate.com/odio/cras/mi/pede/malesuada.js', 22, 83419, 1, '2010-07-14 02:18:40', '2018-08-07', '2017-03-06 15:39:35', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (5, 10, 'Latz', 'Statistician III', 'https://networksolutions.com/vestibulum/vestibulum/ante/ipsum/primis.aspx', 19, 38773, 1, '2010-09-01 04:22:36', '2018-08-12', '2017-01-30 00:23:13', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (6, 72, 'Camido', 'Business Systems Development Analyst', 'http://netvibes.com/est/congue/elementum/in/hac/habitasse/platea.png', 23, 59755, 1, '2010-12-17 17:41:08', '2018-11-24', '2017-08-06 18:30:29', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (7, 87, 'Quire', 'Community Outreach Specialist', 'https://accuweather.com/sollicitudin.jpg', 17, 87512, 1, '2010-11-22 03:05:15', '2018-08-22', '2017-05-22 06:46:52', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (8, 3, 'Mybuzz', 'Account Representative III', 'https://census.gov/aenean/sit/amet/justo/morbi.jsp', 4, 94042, 1, '2010-05-17 19:49:03', '2018-08-02', '2017-06-14 10:07:34', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (9, 86, 'Mynte', 'Recruiter', 'https://amazon.co.jp/montes.jpg', 21, 38050, 1, '2010-02-01 11:53:09', '2018-08-18', '2017-12-07 14:01:55', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (10, 25, 'Voonyx', 'Clinical Specialist', 'http://tinyurl.com/in/consequat/ut/nulla/sed.json', 20, 90125, 1, '2010-12-26 19:56:15', '2018-05-27', '2017-05-10 19:05:10', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (11, 99, 'Einti', 'GIS Technical Architect', 'https://blinklist.com/pede.png', 19, 54883, 1, '2010-05-20 16:35:55', '2018-04-19', '2017-10-29 04:31:24', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (12, 86, 'Mymm', 'Professor', 'http://apple.com/aenean/auctor/gravida/sem/praesent/id.aspx', 11, 60490, 1, '2010-03-02 08:14:12', '2018-03-27', '2017-07-25 20:07:07', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (13, 100, 'Aivee', 'VP Marketing', 'https://behance.net/fusce.js', 6, 36115, 1, '2010-10-01 08:58:10', '2018-09-19', '2017-11-18 23:38:24', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (14, 26, 'Thoughtworks', 'Business Systems Development Analyst', 'http://hostgator.com/ac/neque/duis/bibendum/morbi/non/quam.aspx', 2, 37178, 1, '2010-07-10 05:22:05', '2018-08-17', '2017-12-21 17:30:38', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (15, 70, 'Twiyo', 'GIS Technical Architect', 'https://unc.edu/nulla/tellus/in/sagittis.xml', 11, 34259, 1, '2010-06-08 12:24:58', '2018-03-20', '2017-03-20 14:23:29', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (16, 64, 'Yotz', 'Mechanical Systems Engineer', 'http://ustream.tv/integer/a/nibh/in/quis/justo/maecenas.jpg', 11, 60752, 1, '2010-07-09 19:45:04', '2018-09-07', '2017-03-11 01:38:48', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (17, 38, 'Teklist', 'Senior Sales Associate', 'http://printfriendly.com/vestibulum/sagittis/sapien/cum/sociis/natoque.jsp', 8, 39746, 1, '2010-05-08 20:52:04', '2018-12-18', '2017-03-01 03:59:40', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (18, 49, 'Jabberstorm', 'Associate Professor', 'http://marketwatch.com/pede/lobortis/ligula.jpg', 1, 38386, 1, '2010-02-16 16:50:55', '2018-07-31', '2017-03-13 23:15:14', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (19, 30, 'Yata', 'Analog Circuit Design manager', 'http://so-net.ne.jp/neque/vestibulum/eget/vulputate/ut.json', 16, 71079, 1, '2010-03-28 20:39:00', '2018-04-25', '2017-06-23 16:14:29', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (20, 6, 'Babbleopia', 'Social Worker', 'http://dyndns.org/volutpat.png', 2, 38530, 1, '2010-11-09 11:29:10', '2018-09-19', '2017-09-21 05:41:14', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (21, 99, 'Brainlounge', 'Administrative Assistant I', 'https://cornell.edu/porta/volutpat/quam/pede/lobortis/ligula.json', 21, 79237, 1, '2010-02-02 21:28:45', '2018-12-05', '2017-08-22 05:23:47', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (22, 48, 'Browsecat', 'Software Engineer III', 'http://ow.ly/sed/interdum/venenatis/turpis/enim/blandit.js', 1, 79344, 1, '2010-08-28 10:32:40', '2018-12-16', '2017-05-09 21:14:20', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (23, 63, 'Pixoboo', 'Actuary', 'http://cloudflare.com/dictumst/aliquam/augue/quam.xml', 27, 99450, 1, '2010-05-18 05:00:19', '2018-11-12', '2017-09-13 17:57:17', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (24, 47, 'Youfeed', 'Cost Accountant', 'http://weebly.com/hac/habitasse/platea/dictumst/etiam.png', 20, 77471, 1, '2010-06-17 13:29:10', '2018-09-19', '2017-08-26 13:42:01', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (25, 51, 'Zoomdog', 'Environmental Tech', 'http://webmd.com/at/ipsum.aspx', 9, 63062, 1, '2010-08-17 12:58:44', '2018-09-13', '2017-09-14 13:27:07', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (26, 41, 'Ooba', 'Senior Quality Engineer', 'https://360.cn/varius/ut/blandit/non/interdum/in.aspx', 24, 33870, 1, '2010-09-13 10:48:30', '2018-04-30', '2017-05-30 06:15:07', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (27, 69, 'Thoughtworks', 'GIS Technical Architect', 'http://drupal.org/non/velit/nec/nisi.json', 27, 37046, 1, '2010-12-14 22:00:53', '2018-02-19', '2017-03-10 07:22:42', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (28, 99, 'Yodo', 'Technical Writer', 'https://alexa.com/quam/sapien/varius.aspx', 14, 71553, 1, '2010-03-10 16:19:44', '2018-02-24', '2017-05-07 17:09:02', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (29, 81, 'Voomm', 'VP Marketing', 'https://seattletimes.com/ut/massa/volutpat.js', 29, 42736, 1, '2010-11-24 09:44:00', '2018-07-14', '2017-06-16 03:53:11', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (30, 70, 'Fliptune', 'Business Systems Development Analyst', 'https://mayoclinic.com/placerat/praesent/blandit/nam.png', 15, 76195, 1, '2010-04-05 11:05:16', '2018-08-04', '2017-03-08 09:31:25', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (31, 22, 'Vidoo', 'Teacher', 'http://de.vu/sapien/non/mi/integer/ac.jpg', 18, 64020, 1, '2010-10-17 19:18:25', '2018-05-20', '2017-02-18 19:50:31', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (32, 92, 'Meejo', 'Senior Developer', 'https://123-reg.co.uk/quisque/porta/volutpat/erat/quisque/erat/eros.html', 8, 77643, 1, '2010-06-30 00:51:02', '2018-04-29', '2017-10-14 00:03:05', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (33, 21, 'Skyba', 'Chemical Engineer', 'http://hud.gov/tortor/quis/turpis/sed.aspx', 24, 30384, 1, '2010-02-09 10:04:32', '2018-12-11', '2017-12-27 20:32:33', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (34, 37, 'Skipstorm', 'Software Consultant', 'http://wikimedia.org/duis/faucibus/accumsan.jpg', 16, 34237, 1, '2010-05-07 09:44:18', '2018-10-09', '2017-08-13 11:10:48', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (35, 41, 'Zoonoodle', 'Sales Associate', 'http://census.gov/posuere/cubilia/curae/duis/faucibus.html', 14, 68880, 1, '2010-08-06 19:14:56', '2018-06-05', '2017-09-13 07:30:52', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (36, 100, 'Livefish', 'Web Designer IV', 'http://vinaora.com/ut/nulla/sed/accumsan/felis.html', 20, 99341, 1, '2010-02-06 04:20:53', '2018-08-10', '2017-04-22 00:33:16', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (37, 74, 'Pixope', 'Marketing Assistant', 'https://uol.com.br/ac/consequat/metus/sapien.jsp', 9, 41631, 1, '2010-04-15 01:47:51', '2018-11-20', '2017-06-18 09:40:01', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (38, 38, 'Plajo', 'Speech Pathologist', 'http://typepad.com/id/consequat/in/consequat/ut.js', 18, 37781, 1, '2010-09-02 14:17:53', '2018-03-10', '2017-09-17 03:18:20', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (39, 97, 'Tekfly', 'Social Worker', 'https://ifeng.com/consequat/nulla/nisl/nunc/nisl/duis/bibendum.json', 23, 58865, 1, '2010-03-02 06:05:58', '2018-05-02', '2017-03-28 23:05:13', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (40, 91, 'Yamia', 'Nuclear Power Engineer', 'https://vk.com/vivamus/in/felis.json', 16, 41301, 1, '2010-09-06 03:26:06', '2018-09-03', '2017-04-22 02:15:40', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (41, 4, 'Buzzdog', 'Analog Circuit Design manager', 'http://barnesandnoble.com/sed/lacus/morbi/sem/mauris/laoreet/ut.png', 25, 45949, 1, '2010-06-20 18:56:53', '2018-08-31', '2017-07-06 14:06:01', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (42, 88, 'Topicware', 'VP Sales', 'http://bigcartel.com/vel/dapibus/at/diam/nam/tristique.js', 5, 56178, 1, '2010-07-10 04:54:29', '2018-10-22', '2017-01-17 19:45:48', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (43, 33, 'Oyoloo', 'Analog Circuit Design manager', 'http://senate.gov/nam/tristique/tortor/eu/pede.js', 2, 57743, 1, '2010-07-08 15:35:04', '2018-12-21', '2017-07-07 16:40:40', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (44, 42, 'Eayo', 'Software Consultant', 'http://twitpic.com/eu/nibh/quisque/id.jsp', 19, 40831, 1, '2010-06-23 12:32:46', '2018-01-27', '2017-05-06 20:46:27', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (45, 58, 'Meevee', 'Occupational Therapist', 'http://t.co/sapien/placerat/ante/nulla/justo/aliquam.png', 6, 42375, 1, '2010-02-12 04:55:07', '2018-04-19', '2017-10-14 12:02:09', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (46, 55, 'Gigaclub', 'Senior Cost Accountant', 'https://drupal.org/orci/luctus/et.aspx', 23, 91741, 1, '2010-12-25 05:45:19', '2018-10-07', '2017-03-04 17:27:46', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (47, 59, 'Quire', 'Senior Quality Engineer', 'http://pcworld.com/semper/sapien/a/libero/nam/dui/proin.png', 9, 87870, 1, '2010-05-18 01:11:37', '2018-07-18', '2017-10-17 06:59:05', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (48, 34, 'Gigashots', 'Database Administrator I', 'http://senate.gov/purus/phasellus/in/felis/donec/semper.png', 25, 49976, 1, '2010-08-11 16:07:09', '2018-06-07', '2017-11-19 17:11:49', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (49, 47, 'Dazzlesphere', 'Assistant Media Planner', 'https://ifeng.com/ultrices/mattis/odio/donec/vitae/nisi/nam.png', 5, 46799, 1, '2010-08-18 03:28:37', '2018-07-16', '2017-12-08 13:54:01', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (50, 53, 'Gigabox', 'Tax Accountant', 'https://abc.net.au/vitae/ipsum/aliquam/non/mauris/morbi/non.js', 27, 90762, 1, '2010-11-13 01:52:56', '2018-02-03', '2017-07-20 06:53:07', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (51, 10, 'Dabvine', 'Human Resources Assistant II', 'https://shareasale.com/pharetra/magna/vestibulum/aliquet/ultrices/erat.jsp', 21, 64100, 1, '2010-12-13 20:17:51', '2018-10-24', '2017-10-31 21:01:17', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (52, 64, 'Blogtags', 'Accounting Assistant IV', 'https://toplist.cz/eu/massa/donec/dapibus/duis/at/velit.xml', 19, 31269, 1, '2010-08-05 07:37:30', '2018-05-31', '2017-09-21 17:46:41', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (53, 10, 'Fatz', 'Assistant Professor', 'https://businessinsider.com/donec/posuere/metus.jpg', 8, 86780, 1, '2010-02-05 16:20:15', '2018-12-07', '2017-06-05 18:38:59', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (54, 30, 'Leexo', 'Research Nurse', 'https://icio.us/morbi/odio.json', 18, 87265, 1, '2010-02-17 17:17:37', '2018-02-04', '2017-04-07 05:06:00', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (55, 85, 'DabZ', 'Nurse Practicioner', 'https://jugem.jp/quisque/id.xml', 25, 62236, 1, '2010-01-13 03:22:37', '2018-02-03', '2017-05-06 07:51:59', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (56, 22, 'Jaxbean', 'Director of Sales', 'https://ocn.ne.jp/eros/vestibulum/ac/est/lacinia/nisi.aspx', 28, 44183, 1, '2010-06-28 01:52:57', '2018-06-01', '2017-07-09 11:03:38', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (57, 11, 'Gevee', 'Compensation Analyst', 'http://oakley.com/in.html', 12, 89857, 1, '2010-09-09 03:21:45', '2018-09-25', '2017-06-22 10:22:22', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (58, 94, 'Gabtune', 'Payment Adjustment Coordinator', 'https://soup.io/felis/sed/interdum.aspx', 30, 67017, 1, '2010-09-20 04:21:21', '2018-01-18', '2017-12-23 00:03:02', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (59, 10, 'Roomm', 'Senior Financial Analyst', 'http://home.pl/rutrum/neque/aenean/auctor/gravida.js', 27, 92671, 1, '2010-01-16 02:22:17', '2018-05-13', '2017-07-16 11:49:40', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (60, 95, 'Divape', 'Software Test Engineer I', 'https://gizmodo.com/nulla/sed.png', 29, 94386, 1, '2010-09-05 08:59:36', '2018-06-10', '2017-06-14 13:55:29', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (61, 80, 'Gigazoom', 'Product Engineer', 'http://imageshack.us/faucibus/orci/luctus.js', 24, 97529, 1, '2010-12-29 08:11:20', '2018-03-13', '2017-06-04 13:39:02', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (62, 1, 'Thoughtworks', 'Programmer Analyst IV', 'http://com.com/mi/in/porttitor/pede.jsp', 7, 90518, 1, '2010-03-25 13:42:52', '2018-03-21', '2017-02-14 10:41:29', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (63, 90, 'Youspan', 'VP Quality Control', 'http://google.it/turpis.jsp', 1, 31508, 1, '2010-09-24 23:07:44', '2018-03-16', '2017-10-02 05:01:34', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (64, 89, 'Youspan', 'Biostatistician IV', 'http://sakura.ne.jp/vitae/ipsum/aliquam/non/mauris.json', 29, 89466, 1, '2010-11-10 14:49:53', '2018-05-25', '2017-10-31 18:20:51', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (65, 69, 'Livefish', 'Tax Accountant', 'http://omniture.com/vulputate.png', 22, 97417, 1, '2010-11-02 14:34:05', '2018-12-29', '2017-11-21 03:02:43', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (66, 52, 'Kwimbee', 'GIS Technical Architect', 'http://globo.com/nisi/volutpat/eleifend/donec/ut/dolor.js', 24, 71397, 1, '2010-05-22 13:07:51', '2018-03-19', '2017-06-22 22:13:04', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (67, 76, 'Zava', 'Developer II', 'https://constantcontact.com/ipsum/praesent.aspx', 1, 93840, 1, '2010-12-25 09:59:28', '2018-01-31', '2017-09-16 14:22:33', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (68, 71, 'Midel', 'Senior Developer', 'http://webs.com/et/magnis.json', 3, 39067, 1, '2010-01-13 00:59:11', '2018-05-09', '2017-10-01 09:45:50', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (69, 74, 'Meevee', 'Marketing Assistant', 'http://istockphoto.com/ut/erat/curabitur.json', 13, 31781, 1, '2010-02-19 06:31:46', '2019-01-03', '2017-08-31 00:45:41', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (70, 68, 'Meevee', 'Web Developer IV', 'http://cdbaby.com/cum/sociis/natoque/penatibus.js', 26, 91718, 1, '2010-07-03 00:49:03', '2018-08-12', '2017-08-30 21:34:11', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (71, 31, 'Voomm', 'Payment Adjustment Coordinator', 'http://amazonaws.com/in/consequat/ut.png', 15, 73934, 1, '2010-06-13 11:18:23', '2018-03-11', '2017-09-28 14:13:46', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (72, 82, 'Livepath', 'Desktop Support Technician', 'http://apple.com/platea/dictumst/aliquam/augue/quam/sollicitudin/vitae.html', 23, 30453, 1, '2010-10-02 06:58:50', '2018-06-09', '2017-03-11 23:02:14', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (73, 85, 'Vitz', 'Accountant III', 'http://bloomberg.com/amet/sem/fusce.jpg', 3, 43823, 1, '2010-07-27 06:56:29', '2018-07-25', '2017-02-22 14:10:15', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (74, 2, 'Fiveclub', 'Help Desk Operator', 'https://army.mil/tempus/vivamus/in/felis/eu.aspx', 20, 42069, 1, '2010-06-01 03:24:06', '2018-09-28', '2017-12-25 15:33:18', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (75, 86, 'Oyope', 'Analog Circuit Design manager', 'https://bigcartel.com/posuere/cubilia/curae/nulla/dapibus.png', 7, 58196, 1, '2010-02-03 03:11:52', '2018-09-11', '2017-06-13 01:15:31', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (76, 72, 'DabZ', 'Chemical Engineer', 'https://com.com/adipiscing/lorem/vitae/mattis.js', 19, 89661, 1, '2010-09-16 22:08:57', '2018-10-12', '2017-04-12 13:41:00', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (77, 87, 'Flipstorm', 'VP Accounting', 'https://deviantart.com/etiam/faucibus/cursus.json', 23, 50309, 1, '2010-03-29 02:29:39', '2018-03-01', '2017-05-18 11:17:37', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (78, 64, 'Zoonder', 'Teacher', 'https://angelfire.com/proin/at/turpis/a.js', 25, 79572, 1, '2010-03-21 22:27:17', '2018-12-13', '2017-07-07 15:30:23', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (79, 70, 'Chatterpoint', 'Operator', 'http://independent.co.uk/nulla/ut/erat.xml', 14, 35932, 1, '2010-01-26 14:14:48', '2018-03-26', '2017-03-03 23:58:24', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (80, 45, 'Zoomdog', 'Engineer IV', 'https://squarespace.com/a/pede/posuere/nonummy/integer.json', 8, 30164, 1, '2010-10-02 07:19:16', '2018-04-29', '2017-11-24 17:57:08', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (81, 4, 'Devcast', 'Developer III', 'http://opensource.org/rhoncus/mauris/enim/leo.xml', 13, 37242, 1, '2010-06-04 07:01:46', '2018-12-21', '2017-10-20 07:11:36', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (82, 75, 'Wikido', 'Biostatistician II', 'https://51.la/semper/interdum/mauris/ullamcorper.png', 1, 55839, 1, '2010-10-10 10:17:40', '2018-03-04', '2017-11-01 01:27:26', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (83, 61, 'Voonyx', 'Statistician IV', 'http://nature.com/non.aspx', 1, 50502, 1, '2010-08-10 16:42:17', '2019-01-04', '2017-04-05 11:48:18', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (84, 72, 'Thoughtworks', 'Help Desk Technician', 'http://rambler.ru/libero/quis.jsp', 27, 73615, 1, '2010-04-19 14:57:48', '2018-08-07', '2017-06-17 13:30:55', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (85, 2, 'Skaboo', 'Compensation Analyst', 'http://reverbnation.com/at/dolor/quis/odio.js', 10, 37921, 1, '2010-09-10 00:17:16', '2018-04-22', '2017-02-09 09:36:21', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (86, 81, 'Jabbersphere', 'Senior Developer', 'http://tinypic.com/nunc/commodo/placerat/praesent/blandit/nam.xml', 9, 41943, 1, '2010-10-24 13:40:52', '2019-01-10', '2017-03-17 04:19:30', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (87, 46, 'Skiptube', 'Financial Advisor', 'http://mozilla.com/in/congue/etiam/justo/etiam.aspx', 4, 54404, 1, '2010-11-14 19:49:54', '2018-02-04', '2017-12-09 10:16:28', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (88, 20, 'Blognation', 'Compensation Analyst', 'http://unicef.org/sit/amet.jsp', 12, 72595, 1, '2010-01-30 08:48:17', '2018-12-01', '2017-09-02 17:16:48', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (89, 18, 'Photobug', 'Help Desk Operator', 'https://usgs.gov/morbi/a/ipsum/integer.jpg', 1, 40249, 1, '2010-01-16 13:01:59', '2018-08-07', '2017-09-07 23:42:45', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (90, 21, 'Jaxworks', 'Payment Adjustment Coordinator', 'https://diigo.com/eget/tincidunt/eget/tempus/vel/pede/morbi.html', 23, 77511, 1, '2010-12-15 14:41:43', '2018-07-21', '2017-07-01 03:10:56', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (91, 29, 'Blogspan', 'Senior Financial Analyst', 'http://loc.gov/lectus/aliquam/sit/amet.jpg', 3, 45180, 1, '2010-07-28 10:09:11', '2018-10-11', '2017-12-09 06:13:44', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (92, 2, 'Photofeed', 'Financial Advisor', 'https://deviantart.com/sapien/varius/ut/blandit/non/interdum/in.html', 4, 45989, 1, '2010-10-06 11:08:53', '2018-12-22', '2017-11-24 07:55:09', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (93, 11, 'Blogtag', 'Quality Control Specialist', 'https://sina.com.cn/integer/a/nibh/in/quis.xml', 4, 98557, 1, '2010-03-19 17:12:03', '2018-02-04', '2017-03-22 03:05:39', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (94, 23, 'Voonder', 'Librarian', 'http://mayoclinic.com/pede.xml', 7, 96387, 1, '2010-07-21 22:30:29', '2018-03-19', '2017-04-16 23:49:40', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (95, 64, 'Aimbo', 'Sales Associate', 'https://soundcloud.com/lorem.xml', 4, 97399, 1, '2010-09-27 18:03:39', '2018-10-04', '2017-06-06 12:52:13', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (96, 6, 'Kazu', 'Nuclear Power Engineer', 'http://salon.com/sed/accumsan/felis.jpg', 3, 94603, 1, '2010-09-05 15:18:29', '2018-11-10', '2017-01-19 19:34:00', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (97, 47, 'Jazzy', 'Geological Engineer', 'https://nih.gov/metus/arcu/adipiscing/molestie.json', 18, 67498, 1, '2010-06-19 03:44:10', '2018-10-25', '2017-01-26 15:01:18', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (98, 85, 'Dabjam', 'Assistant Manager', 'http://oakley.com/vel/accumsan/tellus/nisi.html', 14, 69579, 1, '2010-09-15 03:54:25', '2018-02-10', '2017-02-13 10:57:18', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (99, 61, 'Photojam', 'VP Accounting', 'https://cbslocal.com/ipsum/praesent/blandit/lacinia/erat/vestibulum.jsp', 21, 84066, 1, '2010-08-26 04:16:53', '2018-05-26', '2017-08-21 08:01:27', NULL);
INSERT INTO `job` (`id`, `user_id`, `company`, `title`, `link`, `address_id`, `salary`, `active`, `created_date`, `closing_date`, `last_update`, `note`) VALUES (100, 16, 'Rhynyx', 'Recruiter', 'https://photobucket.com/montes/nascetur/ridiculus/mus/vivamus/vestibulum.xml', 16, 84675, 1, '2010-07-13 17:14:40', '2018-04-21', '2017-07-15 10:55:21', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `skills`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `skills` (`id`, `skill`) VALUES (1, 'TCA');
INSERT INTO `skills` (`id`, `skill`) VALUES (2, 'Organizational Leadership');
INSERT INTO `skills` (`id`, `skill`) VALUES (3, 'NCARB');
INSERT INTO `skills` (`id`, `skill`) VALUES (4, 'ICP');
INSERT INTO `skills` (`id`, `skill`) VALUES (5, 'JDA E3');
INSERT INTO `skills` (`id`, `skill`) VALUES (6, 'Diagnostic Ultrasound');
INSERT INTO `skills` (`id`, `skill`) VALUES (7, 'Professional Liability');
INSERT INTO `skills` (`id`, `skill`) VALUES (8, 'Revenue Analysis');
INSERT INTO `skills` (`id`, `skill`) VALUES (9, 'GIS Modeling');
INSERT INTO `skills` (`id`, `skill`) VALUES (10, 'Blackberry Enterprise Server');
INSERT INTO `skills` (`id`, `skill`) VALUES (11, 'DNA methylation');
INSERT INTO `skills` (`id`, `skill`) VALUES (12, 'Hudson');
INSERT INTO `skills` (`id`, `skill`) VALUES (13, 'Whole House Renovations');
INSERT INTO `skills` (`id`, `skill`) VALUES (14, 'Two-phase Flow');
INSERT INTO `skills` (`id`, `skill`) VALUES (15, 'LAN Switching');
INSERT INTO `skills` (`id`, `skill`) VALUES (16, 'NDS');
INSERT INTO `skills` (`id`, `skill`) VALUES (17, 'HEC-HMS');
INSERT INTO `skills` (`id`, `skill`) VALUES (18, 'NHS');
INSERT INTO `skills` (`id`, `skill`) VALUES (19, 'SSADM');
INSERT INTO `skills` (`id`, `skill`) VALUES (20, 'xBase');
INSERT INTO `skills` (`id`, `skill`) VALUES (21, 'Optical Tweezers');
INSERT INTO `skills` (`id`, `skill`) VALUES (22, 'Partner Management');
INSERT INTO `skills` (`id`, `skill`) VALUES (23, 'Eyelash &amp; Eyebrow Tinting');
INSERT INTO `skills` (`id`, `skill`) VALUES (24, 'DS4000');
INSERT INTO `skills` (`id`, `skill`) VALUES (25, 'PLC');
INSERT INTO `skills` (`id`, `skill`) VALUES (26, 'Operational Due Diligence');
INSERT INTO `skills` (`id`, `skill`) VALUES (27, 'Retail Banking');
INSERT INTO `skills` (`id`, `skill`) VALUES (28, 'EJB');
INSERT INTO `skills` (`id`, `skill`) VALUES (29, 'Background Checks');
INSERT INTO `skills` (`id`, `skill`) VALUES (30, 'Family Law');
INSERT INTO `skills` (`id`, `skill`) VALUES (31, 'Econometrics');
INSERT INTO `skills` (`id`, `skill`) VALUES (32, 'iPhoto');
INSERT INTO `skills` (`id`, `skill`) VALUES (33, 'MDX');
INSERT INTO `skills` (`id`, `skill`) VALUES (34, 'GFSI');
INSERT INTO `skills` (`id`, `skill`) VALUES (35, 'HVAC');
INSERT INTO `skills` (`id`, `skill`) VALUES (36, 'WCF');
INSERT INTO `skills` (`id`, `skill`) VALUES (37, 'Mycobacteriology');
INSERT INTO `skills` (`id`, `skill`) VALUES (38, 'Quantitative Analytics');
INSERT INTO `skills` (`id`, `skill`) VALUES (39, 'eHRPD');
INSERT INTO `skills` (`id`, `skill`) VALUES (40, 'Drilling');
INSERT INTO `skills` (`id`, `skill`) VALUES (41, 'Odeon');
INSERT INTO `skills` (`id`, `skill`) VALUES (42, 'Knowledge Representation');
INSERT INTO `skills` (`id`, `skill`) VALUES (43, 'DME');
INSERT INTO `skills` (`id`, `skill`) VALUES (44, 'PyUnit');
INSERT INTO `skills` (`id`, `skill`) VALUES (45, 'NLB');
INSERT INTO `skills` (`id`, `skill`) VALUES (46, 'Computer Games');
INSERT INTO `skills` (`id`, `skill`) VALUES (47, 'EEOC');
INSERT INTO `skills` (`id`, `skill`) VALUES (48, 'Universal Life');
INSERT INTO `skills` (`id`, `skill`) VALUES (49, 'Omnibus');
INSERT INTO `skills` (`id`, `skill`) VALUES (50, 'SDK');
INSERT INTO `skills` (`id`, `skill`) VALUES (51, 'Equipment Repair');
INSERT INTO `skills` (`id`, `skill`) VALUES (52, 'AQTF compliance');
INSERT INTO `skills` (`id`, `skill`) VALUES (53, 'GSA Contracting');
INSERT INTO `skills` (`id`, `skill`) VALUES (54, 'Aviation Security');
INSERT INTO `skills` (`id`, `skill`) VALUES (55, 'DMT');
INSERT INTO `skills` (`id`, `skill`) VALUES (56, 'Visual Studio');
INSERT INTO `skills` (`id`, `skill`) VALUES (57, 'Fax');
INSERT INTO `skills` (`id`, `skill`) VALUES (58, 'MHP');
INSERT INTO `skills` (`id`, `skill`) VALUES (59, 'LPAR');
INSERT INTO `skills` (`id`, `skill`) VALUES (60, 'PeopleSoft');
INSERT INTO `skills` (`id`, `skill`) VALUES (61, 'Commercial Piloting');
INSERT INTO `skills` (`id`, `skill`) VALUES (62, 'Pastoral Care');
INSERT INTO `skills` (`id`, `skill`) VALUES (63, 'WLAN');
INSERT INTO `skills` (`id`, `skill`) VALUES (64, 'AODA');
INSERT INTO `skills` (`id`, `skill`) VALUES (65, 'User Experience Design');
INSERT INTO `skills` (`id`, `skill`) VALUES (66, 'LME');
INSERT INTO `skills` (`id`, `skill`) VALUES (67, 'Defect Life Cycle');
INSERT INTO `skills` (`id`, `skill`) VALUES (68, 'Market Planning');
INSERT INTO `skills` (`id`, `skill`) VALUES (69, 'VMM');
INSERT INTO `skills` (`id`, `skill`) VALUES (70, 'Ambulance');
INSERT INTO `skills` (`id`, `skill`) VALUES (71, 'Avid Media Composer');
INSERT INTO `skills` (`id`, `skill`) VALUES (72, 'LTSpice');
INSERT INTO `skills` (`id`, `skill`) VALUES (73, 'HVAC');
INSERT INTO `skills` (`id`, `skill`) VALUES (74, 'Kurdish');
INSERT INTO `skills` (`id`, `skill`) VALUES (75, 'Finance');
INSERT INTO `skills` (`id`, `skill`) VALUES (76, 'Agents');
INSERT INTO `skills` (`id`, `skill`) VALUES (77, 'DPF');
INSERT INTO `skills` (`id`, `skill`) VALUES (78, 'EP');
INSERT INTO `skills` (`id`, `skill`) VALUES (79, 'MTT');
INSERT INTO `skills` (`id`, `skill`) VALUES (80, 'Offshore Oil');
INSERT INTO `skills` (`id`, `skill`) VALUES (81, 'Shipbuilding');
INSERT INTO `skills` (`id`, `skill`) VALUES (82, 'Enterprise Architecture');
INSERT INTO `skills` (`id`, `skill`) VALUES (83, 'Eye Tracking');
INSERT INTO `skills` (`id`, `skill`) VALUES (84, 'VPM');
INSERT INTO `skills` (`id`, `skill`) VALUES (85, 'NS2');
INSERT INTO `skills` (`id`, `skill`) VALUES (86, 'MVS');
INSERT INTO `skills` (`id`, `skill`) VALUES (87, 'RTL Design');
INSERT INTO `skills` (`id`, `skill`) VALUES (88, 'OMB Circular A-133');
INSERT INTO `skills` (`id`, `skill`) VALUES (89, 'Kitchen &amp; Bath Design');
INSERT INTO `skills` (`id`, `skill`) VALUES (90, 'Essbase');
INSERT INTO `skills` (`id`, `skill`) VALUES (91, 'HMI Configuration');
INSERT INTO `skills` (`id`, `skill`) VALUES (92, 'Digital Strategy');
INSERT INTO `skills` (`id`, `skill`) VALUES (93, 'Crisis Management');
INSERT INTO `skills` (`id`, `skill`) VALUES (94, 'Oracle Applications');
INSERT INTO `skills` (`id`, `skill`) VALUES (95, 'Emergency Services');
INSERT INTO `skills` (`id`, `skill`) VALUES (96, 'PY');
INSERT INTO `skills` (`id`, `skill`) VALUES (97, 'Electrical Design');
INSERT INTO `skills` (`id`, `skill`) VALUES (98, 'RNP');
INSERT INTO `skills` (`id`, `skill`) VALUES (99, 'Key Account Relationship Building');
INSERT INTO `skills` (`id`, `skill`) VALUES (100, 'Occupational Therapists');

COMMIT;


-- -----------------------------------------------------
-- Data for table `benefit`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `benefit` (`id`, `description`) VALUES (1, 'therianthropism');
INSERT INTO `benefit` (`id`, `description`) VALUES (2, 'nonconscription');
INSERT INTO `benefit` (`id`, `description`) VALUES (3, 'overspeculating');
INSERT INTO `benefit` (`id`, `description`) VALUES (4, 'intercorrelated');
INSERT INTO `benefit` (`id`, `description`) VALUES (5, 'nonpathological');
INSERT INTO `benefit` (`id`, `description`) VALUES (6, 'dumbfounderment');
INSERT INTO `benefit` (`id`, `description`) VALUES (7, 'reinterrogating');
INSERT INTO `benefit` (`id`, `description`) VALUES (8, 'departmentalize');
INSERT INTO `benefit` (`id`, `description`) VALUES (9, 'commiseratively');
INSERT INTO `benefit` (`id`, `description`) VALUES (10, 'nonprofiteering');
INSERT INTO `benefit` (`id`, `description`) VALUES (11, 'pseudoelectoral');
INSERT INTO `benefit` (`id`, `description`) VALUES (12, 'chromatographic');
INSERT INTO `benefit` (`id`, `description`) VALUES (13, 'overaffirmative');
INSERT INTO `benefit` (`id`, `description`) VALUES (14, 'supercoincident');
INSERT INTO `benefit` (`id`, `description`) VALUES (15, 'photoelasticity');
INSERT INTO `benefit` (`id`, `description`) VALUES (16, 'salicylaldehyde');
INSERT INTO `benefit` (`id`, `description`) VALUES (17, 'superexaltation');
INSERT INTO `benefit` (`id`, `description`) VALUES (18, 'toxicologically');
INSERT INTO `benefit` (`id`, `description`) VALUES (19, 'superattractive');
INSERT INTO `benefit` (`id`, `description`) VALUES (20, 'conservationist');
INSERT INTO `benefit` (`id`, `description`) VALUES (21, 'interfiltrating');
INSERT INTO `benefit` (`id`, `description`) VALUES (22, 'prefermentation');
INSERT INTO `benefit` (`id`, `description`) VALUES (23, 'epistemological');
INSERT INTO `benefit` (`id`, `description`) VALUES (24, 'nonprofiteering');
INSERT INTO `benefit` (`id`, `description`) VALUES (25, 'seminationalism');
INSERT INTO `benefit` (`id`, `description`) VALUES (26, 'preequalization');
INSERT INTO `benefit` (`id`, `description`) VALUES (27, 'electropositive');
INSERT INTO `benefit` (`id`, `description`) VALUES (28, 'ungesticulating');
INSERT INTO `benefit` (`id`, `description`) VALUES (29, 'nonignitibility');
INSERT INTO `benefit` (`id`, `description`) VALUES (30, 'pseudoelectoral');
INSERT INTO `benefit` (`id`, `description`) VALUES (31, 'overspeculating');
INSERT INTO `benefit` (`id`, `description`) VALUES (32, 'seminationalism');
INSERT INTO `benefit` (`id`, `description`) VALUES (33, 'electropositive');
INSERT INTO `benefit` (`id`, `description`) VALUES (34, 'chromatographic');
INSERT INTO `benefit` (`id`, `description`) VALUES (35, 'reconsolidating');
INSERT INTO `benefit` (`id`, `description`) VALUES (36, 'schrecklichkeit');
INSERT INTO `benefit` (`id`, `description`) VALUES (37, 'proconciliation');
INSERT INTO `benefit` (`id`, `description`) VALUES (38, 'nonapprehension');
INSERT INTO `benefit` (`id`, `description`) VALUES (39, 'seminationalism');
INSERT INTO `benefit` (`id`, `description`) VALUES (40, 'instrumentality');
INSERT INTO `benefit` (`id`, `description`) VALUES (41, 'reconsolidating');
INSERT INTO `benefit` (`id`, `description`) VALUES (42, 'unsyntheticaly');
INSERT INTO `benefit` (`id`, `description`) VALUES (43, 'ferromolybdenum');
INSERT INTO `benefit` (`id`, `description`) VALUES (44, 'antiagglutinant');
INSERT INTO `benefit` (`id`, `description`) VALUES (45, 'inconsequential');
INSERT INTO `benefit` (`id`, `description`) VALUES (46, 'ungesticulating');
INSERT INTO `benefit` (`id`, `description`) VALUES (47, 'autotransformer');
INSERT INTO `benefit` (`id`, `description`) VALUES (48, 'dissolvableness');
INSERT INTO `benefit` (`id`, `description`) VALUES (49, 'schrecklichkeit');
INSERT INTO `benefit` (`id`, `description`) VALUES (50, 'trophoplasmatic');
INSERT INTO `benefit` (`id`, `description`) VALUES (51, 'autotransformer');
INSERT INTO `benefit` (`id`, `description`) VALUES (52, 'chromatographic');
INSERT INTO `benefit` (`id`, `description`) VALUES (53, 'pseudoelectoral');
INSERT INTO `benefit` (`id`, `description`) VALUES (54, 'nonprofiteering');
INSERT INTO `benefit` (`id`, `description`) VALUES (55, 'nonprofiteering');
INSERT INTO `benefit` (`id`, `description`) VALUES (56, 'semilegislative');
INSERT INTO `benefit` (`id`, `description`) VALUES (57, 'supercoincident');
INSERT INTO `benefit` (`id`, `description`) VALUES (58, 'rejustification');
INSERT INTO `benefit` (`id`, `description`) VALUES (59, 'departmentalize');
INSERT INTO `benefit` (`id`, `description`) VALUES (60, 'unparticipating');
INSERT INTO `benefit` (`id`, `description`) VALUES (61, 'subvitalization');
INSERT INTO `benefit` (`id`, `description`) VALUES (62, 'physicochemical');
INSERT INTO `benefit` (`id`, `description`) VALUES (63, 'braggadocianism');
INSERT INTO `benefit` (`id`, `description`) VALUES (64, 'pseudoelectoral');
INSERT INTO `benefit` (`id`, `description`) VALUES (65, 'trophoplasmatic');
INSERT INTO `benefit` (`id`, `description`) VALUES (66, 'rejustification');
INSERT INTO `benefit` (`id`, `description`) VALUES (67, 'nonprofiteering');
INSERT INTO `benefit` (`id`, `description`) VALUES (68, 'superexaltation');
INSERT INTO `benefit` (`id`, `description`) VALUES (69, 'overdestructive');
INSERT INTO `benefit` (`id`, `description`) VALUES (70, 'entrepreneurial');
INSERT INTO `benefit` (`id`, `description`) VALUES (71, 'overcaustically');
INSERT INTO `benefit` (`id`, `description`) VALUES (72, 'unindoctrinated');
INSERT INTO `benefit` (`id`, `description`) VALUES (73, 'therianthropism');
INSERT INTO `benefit` (`id`, `description`) VALUES (74, 'impertinentness');
INSERT INTO `benefit` (`id`, `description`) VALUES (75, 'overaffirmative');
INSERT INTO `benefit` (`id`, `description`) VALUES (76, 'intercorrelated');
INSERT INTO `benefit` (`id`, `description`) VALUES (77, 'superexaltation');
INSERT INTO `benefit` (`id`, `description`) VALUES (78, 'predominatingly');
INSERT INTO `benefit` (`id`, `description`) VALUES (79, 'nonprotuberancy');
INSERT INTO `benefit` (`id`, `description`) VALUES (80, 'preequalization');
INSERT INTO `benefit` (`id`, `description`) VALUES (81, 'schrecklichkeit');
INSERT INTO `benefit` (`id`, `description`) VALUES (82, 'salicylaldehyde');
INSERT INTO `benefit` (`id`, `description`) VALUES (83, 'dermatoglyphics');
INSERT INTO `benefit` (`id`, `description`) VALUES (84, 'ungesticulating');
INSERT INTO `benefit` (`id`, `description`) VALUES (85, 'braggadocianism');
INSERT INTO `benefit` (`id`, `description`) VALUES (86, 'hospitalisation');
INSERT INTO `benefit` (`id`, `description`) VALUES (87, 'astronautically');
INSERT INTO `benefit` (`id`, `description`) VALUES (88, 'epistemological');
INSERT INTO `benefit` (`id`, `description`) VALUES (89, 'autotransformer');
INSERT INTO `benefit` (`id`, `description`) VALUES (90, 'intellectualism');
INSERT INTO `benefit` (`id`, `description`) VALUES (91, 'therianthropism');
INSERT INTO `benefit` (`id`, `description`) VALUES (92, 'supercoincident');
INSERT INTO `benefit` (`id`, `description`) VALUES (93, 'prebarbarically');
INSERT INTO `benefit` (`id`, `description`) VALUES (94, 'inconsequential');
INSERT INTO `benefit` (`id`, `description`) VALUES (95, 'kinematographer');
INSERT INTO `benefit` (`id`, `description`) VALUES (96, 'unpatriotically');
INSERT INTO `benefit` (`id`, `description`) VALUES (97, 'antiagglutinant');
INSERT INTO `benefit` (`id`, `description`) VALUES (98, 'overdestructive');
INSERT INTO `benefit` (`id`, `description`) VALUES (99, 'photoelectrical');
INSERT INTO `benefit` (`id`, `description`) VALUES (100, 'trophoplasmatic');

COMMIT;


-- -----------------------------------------------------
-- Data for table `job_benefits`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (1, 94);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (1, 10);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (1, 98);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (1, 61);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (1, 73);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (2, 88);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (2, 7);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (2, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (2, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (2, 83);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (3, 32);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (3, 24);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (3, 65);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (3, 68);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (3, 83);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (4, 4);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (4, 73);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (4, 69);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (4, 20);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (4, 61);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (5, 54);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (5, 80);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (5, 88);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (5, 77);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (5, 11);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (6, 96);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (6, 94);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (6, 20);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (6, 89);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (6, 90);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (7, 53);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (7, 74);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (7, 51);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (7, 32);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (7, 82);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (8, 54);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (8, 82);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (8, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (8, 46);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (8, 80);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (9, 74);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (9, 90);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (9, 64);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (9, 11);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (9, 53);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (10, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (10, 76);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (10, 11);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (10, 68);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (10, 100);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (11, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (11, 82);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (11, 14);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (11, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (11, 69);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (12, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (12, 12);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (12, 2);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (12, 34);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (12, 89);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (13, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (13, 1);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (13, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (13, 21);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (13, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (14, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (14, 60);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (14, 50);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (14, 96);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (14, 13);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (15, 52);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (15, 41);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (15, 23);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (15, 86);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (15, 75);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (16, 52);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (16, 47);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (16, 95);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (16, 33);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (16, 22);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (17, 43);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (17, 93);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (17, 3);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (17, 41);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (17, 42);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (18, 15);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (18, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (18, 72);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (18, 100);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (18, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (19, 44);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (19, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (19, 69);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (19, 86);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (19, 80);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (20, 85);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (20, 6);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (20, 53);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (20, 4);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (20, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (21, 8);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (21, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (21, 43);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (21, 63);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (21, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (22, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (22, 14);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (22, 11);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (22, 76);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (22, 84);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (23, 28);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (23, 14);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (23, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (23, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (23, 41);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (24, 3);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (24, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (24, 33);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (24, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (24, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (25, 50);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (25, 9);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (25, 6);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (25, 84);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (25, 33);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (26, 25);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (26, 60);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (26, 71);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (26, 24);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (26, 7);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (27, 75);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (27, 63);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (27, 12);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (27, 21);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (27, 64);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (28, 93);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (28, 38);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (28, 30);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (28, 34);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (28, 64);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (29, 92);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (29, 81);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (29, 89);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (29, 26);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (29, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (30, 96);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (30, 11);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (30, 57);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (30, 50);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (30, 10);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (31, 32);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (31, 74);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (31, 56);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (31, 34);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (31, 58);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (32, 45);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (32, 66);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (32, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (32, 86);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (32, 15);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (33, 17);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (33, 27);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (33, 92);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (33, 89);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (33, 44);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (34, 26);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (34, 65);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (34, 1);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (34, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (34, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (35, 44);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (35, 33);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (35, 9);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (35, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (35, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (36, 13);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (36, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (36, 39);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (36, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (36, 18);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (37, 83);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (37, 96);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (37, 38);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (37, 84);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (37, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (38, 31);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (38, 28);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (38, 92);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (38, 51);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (38, 86);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (39, 35);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (39, 15);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (39, 20);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (39, 48);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (39, 87);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (40, 72);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (40, 68);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (40, 36);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (40, 78);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (40, 33);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (41, 56);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (41, 77);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (41, 81);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (41, 52);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (41, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (42, 87);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (42, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (42, 26);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (42, 68);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (42, 27);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (43, 4);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (43, 18);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (43, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (43, 50);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (43, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (44, 39);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (44, 46);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (44, 40);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (44, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (44, 37);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (45, 21);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (45, 33);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (45, 36);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (45, 64);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (45, 9);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (46, 51);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (46, 48);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (46, 11);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (46, 39);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (46, 75);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (47, 35);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (47, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (47, 71);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (47, 40);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (47, 90);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (48, 23);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (48, 45);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (48, 22);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (48, 63);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (48, 49);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (49, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (49, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (49, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (49, 44);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (49, 31);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (50, 34);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (50, 29);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (50, 77);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (50, 51);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (50, 48);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (51, 32);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (51, 52);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (51, 99);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (51, 17);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (51, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (52, 83);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (52, 45);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (52, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (52, 75);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (52, 89);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (53, 22);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (53, 57);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (53, 13);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (53, 100);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (53, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (54, 14);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (54, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (54, 26);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (54, 34);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (54, 41);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (55, 94);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (55, 14);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (55, 49);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (55, 82);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (55, 99);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (56, 99);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (56, 72);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (56, 53);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (56, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (56, 51);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (57, 15);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (57, 8);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (57, 30);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (57, 66);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (57, 42);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (58, 12);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (58, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (58, 65);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (58, 42);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (58, 27);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (59, 52);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (59, 12);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (59, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (59, 90);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (59, 96);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (60, 35);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (60, 23);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (60, 48);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (60, 44);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (60, 90);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (61, 77);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (61, 9);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (61, 88);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (61, 93);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (61, 34);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (62, 25);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (62, 71);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (62, 61);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (62, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (62, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (63, 24);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (63, 95);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (63, 64);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (63, 35);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (63, 83);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (64, 88);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (64, 85);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (64, 60);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (64, 11);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (64, 41);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (65, 100);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (65, 27);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (65, 72);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (65, 87);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (65, 30);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (66, 53);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (66, 74);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (66, 76);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (66, 33);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (66, 89);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (67, 25);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (67, 21);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (67, 14);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (67, 98);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (67, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (68, 94);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (68, 62);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (68, 60);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (68, 2);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (68, 4);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (69, 39);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (69, 26);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (69, 24);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (69, 31);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (69, 51);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (70, 37);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (70, 9);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (70, 19);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (70, 51);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (70, 88);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (71, 50);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (71, 4);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (71, 60);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (71, 1);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (71, 22);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (72, 54);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (72, 59);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (72, 77);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (72, 96);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (72, 65);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (73, 27);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (73, 49);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (73, 25);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (73, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (73, 90);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (74, 25);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (74, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (74, 65);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (74, 43);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (74, 23);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (75, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (75, 52);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (75, 29);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (75, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (75, 74);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (76, 1);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (76, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (76, 74);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (76, 69);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (76, 76);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (77, 71);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (77, 92);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (77, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (77, 6);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (77, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (78, 10);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (78, 15);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (78, 13);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (78, 43);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (78, 66);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (79, 77);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (79, 80);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (79, 75);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (79, 14);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (79, 2);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (80, 34);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (80, 61);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (80, 100);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (80, 16);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (80, 52);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (81, 4);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (81, 30);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (81, 39);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (81, 86);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (81, 24);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (82, 4);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (82, 28);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (82, 83);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (82, 100);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (82, 40);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (83, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (83, 65);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (83, 56);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (83, 91);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (83, 70);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (84, 48);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (84, 11);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (84, 87);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (84, 25);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (84, 35);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (85, 79);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (85, 40);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (85, 67);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (85, 76);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (85, 31);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (86, 24);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (86, 35);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (86, 91);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (86, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (86, 8);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (87, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (87, 91);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (87, 6);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (87, 84);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (87, 95);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (88, 32);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (88, 33);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (88, 45);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (88, 9);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (88, 15);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (89, 42);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (89, 99);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (89, 39);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (89, 88);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (89, 100);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (90, 12);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (90, 40);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (90, 83);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (90, 8);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (90, 54);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (91, 55);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (91, 57);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (91, 13);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (91, 84);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (91, 42);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (92, 58);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (92, 91);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (92, 1);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (92, 35);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (92, 12);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (93, 90);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (93, 87);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (93, 68);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (93, 49);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (93, 75);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (94, 41);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (94, 61);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (94, 56);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (94, 65);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (94, 91);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (95, 54);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (95, 35);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (95, 24);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (95, 22);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (95, 92);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (96, 44);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (96, 67);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (96, 98);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (96, 7);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (96, 20);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (97, 89);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (97, 9);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (97, 17);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (97, 5);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (97, 27);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (98, 97);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (98, 24);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (98, 65);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (98, 2);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (98, 25);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (99, 90);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (99, 68);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (99, 94);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (99, 89);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (99, 48);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (100, 80);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (100, 71);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (100, 84);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (100, 75);
INSERT INTO `job_benefits` (`job_id`, `benefit_id`) VALUES (100, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `schedule_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `schedule_types` (`id`, `description`) VALUES (1, 'Part time');
INSERT INTO `schedule_types` (`id`, `description`) VALUES (2, 'Full time');
INSERT INTO `schedule_types` (`id`, `description`) VALUES (3, 'Contract');

COMMIT;


-- -----------------------------------------------------
-- Data for table `job_schedule`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (1, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (2, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (3, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (4, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (5, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (6, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (7, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (8, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (9, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (10, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (11, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (12, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (13, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (14, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (15, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (16, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (17, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (18, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (19, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (20, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (21, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (22, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (23, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (24, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (25, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (26, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (27, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (28, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (29, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (30, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (31, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (32, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (33, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (34, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (35, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (36, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (37, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (38, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (39, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (40, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (41, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (42, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (43, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (44, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (45, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (46, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (47, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (48, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (49, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (50, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (51, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (52, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (53, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (54, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (55, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (56, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (57, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (58, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (59, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (60, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (61, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (62, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (63, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (64, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (65, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (66, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (67, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (68, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (69, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (70, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (71, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (72, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (73, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (74, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (75, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (76, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (77, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (78, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (79, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (80, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (81, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (82, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (83, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (84, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (85, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (86, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (87, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (88, 3);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (89, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (90, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (91, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (92, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (93, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (94, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (95, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (96, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (97, 1);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (98, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (99, 2);
INSERT INTO `job_schedule` (`job_id`, `schedule_id`) VALUES (100, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_skills`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (1, 91);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (1, 15);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (1, 76);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (1, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (1, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (2, 16);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (2, 43);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (2, 6);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (2, 98);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (2, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (3, 22);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (3, 15);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (3, 76);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (3, 43);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (3, 59);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (4, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (4, 8);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (4, 81);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (4, 24);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (4, 17);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (5, 81);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (5, 22);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (5, 56);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (5, 78);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (5, 83);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (6, 8);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (6, 1);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (6, 51);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (6, 79);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (6, 85);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (7, 95);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (7, 73);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (7, 55);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (7, 90);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (7, 2);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (8, 64);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (8, 55);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (8, 12);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (8, 21);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (8, 85);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (9, 84);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (9, 58);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (9, 33);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (9, 48);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (9, 62);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (10, 75);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (10, 21);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (10, 16);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (10, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (10, 91);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (11, 60);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (11, 23);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (11, 75);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (11, 64);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (11, 98);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (12, 63);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (12, 17);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (12, 91);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (12, 3);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (12, 61);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (13, 57);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (13, 22);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (13, 80);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (13, 29);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (13, 5);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (14, 36);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (14, 71);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (14, 27);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (14, 52);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (14, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (15, 57);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (15, 58);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (15, 38);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (15, 25);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (15, 96);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (16, 96);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (16, 31);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (16, 30);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (16, 90);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (16, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (17, 6);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (17, 72);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (17, 47);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (17, 90);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (17, 51);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (18, 52);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (18, 31);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (18, 16);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (18, 61);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (18, 95);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (19, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (19, 71);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (19, 56);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (19, 51);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (19, 52);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (20, 24);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (20, 77);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (20, 49);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (20, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (20, 6);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (21, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (21, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (21, 31);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (21, 65);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (21, 24);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (22, 54);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (22, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (22, 74);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (22, 16);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (22, 79);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (23, 90);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (23, 1);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (23, 4);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (23, 68);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (23, 9);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (24, 83);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (24, 32);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (24, 62);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (24, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (24, 12);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (25, 48);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (25, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (25, 95);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (25, 71);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (25, 30);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (26, 26);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (26, 4);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (26, 56);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (26, 63);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (26, 90);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (27, 81);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (27, 58);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (27, 9);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (27, 18);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (27, 68);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (28, 9);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (28, 85);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (28, 13);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (28, 86);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (28, 36);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (29, 80);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (29, 38);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (29, 41);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (29, 1);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (29, 19);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (30, 88);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (30, 82);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (30, 41);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (30, 83);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (30, 6);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (31, 43);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (31, 33);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (31, 38);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (31, 70);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (31, 66);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (32, 81);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (32, 36);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (32, 15);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (32, 76);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (32, 86);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (33, 93);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (33, 18);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (33, 59);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (33, 88);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (33, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (34, 26);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (34, 43);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (34, 88);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (34, 45);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (34, 73);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (35, 97);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (35, 86);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (35, 60);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (35, 11);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (35, 62);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (36, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (36, 77);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (36, 84);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (36, 42);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (36, 24);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (37, 52);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (37, 57);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (37, 53);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (37, 98);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (37, 7);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (38, 91);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (38, 96);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (38, 28);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (38, 3);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (38, 11);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (39, 61);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (39, 95);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (39, 21);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (39, 22);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (39, 5);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (40, 84);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (40, 91);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (40, 77);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (40, 97);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (40, 33);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (41, 41);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (41, 96);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (41, 97);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (41, 62);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (41, 4);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (42, 39);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (42, 4);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (42, 44);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (42, 23);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (42, 88);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (43, 32);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (43, 2);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (43, 78);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (43, 20);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (43, 47);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (44, 3);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (44, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (44, 91);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (44, 82);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (44, 95);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (45, 77);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (45, 27);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (45, 76);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (45, 94);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (45, 65);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (46, 7);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (46, 17);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (46, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (46, 44);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (46, 94);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (47, 22);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (47, 68);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (47, 61);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (47, 54);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (47, 41);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (48, 96);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (48, 95);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (48, 63);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (48, 54);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (48, 92);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (49, 55);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (49, 71);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (49, 7);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (49, 9);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (49, 42);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (50, 30);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (50, 44);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (50, 49);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (50, 38);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (50, 55);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (51, 99);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (51, 19);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (51, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (51, 68);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (51, 59);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (52, 83);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (52, 16);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (52, 88);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (52, 63);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (52, 18);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (53, 27);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (53, 61);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (53, 50);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (53, 31);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (53, 56);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (54, 56);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (54, 100);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (54, 78);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (54, 68);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (54, 23);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (55, 26);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (55, 49);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (55, 74);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (55, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (55, 86);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (56, 13);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (56, 38);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (56, 43);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (56, 3);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (56, 59);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (57, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (57, 61);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (57, 12);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (57, 66);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (57, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (58, 53);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (58, 94);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (58, 43);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (58, 13);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (58, 88);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (59, 94);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (59, 1);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (59, 58);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (59, 18);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (59, 97);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (60, 10);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (60, 63);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (60, 90);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (60, 73);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (60, 99);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (61, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (61, 74);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (61, 28);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (61, 32);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (61, 96);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (62, 29);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (62, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (62, 53);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (62, 77);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (62, 28);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (63, 75);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (63, 70);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (63, 39);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (63, 79);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (63, 59);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (64, 53);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (64, 52);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (64, 80);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (64, 57);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (64, 36);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (65, 36);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (65, 4);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (65, 87);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (65, 57);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (65, 38);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (66, 71);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (66, 49);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (66, 47);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (66, 31);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (66, 23);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (67, 92);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (67, 81);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (67, 7);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (67, 41);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (67, 85);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (68, 11);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (68, 12);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (68, 50);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (68, 63);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (68, 51);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (69, 52);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (69, 44);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (69, 67);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (69, 18);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (69, 46);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (70, 9);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (70, 54);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (70, 22);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (70, 33);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (70, 28);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (71, 84);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (71, 83);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (71, 58);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (71, 8);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (71, 86);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (72, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (72, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (72, 89);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (72, 26);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (72, 47);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (73, 39);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (73, 3);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (73, 76);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (73, 72);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (73, 79);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (74, 48);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (74, 10);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (74, 60);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (74, 23);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (74, 43);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (75, 78);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (75, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (75, 46);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (75, 47);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (75, 32);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (76, 60);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (76, 76);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (76, 92);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (76, 45);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (76, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (77, 30);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (77, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (77, 59);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (77, 35);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (77, 85);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (78, 30);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (78, 23);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (78, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (78, 88);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (78, 13);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (79, 8);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (79, 41);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (79, 42);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (79, 29);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (79, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (80, 90);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (80, 83);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (80, 5);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (80, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (80, 41);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (81, 68);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (81, 12);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (81, 6);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (81, 53);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (81, 65);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (82, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (82, 22);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (82, 16);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (82, 24);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (82, 57);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (83, 5);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (83, 75);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (83, 49);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (83, 4);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (83, 45);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (84, 97);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (84, 56);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (84, 61);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (84, 48);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (84, 3);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (85, 17);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (85, 85);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (85, 22);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (85, 97);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (85, 9);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (86, 100);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (86, 44);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (86, 21);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (86, 57);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (86, 76);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (87, 42);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (87, 62);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (87, 69);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (87, 60);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (87, 27);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (88, 78);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (88, 46);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (88, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (88, 62);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (88, 66);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (89, 75);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (89, 89);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (89, 93);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (89, 61);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (89, 18);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (90, 17);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (90, 63);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (90, 53);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (90, 91);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (90, 67);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (91, 94);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (91, 78);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (91, 27);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (91, 83);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (91, 80);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (92, 1);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (92, 55);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (92, 90);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (92, 16);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (92, 45);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (93, 64);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (93, 16);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (93, 4);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (93, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (93, 84);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (94, 81);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (94, 97);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (94, 50);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (94, 17);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (94, 1);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (95, 72);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (95, 51);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (95, 35);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (95, 86);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (95, 18);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (96, 74);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (96, 66);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (96, 25);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (96, 5);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (96, 47);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (97, 83);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (97, 30);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (97, 79);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (97, 40);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (97, 54);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (98, 50);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (98, 8);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (98, 6);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (98, 71);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (98, 76);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (99, 82);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (99, 98);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (99, 14);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (99, 55);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (99, 96);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (100, 85);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (100, 24);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (100, 37);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (100, 34);
INSERT INTO `user_skills` (`user_id`, `skill_id`) VALUES (100, 13);

COMMIT;


-- -----------------------------------------------------
-- Data for table `job_notes`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (1, 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (2, 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (3, 'Duis bibendum. Morbi non quam nec dui luctus rutrum.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (4, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (5, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (6, 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (7, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (8, 'Quisque ut erat.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (9, 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (10, 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (11, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (12, 'Duis mattis egestas metus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (13, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (14, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (15, 'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (16, 'Aliquam non mauris. Morbi non lectus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (17, 'Donec dapibus. Duis at velit eu est congue elementum.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (18, 'Etiam justo. Etiam pretium iaculis justo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (19, 'Etiam pretium iaculis justo. In hac habitasse platea dictumst.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (20, 'Nullam varius.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (21, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (22, 'Proin at turpis a pede posuere nonummy.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (23, 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (24, 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (25, 'Nam nulla.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (26, 'Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (27, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (28, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (29, 'Ut at dolor quis odio consequat varius. Integer ac leo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (30, 'Vivamus vel nulla eget eros elementum pellentesque.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (31, 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (32, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (33, 'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (34, 'Integer a nibh. In quis justo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (35, 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (36, 'Duis ac nibh.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (37, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (38, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (39, 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (40, 'Cras in purus eu magna vulputate luctus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (41, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (42, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (43, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (44, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (45, 'Curabitur convallis.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (46, 'Etiam faucibus cursus urna. Ut tellus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (47, 'In quis justo. Maecenas rhoncus aliquam lacus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (48, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (49, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (50, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (51, 'Integer ac neque. Duis bibendum.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (52, 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (53, 'Etiam faucibus cursus urna.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (54, 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (55, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (56, 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (57, 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (58, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (59, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (60, 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (61, 'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (62, 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (63, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (64, 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (65, 'Donec ut dolor.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (66, 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (67, 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (68, 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (69, 'Suspendisse potenti. Nullam porttitor lacus at turpis.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (70, 'Nulla ut erat id mauris vulputate elementum.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (71, 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (72, 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (73, 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (74, 'Mauris sit amet eros.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (75, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (76, 'Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (77, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (78, 'Cras in purus eu magna vulputate luctus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (79, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (80, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (81, 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (82, 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (83, 'In est risus, auctor sed, tristique in, tempus sit amet, sem.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (84, 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (85, 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (86, 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (87, 'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (88, 'Proin eu mi. Nulla ac enim.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (89, 'In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (90, 'Vestibulum ac est lacinia nisi venenatis tristique.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (91, 'Mauris sit amet eros.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (92, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (93, 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (94, 'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (95, 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (96, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (97, 'Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (98, 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (99, 'Etiam vel augue.');
INSERT INTO `job_notes` (`job_id`, `notes`) VALUES (100, 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `job_skills`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (1, 2);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (1, 57);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (1, 85);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (1, 81);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (1, 86);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (2, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (2, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (2, 19);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (2, 83);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (2, 72);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (3, 82);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (3, 1);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (3, 99);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (3, 89);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (3, 15);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (4, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (4, 77);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (4, 67);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (4, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (4, 21);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (5, 8);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (5, 98);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (5, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (5, 84);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (5, 67);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (6, 73);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (6, 88);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (6, 23);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (6, 27);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (6, 85);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (7, 35);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (7, 52);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (7, 34);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (7, 13);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (7, 79);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (8, 81);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (8, 92);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (8, 79);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (8, 8);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (8, 62);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (9, 8);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (9, 88);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (9, 64);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (9, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (9, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (10, 84);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (10, 72);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (10, 53);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (10, 73);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (10, 76);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (11, 22);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (11, 12);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (11, 29);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (11, 71);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (11, 17);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (12, 63);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (12, 66);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (12, 89);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (12, 62);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (12, 49);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (13, 47);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (13, 92);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (13, 58);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (13, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (13, 53);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (14, 14);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (14, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (14, 82);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (14, 55);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (14, 34);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (15, 66);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (15, 58);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (15, 69);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (15, 54);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (15, 48);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (16, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (16, 52);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (16, 3);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (16, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (16, 28);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (17, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (17, 45);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (17, 24);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (17, 88);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (17, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (18, 69);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (18, 82);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (18, 21);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (18, 35);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (18, 53);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (19, 53);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (19, 17);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (19, 50);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (19, 36);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (19, 70);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (20, 74);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (20, 17);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (20, 61);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (20, 28);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (20, 16);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (21, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (21, 3);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (21, 17);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (21, 99);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (21, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (22, 44);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (22, 62);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (22, 100);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (22, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (22, 93);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (23, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (23, 76);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (23, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (23, 51);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (23, 47);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (24, 77);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (24, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (24, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (24, 8);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (24, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (25, 57);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (25, 39);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (25, 48);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (25, 94);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (25, 33);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (26, 14);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (26, 37);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (26, 65);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (26, 94);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (26, 68);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (27, 87);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (27, 1);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (27, 12);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (27, 33);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (27, 27);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (28, 34);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (28, 19);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (28, 21);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (28, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (28, 61);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (29, 70);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (29, 92);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (29, 44);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (29, 32);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (29, 74);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (30, 94);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (30, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (30, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (30, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (30, 8);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (31, 45);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (31, 57);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (31, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (31, 35);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (31, 93);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (32, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (32, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (32, 62);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (32, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (32, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (33, 75);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (33, 76);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (33, 81);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (33, 28);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (33, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (34, 79);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (34, 36);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (34, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (34, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (34, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (35, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (35, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (35, 54);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (35, 20);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (35, 64);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (36, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (36, 37);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (36, 29);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (36, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (36, 94);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (37, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (37, 26);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (37, 49);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (37, 14);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (37, 91);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (38, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (38, 12);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (38, 33);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (38, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (38, 8);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (39, 39);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (39, 19);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (39, 55);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (39, 65);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (39, 30);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (40, 40);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (40, 86);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (40, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (40, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (40, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (41, 99);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (41, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (41, 24);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (41, 70);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (41, 76);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (42, 45);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (42, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (42, 23);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (42, 16);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (42, 33);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (43, 29);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (43, 63);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (43, 95);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (43, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (43, 88);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (44, 75);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (44, 92);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (44, 31);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (44, 85);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (44, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (45, 32);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (45, 79);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (45, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (45, 88);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (45, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (46, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (46, 87);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (46, 12);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (46, 1);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (46, 70);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (47, 78);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (47, 41);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (47, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (47, 34);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (47, 51);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (48, 73);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (48, 75);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (48, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (48, 93);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (48, 58);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (49, 97);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (49, 27);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (49, 20);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (49, 77);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (49, 15);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (50, 26);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (50, 70);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (50, 52);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (50, 23);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (50, 59);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (51, 100);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (51, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (51, 47);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (51, 33);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (51, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (52, 47);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (52, 19);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (52, 95);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (52, 21);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (52, 88);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (53, 59);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (53, 76);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (53, 84);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (53, 95);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (53, 100);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (54, 75);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (54, 67);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (54, 47);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (54, 13);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (54, 68);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (55, 78);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (55, 44);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (55, 31);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (55, 50);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (55, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (56, 61);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (56, 1);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (56, 55);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (56, 83);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (56, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (57, 2);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (57, 39);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (57, 58);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (57, 48);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (57, 20);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (58, 20);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (58, 36);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (58, 100);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (58, 93);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (58, 91);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (59, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (59, 40);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (59, 58);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (59, 73);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (59, 83);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (60, 86);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (60, 89);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (60, 94);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (60, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (60, 24);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (61, 48);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (61, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (61, 1);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (61, 19);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (61, 73);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (62, 32);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (62, 40);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (62, 1);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (62, 75);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (62, 68);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (63, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (63, 50);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (63, 18);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (63, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (63, 66);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (64, 61);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (64, 78);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (64, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (64, 27);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (64, 96);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (65, 31);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (65, 15);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (65, 55);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (65, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (65, 76);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (66, 99);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (66, 93);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (66, 57);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (66, 76);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (66, 8);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (67, 24);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (67, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (67, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (67, 59);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (67, 87);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (68, 98);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (68, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (68, 99);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (68, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (68, 90);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (69, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (69, 83);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (69, 34);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (69, 41);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (69, 51);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (70, 71);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (70, 40);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (70, 76);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (70, 28);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (70, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (71, 55);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (71, 89);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (71, 31);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (71, 50);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (71, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (72, 27);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (72, 3);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (72, 72);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (72, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (72, 29);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (73, 40);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (73, 66);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (73, 73);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (73, 84);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (73, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (74, 54);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (74, 42);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (74, 74);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (74, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (74, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (75, 30);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (75, 15);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (75, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (75, 85);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (75, 45);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (76, 97);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (76, 16);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (76, 37);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (76, 68);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (76, 20);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (77, 24);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (77, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (77, 39);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (77, 89);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (77, 64);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (78, 64);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (78, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (78, 5);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (78, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (78, 77);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (79, 87);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (79, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (79, 5);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (79, 84);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (79, 32);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (80, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (80, 90);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (80, 55);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (80, 96);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (80, 16);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (81, 50);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (81, 10);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (81, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (81, 68);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (81, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (82, 18);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (82, 14);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (82, 1);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (82, 59);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (82, 20);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (83, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (83, 75);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (83, 33);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (83, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (83, 28);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (84, 13);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (84, 37);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (84, 50);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (84, 36);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (84, 77);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (85, 81);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (85, 58);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (85, 23);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (85, 50);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (85, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (86, 70);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (86, 21);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (86, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (86, 19);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (86, 89);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (87, 12);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (87, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (87, 95);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (87, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (87, 31);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (88, 34);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (88, 85);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (88, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (88, 25);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (88, 88);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (89, 29);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (89, 59);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (89, 52);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (89, 78);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (89, 66);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (90, 89);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (90, 31);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (90, 91);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (90, 3);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (90, 30);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (91, 50);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (91, 65);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (91, 9);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (91, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (91, 17);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (92, 14);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (92, 32);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (92, 49);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (92, 40);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (92, 7);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (93, 34);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (93, 79);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (93, 59);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (93, 38);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (93, 57);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (94, 21);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (94, 80);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (94, 12);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (94, 30);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (94, 37);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (95, 16);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (95, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (95, 70);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (95, 96);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (95, 56);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (96, 86);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (96, 2);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (96, 82);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (96, 48);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (96, 11);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (97, 46);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (97, 43);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (97, 61);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (97, 94);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (97, 58);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (98, 96);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (98, 31);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (98, 70);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (98, 92);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (98, 33);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (99, 28);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (99, 83);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (99, 4);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (99, 60);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (99, 69);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (100, 6);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (100, 35);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (100, 15);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (100, 97);
INSERT INTO `job_skills` (`job_id`, `skill_id`) VALUES (100, 16);

COMMIT;


-- -----------------------------------------------------
-- Data for table `contact`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (1, 3, 'Benji', 'Guerra', 'Junior Executive', 'Ntag', '332-438-2726', 'bguerra0@quantcast.com', 200, 1, '2017-10-12', '2017-06-05 20:30:41', '2017-03-23 07:16:57', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (2, 129, 'Patti', 'Tamsett', 'Web Developer IV', 'Livetube', '563-636-2052', 'ptamsett1@dailymotion.com', 82, 3, '2017-02-14', '2017-03-03 01:38:50', '2017-05-14 09:15:41', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (3, 111, 'Ellene', 'Licence', 'Human Resources Manager', 'Ainyx', '464-214-8861', 'elicence2@admin.ch', 157, 2, '2017-06-23', '2017-09-20 13:18:30', '2017-06-13 23:18:59', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (4, 143, 'Ilsa', 'Zavattari', 'Operator', 'Oodoo', '975-191-2278', 'izavattari3@woothemes.com', 144, 3, '2017-02-21', '2017-09-29 03:37:46', '2017-01-12 20:21:21', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (5, 127, 'Cassi', 'Dyson', 'Assistant Manager', 'Dabshots', '591-393-4699', 'cdyson4@umich.edu', 194, 1, '2017-11-03', '2017-03-01 22:53:52', '2017-11-30 17:48:52', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (6, 110, 'Melanie', 'Willman', 'Senior Sales Associate', 'Mudo', '663-866-4011', 'mwillman5@list-manage.com', 171, 2, '2017-07-08', '2017-04-05 00:05:25', '2017-06-13 04:40:01', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (7, 145, 'Obadias', 'Scramage', 'Social Worker', 'Topicshots', '142-969-8539', 'oscramage6@google.com.hk', 150, 5, '2017-08-26', '2017-05-14 11:07:57', '2017-09-04 03:06:57', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (8, 108, 'Karylin', 'Ebbs', 'Staff Scientist', 'Skyble', '412-193-7918', 'kebbs7@simplemachines.org', 17, 2, '2017-06-19', '2017-09-05 02:42:55', '2017-03-24 22:47:11', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (9, 68, 'Benji', 'Gobel', 'Nurse Practicioner', 'Tagfeed', '329-681-7243', 'bgobel8@wikispaces.com', 128, 5, '2017-06-09', '2017-11-16 00:36:16', '2017-01-15 19:58:06', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (10, 105, 'Dennet', 'Bricket', 'Software Test Engineer III', 'Oyope', '789-289-5986', 'dbricket9@lycos.com', 108, 4, '2017-09-24', '2017-12-02 06:40:56', '2017-03-09 01:07:15', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (11, 121, 'Jacquette', 'Dawidman', 'Mechanical Systems Engineer', 'Edgepulse', '647-233-2602', 'jdawidmana@people.com.cn', 173, 1, '2017-02-26', '2017-03-14 19:24:44', '2017-03-08 02:21:52', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (12, 48, 'Thurstan', 'Yakovitch', 'Actuary', 'Tazzy', '229-393-8301', 'tyakovitchb@smh.com.au', 67, 5, '2017-07-02', '2017-10-12 20:46:02', '2017-02-08 18:38:22', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (13, 122, 'Franny', 'Bunclark', 'Senior Sales Associate', 'Skibox', '666-242-7213', 'fbunclarkc@yahoo.com', 67, 3, '2017-04-27', '2017-11-27 01:43:03', '2017-11-16 07:56:14', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (14, 37, 'Shamus', 'Brickett', 'Quality Engineer', 'Plajo', '849-612-5231', 'sbrickettd@de.vu', 56, 5, '2017-03-15', '2018-01-10 17:30:37', '2017-08-14 20:43:09', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (15, 87, 'Hugues', 'Skoof', 'Programmer Analyst IV', 'Fadeo', '270-762-5491', 'hskoofe@nps.gov', 99, 5, '2017-12-29', '2017-06-28 16:25:00', '2017-04-03 05:46:06', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (16, 143, 'Jule', 'Di Biasi', 'Executive Secretary', 'Quinu', '193-720-4627', 'jdibiasif@mapquest.com', 193, 4, '2017-02-06', '2017-04-26 12:08:01', '2017-09-22 17:58:47', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (17, 39, 'Brandi', 'Jozwicki', 'Project Manager', 'Twitterwire', '868-218-4032', 'bjozwickig@berkeley.edu', 103, 5, '2017-10-29', '2017-12-16 06:56:52', '2017-08-27 20:55:04', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (18, 82, 'Joelle', 'Richarson', 'Nurse Practicioner', 'Mita', '518-763-0651', 'jricharsonh@icio.us', 150, 2, '2017-09-24', '2017-07-11 00:54:08', '2017-01-12 04:25:17', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (19, 6, 'Dave', 'Cloney', 'Payment Adjustment Coordinator', 'Chatterpoint', '327-950-5459', 'dcloneyi@washington.edu', 181, 4, '2017-03-05', '2017-05-10 14:54:15', '2017-05-17 02:30:46', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (20, 39, 'Marris', 'Mattedi', 'Civil Engineer', 'Dazzlesphere', '343-696-0069', 'mmattedij@wiley.com', 104, 3, '2017-08-28', '2017-03-01 10:15:36', '2017-12-21 01:32:05', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (21, 112, 'Caren', 'Pedri', 'Environmental Tech', 'Zoonder', '100-385-2738', 'cpedrik@ovh.net', 136, 2, '2017-10-14', '2017-01-31 00:57:09', '2017-10-09 11:11:42', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (22, 50, 'Amelia', 'Orsman', 'Pharmacist', 'Oloo', '819-413-4408', 'aorsmanl@technorati.com', 117, 5, '2017-04-11', '2017-07-07 15:26:21', '2017-12-30 09:48:14', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (23, 21, 'Bancroft', 'Conaghy', 'Software Engineer I', 'Ailane', '251-301-3313', 'bconaghym@netvibes.com', 33, 3, '2017-06-12', '2017-06-16 19:13:13', '2017-06-29 12:38:29', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (24, 123, 'Kissee', 'Kinner', 'Financial Advisor', 'Edgeclub', '485-967-6999', 'kkinnern@europa.eu', 34, 3, '2017-07-03', '2017-08-11 03:35:46', '2017-05-16 09:57:57', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (25, 67, 'Dottie', 'Matthew', 'Payment Adjustment Coordinator', 'Skiptube', '767-829-2873', 'dmatthewo@4shared.com', 55, 1, '2017-07-12', '2017-03-03 16:14:29', '2017-12-27 11:30:33', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (26, 67, 'Dodie', 'Reinhardt', 'Systems Administrator I', 'Jabberstorm', '282-162-2674', 'dreinhardtp@opera.com', 188, 2, '2017-10-08', '2017-04-29 06:06:10', '2017-01-28 12:33:07', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (27, 49, 'Rosalie', 'Hellens', 'Food Chemist', 'Jamia', '150-426-7181', 'rhellensq@oaic.gov.au', 8, 3, '2017-04-30', '2017-02-08 11:22:34', '2017-02-18 03:45:59', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (28, 19, 'Tamqrah', 'Dumbelton', 'Recruiting Manager', 'Flipopia', '247-110-1287', 'tdumbeltonr@yandex.ru', 23, 2, '2017-03-24', '2017-03-24 23:41:43', '2017-07-16 00:41:42', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (29, 31, 'Arthur', 'Carmen', 'Product Engineer', 'Skipfire', '445-604-8361', 'acarmens@ehow.com', 34, 1, '2017-11-05', '2017-06-10 19:30:06', '2017-11-10 16:00:47', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (30, 29, 'Gray', 'Muckley', 'Financial Analyst', 'Dynabox', '362-838-6285', 'gmuckleyt@feedburner.com', 199, 4, '2017-12-25', '2017-07-25 21:58:45', '2017-08-27 04:12:35', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (31, 72, 'Annie', 'Godlip', 'Administrative Officer', 'Dynabox', '538-768-3244', 'agodlipu@google.com.br', 124, 1, '2017-12-22', '2017-06-12 07:42:00', '2017-09-16 22:19:20', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (32, 130, 'Lisabeth', 'Miguel', 'Sales Representative', 'Edgeclub', '416-139-8075', 'lmiguelv@imdb.com', 61, 2, '2017-01-14', '2018-01-04 21:46:37', '2017-04-01 12:11:26', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (33, 148, 'Sebastian', 'Baunton', 'Financial Analyst', 'Buzzster', '678-924-7665', 'sbauntonw@tuttocitta.it', 89, 2, '2017-02-17', '2017-06-12 00:44:38', '2017-11-11 20:11:04', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (34, 77, 'Colas', 'Bellows', 'Web Developer II', 'Zoonder', '182-860-7092', 'cbellowsx@redcross.org', 18, 3, '2017-04-02', '2017-07-17 20:04:02', '2017-06-29 10:03:53', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (35, 43, 'Danyette', 'Lockyear', 'Assistant Manager', 'Skaboo', '457-867-2809', 'dlockyeary@vinaora.com', 190, 3, '2017-12-14', '2017-02-07 10:42:32', '2017-06-03 23:17:07', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (36, 9, 'Hurlee', 'Dodimead', 'Junior Executive', 'Rhyloo', '289-186-5380', 'hdodimeadz@newyorker.com', 158, 4, '2017-03-04', '2017-05-07 02:48:13', '2017-12-10 13:09:48', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (37, 146, 'Wolf', 'Haig', 'Financial Advisor', 'Wikivu', '995-530-9532', 'whaig10@forbes.com', 129, 2, '2017-04-26', '2017-04-27 08:54:58', '2017-01-25 21:28:10', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (38, 149, 'Georges', 'Blader', 'Recruiting Manager', 'Avavee', '167-828-1545', 'gblader11@salon.com', 54, 3, '2017-08-07', '2017-03-24 04:02:49', '2017-02-28 09:53:31', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (39, 67, 'Gualterio', 'Churn', 'Engineer IV', 'Latz', '370-140-2278', 'gchurn12@irs.gov', 142, 2, '2017-04-25', '2017-08-19 06:09:11', '2017-12-22 11:40:49', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (40, 9, 'Carissa', 'Aughtie', 'Sales Associate', 'Jaxspan', '973-223-1198', 'caughtie13@storify.com', 190, 4, '2017-06-21', '2017-01-18 08:36:12', '2017-08-21 00:36:17', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (41, 45, 'Donni', 'Cullotey', 'Administrative Officer', 'Mydeo', '536-405-7415', 'dcullotey14@usa.gov', 5, 3, '2017-10-09', '2018-01-04 05:19:31', '2017-01-29 02:49:27', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (42, 4, 'Isidora', 'Noel', 'Staff Accountant II', 'Innojam', '527-186-0762', 'inoel15@reddit.com', 105, 3, '2017-04-17', '2017-03-19 09:30:07', '2017-03-30 18:08:15', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (43, 135, 'Boris', 'Stowe', 'Nurse', 'Jabbercube', '431-341-6340', 'bstowe16@youtu.be', 79, 4, '2017-08-23', '2017-03-07 02:15:25', '2017-11-28 03:49:07', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (44, 31, 'Beaufort', 'Selburn', 'Human Resources Manager', 'Skyble', '881-602-0301', 'bselburn17@pcworld.com', 116, 1, '2017-03-25', '2017-11-01 14:15:37', '2017-04-13 00:25:43', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (45, 56, 'Eydie', 'Sparwell', 'Automation Specialist II', 'Photobug', '316-222-4149', 'esparwell18@ibm.com', 135, 3, '2017-10-17', '2017-05-03 01:41:48', '2017-12-21 21:43:37', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (46, 149, 'Janela', 'Loxton', 'Teacher', 'Talane', '373-489-0826', 'jloxton19@archive.org', 181, 1, '2017-05-22', '2017-08-04 12:53:09', '2017-07-28 20:25:41', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (47, 36, 'Niels', 'Sanger', 'Nurse', 'Eamia', '458-545-9843', 'nsanger1a@home.pl', 148, 1, '2017-06-26', '2017-08-18 20:30:55', '2017-01-28 03:37:25', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (48, 26, 'Elisabet', 'Ikins', 'Compensation Analyst', 'Meevee', '842-799-2440', 'eikins1b@linkedin.com', 137, 5, '2017-03-11', '2017-06-17 20:00:20', '2017-03-03 07:29:12', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (49, 139, 'Puff', 'Rosenvasser', 'Analog Circuit Design manager', 'Katz', '453-954-8545', 'prosenvasser1c@admin.ch', 195, 5, '2017-09-24', '2018-01-06 14:19:49', '2017-09-19 12:07:11', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (50, 8, 'Doreen', 'Rushbrooke', 'Financial Advisor', 'Digitube', '245-364-2680', 'drushbrooke1d@sphinn.com', 134, 5, '2017-04-27', '2017-03-29 09:27:20', '2017-06-20 07:30:49', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (51, 24, 'Abrahan', 'Mulholland', 'Business Systems Development Analyst', 'Topicstorm', '730-225-0417', 'amulholland1e@yolasite.com', 148, 2, '2017-12-03', '2017-05-18 12:04:35', '2017-12-11 09:17:18', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (52, 39, 'Maribel', 'Wortt', 'Sales Representative', 'Photolist', '512-244-6020', 'mwortt1f@wiley.com', 147, 3, '2017-12-28', '2017-03-01 05:25:57', '2017-03-05 04:12:31', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (53, 150, 'Regen', 'Coffey', 'Product Engineer', 'Vitz', '148-490-5951', 'rcoffey1g@shinystat.com', 30, 2, '2017-07-08', '2017-10-13 13:36:42', '2017-10-18 04:41:54', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (54, 95, 'Lyda', 'Merrisson', 'Paralegal', 'Twiyo', '295-980-0668', 'lmerrisson1h@aboutads.info', 95, 4, '2017-01-25', '2017-04-10 19:30:52', '2017-04-08 20:18:02', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (55, 53, 'Tandi', 'Udey', 'Operator', 'Gigabox', '787-401-3859', 'tudey1i@springer.com', 35, 2, '2017-11-21', '2017-04-27 03:49:03', '2017-08-16 05:54:38', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (56, 1, 'Randy', 'McPhater', 'Desktop Support Technician', 'Dynabox', '462-349-1628', 'rmcphater1j@mtv.com', 168, 5, '2017-05-09', '2017-09-04 15:40:24', '2017-07-23 08:26:56', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (57, 42, 'Maxine', 'Brame', 'Speech Pathologist', 'Blogpad', '716-514-6037', 'mbrame1k@blog.com', 112, 1, '2017-06-08', '2018-01-05 19:30:21', '2017-10-28 17:20:04', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (58, 28, 'Jo', 'Gauson', 'Marketing Assistant', 'Pixope', '926-432-8186', 'jgauson1l@myspace.com', 2, 3, '2017-12-09', '2017-09-18 20:04:50', '2017-05-07 11:47:18', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (59, 127, 'Rosalinde', 'Swaby', 'Director of Sales', 'Browsedrive', '904-618-7221', 'rswaby1m@yahoo.com', 165, 1, '2017-09-19', '2017-08-18 16:29:34', '2017-02-18 10:43:45', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (60, 23, 'Gunter', 'Denne', 'Geologist III', 'Ainyx', '649-171-6304', 'gdenne1n@hao123.com', 67, 3, '2017-11-12', '2017-02-12 00:18:00', '2017-05-13 23:44:59', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (61, 108, 'Evangeline', 'Gosnall', 'Project Manager', 'Quinu', '811-283-1105', 'egosnall1o@netlog.com', 32, 4, '2017-09-24', '2017-06-18 05:13:56', '2017-08-10 17:06:37', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (62, 134, 'Brigida', 'Footitt', 'Chemical Engineer', 'Camido', '664-318-7696', 'bfootitt1p@creativecommons.org', 23, 5, '2017-04-26', '2017-10-06 17:10:31', '2017-06-19 05:12:11', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (63, 110, 'Lissy', 'Hinners', 'Food Chemist', 'Zooveo', '306-171-6936', 'lhinners1q@macromedia.com', 40, 3, '2017-08-09', '2017-11-23 08:56:36', '2017-03-21 14:06:56', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (64, 82, 'Josefa', 'Rosle', 'Compensation Analyst', 'Shuffletag', '414-337-5878', 'jrosle1r@purevolume.com', 171, 3, '2017-02-27', '2017-05-04 19:48:31', '2017-05-04 09:54:05', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (65, 61, 'Lyman', 'Lyptrit', 'Structural Analysis Engineer', 'Flashspan', '988-487-5899', 'llyptrit1s@weather.com', 133, 2, '2017-12-07', '2017-01-29 06:15:48', '2017-08-05 17:33:27', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (66, 1, 'Jorie', 'Ellerey', 'Financial Analyst', 'Kazio', '124-933-5687', 'jellerey1t@hibu.com', 181, 3, '2017-08-26', '2017-06-27 02:09:11', '2017-10-27 14:18:20', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (67, 84, 'Crista', 'Rhys', 'Mechanical Systems Engineer', 'Thoughtsphere', '643-370-8540', 'crhys1u@oaic.gov.au', 67, 5, '2017-09-24', '2017-12-10 10:39:50', '2017-11-07 01:50:13', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (68, 110, 'Monti', 'Allibone', 'Nurse', 'Flipbug', '823-779-1119', 'mallibone1v@ed.gov', 164, 1, '2017-07-23', '2017-06-13 03:47:46', '2017-01-21 23:15:17', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (69, 147, 'Rafaellle', 'Tradewell', 'Data Coordiator', 'Linkbridge', '669-809-5641', 'rtradewell1w@upenn.edu', 171, 1, '2017-09-26', '2017-09-24 23:36:53', '2017-06-06 02:38:48', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (70, 58, 'Chase', 'Yegoshin', 'Legal Assistant', 'Fiveclub', '531-515-7992', 'cyegoshin1x@multiply.com', 36, 4, '2017-09-18', '2017-06-18 04:54:31', '2017-12-17 04:59:47', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (71, 44, 'Leonanie', 'Cadden', 'Account Executive', 'Browsebug', '488-653-9138', 'lcadden1y@a8.net', 30, 3, '2017-09-15', '2017-04-19 22:51:01', '2017-04-15 11:53:53', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (72, 83, 'Chen', 'Gilderoy', 'Help Desk Operator', 'Lajo', '622-713-4477', 'cgilderoy1z@hibu.com', 36, 1, '2017-03-07', '2017-05-23 21:01:45', '2017-01-12 10:36:26', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (73, 46, 'Kenna', 'O\'Regan', 'Structural Analysis Engineer', 'Demimbu', '126-908-3102', 'koregan20@nytimes.com', 59, 1, '2017-08-24', '2017-05-29 03:31:01', '2017-12-26 22:56:42', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (74, 33, 'Carlotta', 'Ramsbotham', 'Automation Specialist II', 'Realbuzz', '843-304-0930', 'cramsbotham21@nationalgeographic.com', 105, 5, '2017-08-14', '2017-04-10 11:00:00', '2017-10-27 16:07:24', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (75, 51, 'Ronalda', 'Mawtus', 'Librarian', 'Browsebug', '567-246-6685', 'rmawtus22@1688.com', 19, 4, '2017-10-13', '2017-07-30 03:50:26', '2017-09-27 10:01:23', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (76, 51, 'Scarlet', 'Rudeyeard', 'Automation Specialist III', 'Trilith', '664-424-5042', 'srudeyeard23@phoca.cz', 4, 4, '2017-06-07', '2017-10-03 00:37:05', '2017-08-19 21:34:03', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (77, 51, 'Myles', 'Nijs', 'Programmer II', 'Edgeclub', '761-351-8463', 'mnijs24@pinterest.com', 119, 4, '2017-06-24', '2017-09-26 23:19:33', '2017-02-21 12:18:43', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (78, 140, 'Flore', 'Garces', 'Graphic Designer', 'Thoughtstorm', '399-592-3040', 'fgarces25@ustream.tv', 54, 2, '2017-01-24', '2017-06-01 00:09:04', '2017-11-28 04:51:59', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (79, 124, 'Bettine', 'Gehricke', 'Marketing Manager', 'Skimia', '284-796-1164', 'bgehricke26@sun.com', 9, 1, '2017-07-22', '2017-12-24 19:04:47', '2017-11-25 08:36:29', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (80, 27, 'Graig', 'Tregoning', 'VP Accounting', 'Avaveo', '725-166-7675', 'gtregoning27@pcworld.com', 113, 1, '2017-01-28', '2017-03-09 07:41:53', '2017-09-29 14:15:23', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (81, 69, 'Reta', 'Cuddy', 'Research Associate', 'Eire', '431-383-3326', 'rcuddy28@walmart.com', 134, 1, '2017-11-29', '2017-08-27 17:07:39', '2017-02-26 23:00:22', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (82, 124, 'Reggie', 'Masden', 'Quality Engineer', 'Lajo', '174-377-5065', 'rmasden29@google.de', 69, 3, '2017-12-28', '2017-02-21 21:27:49', '2017-11-22 09:56:48', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (83, 139, 'Cristen', 'Poulton', 'Geologist III', 'Vimbo', '704-364-7371', 'cpoulton2a@eepurl.com', 95, 1, '2017-02-23', '2017-05-02 10:47:06', '2017-01-29 10:21:40', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (84, 72, 'Mackenzie', 'Barthelet', 'VP Marketing', 'Meezzy', '148-764-2768', 'mbarthelet2b@statcounter.com', 92, 4, '2017-02-06', '2017-04-27 23:31:47', '2017-06-06 21:20:47', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (85, 87, 'Beltran', 'Huddart', 'Human Resources Manager', 'Feedspan', '300-856-3372', 'bhuddart2c@psu.edu', 145, 2, '2017-06-11', '2017-02-01 05:19:22', '2017-04-02 08:42:41', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (86, 138, 'Yehudi', 'Ivanovic', 'Dental Hygienist', 'Quamba', '212-721-3321', 'yivanovic2d@aol.com', 136, 2, '2017-08-28', '2017-12-28 19:39:35', '2017-02-08 15:41:22', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (87, 140, 'Korney', 'Vanne', 'Senior Quality Engineer', 'Centimia', '302-955-0240', 'kvanne2e@google.cn', 130, 4, '2017-05-29', '2017-01-19 15:56:03', '2017-04-30 01:29:45', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (88, 126, 'Rey', 'Cauthra', 'VP Sales', 'Skyvu', '820-870-0946', 'rcauthra2f@uiuc.edu', 31, 5, '2017-07-19', '2017-11-09 23:02:00', '2017-12-23 02:43:13', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (89, 49, 'Mord', 'Colebourn', 'Technical Writer', 'Aivee', '787-856-3723', 'mcolebourn2g@yellowpages.com', 159, 2, '2017-09-28', '2017-10-01 22:15:26', '2017-10-09 13:37:28', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (90, 137, 'Sonnie', 'Hymans', 'Electrical Engineer', 'Digitube', '345-729-3371', 'shymans2h@blogger.com', 12, 4, '2017-06-10', '2017-01-19 11:35:18', '2017-04-03 18:31:56', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (91, 77, 'Freddy', 'Guerreru', 'Recruiting Manager', 'Thoughtblab', '643-208-4616', 'fguerreru2i@bandcamp.com', 89, 4, '2017-05-13', '2017-10-04 03:23:43', '2017-05-01 13:04:37', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (92, 110, 'Kean', 'Gapper', 'Software Consultant', 'Devbug', '139-709-4439', 'kgapper2j@deviantart.com', 122, 1, '2017-10-22', '2017-12-16 21:18:13', '2017-05-01 06:37:36', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (93, 104, 'Costanza', 'Stollhofer', 'Librarian', 'Camido', '120-208-9596', 'cstollhofer2k@posterous.com', 53, 4, '2017-09-21', '2017-05-25 23:03:55', '2017-09-06 13:43:30', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (94, 63, 'Glynis', 'Jost', 'Quality Engineer', 'Oozz', '576-934-9487', 'gjost2l@example.com', 152, 1, '2017-10-20', '2017-04-06 12:13:43', '2017-07-31 15:22:15', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (95, 83, 'Ibby', 'Leser', 'Computer Systems Analyst I', 'DabZ', '439-848-2231', 'ileser2m@google.nl', 194, 2, '2017-04-04', '2017-09-03 11:03:26', '2017-09-03 23:06:53', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (96, 127, 'Britt', 'Vasiljevic', 'Human Resources Manager', 'Devbug', '202-351-9783', 'bvasiljevic2n@vkontakte.ru', 66, 5, '2017-12-20', '2017-05-17 01:01:11', '2017-10-03 08:46:13', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (97, 101, 'Alie', 'Witherington', 'Staff Scientist', 'Pixope', '408-293-4527', 'awitherington2o@vistaprint.com', 55, 3, '2017-03-26', '2017-10-02 08:07:47', '2017-01-25 23:34:20', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (98, 73, 'Ingeberg', 'Maytum', 'Budget/Accounting Analyst I', 'Flashdog', '994-516-7922', 'imaytum2p@utexas.edu', 51, 3, '2017-08-08', '2017-08-18 16:33:30', '2017-09-27 05:45:53', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (99, 2, 'Fleurette', 'Terry', 'Tax Accountant', 'DabZ', '813-416-6023', 'fterry2q@1688.com', 72, 4, '2017-04-12', '2017-11-07 00:58:31', '2017-04-22 19:09:01', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (100, 33, 'Marti', 'Trollope', 'Accounting Assistant III', 'Voomm', '142-408-2794', 'mtrollope2r@mediafire.com', 142, 5, '2017-08-16', '2017-09-20 17:01:11', '2017-05-27 05:02:13', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (101, 122, 'Quent', 'Westmore', 'Professor', 'Fadeo', '309-526-4741', 'qwestmore2s@rambler.ru', 46, 3, '2017-02-12', '2017-07-19 19:38:50', '2017-09-09 09:04:16', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (102, 54, 'Dode', 'Clery', 'Project Manager', 'Aimbo', '422-807-8786', 'dclery2t@nhs.uk', 154, 4, '2017-10-07', '2017-02-27 08:12:51', '2017-10-24 01:02:48', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (103, 11, 'Horace', 'Battershall', 'Sales Representative', 'Mudo', '922-316-8454', 'hbattershall2u@alibaba.com', 71, 2, '2017-06-25', '2017-05-20 02:18:42', '2017-02-18 15:43:02', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (104, 136, 'Bret', 'Pleasance', 'Geological Engineer', 'Eazzy', '695-528-5812', 'bpleasance2v@oakley.com', 179, 5, '2017-01-25', '2017-10-21 21:35:30', '2017-06-28 10:48:04', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (105, 19, 'Charil', 'Orgen', 'VP Sales', 'Innotype', '608-400-9531', 'corgen2w@geocities.jp', 139, 4, '2017-02-18', '2017-04-10 03:02:03', '2017-07-09 03:53:36', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (106, 100, 'Erda', 'Godber', 'Financial Advisor', 'Vitz', '713-812-4316', 'egodber2x@dyndns.org', 72, 2, '2017-04-21', '2017-05-29 06:57:47', '2017-05-04 04:06:53', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (107, 22, 'Lucinda', 'Janos', 'Developer II', 'Livetube', '395-722-1391', 'ljanos2y@seattletimes.com', 68, 3, '2017-09-28', '2017-10-23 00:06:36', '2017-03-21 06:18:25', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (108, 91, 'Eugene', 'Huffa', 'Help Desk Operator', 'Trunyx', '911-473-4522', 'ehuffa2z@printfriendly.com', 183, 2, '2017-03-15', '2017-04-19 07:44:48', '2017-09-05 23:23:39', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (109, 10, 'Elyse', 'Whight', 'VP Marketing', 'Livetube', '665-364-8948', 'ewhight30@reverbnation.com', 15, 5, '2017-06-27', '2018-01-03 19:20:28', '2017-01-20 21:51:09', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (110, 55, 'Garner', 'Kurtis', 'Physical Therapy Assistant', 'Tazzy', '643-704-6533', 'gkurtis31@myspace.com', 15, 3, '2017-01-12', '2017-05-06 03:48:15', '2017-09-12 12:19:54', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (111, 16, 'Krissy', 'Sunshine', 'Help Desk Technician', 'Meembee', '581-263-6453', 'ksunshine32@myspace.com', 158, 1, '2017-08-19', '2017-06-13 21:49:41', '2017-11-21 08:51:00', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (112, 59, 'Fidel', 'Leason', 'Sales Associate', 'Voolith', '521-482-9500', 'fleason33@quantcast.com', 38, 2, '2017-02-19', '2017-10-01 10:12:10', '2017-03-22 07:10:30', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (113, 23, 'Barr', 'Garci', 'Research Associate', 'Realcube', '467-414-4240', 'bgarci34@foxnews.com', 4, 1, '2017-04-11', '2017-11-10 22:25:03', '2017-12-20 07:42:59', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (114, 106, 'Denis', 'Caple', 'General Manager', 'Centimia', '822-727-8839', 'dcaple35@japanpost.jp', 170, 4, '2017-10-10', '2017-12-27 15:53:20', '2017-01-25 14:47:16', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (115, 24, 'Hayes', 'Merdew', 'Safety Technician II', 'Lajo', '632-183-2093', 'hmerdew36@ft.com', 44, 4, '2017-07-30', '2017-05-27 14:47:34', '2017-09-20 15:42:45', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (116, 75, 'Yulma', 'Abbotts', 'Analyst Programmer', 'Riffpath', '509-256-9308', 'yabbotts37@skype.com', 142, 1, '2017-03-15', '2017-01-28 09:20:06', '2017-10-31 10:11:37', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (117, 146, 'Ignacius', 'Okey', 'Information Systems Manager', 'Tavu', '649-995-1986', 'iokey38@redcross.org', 16, 5, '2017-10-08', '2017-10-08 08:05:41', '2017-11-11 07:59:09', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (118, 148, 'Barbey', 'Basile', 'Senior Quality Engineer', 'Reallinks', '492-965-1340', 'bbasile39@squidoo.com', 116, 5, '2017-08-14', '2017-12-03 11:44:37', '2017-12-07 23:37:14', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (119, 7, 'Sly', 'Sharply', 'Software Consultant', 'Photobug', '252-876-8683', 'ssharply3a@google.nl', 123, 5, '2017-07-15', '2017-10-29 11:00:55', '2017-07-03 06:17:29', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (120, 42, 'Roanne', 'Argont', 'Assistant Professor', 'Teklist', '513-110-6139', 'rargont3b@wikispaces.com', 191, 3, '2017-10-02', '2017-06-07 20:47:06', '2017-02-20 18:36:49', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (121, 36, 'Wittie', 'Jandourek', 'Dental Hygienist', 'Podcat', '351-975-3216', 'wjandourek3c@home.pl', 183, 2, '2018-01-07', '2017-02-08 04:31:02', '2017-02-06 06:26:05', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (122, 63, 'Kaela', 'Romer', 'Analog Circuit Design manager', 'Topicstorm', '700-864-0685', 'kromer3d@apple.com', 106, 4, '2017-09-14', '2017-06-09 05:14:05', '2017-07-25 18:50:53', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (123, 56, 'Austen', 'Sent', 'Senior Cost Accountant', 'Photobug', '614-161-1212', 'asent3e@google.pl', 200, 2, '2017-03-06', '2017-01-20 09:26:22', '2017-05-13 12:27:00', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (124, 73, 'Janot', 'Brusin', 'Environmental Specialist', 'Gigabox', '123-890-6454', 'jbrusin3f@jimdo.com', 112, 3, '2017-07-20', '2017-05-10 17:23:11', '2017-02-07 14:24:40', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (125, 101, 'Robin', 'Kehoe', 'Research Nurse', 'Blogtag', '415-664-4517', 'rkehoe3g@vimeo.com', 12, 5, '2017-07-20', '2017-07-02 18:13:33', '2017-10-27 19:14:16', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (126, 52, 'Melly', 'Nevill', 'Project Manager', 'Edgetag', '280-474-7099', 'mnevill3h@comsenz.com', 148, 3, '2017-10-23', '2017-10-24 20:56:35', '2017-11-03 07:39:08', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (127, 75, 'Yorgo', 'O\'Driscoll', 'Compensation Analyst', 'Viva', '773-782-5195', 'yodriscoll3i@theguardian.com', 85, 3, '2017-08-24', '2017-11-29 08:07:05', '2017-02-19 05:23:58', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (128, 118, 'Ximenez', 'Treadway', 'Analog Circuit Design manager', 'Edgeify', '807-706-4547', 'xtreadway3j@hc360.com', 3, 2, '2018-01-02', '2017-10-15 02:22:03', '2017-02-07 05:58:53', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (129, 69, 'Mechelle', 'Coton', 'Database Administrator IV', 'Skipfire', '475-313-9282', 'mcoton3k@businessinsider.com', 20, 5, '2017-11-29', '2017-03-02 13:47:33', '2017-09-16 14:10:57', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (130, 55, 'Dirk', 'Bartolomeazzi', 'Accounting Assistant I', 'Linkbridge', '284-814-0544', 'dbartolomeazzi3l@exblog.jp', 45, 5, '2017-11-05', '2017-09-13 18:31:11', '2017-11-20 06:11:04', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (131, 70, 'Megen', 'Liccardi', 'Senior Financial Analyst', 'Realcube', '672-241-3198', 'mliccardi3m@ucoz.ru', 67, 3, '2017-10-06', '2017-01-26 09:36:14', '2017-06-10 08:06:51', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (132, 96, 'Alayne', 'Fleg', 'Data Coordiator', 'Topicware', '405-304-9432', 'afleg3n@indiegogo.com', 105, 1, '2017-05-14', '2017-06-21 08:40:46', '2017-10-21 19:28:03', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (133, 140, 'Kane', 'MacWhan', 'Programmer Analyst IV', 'Kaymbo', '608-207-9560', 'kmacwhan3o@gnu.org', 65, 1, '2017-04-17', '2017-08-14 15:40:54', '2017-12-23 20:14:59', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (134, 47, 'Diena', 'Seiller', 'Associate Professor', 'Wikido', '138-963-4338', 'dseiller3p@boston.com', 108, 2, '2017-09-14', '2018-01-09 06:53:23', '2017-01-29 10:11:30', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (135, 17, 'Harlene', 'Pechold', 'Librarian', 'Twinder', '779-660-9960', 'hpechold3q@reuters.com', 176, 4, '2017-06-02', '2017-04-19 09:11:25', '2017-07-22 16:21:41', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (136, 100, 'Doralynn', 'Floch', 'Accounting Assistant I', 'Talane', '179-491-4719', 'dfloch3r@ted.com', 5, 2, '2017-05-08', '2017-12-21 23:06:04', '2017-10-26 18:05:26', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (137, 38, 'Jacinda', 'Webermann', 'Account Executive', 'Fiveclub', '581-903-5453', 'jwebermann3s@people.com.cn', 143, 3, '2017-05-02', '2017-12-08 10:43:07', '2017-11-18 21:50:55', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (138, 39, 'Kristo', 'Beels', 'Office Assistant IV', 'Fiveclub', '974-966-1286', 'kbeels3t@tamu.edu', 138, 5, '2017-09-11', '2017-08-13 03:46:11', '2017-01-16 20:32:07', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (139, 87, 'Edgard', 'Heighway', 'Developer III', 'Dabfeed', '239-765-8998', 'eheighway3u@mail.ru', 172, 2, '2017-08-21', '2017-09-28 06:19:09', '2017-10-10 18:54:16', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (140, 17, 'Cheryl', 'Ottee', 'Database Administrator III', 'Lajo', '948-651-7118', 'cottee3v@163.com', 71, 2, '2017-06-16', '2017-05-11 04:33:10', '2017-02-20 13:08:07', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (141, 150, 'Ad', 'Vasilik', 'Social Worker', 'Topiczoom', '718-533-2920', 'avasilik3w@geocities.jp', 70, 2, '2017-01-13', '2017-07-16 22:50:02', '2017-05-24 04:14:19', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (142, 124, 'Elwira', 'Scolding', 'Operator', 'Plambee', '586-566-3376', 'escolding3x@walmart.com', 78, 4, '2017-11-11', '2017-06-07 13:05:55', '2017-11-16 13:18:24', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (143, 25, 'Emalee', 'Jakel', 'Human Resources Manager', 'Snaptags', '492-909-8972', 'ejakel3y@aol.com', 168, 5, '2017-09-05', '2017-10-13 11:17:52', '2017-06-09 11:45:24', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (144, 24, 'Lesley', 'Pilley', 'Nurse', 'Zoomlounge', '782-102-2705', 'lpilley3z@microsoft.com', 22, 2, '2017-06-28', '2017-04-04 18:21:04', '2017-11-05 17:55:17', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (145, 21, 'Maribelle', 'McSkin', 'Human Resources Manager', 'Mybuzz', '379-837-0212', 'mmcskin40@aboutads.info', 105, 4, '2017-06-07', '2017-07-01 01:17:58', '2017-05-23 20:35:25', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (146, 23, 'Linet', 'Fone', 'Help Desk Technician', 'Roomm', '635-516-9983', 'lfone41@friendfeed.com', 17, 4, '2017-05-16', '2017-01-21 10:00:11', '2017-04-04 04:47:03', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (147, 21, 'Jarret', 'Warby', 'Design Engineer', 'Yambee', '484-375-9539', 'jwarby42@businessinsider.com', 143, 2, '2017-02-23', '2017-12-25 04:17:55', '2017-01-24 17:16:02', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (148, 13, 'Mimi', 'Venton', 'GIS Technical Architect', 'Devshare', '310-538-2344', 'mventon43@redcross.org', 186, 2, '2017-09-08', '2017-12-26 12:51:21', '2017-10-18 12:02:30', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (149, 148, 'Gilbertine', 'Spinke', 'Analog Circuit Design manager', 'Browsezoom', '747-543-5066', 'gspinke44@phpbb.com', 106, 2, '2017-05-20', '2017-04-30 14:07:19', '2017-09-06 22:09:41', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (150, 25, 'Corly', 'Kennedy', 'Marketing Assistant', 'Gabtype', '325-817-4794', 'ckennedy45@privacy.gov.au', 142, 4, '2017-05-28', '2017-08-13 11:47:46', '2017-08-08 18:16:51', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (151, 1, 'Francesca', 'McGrory', 'Nurse', 'Realcube', '629-665-5606', 'fmcgrory46@engadget.com', 88, 4, '2017-02-12', '2017-10-01 10:47:41', '2017-12-28 09:08:01', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (152, 148, 'Burgess', 'Seally', 'Chemical Engineer', 'Eimbee', '501-163-9892', 'bseally47@aol.com', 34, 3, '2017-05-24', '2017-02-03 07:42:10', '2017-09-03 05:22:47', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (153, 42, 'Sigrid', 'Bridgewater', 'Assistant Professor', 'Flashpoint', '581-646-9698', 'sbridgewater48@nature.com', 191, 1, '2017-08-07', '2017-08-11 16:31:41', '2017-03-29 09:06:07', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (154, 25, 'Etan', 'Luparti', 'Senior Quality Engineer', 'Fivechat', '485-466-9889', 'eluparti49@aol.com', 155, 3, '2017-09-10', '2017-02-11 19:42:05', '2017-02-17 11:30:32', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (155, 97, 'Palm', 'Cattlow', 'Staff Scientist', 'Skidoo', '789-450-7267', 'pcattlow4a@desdev.cn', 69, 4, '2017-09-24', '2017-01-25 13:16:06', '2017-12-16 10:33:34', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (156, 23, 'Casi', 'Barrington', 'Business Systems Development Analyst', 'Mita', '676-763-4138', 'cbarrington4b@e-recht24.de', 25, 2, '2017-01-28', '2017-11-09 23:53:20', '2017-10-08 10:32:40', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (157, 74, 'Allegra', 'Caudle', 'Senior Sales Associate', 'Oyoba', '126-702-5530', 'acaudle4c@unicef.org', 123, 1, '2017-07-06', '2017-04-06 07:25:34', '2017-03-13 20:37:17', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (158, 89, 'Rae', 'Shepstone', 'Engineer II', 'Gigazoom', '467-957-8429', 'rshepstone4d@latimes.com', 53, 5, '2017-06-18', '2017-01-14 15:54:19', '2017-02-15 08:18:14', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (159, 145, 'Waldo', 'Boykett', 'Executive Secretary', 'Fivespan', '223-436-5492', 'wboykett4e@reddit.com', 190, 3, '2018-01-10', '2017-05-28 18:48:28', '2017-03-22 08:27:03', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (160, 20, 'Lyssa', 'Killingworth', 'Information Systems Manager', 'Eare', '720-211-4122', 'lkillingworth4f@irs.gov', 129, 4, '2017-05-29', '2017-08-04 04:38:24', '2017-04-12 14:38:58', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (161, 81, 'Brendon', 'Briscam', 'Sales Representative', 'Jaxbean', '692-693-3611', 'bbriscam4g@gizmodo.com', 41, 3, '2017-04-16', '2017-06-16 16:58:11', '2017-03-20 07:14:33', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (162, 32, 'Gillan', 'Milsom', 'Chemical Engineer', 'Voolia', '239-976-3785', 'gmilsom4h@squarespace.com', 43, 5, '2017-11-22', '2017-01-28 06:49:58', '2017-09-19 13:26:54', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (163, 10, 'Hillel', 'Dooman', 'Software Consultant', 'Jayo', '285-708-4853', 'hdooman4i@fotki.com', 184, 4, '2017-03-28', '2017-05-12 22:02:25', '2017-11-20 10:08:23', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (164, 23, 'Lou', 'Ratledge', 'Actuary', 'Voomm', '789-469-6427', 'lratledge4j@plala.or.jp', 42, 1, '2017-04-15', '2017-06-20 01:14:52', '2018-01-07 18:53:30', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (165, 108, 'Samantha', 'Molen', 'Staff Accountant IV', 'Edgetag', '312-409-1322', 'smolen4k@blinklist.com', 8, 2, '2017-03-04', '2017-09-24 18:44:41', '2018-01-02 18:46:13', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (166, 97, 'Chrisy', 'Uridge', 'Human Resources Manager', 'Thoughtsphere', '849-222-4844', 'curidge4l@discovery.com', 116, 3, '2017-04-15', '2017-08-05 15:45:21', '2017-05-19 14:12:42', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (167, 137, 'Marin', 'Twatt', 'Paralegal', 'Quimm', '383-889-0790', 'mtwatt4m@unc.edu', 82, 1, '2017-11-12', '2018-01-04 00:37:25', '2017-03-18 04:34:29', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (168, 144, 'Byron', 'Ather', 'Occupational Therapist', 'Topicblab', '250-526-5378', 'bather4n@ebay.com', 169, 4, '2017-08-22', '2017-02-03 07:00:24', '2017-09-22 08:52:06', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (169, 80, 'Alvan', 'Shutle', 'Accounting Assistant III', 'Blogtags', '257-959-6834', 'ashutle4o@dell.com', 40, 3, '2017-01-20', '2017-07-14 18:13:33', '2017-04-19 17:31:33', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (170, 63, 'Bret', 'Haynes', 'Nuclear Power Engineer', 'Kaymbo', '257-780-2345', 'bhaynes4p@naver.com', 118, 2, '2017-05-10', '2017-07-23 07:38:52', '2017-03-17 23:43:30', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (171, 17, 'Forester', 'McGeoch', 'Information Systems Manager', 'Trudeo', '742-600-2875', 'fmcgeoch4q@amazon.de', 166, 3, '2017-04-06', '2017-10-21 10:36:26', '2017-04-08 23:43:15', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (172, 12, 'Gustav', 'Boscher', 'Associate Professor', 'Pixoboo', '728-261-5027', 'gboscher4r@google.co.jp', 153, 4, '2017-08-08', '2017-07-08 21:21:20', '2017-09-10 15:55:28', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (173, 57, 'Brok', 'Batthew', 'Electrical Engineer', 'Youspan', '630-370-3032', 'bbatthew4s@youtu.be', 28, 5, '2017-09-18', '2017-06-05 14:32:45', '2017-06-29 03:05:57', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (174, 13, 'Babette', 'Fulcher', 'Teacher', 'Divape', '644-809-4742', 'bfulcher4t@freewebs.com', 112, 4, '2017-03-06', '2017-06-14 18:26:37', '2017-04-25 19:09:45', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (175, 125, 'Marylinda', 'Stiles', 'Community Outreach Specialist', 'Vidoo', '258-520-3498', 'mstiles4u@technorati.com', 189, 1, '2017-04-05', '2017-02-28 03:04:11', '2017-10-05 20:19:35', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (176, 29, 'Bev', 'Boschmann', 'Account Representative I', 'Gabspot', '729-300-6830', 'bboschmann4v@disqus.com', 13, 4, '2017-01-30', '2017-01-16 08:20:14', '2017-10-09 22:27:36', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (177, 8, 'Baillie', 'Paulillo', 'Compensation Analyst', 'Skippad', '595-877-8264', 'bpaulillo4w@123-reg.co.uk', 85, 5, '2017-09-11', '2017-08-16 08:17:42', '2017-07-21 23:04:31', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (178, 40, 'Cathi', 'Allmark', 'Analyst Programmer', 'Edgeify', '213-620-4520', 'callmark4x@cyberchimps.com', 6, 5, '2017-11-20', '2017-10-14 12:13:27', '2017-07-09 04:54:37', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (179, 142, 'Chantalle', 'Tenant', 'Automation Specialist IV', 'Skipfire', '381-347-8272', 'ctenant4y@eventbrite.com', 4, 5, '2017-02-08', '2017-11-27 01:48:18', '2017-10-23 01:51:43', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (180, 35, 'Perry', 'Ezele', 'Media Manager II', 'Demizz', '865-515-0566', 'pezele4z@techcrunch.com', 183, 1, '2017-11-19', '2017-07-28 01:00:08', '2017-10-30 16:29:18', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (181, 20, 'Justen', 'Oliphant', 'Civil Engineer', 'Abatz', '819-818-4614', 'joliphant50@surveymonkey.com', 190, 4, '2017-03-23', '2017-01-18 22:21:54', '2017-06-29 08:30:45', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (182, 130, 'Ivie', 'Lillow', 'Editor', 'Jetwire', '715-232-8540', 'ilillow51@feedburner.com', 118, 3, '2017-11-21', '2017-06-04 18:03:46', '2017-04-19 06:33:30', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (183, 127, 'Fred', 'Priestnall', 'Recruiter', 'Voomm', '824-542-8513', 'fpriestnall52@bing.com', 31, 3, '2017-03-29', '2017-08-02 17:20:04', '2017-11-19 14:53:14', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (184, 39, 'Daphna', 'Steger', 'Pharmacist', 'Divape', '338-484-3419', 'dsteger53@over-blog.com', 82, 1, '2017-05-31', '2017-12-13 07:23:07', '2017-12-04 04:15:02', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (185, 99, 'Cymbre', 'Walls', 'Office Assistant IV', 'Brightbean', '450-587-2777', 'cwalls54@europa.eu', 61, 4, '2017-03-26', '2017-05-02 08:41:31', '2017-05-10 03:30:15', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (186, 34, 'Emanuele', 'Heales', 'Librarian', 'Jaloo', '770-627-1698', 'eheales55@zimbio.com', 93, 3, '2017-12-21', '2017-02-10 13:42:23', '2017-06-09 02:41:44', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (187, 54, 'Elmira', 'Cussen', 'Human Resources Manager', 'Eimbee', '260-767-1094', 'ecussen56@netlog.com', 150, 4, '2018-01-04', '2017-05-31 23:06:25', '2017-05-26 23:19:44', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (188, 67, 'Angele', 'Befroy', 'Senior Quality Engineer', 'Ailane', '497-268-2358', 'abefroy57@moonfruit.com', 189, 4, '2017-07-27', '2017-10-06 17:45:00', '2017-07-31 02:30:51', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (189, 126, 'Lorens', 'Hurleston', 'Software Engineer III', 'Flashpoint', '758-678-6171', 'lhurleston58@jalbum.net', 166, 3, '2017-07-25', '2017-09-29 15:38:28', '2017-08-18 05:47:06', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (190, 92, 'Hazel', 'Hector', 'Graphic Designer', 'Babblestorm', '389-281-5816', 'hhector59@jugem.jp', 6, 1, '2017-05-02', '2017-03-04 16:21:39', '2017-11-14 09:26:45', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (191, 97, 'Amalia', 'Goldine', 'Automation Specialist I', 'Viva', '361-233-3314', 'agoldine5a@blogtalkradio.com', 124, 2, '2017-09-20', '2017-06-14 03:19:08', '2017-07-24 21:46:17', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (192, 8, 'Gayle', 'Djekovic', 'Web Developer II', 'Skilith', '703-916-5612', 'gdjekovic5b@blogger.com', 161, 1, '2017-06-28', '2017-03-27 11:29:02', '2017-10-24 18:26:20', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (193, 67, 'Ida', 'Iacomini', 'Director of Sales', 'Kwimbee', '818-365-6803', 'iiacomini5c@harvard.edu', 56, 1, '2017-12-13', '2017-06-18 16:36:52', '2017-10-02 06:35:31', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (194, 79, 'Jammal', 'Hurburt', 'Administrative Assistant II', 'Riffpedia', '396-780-4671', 'jhurburt5d@theguardian.com', 179, 5, '2017-11-17', '2017-06-20 04:09:33', '2017-06-14 13:32:51', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (195, 114, 'Lura', 'Baddeley', 'Community Outreach Specialist', 'Avavee', '934-422-2771', 'lbaddeley5e@chronoengine.com', 72, 3, '2017-05-17', '2017-02-21 13:20:18', '2018-01-09 22:52:47', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (196, 148, 'Marlow', 'Ruddle', 'Biostatistician III', 'Skipstorm', '757-369-6254', 'mruddle5f@weibo.com', 15, 2, '2017-04-20', '2017-07-29 18:38:44', '2017-09-14 09:51:27', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (197, 84, 'Bil', 'Freake', 'Media Manager I', 'Twimbo', '634-726-7339', 'bfreake5g@nydailynews.com', 184, 3, '2017-02-22', '2017-01-27 07:52:53', '2017-10-08 11:07:05', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (198, 16, 'Quincey', 'Kennagh', 'Software Consultant', 'Oyoloo', '950-349-3055', 'qkennagh5h@themeforest.net', 98, 1, '2017-05-24', '2017-09-25 08:17:53', '2017-12-09 17:49:32', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (199, 77, 'Wilden', 'Pechacek', 'Sales Representative', 'Chatterpoint', '829-229-6613', 'wpechacek5i@elegantthemes.com', 84, 4, '2017-07-03', '2017-09-17 05:17:29', '2017-03-03 04:38:37', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (200, 52, 'Richmound', 'Lefeuvre', 'Financial Analyst', 'Zoombeat', '566-141-9344', 'rlefeuvre5j@oracle.com', 30, 4, '2017-05-18', '2017-01-29 02:27:13', '2017-05-10 22:09:55', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (201, 13, 'Birch', 'Sherston', 'Tax Accountant', 'Gigashots', '611-767-8034', 'bsherston5k@mashable.com', 1, 4, '2017-06-07', '2017-03-12 01:25:08', '2017-01-15 23:09:21', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (202, 82, 'Elia', 'Witnall', 'Assistant Manager', 'Yakitri', '724-390-5179', 'ewitnall5l@blogspot.com', 6, 5, '2017-01-13', '2017-10-14 12:40:30', '2017-03-26 08:06:06', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (203, 88, 'Milo', 'Guyton', 'Geological Engineer', 'Edgepulse', '850-592-1362', 'mguyton5m@amazon.co.uk', 5, 4, '2017-09-07', '2017-08-30 15:12:33', '2017-06-22 22:12:20', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (204, 36, 'Rina', 'Overall', 'Registered Nurse', 'Izio', '699-347-6075', 'roverall5n@nbcnews.com', 175, 3, '2017-10-01', '2017-11-20 12:23:56', '2017-07-01 20:19:21', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (205, 56, 'Michaella', 'Akehurst', 'Computer Systems Analyst III', 'Yata', '732-674-9600', 'makehurst5o@spotify.com', 83, 1, '2017-07-22', '2017-10-16 18:35:39', '2017-01-26 07:24:30', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (206, 76, 'Hetty', 'Danforth', 'Research Associate', 'Tazzy', '940-247-1895', 'hdanforth5p@parallels.com', 48, 1, '2018-01-05', '2017-11-10 14:26:39', '2017-01-23 18:28:41', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (207, 125, 'Kaila', 'Kimbling', 'Senior Developer', 'Realfire', '644-435-5576', 'kkimbling5q@123-reg.co.uk', 140, 2, '2017-11-11', '2017-01-26 02:41:44', '2017-06-13 03:18:49', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (208, 115, 'Darn', 'Pocke', 'Engineer III', 'Youbridge', '520-282-2502', 'dpocke5r@ebay.com', 187, 4, '2017-10-20', '2017-03-04 10:02:35', '2017-12-22 23:43:13', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (209, 94, 'Raeann', 'Mulchrone', 'Business Systems Development Analyst', 'Realpoint', '763-852-3413', 'rmulchrone5s@etsy.com', 109, 4, '2017-08-18', '2017-05-13 07:12:30', '2017-01-31 03:58:28', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (210, 112, 'Flemming', 'Grigoriscu', 'Geologist II', 'Yadel', '408-352-9644', 'fgrigoriscu5t@nifty.com', 70, 3, '2017-10-07', '2017-06-24 19:55:14', '2017-02-02 03:25:22', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (211, 69, 'Brianna', 'Cardenoza', 'Recruiting Manager', 'Tagfeed', '470-403-4105', 'bcardenoza5u@friendfeed.com', 52, 2, '2017-09-10', '2017-05-08 00:06:56', '2017-04-22 02:39:03', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (212, 103, 'Shepard', 'Ducroe', 'Financial Analyst', 'Eazzy', '827-901-7717', 'sducroe5v@europa.eu', 198, 2, '2017-09-02', '2017-04-11 14:59:47', '2017-10-06 08:25:19', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (213, 61, 'Roselle', 'Townsend', 'VP Accounting', 'Realcube', '644-406-6290', 'rtownsend5w@parallels.com', 143, 4, '2017-06-02', '2017-07-19 20:19:46', '2017-01-15 02:48:21', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (214, 68, 'Cathrin', 'Brettel', 'Assistant Professor', 'Topicware', '830-593-9399', 'cbrettel5x@dmoz.org', 53, 5, '2017-12-01', '2017-05-02 21:23:23', '2017-04-15 00:05:20', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (215, 133, 'Elna', 'McRorie', 'Structural Analysis Engineer', 'Wordware', '549-167-7849', 'emcrorie5y@earthlink.net', 199, 1, '2017-08-21', '2017-08-24 00:20:06', '2017-11-12 21:56:49', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (216, 107, 'Lynnea', 'Titherington', 'Professor', 'Mydo', '809-614-2654', 'ltitherington5z@europa.eu', 125, 4, '2017-05-24', '2017-09-20 05:28:39', '2017-08-03 13:24:15', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (217, 65, 'Dermot', 'Yurmanovev', 'Nurse', 'Jetwire', '813-860-9636', 'dyurmanovev60@tiny.cc', 116, 4, '2017-08-24', '2018-01-04 10:03:37', '2017-06-07 21:51:06', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (218, 5, 'Jammal', 'Winsley', 'Analog Circuit Design manager', 'Wikido', '565-503-4262', 'jwinsley61@dailymail.co.uk', 138, 5, '2017-10-20', '2017-07-02 11:10:41', '2017-02-10 03:17:22', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (219, 5, 'Clarence', 'Ateggart', 'Junior Executive', 'Digitube', '497-199-0128', 'categgart62@wordpress.org', 78, 2, '2017-08-23', '2017-04-14 15:08:27', '2017-06-24 21:00:14', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (220, 54, 'Horace', 'Suggate', 'Project Manager', 'Mycat', '663-483-2644', 'hsuggate63@apple.com', 189, 1, '2017-02-26', '2017-09-30 19:49:01', '2017-06-15 19:05:13', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (221, 133, 'Ninette', 'Faithfull', 'Data Coordiator', 'Youspan', '336-670-9554', 'nfaithfull64@pinterest.com', 188, 3, '2017-07-27', '2017-10-19 00:27:10', '2017-03-22 07:19:58', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (222, 27, 'Mycah', 'Pichmann', 'Media Manager I', 'Photobean', '562-131-5087', 'mpichmann65@exblog.jp', 46, 4, '2017-08-25', '2017-05-25 22:23:35', '2017-08-21 22:09:18', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (223, 95, 'Tisha', 'Moohan', 'VP Marketing', 'Mynte', '305-599-3598', 'tmoohan66@google.ca', 50, 5, '2017-10-02', '2017-04-13 23:29:49', '2017-05-10 13:40:49', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (224, 136, 'Salem', 'Ginnety', 'Budget/Accounting Analyst II', 'BlogXS', '108-717-7730', 'sginnety67@jiathis.com', 139, 2, '2017-02-03', '2017-05-11 13:36:59', '2017-10-14 13:17:40', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (225, 115, 'Hansiain', 'Beeby', 'Human Resources Manager', 'Feednation', '561-882-0246', 'hbeeby68@yellowpages.com', 199, 5, '2017-02-03', '2017-05-15 18:28:51', '2017-05-03 00:26:04', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (226, 51, 'Zechariah', 'Skevington', 'Business Systems Development Analyst', 'Jaloo', '994-214-8734', 'zskevington69@webmd.com', 17, 5, '2017-04-26', '2017-12-10 14:11:18', '2018-01-04 10:36:54', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (227, 149, 'Erick', 'Adamoli', 'Help Desk Operator', 'Camimbo', '752-169-0771', 'eadamoli6a@edublogs.org', 147, 4, '2017-06-21', '2017-09-09 23:10:34', '2017-12-06 12:38:29', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (228, 116, 'Charley', 'Doumenc', 'Food Chemist', 'Yabox', '781-622-5684', 'cdoumenc6b@com.com', 120, 5, '2017-04-22', '2017-03-27 13:12:51', '2017-11-24 14:37:31', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (229, 1, 'Felicia', 'Matas', 'Budget/Accounting Analyst IV', 'Edgeblab', '208-901-2391', 'fmatas6c@51.la', 175, 5, '2017-11-10', '2017-08-15 01:55:01', '2018-01-08 14:14:48', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (230, 47, 'Doralynne', 'Hennington', 'Teacher', 'Fadeo', '797-271-2212', 'dhennington6d@newyorker.com', 35, 1, '2017-07-26', '2017-07-12 10:53:05', '2017-03-25 16:20:47', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (231, 1, 'Celisse', 'Treen', 'Geological Engineer', 'Teklist', '917-500-4462', 'ctreen6e@psu.edu', 175, 1, '2018-01-05', '2017-10-27 11:31:59', '2017-10-10 21:28:10', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (232, 49, 'Dee', 'Chessell', 'Systems Administrator IV', 'Yakitri', '524-860-2766', 'dchessell6f@paginegialle.it', 105, 3, '2017-10-09', '2017-07-28 13:57:13', '2017-12-05 02:01:52', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (233, 92, 'Sioux', 'Brocking', 'Civil Engineer', 'Topiczoom', '655-574-1908', 'sbrocking6g@chron.com', 95, 4, '2017-02-14', '2017-11-24 16:16:57', '2017-09-11 12:22:37', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (234, 134, 'Ira', 'Quested', 'Health Coach I', 'Talane', '510-436-5644', 'iquested6h@privacy.gov.au', 89, 5, '2017-05-15', '2017-01-15 00:28:15', '2017-09-05 13:20:17', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (235, 9, 'Alexis', 'Gregorio', 'Desktop Support Technician', 'Cogilith', '298-845-8126', 'agregorio6i@t.co', 53, 3, '2017-04-11', '2017-10-08 15:36:49', '2017-04-27 07:00:45', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (236, 50, 'Nikolaus', 'Eastbrook', 'Human Resources Manager', 'Photospace', '688-837-2144', 'neastbrook6j@bing.com', 171, 2, '2017-04-03', '2017-03-16 02:48:16', '2017-05-22 02:55:37', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (237, 138, 'Xenia', 'Yesinov', 'Chief Design Engineer', 'Vidoo', '696-740-1266', 'xyesinov6k@jugem.jp', 84, 4, '2017-05-04', '2017-02-03 13:37:01', '2017-10-07 05:55:10', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (238, 3, 'Arne', 'Bignold', 'Programmer II', 'Edgewire', '751-800-9470', 'abignold6l@apple.com', 149, 2, '2017-07-05', '2017-06-20 03:12:27', '2017-03-21 17:43:34', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (239, 90, 'Jackelyn', 'Warton', 'Food Chemist', 'Youfeed', '303-399-7292', 'jwarton6m@fastcompany.com', 12, 4, '2017-04-25', '2017-04-18 13:42:45', '2017-07-03 10:09:27', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (240, 145, 'Mala', 'Rainville', 'Junior Executive', 'Topicware', '566-910-2382', 'mrainville6n@rediff.com', 29, 4, '2017-04-21', '2017-06-21 00:28:04', '2017-04-23 10:00:05', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (241, 33, 'Ainslie', 'Wallwood', 'Web Designer IV', 'Thoughtbridge', '403-344-7261', 'awallwood6o@ebay.com', 139, 4, '2017-11-09', '2017-10-22 14:31:40', '2017-12-19 01:13:04', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (242, 130, 'Athena', 'Jaques', 'Mechanical Systems Engineer', 'Skimia', '502-420-3066', 'ajaques6p@businesswire.com', 7, 1, '2017-11-25', '2017-11-29 14:00:11', '2017-08-18 09:54:44', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (243, 147, 'Patsy', 'Ghidoni', 'Developer I', 'Snaptags', '829-665-2293', 'pghidoni6q@samsung.com', 181, 2, '2017-11-25', '2017-09-13 23:27:29', '2017-10-07 01:48:17', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (244, 114, 'Godfrey', 'Clench', 'VP Quality Control', 'Dazzlesphere', '151-225-1537', 'gclench6r@example.com', 72, 2, '2017-10-02', '2017-12-02 04:28:32', '2017-03-03 01:43:49', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (245, 64, 'Nolan', 'Gercken', 'Information Systems Manager', 'Oozz', '474-923-6739', 'ngercken6s@wufoo.com', 67, 3, '2017-10-30', '2017-05-26 14:09:24', '2017-05-12 19:03:46', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (246, 131, 'Robbie', 'Tukesby', 'Geologist IV', 'Topicstorm', '455-407-5694', 'rtukesby6t@netlog.com', 73, 3, '2017-02-12', '2017-05-24 19:51:27', '2017-05-06 21:43:51', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (247, 25, 'Nevil', 'Ledington', 'Geologist I', 'Mybuzz', '917-467-0338', 'nledington6u@google.pl', 65, 2, '2017-02-18', '2017-06-19 00:54:26', '2017-04-15 02:31:03', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (248, 100, 'Terri-jo', 'Rigglesford', 'Office Assistant III', 'Jaxnation', '147-724-9491', 'trigglesford6v@51.la', 4, 3, '2017-05-01', '2017-09-02 11:14:13', '2017-11-04 02:09:07', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (249, 92, 'Windy', 'Reckhouse', 'Graphic Designer', 'Zoomcast', '755-739-5863', 'wreckhouse6w@jimdo.com', 192, 3, '2017-06-13', '2017-07-27 21:51:24', '2017-05-28 21:36:57', NULL);
INSERT INTO `contact` (`id`, `user_id`, `first_name`, `last_name`, `title`, `company`, `phone`, `email`, `address_id`, `contact_count`, `last_contact_date`, `create_date`, `last_update`, `note`) VALUES (250, 83, 'Koralle', 'Belchamp', 'Structural Analysis Engineer', 'Viva', '479-651-1793', 'kbelchamp6x@163.com', 53, 4, '2018-01-04', '2017-07-19 19:13:02', '2017-09-17 06:12:38', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `job_contacts`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (1, 46);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (2, 185);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (3, 238);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (4, 63);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (5, 24);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (6, 47);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (7, 91);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (8, 43);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (9, 215);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (10, 201);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (11, 222);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (12, 120);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (13, 96);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (14, 69);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (15, 245);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (16, 37);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (17, 121);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (18, 51);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (19, 54);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (20, 246);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (21, 66);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (22, 142);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (23, 223);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (24, 9);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (25, 37);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (26, 36);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (27, 202);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (28, 165);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (29, 232);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (30, 86);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (31, 50);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (32, 18);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (33, 162);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (34, 36);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (35, 122);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (36, 223);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (37, 171);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (38, 40);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (39, 183);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (40, 99);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (41, 80);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (42, 56);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (43, 111);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (44, 34);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (45, 72);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (46, 7);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (47, 103);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (48, 166);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (49, 176);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (50, 79);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (51, 22);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (52, 171);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (53, 227);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (54, 5);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (55, 223);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (56, 116);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (57, 67);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (58, 235);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (59, 106);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (60, 160);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (61, 172);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (62, 37);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (63, 212);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (64, 15);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (65, 203);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (66, 151);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (67, 62);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (68, 214);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (69, 3);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (70, 78);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (71, 40);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (72, 95);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (73, 243);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (74, 4);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (75, 91);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (76, 207);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (77, 136);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (78, 66);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (79, 10);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (80, 25);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (81, 160);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (82, 161);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (83, 145);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (84, 190);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (85, 1);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (86, 161);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (87, 18);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (88, 180);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (89, 168);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (90, 83);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (91, 168);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (92, 76);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (93, 194);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (94, 118);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (95, 1);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (96, 48);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (97, 62);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (98, 217);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (99, 40);
INSERT INTO `job_contacts` (`job_id`, `contact_id`) VALUES (100, 163);

COMMIT;


-- -----------------------------------------------------
-- Data for table `event`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (1, 'Intuitive radical synergy', '2018-06-09', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 30);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (2, 'Integrated holistic matrices', '2018-04-29', 'Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 14);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (3, 'Business-focused interactive policy', '2018-11-05', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 22);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (4, 'Pre-emptive optimal matrix', '2018-07-19', 'Integer a nibh.', 21);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (5, 'Automated neutral matrices', '2018-10-18', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', 23);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (6, 'Triple-buffered encompassing customer loyalty', '2018-07-05', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', 12);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (7, 'Monitored impactful knowledge user', '2018-05-02', 'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 28);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (8, 'Re-contextualized next generation orchestration', '2018-12-21', 'Nunc rhoncus dui vel sem. Sed sagittis.', 26);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (9, 'Implemented intermediate process improvement', '2018-04-17', 'In eleifend quam a odio. In hac habitasse platea dictumst.', 18);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (10, 'Balanced radical concept', '2018-06-05', 'In congue. Etiam justo.', 14);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (11, 'Innovative object-oriented database', '2018-11-05', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', 14);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (12, 'Vision-oriented actuating leverage', '2018-06-10', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 30);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (13, 'Optional hybrid collaboration', '2018-01-12', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 1);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (14, 'Object-based attitude-oriented structure', '2018-11-25', 'Suspendisse ornare consequat lectus.', 10);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (15, 'Re-contextualized 24 hour leverage', '2018-12-12', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', 19);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (16, 'Versatile tangible collaboration', '2018-06-05', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.', 23);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (17, 'Quality-focused client-server monitoring', '2018-09-21', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 17);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (18, 'Re-engineered client-driven toolset', '2018-12-22', 'Phasellus id sapien in sapien iaculis congue.', 26);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (19, 'Diverse logistical internet solution', '2018-07-05', 'Quisque ut erat.', 11);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (20, 'Customizable value-added budgetary management', '2018-03-13', 'Nulla mollis molestie lorem. Quisque ut erat.', 11);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (21, 'Business-focused multi-tasking interface', '2018-09-24', 'Etiam pretium iaculis justo.', 10);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (22, 'Fundamental methodical orchestration', '2018-09-01', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 2);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (23, 'Adaptive multimedia application', '2018-10-09', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', 29);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (24, 'Synergistic radical software', '2018-01-16', 'Nulla mollis molestie lorem.', 23);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (25, 'User-friendly needs-based parallelism', '2018-10-30', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 21);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (26, 'Virtual dedicated emulation', '2018-03-04', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', 9);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (27, 'Diverse zero defect knowledge user', '2018-10-19', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 26);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (28, 'Streamlined logistical process improvement', '2018-09-13', 'Phasellus in felis. Donec semper sapien a libero.', 11);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (29, 'Robust human-resource firmware', '2018-04-29', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 20);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (30, 'Public-key national synergy', '2018-11-16', 'Vivamus in felis eu sapien cursus vestibulum.', 11);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (31, 'Managed object-oriented portal', '2018-10-17', 'Mauris lacinia sapien quis libero.', 18);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (32, 'Customizable actuating time-frame', '2018-04-25', 'In eleifend quam a odio. In hac habitasse platea dictumst.', 28);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (33, 'Enterprise-wide actuating extranet', '2018-12-11', 'Pellentesque viverra pede ac diam.', 2);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (34, 'Reverse-engineered 6th generation encryption', '2018-12-25', 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', 28);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (35, 'Total full-range flexibility', '2018-01-29', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', 13);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (36, 'Extended 24 hour moratorium', '2018-10-08', 'Vestibulum ac est lacinia nisi venenatis tristique.', 21);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (37, 'Exclusive scalable protocol', '2018-01-28', 'Nullam molestie nibh in lectus.', 18);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (38, 'Exclusive holistic hardware', '2018-09-16', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 13);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (39, 'Switchable foreground encryption', '2018-02-12', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 26);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (40, 'Implemented 6th generation policy', '2018-11-16', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 21);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (41, 'Automated modular archive', '2018-01-17', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', 28);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (42, 'Cross-platform uniform website', '2018-10-31', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 9);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (43, 'Face to face context-sensitive Graphic Interface', '2018-10-24', 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', 21);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (44, 'Persevering actuating definition', '2018-02-15', 'Duis aliquam convallis nunc.', 24);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (45, 'Synergistic holistic solution', '2018-05-16', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', 15);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (46, 'Streamlined static process improvement', '2018-04-07', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 30);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (47, 'Multi-layered 6th generation attitude', '2018-12-11', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 23);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (48, 'Customizable dedicated structure', '2018-08-16', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 26);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (49, 'Phased motivating methodology', '2018-05-29', 'Phasellus id sapien in sapien iaculis congue.', 17);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (50, 'Re-contextualized disintermediate infrastructure', '2018-11-07', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 8);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (51, 'Fundamental stable product', '2018-10-03', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 13);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (52, 'Quality-focused explicit matrices', '2018-07-21', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', 13);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (53, 'De-engineered solution-oriented archive', '2018-07-08', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 18);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (54, 'Devolved systemic moderator', '2018-01-25', 'Donec posuere metus vitae ipsum. Aliquam non mauris.', 9);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (55, 'Multi-lateral 3rd generation focus group', '2018-09-29', 'Nulla nisl.', 19);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (56, 'Assimilated non-volatile pricing structure', '2018-12-05', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 7);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (57, 'Monitored modular analyzer', '2018-09-02', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 4);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (58, 'Polarised impactful service-desk', '2018-11-19', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 18);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (59, 'Monitored homogeneous access', '2018-07-31', 'Vivamus tortor. Duis mattis egestas metus.', 1);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (60, 'Proactive 6th generation contingency', '2018-06-27', 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', 20);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (61, 'Right-sized discrete frame', '2018-01-13', 'Integer ac leo.', 30);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (62, 'Exclusive static extranet', '2018-03-06', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 4);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (63, 'Configurable actuating concept', '2018-02-25', 'Aliquam quis turpis eget elit sodales scelerisque.', 20);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (64, 'Organic 24 hour software', '2018-03-30', 'Nulla tellus. In sagittis dui vel nisl.', 30);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (65, 'Phased background data-warehouse', '2018-11-27', 'In hac habitasse platea dictumst.', 15);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (66, 'Upgradable web-enabled attitude', '2018-09-19', 'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', 12);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (67, 'Optional disintermediate analyzer', '2018-05-30', 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.', 4);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (68, 'Pre-emptive full-range capability', '2018-04-19', 'In quis justo.', 10);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (69, 'Focused asynchronous success', '2018-01-20', 'Cras in purus eu magna vulputate luctus.', 27);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (70, 'Cross-platform responsive open system', '2018-02-15', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 14);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (71, 'Ameliorated directional functionalities', '2018-09-27', 'Sed accumsan felis.', 8);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (72, 'Networked systematic circuit', '2018-06-18', 'Nullam varius.', 11);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (73, 'Ameliorated bottom-line analyzer', '2018-01-28', 'Praesent blandit.', 9);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (74, 'Adaptive stable policy', '2018-01-13', 'Aenean auctor gravida sem.', 14);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (75, 'Profound system-worthy methodology', '2018-01-11', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 27);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (76, 'Proactive homogeneous time-frame', '2019-01-01', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', 28);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (77, 'Operative bottom-line functionalities', '2018-03-19', 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 14);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (78, 'Organized disintermediate portal', '2018-03-01', 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 21);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (79, 'Universal global structure', '2018-03-15', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 1);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (80, 'Synchronised 3rd generation initiative', '2018-03-05', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 26);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (81, 'Centralized discrete complexity', '2018-06-01', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 15);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (82, 'Pre-emptive intermediate function', '2018-12-07', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 14);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (83, 'Intuitive hybrid array', '2018-03-16', 'Aliquam sit amet diam in magna bibendum imperdiet.', 13);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (84, 'Universal systematic local area network', '2018-11-17', 'Etiam pretium iaculis justo.', 17);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (85, 'Team-oriented next generation open architecture', '2018-07-23', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 13);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (86, 'Face to face systemic implementation', '2018-05-05', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 10);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (87, 'Self-enabling system-worthy circuit', '2018-09-27', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 17);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (88, 'Face to face 4th generation strategy', '2018-07-22', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', 3);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (89, 'Adaptive even-keeled benchmark', '2018-06-03', 'Integer non velit.', 19);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (90, 'Secured holistic model', '2018-05-25', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', 3);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (91, 'Total didactic contingency', '2018-10-06', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 10);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (92, 'Implemented 5th generation paradigm', '2018-02-02', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 20);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (93, 'Distributed grid-enabled algorithm', '2018-12-07', 'Donec quis orci eget orci vehicula condimentum.', 10);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (94, 'Customer-focused multi-state help-desk', '2018-12-03', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', 3);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (95, 'Distributed executive time-frame', '2018-12-02', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 17);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (96, 'Proactive dynamic budgetary management', '2018-07-15', 'Donec dapibus.', 17);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (97, 'Advanced logistical frame', '2018-11-11', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 12);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (98, 'De-engineered bottom-line functionalities', '2018-06-07', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 14);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (99, 'Triple-buffered asynchronous migration', '2018-08-23', 'Etiam vel augue. Vestibulum rutrum rutrum neque.', 9);
INSERT INTO `event` (`id`, `title`, `event_date`, `description`, `address_id`) VALUES (100, 'Function-based methodical concept', '2018-01-22', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_events`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 1);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (11, 2);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (9, 3);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (19, 4);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (9, 5);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (3, 6);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (20, 7);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (3, 8);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (12, 9);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (20, 10);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (20, 11);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (3, 12);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (6, 13);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (19, 14);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (1, 15);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (15, 16);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (7, 17);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (9, 18);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (18, 19);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 20);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (11, 21);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (19, 22);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 23);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (18, 24);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (3, 25);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (15, 26);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (1, 27);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (18, 28);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (5, 29);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (13, 30);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (8, 31);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (8, 32);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 33);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (14, 34);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (17, 35);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (20, 36);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (18, 37);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (5, 38);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (7, 39);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 40);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (6, 41);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (1, 42);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (6, 43);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (5, 44);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (12, 45);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (9, 46);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (13, 47);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (5, 48);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (9, 49);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (11, 50);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (16, 51);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (8, 52);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (8, 53);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (5, 54);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (17, 55);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (4, 56);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 57);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (13, 58);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (1, 59);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (13, 60);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (18, 61);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (5, 62);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (3, 63);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (17, 64);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (6, 65);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (8, 66);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (2, 67);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (14, 68);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (1, 69);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (4, 70);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (3, 71);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (7, 72);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (13, 73);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 74);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (17, 75);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (9, 76);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (17, 77);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (2, 78);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 79);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (4, 80);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (8, 81);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (11, 82);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (15, 83);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 84);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (8, 85);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (12, 86);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (3, 87);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (14, 88);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (18, 89);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (19, 90);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (9, 91);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (5, 92);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (20, 93);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (17, 94);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 95);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (3, 96);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (2, 97);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (15, 98);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (18, 99);
INSERT INTO `user_events` (`user_id`, `event_id`) VALUES (10, 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `interview`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (1, '2018-02-22', 205, 15);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (2, '2018-03-02', 8, 68);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (3, '2018-01-30', 147, 91);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (4, '2018-03-09', 211, 10);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (5, '2018-05-15', 135, 8);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (6, '2018-05-14', 52, 31);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (7, '2018-01-14', 124, 59);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (8, '2018-05-23', 8, 41);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (9, '2018-03-11', 177, 16);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (10, '2018-03-09', 120, 96);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (11, '2018-02-19', 194, 18);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (12, '2018-03-24', 83, 56);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (13, '2018-02-08', 141, 18);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (14, '2018-04-07', 47, 38);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (15, '2018-03-29', 244, 10);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (16, '2018-04-28', 183, 19);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (17, '2018-05-18', 189, 100);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (18, '2018-04-09', 173, 88);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (19, '2018-01-18', 26, 74);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (20, '2018-06-05', 101, 7);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (21, '2018-02-12', 148, 10);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (22, '2018-02-09', 202, 69);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (23, '2018-05-12', 204, 43);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (24, '2018-01-23', 83, 25);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (25, '2018-05-24', 162, 99);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (26, '2018-05-10', 159, 100);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (27, '2018-02-04', 224, 40);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (28, '2018-03-14', 19, 95);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (29, '2018-05-01', 57, 94);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (30, '2018-05-02', 110, 31);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (31, '2018-04-17', 199, 65);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (32, '2018-04-22', 61, 98);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (33, '2018-05-04', 227, 58);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (34, '2018-04-09', 19, 49);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (35, '2018-03-09', 26, 18);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (36, '2018-05-26', 107, 95);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (37, '2018-01-11', 204, 10);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (38, '2018-03-15', 45, 17);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (39, '2018-02-15', 21, 17);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (40, '2018-05-28', 161, 62);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (41, '2018-06-07', 61, 14);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (42, '2018-02-18', 145, 51);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (43, '2018-06-05', 61, 100);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (44, '2018-04-09', 158, 91);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (45, '2018-04-02', 128, 16);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (46, '2018-06-05', 208, 40);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (47, '2018-03-27', 57, 66);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (48, '2018-05-06', 17, 24);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (49, '2018-03-08', 40, 17);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (50, '2018-06-01', 163, 53);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (51, '2018-01-17', 136, 44);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (52, '2018-02-19', 67, 17);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (53, '2018-05-02', 63, 42);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (54, '2018-05-10', 48, 32);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (55, '2018-02-14', 38, 10);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (56, '2018-02-15', 103, 41);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (57, '2018-03-13', 45, 67);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (58, '2018-05-31', 84, 88);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (59, '2018-03-03', 143, 31);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (60, '2018-02-08', 168, 80);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (61, '2018-03-17', 208, 4);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (62, '2018-03-11', 35, 25);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (63, '2018-04-29', 39, 35);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (64, '2018-02-01', 100, 77);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (65, '2018-05-16', 222, 61);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (66, '2018-03-20', 34, 39);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (67, '2018-01-30', 99, 5);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (68, '2018-01-23', 15, 16);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (69, '2018-03-07', 17, 29);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (70, '2018-05-20', 71, 99);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (71, '2018-03-05', 83, 32);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (72, '2018-02-16', 119, 81);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (73, '2018-02-15', 123, 45);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (74, '2018-06-01', 84, 91);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (75, '2018-03-17', 110, 33);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (76, '2018-01-24', 107, 60);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (77, '2018-03-23', 134, 100);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (78, '2018-04-22', 127, 53);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (79, '2018-05-06', 85, 12);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (80, '2018-03-20', 150, 34);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (81, '2018-02-10', 128, 48);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (82, '2018-02-09', 232, 60);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (83, '2018-01-22', 186, 25);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (84, '2018-01-14', 244, 14);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (85, '2018-01-23', 183, 70);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (86, '2018-01-13', 104, 31);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (87, '2018-03-01', 122, 71);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (88, '2018-04-26', 75, 42);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (89, '2018-06-08', 10, 43);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (90, '2018-06-03', 102, 2);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (91, '2018-03-03', 176, 46);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (92, '2018-02-11', 233, 97);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (93, '2018-04-27', 71, 96);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (94, '2018-02-15', 158, 70);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (95, '2018-03-03', 250, 68);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (96, '2018-05-30', 43, 58);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (97, '2018-04-24', 194, 4);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (98, '2018-04-24', 18, 53);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (99, '2018-06-02', 48, 97);
INSERT INTO `interview` (`id`, `interview_date`, `contact_id`, `address_id`) VALUES (100, '2018-05-27', 59, 57);

COMMIT;


-- -----------------------------------------------------
-- Data for table `job_interviews`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (15, 1);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (8, 2);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (3, 3);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (5, 4);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (12, 5);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (16, 6);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (9, 7);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (19, 8);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (9, 9);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (15, 10);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (4, 11);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (11, 12);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (13, 13);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (4, 14);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (4, 15);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (20, 16);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (12, 17);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (10, 18);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (18, 19);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (10, 20);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (9, 21);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (19, 22);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (6, 23);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (7, 24);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (9, 25);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (8, 26);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (8, 27);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (4, 28);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (17, 29);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (16, 30);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (16, 31);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (5, 32);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (6, 33);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (6, 34);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (8, 35);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (14, 36);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (8, 37);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (11, 38);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (3, 39);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (20, 40);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (7, 41);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (7, 42);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (6, 43);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (14, 44);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (14, 45);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (9, 46);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (7, 47);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (17, 48);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (15, 49);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (10, 50);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (3, 51);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (17, 52);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (13, 53);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (16, 54);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (10, 55);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (7, 56);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (4, 57);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (18, 58);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (4, 59);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (1, 60);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (17, 61);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (13, 62);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (12, 63);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (12, 64);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (5, 65);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (8, 66);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (13, 67);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (4, 68);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (15, 69);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (8, 70);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (10, 71);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (12, 72);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (4, 73);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (18, 74);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (7, 75);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (1, 76);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (20, 77);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (12, 78);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (1, 79);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (13, 80);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (5, 81);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (14, 82);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (2, 83);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (18, 84);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (11, 85);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (3, 86);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (11, 87);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (3, 88);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (19, 89);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (7, 90);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (9, 91);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (20, 92);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (6, 93);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (1, 94);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (15, 95);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (16, 96);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (10, 97);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (7, 98);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (16, 99);
INSERT INTO `job_interviews` (`job_id`, `interview_id`) VALUES (17, 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `quotes`
-- -----------------------------------------------------
START TRANSACTION;
USE `workitdb`;
INSERT INTO `quotes` (`id`, `quote`) VALUES (1, '“Talk is cheap. Show me the code.”  - Linus Torvalds');
INSERT INTO `quotes` (`id`, `quote`) VALUES (2, '“That\'s the thing about people who think they hate computers. What they really hate is lousy programmers.” - Larry Niven');
INSERT INTO `quotes` (`id`, `quote`) VALUES (3, '“Programs must be written for people to read, and only incidentally for machines to execute.” - Harold Abelson, Structure and Interpretation of Computer Programs');
INSERT INTO `quotes` (`id`, `quote`) VALUES (4, '“I\'m not a great programmer; I\'m just a good programmer with great habits.” - Kent Beck');
INSERT INTO `quotes` (`id`, `quote`) VALUES (5, '“Truth can only be found in one place: the code.” - Robert C. Martin, Clean Code: A Handbook of Agile Software Craftsmanship');
INSERT INTO `quotes` (`id`, `quote`) VALUES (6, '“Walking on water and developing software from a specification are easy if both are frozen.” - Edward Berard');
INSERT INTO `quotes` (`id`, `quote`) VALUES (7, '“On two occasions, I have been asked [by members of Parliament], \'Pray, Mr. Babbage, if you put into the machine wrong figures, will the right answers come out?\' I am not able to rightly apprehend the kind of confusion of ideas that could provoke such a question.” - Charles Babbage');
INSERT INTO `quotes` (`id`, `quote`) VALUES (8, '“The most important property of a program is whether it accomplishes the intention of its user.” - C.A.R. Hoare ');
INSERT INTO `quotes` (`id`, `quote`) VALUES (9, '“Progress is possible only if we train ourselves to think about programs without thinking of them as pieces of executable code. ” - Edsger W. Dijkstra');
INSERT INTO `quotes` (`id`, `quote`) VALUES (10, '“Simple things should be simple, complex things should be possible.” - Alan Kay');
INSERT INTO `quotes` (`id`, `quote`) VALUES (11, '“For all the robots who question their programming.” - Annalee Newitz, Autonomous');
INSERT INTO `quotes` (`id`, `quote`) VALUES (12, '“Health and programming should go together like a horse and carriage. You can\'t have one without the other. In our sedentary office work, we often forget that an absence of health is as bad as a lack of programming skills.” - Staffan Noteberg');
INSERT INTO `quotes` (`id`, `quote`) VALUES (13, '“Einstein repeatedly argued that there must be simplified explanations of nature, because God is not capricious or arbitrary. No such faith comforts the software engineer.” - Frederick P. Brooks Jr., The Mythical Man-Month: Essays on Software Engineering');
INSERT INTO `quotes` (`id`, `quote`) VALUES (14, '“AI is the transformer of civilization.” - Toba Beta');
INSERT INTO `quotes` (`id`, `quote`) VALUES (15, '“Programming isn\'t about what you know; it\'s about what you can figure out.” - Chris Pine, Learn to Program');
INSERT INTO `quotes` (`id`, `quote`) VALUES (16, '“The happiest moment i felt; is that moment when i realized my ability to create.” - Dr. Hazem Ali');
INSERT INTO `quotes` (`id`, `quote`) VALUES (17, '“Think twice, code once.” - Waseem Latif');
INSERT INTO `quotes` (`id`, `quote`) VALUES (18, '“The perfect kind of architecture decision is the one which never has to be made.” - Robert C Martin');
INSERT INTO `quotes` (`id`, `quote`) VALUES (19, '“Programming is breaking of one big impossible task into several very small possible tasks.” - Jazzwant');
INSERT INTO `quotes` (`id`, `quote`) VALUES (20, '“Measuring programming progress by lines of code is like measuring aircraft building progress by weight.” - Bill Gates');
INSERT INTO `quotes` (`id`, `quote`) VALUES (21, '“The best way to prepare [to be a programmer] is to write programs, and to study great programs that other people have written. In my case, I went to the garbage cans at the Computer Science Center and fished out listings of their operating system.” - Bill Gates');
INSERT INTO `quotes` (`id`, `quote`) VALUES (22, '“Everybody in this country should learn to program a computer, because it teaches you how to think.” - Steve Jobs');

COMMIT;

