-- Fernández Barbosa Luis Antonio 
-- Examen Extraordinario de Bases de Datos 2 junio de 2023
use extra_FBLA;
-- 1. Usando la terminal restaurar archivo: libros.sql en la base de datos Extra__[INICIALES]
-- En la terminal se genera el comando para su restauracion
-- >mysql -h 127.0.0.1 -uroot -pLAFB2000 < C:\Users\ptdfg\Downloads\Proyecto_BDII\libros.sql

-- 2. Cambiar el nivel de aislamiento a REPEATABLE READ
set @@SESSION.transaction_isolation = 'REPEATABLE-READ';
select @@transaction_isolation;
-- 3. En una transacción insertar 3 escritores y en otra transacción insertar dos libro por escritor, en cada uno
-- guardar SAVEPOINT
set SQL_SAFE_UPDATES=0;
start transaction;
insert into escritor values (null,'Escritor1','AP1','Dir1','ES1');
savepoint punto_Es1;
insert into escritor values (null,'Escritor2','AP2','Dir2','ES2');
savepoint punto_Es2;
insert into escritor values (null,'Escritor3','AP3','Dir3','ES3');
savepoint punto_Es3;
set SQL_SAFE_UPDATES=1;

set SQL_SAFE_UPDATES=0;
start transaction;
insert into libro values (null,3,'Libro1_E1','Cont1'), (null,3,'Libro2_E1','Cont2');
savepoint p_LibEs1;
insert into libro values (null,4,'Libro1_E2','Cont3'), (null,4,'Libro2_E2','Cont4');
savepoint p_LibEs2;
insert into libro values (null,5,'Libro1_E3','Cont5'), (null,5,'Libro2_E3','Cont6');
savepoint p_LibEs3;
set SQL_SAFE_UPDATES=1;

-- 4. Crear una vista llamada obras que muestre nombre completo dirección y titulo de cada escritor y libro que haya
-- escrito
create or replace view obras as
select id_escritor, nombre,apellidos, direccion, alias
from escritor
group by id_escritor
order by id_escritor;

select * from obras;
-- 5. Roles
-- a. Crear un rol para solo lectura de las tablas escritor y libro
drop role if exists readapp;
create role readapp;
grant select on *.* to readapp;
show grants for readapp;
-- show grants for 'root'@'localhost'; 

-- b. Crear un rol para escritura en las tablas escritor y libro
drop role if exists writeapp;
create role writeapp;
grant insert, update, delete on *.* to writeapp;
show grants for writeapp; 

-- 6. Usuarios

-- a. Crear un usuario lector_[iniciales] y asignarle el rol de lectura
-- a) El usuario debe tener acceso desde localhost y desde cualquier punto con contraseñas diferentes
-- b) El usuario remoto no puede tener mas de una sesión activa
drop user if exists 'lector_FBLA'@'localhost';
create user 'lector_FBLA'@'localhost' identified by 'pass1' with max_user_connections 1;
grant readapp to 'lector_FBLA'@'localhost';

-- b. Crear un usuario escritor_[ iniciales] y asignarle los roles de lectura y escritura
-- a) Solo tiene acceso desde localhost y puede realizar solo 20 consultas y 15 actualizaciones y tener
-- solo 2 sesiones por hora
drop user if exists 'escritor_FBLA'@'localhost';
create user 'escritor_FBLA'@'localhost' identified by 'pass2' with max_queries_per_hour 20 max_updates_per_hour 15 max_connections_per_hour 2 ;
grant readapp, writeapp to 'escritor_FBLA'@'localhost';

-- 7. Mostrar los privilegios del usuario lector usando el rol escritor
show privileges;
-- 8. Generar un procedimiento almacenado que liste los títulos de un escritor buscándolo por nombre y apellido, estos
-- dos datos deben ser parámetros del SP

-- 9. Generar un trigger que valide que un escritor tenga una clave valida de país en formato ISO (2 caracteres) en el
-- campo dirección al momento insertar
DELIMITER // 
DROP TRIGGER IF EXISTS cl_pais//
CREATE TRIGGER cl_pais
BEFORE INSERT ON escritor  
FOR EACH ROW 
BEGIN    
    set new.direccion = upper(new.direccion);
    if(NEW.direccion = 'MX') then
        SIGNAL SQLSTATE'45000'
        set  MESSAGE_TEXT = 'Clave diferente de 2 caracteres';
    end if;
END //
delimiter ;

insert into escritor values
(null, 'Escritor6', 'AP6', 2, 'Es6');

-- 10. Crear una consulta prepara que muestre los libros de un escritor por id_escritor