
CREATE TABLE TestSpeedMySql
(
	CurrentDate DATETIME NULL,
	TextInput NVARCHAR(255) NULL
)
partition by range (Year(CurrentDate)) 
(
	partition p0 values less than (Year('1990-01-01')),
	partition p1 values less than (Year('2000-01-01')),
	partition p2 values less than (Year('2010-01-01')),
	partition p3 values less than (Year('9999-01-01'))
);

-- get DB size
-- SELECT table_schema "MilenDB", sum( data_length + index_length ) / 1024 / 1024 "Data Base Size in MB"
-- FROM information_schema.TABLES;

DELIMITER $$
CREATE PROCEDURE InsertRolls(counter INT)
BEGIN
SET @ind = 0;
  WHILE @ind < counter DO

INSERT INTO `TestSpeedMySql` 
VALUES (
(SELECT timestamp('2000-01-01 00:00:01') - INTERVAL FLOOR( RAND( ) * 36650) DAY), 'put some value');

SET @ind = @ind + 1;
END WHILE;
END $$

DELIMITER ;

CALL InsertRolls(1000);






-- select * from TestSpeedMySql; 
-- truncate table TestSpeedMySql;
-- SHOW TABLE STATUS WHERE Name = 'TestSpeedMySql'; shows reults whit table typ
-- SHOW VARIABLES LIKE '%partition%'
