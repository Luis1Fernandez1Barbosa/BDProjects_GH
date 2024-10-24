select * from mysql.user;

use credito;
select * from info_empleado;
select sum(importe) from consumo;
select * from consumo where importe >100;
select * from consumo where tiendano = 8;

show processlist;
SHOW PROCEDURE STATUS where db='credito';

DELIMITER $$
DROP PROCEDURE IF EXISTS proced_1$$
CREATE PROCEDURE proced_1(IN empno VARCHAR(50))
BEGIN
-- ******Movimientos********
    SELECT empno clave, concat_ws(' ',epaterno, ematerno, enombre)
persona,puestono,sexo,curp,fingreso,sueldo, deptono, 'empleados' as tipo from empleado order by 2;
END
$$
DELIMITER ;

CALL proced_1('12001');

CALL contar_productos('12001', @total_cons);
SELECT @total_cons;

