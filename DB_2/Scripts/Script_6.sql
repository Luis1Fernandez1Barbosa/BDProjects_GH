select * from mysql.user;
use extra_FBLA;

select * from escritor;
select * from libro;


use credito;
select * from conc_ventas;
select * from bitacora;
select * from consumo;
select * from cuenta;
select * from empleado;
select * from tarjeta;
select * from tienda;

select sum(importe) from consumo;
select * from consumo where importe >100;
SHOW TABLES;
show privileges;
show processlist;
show variables like '%isolation%';
SHOW PROCEDURE STATUS where db='credito';
show triggers;
select @@transaction_isolation;

select fecha, count(*)fecha, tiendano, movimiento, cuentano, importe, 
GROUPING(fecha), GROUPING(fecha,tiendano)
from consumo 
group by fecha, tiendano with rollup
order by fecha, tiendano; 

 
-- Ganancia total por pais y categoria
select tipo, tiendano, tnombre
from  tienda
group by tipo
order by tipo; 

create or replace view conc_ven_tp as
select tipo, tnombre,tiendano
from tienda;

select * from conc_ven_tp;
select * from conc_ventas;

create or replace view conc_ventas as
select cuentano,fecha, importe, movimiento, tiendano
from consumo 
group by cuentano
order by cuentano;



create user 'LuisV_2808'@'localhost' identified by 'passV';
grant select on credito.conc_ventas to 'LuisV_2808'@'localhost';
grant select on credito.conc_ven_tp to 'LuisV_2808'@'localhost';
