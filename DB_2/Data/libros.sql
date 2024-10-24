create database if not exists extra_FBLA;
use extra_FBLA; 

CREATE TABLE escritor (
id_escritor INT NOT NULL auto_increment, 
nombre VARCHAR(30) NOT NULL, 
apellidos VARCHAR(40) NOT NULL, 
direccion VARCHAR(100) NULL,
alias VARCHAR(30) NULL DEFAULT 'NA', 
PRIMARY KEY(id_escritor)
) ENGINE=InnoDB;

CREATE TABLE libro(
	id_libro INT NOT NULL auto_increment PRIMARY KEY, 
    id_escritor INT NOT NULL,
    titulo VARCHAR(100),
    contenido TEXT NULL,
    FOREIGN KEY(id_escritor) REFERENCES escritor(id_escritor) 
    ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO escritor VALUES (NULL, 'CARLOS', 'MONSIVAIS', 'CDMX', 'MONSI');
INSERT INTO escritor VALUES (NULL, 'GABRIEL', 'GARCIA', NULL, NULL);

desc escritor;
desc libro;

INSERT INTO libro VALUES
(NULL, 1, 'CONFRONTACIONES',NULL),
(NULL, 2, '100 AÑOS DE SOLEDAD', NULL),
(NULL, 2, 'EL AMOR EN TIEMPOS DE COLERA', 'ALGO');