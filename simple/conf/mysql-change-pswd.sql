SET @changepswd = CONCAT('SET PASSWORD FOR "','demo','"@"%" = "',@newdbpswd,'" ');
PREPARE stmt FROM @changepswd; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SELECT @newdbpswd, @changepswd;