-- EJERCICIO 03 SEGURIDAD
-- Fernández Barbosa Luis Antonio
-- *****************************************
-- Ver Usuarios
select * from mysql.user;
select * from BD.Table; 


-- *************************Creacion de usuarios************************* 
CREATE USER 'Admin1'@'localhost' IDENTIFIED BY 'Pass1';
CREATE USER 'Op1'@'localhost' IDENTIFIED BY 'Pass2';
CREATE USER 'Op2'@'localhost' IDENTIFIED BY 'Pass3';


-- ***************************
select user();
-- ********************Maximo QUERYS**********************
-- ... WITH MAX_QUERIES_PER_HOUR 5 ACCOUNT LOCK;
-- ********************Maximo CONECTION**********************
-- ... WITH MAX_USER_CONNECTION 2;
-- ... WITH MAX_CONNECTION_PER_HOUR 5;
-- ********************Desbloqueo**********************
ALTER USER ' ' ACCOUNT UNLOCK;

-- ******************NIVELES*********************
select * from niveles;
insert into niveles values(8, "Doctor");
update niveles set nombre = 'DR' where id_nivel=8;

-- ***************************PRIVILEGIOS*************************
show privileges;
show grants for 'usuario'@'localhost';

revoke all privileges;
revoke update, delete, insert on *.* from 'usuario'; 
revoke update, delete, insert on BD.Table from 'usuario';

grant update on BD.niveles to 'user'@localhost;
grant select on BD.* to 'user'@localhost; -- solo ver
