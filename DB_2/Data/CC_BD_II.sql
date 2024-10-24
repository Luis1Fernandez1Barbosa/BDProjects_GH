SET NAMES 'UTF8MB4';
DROP DATABASE IF EXISTS BD_Default;
CREATE DATABASE IF NOT EXISTS BD_Default DEFAULT CHARACTER SET UTF8MB4;
USE BD_Default;
CREATE TABLE materias(
id                            INTEGER NOT NULL AUTO_INCREMENT,
nombre                        VARCHAR(40) NOT NULL,
creditos                      INTEGER NOT NULL,
imagen                        VARCHAR(20) NOT NULL,
descripcion                   VARCHAR(280) NOT NULL,
PRIMARY KEY(id)
)DEFAULT CHARACTER SET UTF8MB4;

CREATE TABLE comentarios(
id									INTEGER(5) NOT NULL AUTO_INCREMENT,
correo								VARCHAR(20) NOT NULL,
imagen 								VARCHAR(20) NOT NULL,
opinion 							VARCHAR(100) NOT NULL,
PRIMARY KEY (id)
)DEFAULT CHARACTER SET UTF8MB4;

INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Redes de computadoras',10,'imagen3','Una red informática, una red de comunicaciones de datos o una red de computadoras es la interconexión de distinto número de sistemas informáticos a través de una serie de dispositivos de telecomunicaciones y un medio físico (alámbrico o inalámbrico).');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Programación Web2',8,'imagen4','Se refiere a la creación de sitios web para Internet o una intranet. Para conseguirlo se hace uso de tecnologías del lado del servidor y del cliente que conllevan unos procesos de base de datos y el uso de un navegador para realizar determinadas tareas o mostrar información.');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Microprocesadores y Microcontroladores',10,'imagen5','Los  microprocesadores y los microcontroladores, son dispositivos digitales  programables  que  tienen  una  gran  importancia    en  la    vida  moderna;  éstos  han  marcado  la  pauta en  el  desarrollo  de  la  tecnología.');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Sistemas de información',9,'imagen6','Cuando se habla de un sistema de información (SI) se refiere a un conjunto ordenado de mecanismos que tienen como fin la administración de datos y de información, de manera que puedan ser recuperados y procesados fácil y rápidamente');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Temas especiales de computación',4,'imagen7','La computación cuántica o informática cuántica​ es un paradigma de computación distinto al de la informática clásica o computación clásica. Se basa en el uso de cubits, una especial combinación de unos y ceros.');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Materia 6',7,'imagen2','Se hace una descripción de la materia 6');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Materia 7',2,'imagen1','Se hace una descripción de la materia 7');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Materia 8',9,'imagen2','Se hace una descripción de la materia 8');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Materia 9',1,'imagen1','Se hace una descripción de la materia 9');
INSERT INTO materias(nombre,creditos,imagen,descripcion) VALUES('Materia 10',9,'imagen2','Se hace una descripción de la materia 10');