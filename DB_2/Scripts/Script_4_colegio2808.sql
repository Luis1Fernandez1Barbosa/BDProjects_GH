select * from mysql.user;

use colegio2808;
select * from cursos;
select sum(importe) from consumo;
select * from consumo where importe >100;

show processlist;
SHOW PROCEDURE STATUS where db='colegio2808';
show triggers;


delimiter //
DROP TRIGGER  IF EXISTS bi_cursos //
 
CREATE TRIGGER bi_cursos
BEFORE INSERT ON cursos
FOR EACH ROW
BEGIN
    if(left(NEW.nombre, 5) <> 'CURSO') then
        set new.nombre = concat('curso ', new.nombre);
    end if;
    set new.nombre = upper(new.nombre);
    if(NEW.ffin <= NEW.finicio) then
        SIGNAL SQLSTATE'45000'
        set  MESSAGE_TEXT = 'Fecha final fuera de rango';
    end if;
END; //
 
DELIMITER ;
 
insert into cursos values
('C016', 'escolar 2020-2021', '2020-2021', '2020-07-31 00:00:00', '2023-07-30 00:00:00');

create or replace view alumnos_pagos as
select a.clave_alu, concat_ws(' ', nombre, ap_paterno, ap_materno) as alumno, ifnull(sum(pago), 0)  as tpago, count(pago) as npago 
from alumnos a
left join pagos p ON(a.clave_alu = p.clave_alu)
group by a.clave_alu;

create or replace view alumnas as
select clave_alu matricula, concat_ws(' ', nombre, ap_paterno, ap_materno) as alumno, curp, ciudad
from alumnos
where sexo = 'F';

select * from alumnas;
DELIMITER $$
DROP PROCEDURE IF EXISTS listarPersonas $$
CREATE PROCEDURE listarPersonas(IN vtabla VARCHAR(20))
BEGIN
CASE vtabla
WHEN 'alumnos' THEN
SELECT clave_alu clave, concat_ws(' ',ap_paterno, ap_materno, nombre)
persona,sexo, curp, 'alumno' as tipo from alumnos order by 2;
WHEN 'profesores' THEN
SELECT clave_prof clave, concat_ws(' ',apellido_p, apellido_m, nombres)
persona,sexo, curp, 'profesor' as tipo from profesores order by 2;
WHEN 'todos' THEN
SELECT clave_alu clave, concat_ws(' ',ap_paterno, ap_materno, nombre)
persona,sexo, curp, 'todos' as tipo from alumnos
UNION ALL
SELECT clave_prof clave, concat_ws(' ',apellido_p, apellido_m, nombres)
persona,sexo, curp, 'profesor' as tipo from profesores order by 2;
else
SELECT 'SIN DATOS&' MSG;
END CASE;
END$$

DELIMITER ;
CALL listarPersonas('profesores');

-- ************************************************
delimiter $$
DROP PROCEDURE IF EXISTS pagos_alumnos $$
CREATE PROCEDURE pagos_alumnos(IN vclave_alu VARCHAR(20), OUT pagos_count INT, OUT pagos_sum
DECIMAL(10,2))
READS SQL DATA
BEGIN
SELECT distinct id_curso
FROM pagos
WHERE clave_alu = vclave_alu;
SELECT COUNT(*), SUM(pago)
FROM pagos
WHERE clave_alu = vclave_alu
AND id_curso = id_curso
INTO pagos_count, pagos_sum;
END $$

CALL pagos_alumnos('id_curso');
SELECT pagos_alumnos();