-- Sat 18 Jul 2020 07:49:01 PM -05
-- Model: API Skilltrakker    Version: 1.2

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Skilltrakker_API
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS Skilltrakker_API ;

-- -----------------------------------------------------
-- Schema Skilltrakker_API
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS Skilltrakker_API DEFAULT CHARACTER SET utf8 ;
USE Skilltrakker_API ;

-- -----------------------------------------------------
-- Table gyms
-- -----------------------------------------------------
DROP TABLE IF EXISTS gyms ;

CREATE TABLE IF NOT EXISTS gyms (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'GYM code',
  name VARCHAR(45) NOT NULL COMMENT 'GYM Name',
  description VARCHAR(45) NULL DEFAULT NULL COMMENT 'GYM Description',
  settings JSON NULL DEFAULT NULL COMMENT 'GYM Settings in JSON format',
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  deleted_at timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
COMMENT = 'Table that stores gyms information';


-- -----------------------------------------------------
-- Table rol
-- -----------------------------------------------------
DROP TABLE IF EXISTS roles ;

CREATE TABLE IF NOT EXISTS roles (
  id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Roles\` Code',
  name VARCHAR(45) NOT NULL COMMENT 'Roles\` name, (Owner, Administrator,user)',
  access_level INT NOT NULL COMMENT 'Number that define the Access level of the rol.',
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
COMMENT = 'Table that stores USERS rol into the system';


-- -----------------------------------------------------
-- Table users
-- -----------------------------------------------------
DROP TABLE IF EXISTS users ;

CREATE TABLE IF NOT EXISTS users (
  id INT NOT NULL COMMENT 'USER\` code',
  name VARCHAR(255) NOT NULL COMMENT 'user\` name',
  email VARCHAR(45) NOT NULL COMMENT 'user\` email address',
  password VARCHAR(45) NOT NULL COMMENT 'user\` password for loging into the system',
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  deleted_at timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX email_UNIQUE (email ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores USERS information';


-- -----------------------------------------------------
-- Table gyms_has_users
-- -----------------------------------------------------
DROP TABLE IF EXISTS gyms_has_users ;

CREATE TABLE IF NOT EXISTS gyms_has_users (
  gym_id bigint NOT NULL COMMENT 'GYM\` Code',
  user_id INT NOT NULL COMMENT 'USER\` code',
  PRIMARY KEY (gym_id, user_id),
  INDEX fk_gyms_has_users_user1_idx (user_id ASC),
  INDEX fk_gyms_has_users_gym1_idx (gym_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that contains Gyms\`s users';


-- -----------------------------------------------------
-- Table gymnasts
-- -----------------------------------------------------
DROP TABLE IF EXISTS gymnasts ;

CREATE TABLE IF NOT EXISTS gymnasts (
  id INT NOT NULL AUTO_INCREMENT COMMENT 'Gymnast\` code',
  name VARCHAR(45) NOT NULL COMMENT 'Gymnast\` name',
  birth_date DATE NOT NULL COMMENT 'Gymnast\` birth date',
  life_time_score INT NOT NULL DEFAULT 0 COMMENT 'Score gather by an gymnast since is member of a gym.',
  current_streak_points INT NOT NULL DEFAULT 0 COMMENT 'Amount of points adquired by a Gymnas for loging everyday, is reset after 1 day of not loging.',
  last_streak DATE NULL DEFAULT NULL COMMENT 'Last amount of points before the gymnast lost his streak\n',
  about MEDIUMTEXT NULL DEFAULT NULL COMMENT 'Decription of the gymnast\n',
  created DATE NOT NULL,
  updated DATE NOT NULL,
  gyms_has_users_gyms_id bigint NOT NULL,
  gyms_has_users_users_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_gymnasts_gyms_has_users1_idx (gyms_has_users_gyms_id ASC, gyms_has_users_users_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores GYMNASTS information';


-- -----------------------------------------------------
-- Table classes
-- -----------------------------------------------------
DROP TABLE IF EXISTS classes ;

CREATE TABLE IF NOT EXISTS classes (
  id INT NOT NULL AUTO_INCREMENT COMMENT 'Class\` id',
  name VARCHAR(45) NOT NULL COMMENT 'Class\` name',
  description MEDIUMTEXT NULL DEFAULT NULL COMMENT 'Class\` description',
  PRIMARY KEY (id))
ENGINE = InnoDB
COMMENT = 'Table that stores CLASSES\` information';


-- -----------------------------------------------------
-- Table challenges
-- -----------------------------------------------------
DROP TABLE IF EXISTS challenges ;

CREATE TABLE IF NOT EXISTS challenges (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  description MEDIUMTEXT NOT NULL,
  points INT NULL DEFAULT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
COMMENT = 'Table that stores CHALLENGES\` information';


-- -----------------------------------------------------
-- Table normal_challenges
-- -----------------------------------------------------
DROP TABLE IF EXISTS normal_challenges ;

CREATE TABLE IF NOT EXISTS normal_challenges (
  classes_id INT NOT NULL COMMENT 'Class\` code',
  challenges_id INT NOT NULL COMMENT 'Challenge\` code',
  is_active TINYINT(1) NOT NULL COMMENT 'Status of the Challenge\n0 Inactive\n1 Active',
  PRIMARY KEY (classes_id, challenges_id),
  INDEX fk_class_has_challenges_idx (challenges_id ASC),
  INDEX fk_challenge_is_in_class_idx (classes_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores the CHALLENGES that a CLASS had.';


-- -----------------------------------------------------
-- Table levels
-- -----------------------------------------------------
DROP TABLE IF EXISTS levels ;

CREATE TABLE IF NOT EXISTS levels (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'Code of the Level',
  level VARCHAR(45) NOT NULL COMMENT 'Name for the Level',
  description MEDIUMTEXT NULL DEFAULT NULL COMMENT 'Description of what that level means',
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  deleted_at timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
COMMENT = 'Table that stores LEVELS description for the diferents skills.';

-- -----------------------------------------------------
-- Table categories
-- -----------------------------------------------------
DROP TABLE IF EXISTS categories ;

CREATE TABLE IF NOT EXISTS categories (
  id bigint NOT NULL AUTO_INCREMENT COMMENT 'Code of the Level',
  name VARCHAR(45) NOT NULL COMMENT 'Name for the Level',
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  deleted_at timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
COMMENT = 'Table that stores LEVELS description for the diferents skills.';


-- -----------------------------------------------------
-- Table events
-- -----------------------------------------------------
DROP TABLE IF EXISTS events ;

CREATE TABLE IF NOT EXISTS events (
  id bigint NOT NULL COMMENT 'Code of the Event',
  gym_id bigint NOT NULL COMMENT 'Code of the Gym',
  name CHAR(45) NULL COMMENT 'Name of the Event',
  abbrev CHAR(5) NULL COMMENT 'Abbreviation of the Event  ',
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  deleted_at timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX fk_events_gym1_idx (gym_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores the EVENTS in wich a skill is executed, if they are active and the respective abreviation.';


-- -----------------------------------------------------
-- Table skills
-- -----------------------------------------------------
DROP TABLE IF EXISTS skills ;

CREATE TABLE IF NOT EXISTS skills (
  id bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Code of the Skill',
  name VARCHAR(45) NOT NULL COMMENT 'Name of the skill',
  description MEDIUMTEXT NULL COMMENT 'Description of the Skill\n',
  category VARCHAR(45) NOT NULL COMMENT 'category to which the event belongs',
  certificate TINYINT(1) GENERATED ALWAYS AS (0)  COMMENT 'Boolean value to know the status',
  event_id bigint NOT NULL COMMENT 'Code of the Event',
  category_id bigint NOT NULL COMMENT 'Code of the Category',
  level_id bigint NOT NULL COMMENT 'Code of the Level',
  PRIMARY KEY (id),
  INDEX fk_skills_event_idx (event_id ASC),
  INDEX fk_skills_category_idx (category_id ASC),
  INDEX fk_skills_level_idx (level_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores SKILLS that a GYMNAST can get.';

-- -----------------------------------------------------
-- Table skill_lists
-- -----------------------------------------------------
DROP TABLE IF EXISTS skill_lists ;

CREATE TABLE IF NOT EXISTS skill_lists (
  id bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Code of the Skill list',
  gym_id bigint NOT NULL COMMENT 'Code of the gym',
  name VARCHAR(45) NOT NULL COMMENT 'Name of the skill List',
  timestamp DATE NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_skills_gym_idx (gym_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores SKILLS List.';

-- -----------------------------------------------------
-- Table skill_lists_has_skills
-- -----------------------------------------------------
DROP TABLE IF EXISTS skill_lists_has_skills ;

CREATE TABLE IF NOT EXISTS skill_lists_has_skills (
  skill_list_id bigint UNSIGNED NOT NULL COMMENT 'Skill List\` code',
  skill_id bigint UNSIGNED NOT NULL COMMENT 'Skill\` code',
  `order` INT NULL COMMENT 'Order for skill list',
  timestamp DATE NOT NULL,
  PRIMARY KEY (skill_list_id, skill_id),
  INDEX fk_skill_lists_has_skills_skill_list_idx (skill_list_id ASC),
  INDEX fk_skill_lists_has_skills_skill_idx (skill_id ASC))
ENGINE = InnoDB
COMMENT = 'table that stores the relation and the order of the kill lists.';

-- -----------------------------------------------------
-- Table gymnast_has_skills
-- -----------------------------------------------------
DROP TABLE IF EXISTS gymnast_has_skills ;

CREATE TABLE IF NOT EXISTS gymnast_has_skills (
  gymnast_id INT NOT NULL COMMENT 'Gymnast\` code',
  skills_Id bigint UNSIGNED NOT NULL COMMENT 'Skill\` code',
  progress_status VARCHAR(45) NULL COMMENT 'Tells the gymnast actual status in learning the skill',
  coach_verify JSON NULL COMMENT 'Verification from a coach when an gymnast set the level for a skill',
  timestamp DATE NOT NULL,
  interactions JSON NULL COMMENT 'Interactions for the skill update by others gymnasts\nHi 5\nComments\nApplasuse\nIn JSON Format',
  PRIMARY KEY (gymnast_id, skills_Id),
  INDEX fk_gymnast_has_skills_idx (skills_Id ASC),
  INDEX fk_skills_is_mastered_by_gymnast_idx (gymnast_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores SKILLS that a GYMNAST get.';

-- -----------------------------------------------------
-- Table gymnasts_classes
-- -----------------------------------------------------
DROP TABLE IF EXISTS gymnasts_classes ;

CREATE TABLE IF NOT EXISTS gymnasts_classes (
  gymnasts_id INT NOT NULL COMMENT 'Foreing key from GYMNASTS table',
  classes_id INT NOT NULL COMMENT 'Foreing key from CLASSES table',
  PRIMARY KEY (gymnasts_id, classes_id),
  INDEX fk_gymnast_has_classes_idx (classes_id ASC),
  INDEX fk_class_has_gymnasts_idx (gymnasts_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores the CLASSES in what a GYMNAST is enrolled.';


-- -----------------------------------------------------
-- Table daily_challenges
-- -----------------------------------------------------
DROP TABLE IF EXISTS daily_challenges ;

CREATE TABLE IF NOT EXISTS daily_challenges (
  classes_id INT NOT NULL COMMENT 'Class\` code',
  challenges_id INT NOT NULL COMMENT 'Challenge\` code',
  date DATE NOT NULL COMMENT 'Date in wich the challenge has to be completed.',
  PRIMARY KEY (classes_id, challenges_id, date),
  INDEX fk_class_has_daily_challenges_idx (challenges_id ASC),
  INDEX fk_challenge_has_classes_idx (classes_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores the daily challenges that a class had.';


-- -----------------------------------------------------
-- Table completed_normal_challenges
-- -----------------------------------------------------
DROP TABLE IF EXISTS completed_normal_challenges ;

CREATE TABLE IF NOT EXISTS completed_normal_challenges (
  gymnasts_id INT NOT NULL COMMENT 'gymnast’ code',
  normal_challenges_classes_id INT NOT NULL COMMENT 'Foreing key from NORMAL CHALLENGES table',
  normal_challenges_challenges_id INT NOT NULL COMMENT 'Foreing key from NORMAL CHALLENGES table',
  date_of_completation DATE NOT NULL COMMENT 'Date in wich the challenge was completed',
  Interactions JSON NULL COMMENT 'Interactions for the completed challenged by others gymnasts\nHi 5\nComments\nApplasuse\nIn JSON Format',
  PRIMARY KEY (gymnasts_id, normal_challenges_classes_id, normal_challenges_challenges_id),
  INDEX fk_gymnasts_has_normal_challenges_normal_challenges1_idx (normal_challenges_classes_id ASC, normal_challenges_challenges_id ASC),
  INDEX fk_gymnasts_has_normal_challenges_gymnasts1_idx (gymnasts_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores the NORMAL_CHALLENGES that a GYMNAST has completed.';


-- -----------------------------------------------------
-- Table completed_daily_challenges
-- -----------------------------------------------------
DROP TABLE IF EXISTS completed_daily_challenges ;

CREATE TABLE IF NOT EXISTS completed_daily_challenges (
  gymnasts_id INT NOT NULL COMMENT 'gymnast’ code',
  daily_challenges_classes_id INT NOT NULL COMMENT 'Foreing key from DAILY CHALLENGES table',
  daily_challenges_challenges_id INT NOT NULL COMMENT 'Foreing key from DAILY CHALLENGES table',
  daily_challenges_date DATE NOT NULL COMMENT 'Foreing key from DAILY CHALLENGES table',
  date_of_completation DATE NOT NULL COMMENT 'Date in wich the challenge was completed',
  Interactions VARCHAR(45) NULL COMMENT 'Interactions for the completed challenged by others gymnasts\nHi 5\nComments\nApplasuse\nIn JSON Format',
  PRIMARY KEY (gymnasts_id, daily_challenges_classes_id, daily_challenges_challenges_id, daily_challenges_date),
  INDEX fk_gymnasts_has_daily_challenges_daily_challenges1_idx (daily_challenges_classes_id ASC, daily_challenges_challenges_id ASC, daily_challenges_date ASC),
  INDEX fk_gymnasts_has_daily_challenges_gymnasts1_idx (gymnasts_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores the DAILY_CHALLENGES that a GYMNAST has completed.';


-- -----------------------------------------------------
-- Table plans
-- -----------------------------------------------------
DROP TABLE IF EXISTS plans ;

CREATE TABLE IF NOT EXISTS plans (
  id INT NOT NULL COMMENT 'PLAN\` Code',
  name VARCHAR(45) NOT NULL COMMENT 'PLAN\` name',
  price FLOAT NULL COMMENT 'PLAN\` Price',
  cycle VARCHAR(45) NULL COMMENT 'Days that the plan covers. ',
  PRIMARY KEY (id))
ENGINE = InnoDB
COMMENT = 'Table that stores PLANS and promotions';


-- -----------------------------------------------------
-- Table payment_procesors
-- -----------------------------------------------------
DROP TABLE IF EXISTS payment_procesors ;

CREATE TABLE IF NOT EXISTS payment_procesors (
  id INT NOT NULL COMMENT 'PAYMENT PROCESOR\` Code',
  slug VARCHAR(45) NULL COMMENT 'Identification or name of the PAYMENT PROCESOR',
  PRIMARY KEY (id))
ENGINE = InnoDB
COMMENT = 'Table that stores PAYMENT PROCESORS information';


-- -----------------------------------------------------
-- Table subscriptions
-- -----------------------------------------------------
DROP TABLE IF EXISTS subscriptions ;

CREATE TABLE IF NOT EXISTS subscriptions (
  users_id INT NOT NULL COMMENT 'USER\` Code\n',
  payment_procesors_id INT NOT NULL COMMENT 'PAYMENT PROCESOR\`  Code',
  plans_id INT NOT NULL COMMENT 'PLAN\` code',
  suscriptions_status INT NULL COMMENT '0.inactive 1. Active 2. Suspended',
  start_at DATE NULL COMMENT 'Starting dperiod for the suscription',
  end_at DATE NULL COMMENT 'Ending period for the suscription',
  created_at VARCHAR(45) NULL,
  updated_at VARCHAR(45) NULL,
  deleted_at VARCHAR(45) NULL,
  PRIMARY KEY (users_id, plans_id),
  INDEX fk_subscriptions_has_payment_procesors1_idx (payment_procesors_id ASC),
  INDEX fk_subscriptions_has_users1_idx (users_id ASC),
  INDEX fk_subscriptions_has_plans1_idx (plans_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores USERS subscriptions to the differents plans.';


-- -----------------------------------------------------
-- Table payments
-- -----------------------------------------------------
DROP TABLE IF EXISTS payments ;

CREATE TABLE IF NOT EXISTS payments (
  id INT NOT NULL COMMENT 'PAYMENT\` Code',
  subscriptions_users_id INT NOT NULL,
  subscriptions_plans_id INT NOT NULL,
  attemted_at DATE NULL COMMENT 'Payment get proceced at (DATE)',
  amount FLOAT NULL,
  fee FLOAT NULL,
  created_at DATETIME NULL,
  period_start DATETIME NULL COMMENT 'The start of the period that is covered by the payment.',
  period_end DATETIME NULL COMMENT 'The end of the period that is covered by the payment.',
  PRIMARY KEY (id),
  INDEX fk_payments_subscriptions1_idx (subscriptions_users_id ASC, subscriptions_plans_id ASC))
ENGINE = InnoDB
COMMENT = 'Table that stores PAYMENTS made for an specific subscription';

DROP TABLE IF EXISTS password_resets ;

CREATE TABLE IF NOT EXISTS password_resets (
  email varchar(255) NOT NULL,
  token varchar(255) NOT NULL,
  created_at DATETIME NULL,
  INDEX password_resets_email_index (`email`))
ENGINE = InnoDB
COMMENT = 'Table that stores the tokens for changing user passwords';

CREATE TABLE IF NOT EXISTS permissions (
  id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  guard_name varchar(255) NOT NULL,
  created_at timestamp NULL DEFAULT NULL,
  updated_at timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)) 
ENGINE = InnoDB
COMMENT = 'Table that stores user permissions';

DROP TABLE IF EXISTS model_has_roles;
CREATE TABLE IF NOT EXISTS model_has_roles (
  role_id bigint(20) UNSIGNED NOT NULL,
  model_type varchar(255) NOT NULL,
  model_id bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (role_id,model_id,model_type),
  KEY model_has_roles_model_id_model_type_index (model_id,model_type)) 
ENGINE=InnoDB
COMMENT = 'Table that stores the relationships between users and roles';

DROP TABLE IF EXISTS model_has_permissions;
CREATE TABLE IF NOT EXISTS model_has_permissions (
  permission_id bigint(20) UNSIGNED NOT NULL,
  model_type varchar(255) NOT NULL,
  model_id bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (permission_id,model_id,model_type),
  KEY model_has_permissions_model_id_model_type_index (model_id,model_type))
ENGINE=InnoDB
COMMENT = 'Table that stores the relationships between users and permissions';
-- -----------------------------------------------------
-- ALTER TABLES FOR FK
-- -----------------------------------------------------
ALTER TABLE model_has_permissions
  ADD CONSTRAINT model_has_permissions_permission_id_foreign 
      FOREIGN KEY (permission_id) 
      REFERENCES permissions (id) 
      ON DELETE CASCADE;
ALTER TABLE model_has_roles
  ADD CONSTRAINT model_has_roles_role_id_foreign 
      FOREIGN KEY (role_id) 
      REFERENCES roles (id) 
      ON DELETE CASCADE;

ALTER TABLE gyms_has_users 
ADD CONSTRAINT fk_gyms_has_users_gym1
    FOREIGN KEY (gym_id)
    REFERENCES gyms (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_gyms_has_users_user1
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE events
ADD CONSTRAINT fk_events_gym1
    FOREIGN KEY (gym_id) 
    REFERENCES gyms (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE gymnasts
ADD CONSTRAINT fk_gymnasts_gyms_has_users1
    FOREIGN KEY (gyms_has_users_gyms_id , gyms_has_users_users_id)
    REFERENCES gyms_has_users (gym_id , user_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE normal_challenges
ADD CONSTRAINT fk_class_has_challenges
    FOREIGN KEY (classes_id)
    REFERENCES classes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_challenge_is_in_class_
    FOREIGN KEY (challenges_id)
    REFERENCES challenges (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE skills
ADD CONSTRAINT fk_skills_event
    FOREIGN KEY (event_id)
    REFERENCES events (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_skills_category
    FOREIGN KEY (category_id)
    REFERENCES categories (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_skills_level
    FOREIGN KEY (level_id)
    REFERENCES levels (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE skill_lists
ADD CONSTRAINT fk_skills_gym
    FOREIGN KEY (gym_id)
    REFERENCES gyms (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE skill_lists_has_skills
ADD CONSTRAINT fk_skill_lists_has_skills_skill_list
    FOREIGN KEY (skill_list_id)
    REFERENCES skill_lists (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_skill_lists_has_skills_skill
    FOREIGN KEY (skill_id)
    REFERENCES skills (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE gymnast_has_skills
ADD CONSTRAINT fk_gymnast_has_skills
    FOREIGN KEY (gymnast_id)
    REFERENCES gymnasts (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_skills_is_mastered_by_gymnast
    FOREIGN KEY (skills_Id)
    REFERENCES skills (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE gymnasts_classes
ADD CONSTRAINT fk_gymnast_has_classes
    FOREIGN KEY (gymnasts_id)
    REFERENCES gymnasts (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_class_has_gymnasts
    FOREIGN KEY (classes_id)
    REFERENCES classes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE daily_challenges
ADD CONSTRAINT fk_class_has_daily_challenges
    FOREIGN KEY (classes_id)
    REFERENCES classes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_challenge_has_classes_idx
    FOREIGN KEY (challenges_id)
    REFERENCES challenges (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE completed_normal_challenges
ADD CONSTRAINT fk_gymnast_has_normal_challenges
    FOREIGN KEY (gymnasts_id)
    REFERENCES gymnasts (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_normal_challenge_is_completed_by_gymnast
    FOREIGN KEY (normal_challenges_classes_id , normal_challenges_challenges_id)
    REFERENCES normal_challenges (classes_id , challenges_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE completed_daily_challenges
ADD CONSTRAINT fk_gymnast_has_daily_challenges
    FOREIGN KEY (gymnasts_id)
    REFERENCES gymnasts (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_daily_challenge_is_completed_by_gymnast
    FOREIGN KEY (daily_challenges_classes_id , daily_challenges_challenges_id , daily_challenges_date)
    REFERENCES daily_challenges (classes_id , challenges_id , date)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE subscriptions
ADD CONSTRAINT fk_subscriptions_has_users1
    FOREIGN KEY (users_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_subscriptions_has_payment_procesors1
    FOREIGN KEY (payment_procesors_id)
    REFERENCES payment_procesors (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT fk_subscriptions_has_plans1
    FOREIGN KEY (plans_id)
    REFERENCES plans (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE payments
ADD CONSTRAINT fk_payments_subscriptions1
    FOREIGN KEY (subscriptions_users_id , subscriptions_plans_id)
    REFERENCES subscriptions (users_id , plans_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
