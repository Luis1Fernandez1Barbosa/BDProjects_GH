-- EJERCICIO 03 SEGURIDAD
-- Fernández Barbosa Luis Antonio
-- Administrador
CREATE USER 'Admin1'@'localhost' IDENTIFIED BY 'Adpas0' ;
revoke all privileges on *.* to 'Admin1'@'localhost';
-- Operador 1
CREATE USER 'Op1'@'localhost' IDENTIFIED BY 'Opas1' WITH MAX_QUERIES_PER_HOUR 20 WITH MAX_UPDATE_PER_HOUR 10 ACCOUNT LOCK;
grant select on *.* to 'Op1'@'localhost';

grant write on credito.estado to 'Op1'@'localhost';
grant write on credito.depto to 'Op1'@'localhost';
auth required pam_faillock.credito deny=3;

-- Operador 2
CREATE USER 'Op2'@'localhost' IDENTIFIED BY 'Opas2' WITH MAX_USER_CONNECTION 2;
auth required cpam_faillock.credito deny=3;

-- RESPALDO
mysqldump -h localhost -u root -pLAFB2000 credito>D:\LAFB\Base_de_Datos_2\BackUp_Files\credito_%date:\=%_%time:~0,2%-%time:~3,2%-%time:~6,2%.sql