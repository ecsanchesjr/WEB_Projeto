-- MySQL Script generated by MySQL Workbench
-- dom 03 dez 2017 02:55:25 -02
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema web
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema web
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `web` DEFAULT CHARACTER SET utf8 ;
USE `web` ;

-- -----------------------------------------------------
-- Table `web`.`Player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`Player` (
  `player_login` VARCHAR(15) NOT NULL,
  `player_email` VARCHAR(60) NOT NULL,
  `player_pwd` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`player_login`),
  UNIQUE INDEX `player_email_UNIQUE` (`player_email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`Character`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`Character` (
  `char_name` VARCHAR(45) NOT NULL,
  `char_level` INT NOT NULL,
  `char_class` VARCHAR(45) NOT NULL,
  `char_background` VARCHAR(45) NOT NULL,
  `char_playername` VARCHAR(45) NOT NULL,
  `char_exppoints` INT NOT NULL,
  `char_alignment` VARCHAR(45) NOT NULL,
  `char_advgroup` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`char_name`, `char_playername`),
  INDEX `player_char_idx` (`char_playername` ASC),
  CONSTRAINT `player_char`
    FOREIGN KEY (`char_playername`)
    REFERENCES `web`.`Player` (`player_login`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`Attributes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`Attributes` (
  `att_strength` INT NULL DEFAULT 0,
  `att_dexterity` INT NULL DEFAULT 0,
  `att_constituition` INT NULL DEFAULT 0,
  `att_intelligence` INT NULL DEFAULT 0,
  `att_wisdom` INT NULL DEFAULT 0,
  `att_charisma` INT NULL DEFAULT 0,
  `att_inspiration` INT NOT NULL,
  `att_proficiencybonus` INT NOT NULL,
  `att_passiveperception` INT NOT NULL,
  `att_charname` VARCHAR(45) NOT NULL,
  `att_charplayername` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`att_charname`, `att_charplayername`),
  INDEX `fk_char2_idx` (`att_charplayername` ASC),
  CONSTRAINT `fk_char1`
    FOREIGN KEY (`att_charname`)
    REFERENCES `web`.`Character` (`char_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_char2`
    FOREIGN KEY (`att_charplayername`)
    REFERENCES `web`.`Character` (`char_playername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`SavingThrows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`SavingThrows` (
  `sv_charname` VARCHAR(45) NOT NULL,
  `sv_charplayername` VARCHAR(45) NOT NULL,
  `sv_strength` INT NULL,
  `sv_dexterity` INT NULL,
  `sv_constituition` VARCHAR(45) NULL,
  `sv_intelligence` INT NULL,
  `sv_wisdom` INT NULL,
  `sv_charisma` INT NULL,
  PRIMARY KEY (`sv_charname`, `sv_charplayername`),
  INDEX `fk_SavingThrows_2_idx` (`sv_charplayername` ASC),
  CONSTRAINT `fk_SavingThrows_1`
    FOREIGN KEY (`sv_charname`)
    REFERENCES `web`.`Character` (`char_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SavingThrows_2`
    FOREIGN KEY (`sv_charplayername`)
    REFERENCES `web`.`Character` (`char_playername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`Skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`Skills` (
  `skills_charname` VARCHAR(45) NOT NULL,
  `skills_charplayername` VARCHAR(45) NOT NULL,
  `skills_acrobatics` INT NULL DEFAULT 0,
  `skills_animalhand` INT NULL DEFAULT 0,
  `skills_arcana` INT NULL DEFAULT 0,
  `skills_athletics` INT NULL DEFAULT 0,
  `skills_decepticon` INT NULL DEFAULT 0,
  `skills_history` INT NULL DEFAULT 0,
  `skills_insight` INT NULL DEFAULT 0,
  `skills_intimidation` INT NULL DEFAULT 0,
  `skills_investigation` INT NULL DEFAULT 0,
  `skills_medicine` INT NULL DEFAULT 0,
  `skills_nature` INT NULL DEFAULT 0,
  `skills_percepticon` INT NULL DEFAULT 0,
  `skills_performance` INT NULL DEFAULT 0,
  `skills_persuasion` INT NULL DEFAULT 0,
  `skills_religion` INT NULL DEFAULT 0,
  `skills_sleightofhand` INT NULL DEFAULT 0,
  `skills_stealth` INT NULL DEFAULT 0,
  `skills_survival` INT NULL DEFAULT 0,
  INDEX `fk_Skills_1_idx` (`skills_charname` ASC),
  INDEX `fk_Skills_2_idx` (`skills_charplayername` ASC),
  PRIMARY KEY (`skills_charname`, `skills_charplayername`),
  CONSTRAINT `fk_Skills_1`
    FOREIGN KEY (`skills_charname`)
    REFERENCES `web`.`Character` (`char_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Skills_2`
    FOREIGN KEY (`skills_charplayername`)
    REFERENCES `web`.`Character` (`char_playername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`Attacks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`Attacks` (
  `attack_charname` VARCHAR(45) NOT NULL,
  `attack_charplayername` VARCHAR(45) NOT NULL,
  `attack_name` VARCHAR(30) NOT NULL,
  `attack_attack` INT NULL,
  `attack_damage` INT NULL,
  `attack_range` INT NULL,
  `attack_ammo` INT NULL,
  `attack_used` INT NULL,
  PRIMARY KEY (`attack_charname`, `attack_charplayername`, `attack_name`),
  INDEX `fk_Attacks_2_idx` (`attack_charplayername` ASC),
  CONSTRAINT `fk_Attacks_1`
    FOREIGN KEY (`attack_charname`)
    REFERENCES `web`.`Character` (`char_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Attacks_2`
    FOREIGN KEY (`attack_charplayername`)
    REFERENCES `web`.`Character` (`char_playername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`Features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`Features` (
  `features_charname` VARCHAR(45) NOT NULL,
  `features_charplayername` VARCHAR(45) NOT NULL,
  `features_information` VARCHAR(800) NULL,
  PRIMARY KEY (`features_charname`, `features_charplayername`),
  INDEX `fk_Features_2_idx` (`features_charplayername` ASC),
  CONSTRAINT `fk_Features_1`
    FOREIGN KEY (`features_charname`)
    REFERENCES `web`.`Character` (`char_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Features_2`
    FOREIGN KEY (`features_charplayername`)
    REFERENCES `web`.`Character` (`char_playername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`ProfAndLang`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`ProfAndLang` (
  `profandlang_charname` VARCHAR(45) NOT NULL,
  `profandlang_charplayername` VARCHAR(45) NOT NULL,
  `profandlang_information` VARCHAR(800) NULL,
  PRIMARY KEY (`profandlang_charplayername`, `profandlang_charname`),
  INDEX `fk_ProfAndLang_1_idx` (`profandlang_charname` ASC),
  CONSTRAINT `fk_ProfAndLang_1`
    FOREIGN KEY (`profandlang_charname`)
    REFERENCES `web`.`Character` (`char_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ProfAndLang_2`
    FOREIGN KEY (`profandlang_charplayername`)
    REFERENCES `web`.`Character` (`char_playername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`InventAndEquip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`InventAndEquip` (
  `equip_charname` VARCHAR(45) NOT NULL,
  `equip_charplayername` VARCHAR(45) NOT NULL,
  `equip_c` VARCHAR(45) NULL,
  `equip_s` VARCHAR(45) NULL,
  `equip_e` VARCHAR(45) NULL,
  `equip_g` VARCHAR(45) NULL,
  `equip_p` VARCHAR(45) NULL,
  `equip_information` VARCHAR(800) NULL,
  PRIMARY KEY (`equip_charname`, `equip_charplayername`),
  INDEX `fk_InventAndEquip_2_idx` (`equip_charplayername` ASC),
  CONSTRAINT `fk_InventAndEquip_1`
    FOREIGN KEY (`equip_charname`)
    REFERENCES `web`.`Character` (`char_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_InventAndEquip_2`
    FOREIGN KEY (`equip_charplayername`)
    REFERENCES `web`.`Character` (`char_playername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web`.`Status` (
  `status_charplayername` VARCHAR(45) NOT NULL,
  `status_charname` VARCHAR(45) NOT NULL,
  `status_currenthitpoints` INT NULL,
  `status_armorclass` INT NULL,
  `status_maxhp` INT NULL,
  `status_temphp` INT NULL,
  `status_initiate` INT NULL,
  `status_speed` INT NULL,
  `status_vision` INT NULL,
  PRIMARY KEY (`status_charplayername`, `status_charname`),
  INDEX `fk_Status_1_idx` (`status_charname` ASC),
  CONSTRAINT `fk_Status_1`
    FOREIGN KEY (`status_charname`)
    REFERENCES `web`.`Character` (`char_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Status_2`
    FOREIGN KEY (`status_charplayername`)
    REFERENCES `web`.`Character` (`char_playername`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
