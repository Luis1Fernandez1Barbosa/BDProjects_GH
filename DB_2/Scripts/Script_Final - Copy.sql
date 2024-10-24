-- FERNANDEZ BARBOSA LUIS ANTONIO
-- BASE DE DATOS 2 - 2808

-- 1a) ---------------------------------------------------
create user 'Luis1_2808'@'localhost' identified by 'pass1' with max_queries_per_hour 20;
grant select on *.* to 'Luis1_2808'@'localhost';

-- 1b) ---------------------------------------------------
create user 'Luis2_2808'@'localhost' identified by 'pass2' with max_user_connections 3;
grant select, insert on credito.* to 'Luis2_2808'@'localhost';

-- 4) ------------------------------------------------------
-- bitacora
drop table if exists bitacora;
create table bitacora(
    id int not null auto_increment primary key,
    fecha datetime not null,
    usuario varchar(50) not null,
    tabla varchar(50) not null,
    accion text null
);
-- bit_consumo
delimiter //
DROP TRIGGER  IF EXISTS bit_consumo //
CREATE TRIGGER bit_consumo
BEFORE DELETE ON consumo
FOR EACH ROW
BEGIN
INSERT INTO bitacora VALUES
(null, sysdate(), user(), 'consumo', JSON_OBJECT('accion', 'DELETE'));	
END; //
DELIMITER ;
-- bit_cuenta ***********************************************
delimiter //
DROP TRIGGER  IF EXISTS bit_cuenta //
CREATE TRIGGER bit_cuenta
BEFORE DELETE ON cuenta
FOR EACH ROW
BEGIN
INSERT INTO bitacora VALUES
(null, sysdate(), user(), 'cuenta', JSON_OBJECT('accion', 'DELETE'));	
END; //
DELIMITER ;
-- bit_empleado ***********************************************
delimiter //
DROP TRIGGER  IF EXISTS bit_empleado //
CREATE TRIGGER bit_empleado
BEFORE DELETE ON empleado
FOR EACH ROW
BEGIN
INSERT INTO bitacora VALUES
(null, sysdate(), user(), 'empleado', JSON_OBJECT('accion', 'DELETE'));	
END; //
DELIMITER ;
-- bit_tarjeta ***********************************************
delimiter //
DROP TRIGGER  IF EXISTS bit_tarjet //
CREATE TRIGGER bit_tarjet
BEFORE DELETE ON tarjeta 
FOR EACH ROW
BEGIN
INSERT INTO bitacora (id, fecha, usuario,tabla, accion) VALUES
(null, sysdate(), user(), 'tarjeta', JSON_OBJECT('accion', 'DELETE'));	
END; //
DELIMITER ;
-- bit_tienda ***********************************************
delimiter //
DROP TRIGGER  IF EXISTS bit_tienda //
CREATE TRIGGER bit_tienda
BEFORE DELETE ON tienda 
FOR EACH ROW
BEGIN
INSERT INTO bitacora (id, fecha, usuario,tabla, accion) VALUES
(null, sysdate(), user(), 'tienda', JSON_OBJECT('accion', 'DELETE'));	
END; //
DELIMITER ;
-- 
set SQL_SAFE_UPDATES=0;
delete from consumo where cuentano='00023450260';
delete from cuenta where cuentano='00023450023';
delete from empleado where empno='12003';
delete from tarjeta where tarjeta='9501002345025004';
delete from tienda where tipo='VIPS';
set SQL_SAFE_UPDATES=1;

-- 5) ----------------------------------------------------
DELIMITER // 
DROP TRIGGER IF EXISTS bi_consumo//
CREATE TRIGGER bi_consumo 
BEFORE INSERT ON consumo  
FOR EACH ROW 
BEGIN    
    set new.importe = upper(new.importe);
    if(NEW.importe <= 0) then
        SIGNAL SQLSTATE'45000'
        set  MESSAGE_TEXT = 'Importe menor o igual a 0';
    end if;
END //
delimiter ;

insert into consumo values
('00023450260', '2022-05-30', '5', 'C', '0');

-- 7) --------------------------------------------------
create or replace view conc_ventas as
select cuentano,fecha, importe, movimiento, tiendano
from consumo 
group by cuentano
order by cuentano;
-- 8) -----------------------------------------------------
create or replace view conc_ven_tp as
select tipo, tnombre,tiendano
from tienda;

-- 9) --------------------------------------------------------
create user 'LuisV_2808'@'localhost' identified by 'passV';
grant select on credito.conc_ventas to 'LuisV_2808'@'localhost';
grant select on credito.conc_ven_tp to 'LuisV_2808'@'localhost';

-- 10) -------------------------------------------------------
select fecha, count(*)fecha, tiendano, movimiento, cuentano, importe, 
GROUPING(fecha), GROUPING(fecha,tiendano)
from consumo 
group by fecha, tiendano with rollup
order by fecha, tiendano; 
