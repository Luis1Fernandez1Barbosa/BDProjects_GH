select * from mysql.user;

use credito;
select * from consumo;
select sum(importe) from consumo;
select * from consumo where importe >100;
select * from consumo where tiendano = 8;
select * from cuenta;
select * from empleado;
select * from tarjeta;
select * from tienda;

select sum(importe) as Importe, monthname(fecha) as Dia from consumo;

select count(*) from consumo; 
select user();
select * from mysql.user;
show processlist;
SHOW PROCEDURE STATUS where db='credito';
show triggers;
show privileges;
show grants for 'Luis1_2808'@'localhost';

create user 'Luis1_2808'@'localhost' identified by 'pass1' with max_queries_per_hour 20;
grant select on *.* to 'Luis1_2808'@'localhost';

create user 'Luis2_2808'@'localhost' identified by 'pass2' with max_user_connections 3;

grant select, insert on credito.* to 'Luis2_2808'@'localhost';

revoke select, insert on *.* from 'Luis2_2808'@'localhost';
-- TRIGGERS*********************************************************************



-- PROCEDURE*********************************************************************
DELIMITER $$
DROP PROCEDURE IF EXISTS contar_productos$$
CREATE PROCEDURE contar_productos()
BEGIN
-- ******Movimientos********
  SET total_cons = (
    SELECT * FROM consumo 
    WHERE consumo.tiendano = tiendano);
  SET total_mov = (
    SELECT COUNT(*) FROM consumo 
    WHERE sum(importe) = tiendano);
    SELECT tiendano clave, concat_ws(' ',ap_paterno, ap_materno, nombre)
persona,sexo, curp, 'alumno' as tipo from alumnos order by 2;
END
$$
DELIMITER ;

CALL contar_productos('8', @total_cons);
SELECT @total_cons;

