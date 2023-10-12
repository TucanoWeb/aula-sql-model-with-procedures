-- Wed Jun 14 13:34:45 2023
-- Model: Modelagem    Version: 1.0
-- MySQL Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cor` VARCHAR(45) NULL,
  `preco` VARCHAR(45) NULL,
  `tamanho` VARCHAR(45) NULL,
  `peso` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name_user` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`logs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `command` VARCHAR(255) NULL DEFAULT '',
  `produto_id` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `produto_id`, `users_id`),
  INDEX `fk_logs_produto_idx` (`produto_id` ASC),
  INDEX `fk_logs_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_logs_produto`
    FOREIGN KEY (`produto_id`)
    REFERENCES `mydb`.`produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- procedure getAllProducts
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE getAllProducts()
BEGIN 
	SELECT * FROM produtos;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure findOneProduct
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE findOneProduct(IN id_product INT)
BEGIN 
	SELECT * FROM produtos WHERE id=id_product;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updatePriceProduct
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE updatePriceProduct(IN valor_prod varchar(255), IN id_product INT, IN user_id_value INT)
BEGIN 
	UPDATE produtos SET preco=valor_prod WHERE id=id_product;
    INSERT INTO logs (command, produto_id, users_id) VALUES ("Update Price", id_product, user_id_value);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateCorProduct
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE updateCorProduct(IN id_product INT, IN cor_prod varchar(255), IN user_id_value INT)
BEGIN 
	UPDATE produtos SET cor=cor_prod WHERE id=id_product;
    INSERT INTO logs (command, produto_id, users_id) VALUES ("Update Color", id_product, user_id_value);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateWeightProduct
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE updateWeightProduct(IN id_product INT, IN peso_prod varchar(255), IN user_id_value INT)
BEGIN 
	UPDATE produtos SET peso=peso_prod WHERE id=id_product;
    INSERT INTO logs (command, produto_id, users_id) VALUES ("Update Weigth", id_product, user_id_value);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateSizeProduct
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE updateSizeProduct(IN id_product INT, IN tamanho_prod varchar(255), IN user_id_value INT)
BEGIN 
	UPDATE produtos SET tamanho=tamanho_prod WHERE id=id_product;
    INSERT INTO logs (command, produto_id, users_id) VALUES ("Update Size", id_product, user_id_value);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure createProduct
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE createProduct(IN valor_prod varchar(255), IN cor_prod varchar(255), IN tamanho_prod varchar(255), IN peso_prod varchar(255), IN user_id_value INT)
BEGIN 
	INSERT INTO produtos (cor, preco, tamanho, peso) VALUES (cor_prod, valor_prod, tamanho_prod, peso_prod);
    INSERT INTO logs (command, produto_id, users_id) VALUES ("Create Product", (SELECT MAX(id) FROM produtos), user_id_value);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure createUser
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE createUser(IN name_user_value varchar(255))
BEGIN 
	INSERT INTO users (name_user) VALUES (name_user_value);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateUser
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE updateUser(IN name_user_value varchar(255), IN user_id_value INT)
BEGIN 
	UPDATE produtos SET name_user=name_user_value WHERE id=user_id_value;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteUser
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE deleteUser(IN user_id_value INT)
BEGIN 
	DELETE from users WHERE id=user_id_value;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteProduct
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE deleteProduct(IN id_product INT)
BEGIN 
	DELETE from produtos WHERE id=id_product;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getAllUsers
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE getAllUsers()
BEGIN 
	SELECT * from users;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getAllLogs
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE getAllLogs()
BEGIN 
	SELECT * from logs;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure FindLogPerUser
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE FindLogPerUser(IN id_value INT)
BEGIN 
	SELECT * from logs WHERE users_id=id_value;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure FindLogPerProduct
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE FindLogPerProduct(IN id_value INT)
BEGIN 
	SELECT * from logs WHERE produto_id=id_value;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure FindLogPerDate
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE FindLogPerDate(IN value_initial varchar(45), IN value_final varchar(45))
BEGIN 
	SELECT * from logs WHERE update_time between value_initial AND value_final;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
