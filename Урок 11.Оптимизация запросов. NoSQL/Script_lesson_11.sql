-- Создайте таблицу logs типа Archive.
-- Пусть при каждом создании записи в таблицах users,
-- catalogs и products в таблицу logs помещается время
-- и дата создания записи, название таблицы, идентификатор
-- первичного ключа и содержимое поля name.

CREATE TABLE logs (
  created_at datetime COMMENT 'Время создания записи',
  table_name varchar(255) COMMENT 'Название таблицы',
  id int COMMENT 'Идентификатор первичного ключа',
  name varchar(255) COMMENT 'Содержимое поля name'
) ENGINE=Archive


DELIMITER //

CREATE TRIGGER users_to_logs AFTER INSERT ON users
FOR EACH ROW BEGIN 
  INSERT INTO logs 
    (created_at, table_name, id, name)
  VALUES 
    (now(), 'users', NEW.id, NEW.name);
END//

CREATE TRIGGER catalogs_to_logs AFTER INSERT ON catalogs
FOR EACH ROW BEGIN 
  INSERT INTO logs 
    (created_at, table_name, id, name)
  VALUES 
    (now(), 'catalogs', NEW.id, NEW.name);
END//

CREATE TRIGGER products_to_logs AFTER INSERT ON products
FOR EACH ROW BEGIN 
  INSERT INTO logs 
    (created_at, table_name, id, name)
  VALUES 
    (now(), 'products', NEW.id, NEW.name);
END//

DELIMITER ;


-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.
DELIMITER //

CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 1000000;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO users(name, birthday_at) VALUES (CONCAT('user_', j), NOW());
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //

DELIMITER ;

CALL insert_into_users();