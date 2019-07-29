--UNIVERSIDAD TECOLOGICA ISRAEL
--EP1B BASE DE DATOS II
--JESSICA CHICAIZA
--SEPTIMO "D"



--CREO LA BASE DE DATOS
create database examen_bdd

use examen_bdd
go  

--TABLA LECTOR
CREATE TABLE Lector (
idLector int IDENTITY (1,1) NOT NULL, 
Nombre varchar(20) NOT NULL,
Apellido varchar(20),
Direccion varchar(50) null CONSTRAINT DF_Direccion DEFAULT('Desconocida'),
Telefono nchar(10)NOT NULL,
Email nchar(50) NOT NULL,
CONSTRAINT PK_Lector PRIMARY KEY CLUSTERED (idLector)
)

--INSERIÓN DE DATOS A LA TABLA LECTOR
insert into Lector (Nombre, Apellido,Telefono,Email) values('Juan','Perez','2345423','juan@yahoo.es');
insert into Lector (Nombre, Apellido,Direccion,Telefono,Email) values('Maria','Benavides','Av.12 de Octubre','3073423','mary@gmail.com');
--VISUAIZAR DATOS DE LA LECTOR
select * from  Lector

--TABLA LIBRO
CREATE TABLE Libro 
(
IdLibro nchar(5) NOT NULL,
Titulo varchar(50) NOT NULL,
Descripcion text NOT NULL,
NumPaginas smallint NOT NULL,
NumEjemplares tinyint NULL,
ISBN bigint NULL,
CONSTRAINT PK_Libro PRIMARY KEY CLUSTERED(IdLibro),
CONSTRAINT CK_NumPaginas CHECK (NumPaginas >= 10),
CONSTRAINT CK_NumEjemplares CHECK (NumEjemplares > 0),
CONSTRAINT U_ISBN UNIQUE NONCLUSTERED(ISBN)
)
--INSERIÓN DE DATOS A LA TABLA LIBRO
insert into Libro values(1,'Luces de bohemia','es un esperpento publicado por Valle-Inclán en 1924. Se trata de un esperpento trágico sobre la vida literaria en la sociedad española.',100,2,'8403094264');
insert into Libro values(2,'Don quijote de la Mancha','Alonso Quijano es un hidalgo pobre de la Mancha, que de tanto leer novelas de caballería acaba enloqueciendo y creyendo ser un caballero andante, nombrándose a sí mismo como Don Quijote de la Mancha.',150,5,'8423708195');

--VISUALIZAR DATOS DE LA TABLA LECTOR
SELECT * FROM Libro


--TABLA PRESTAMOLIBRO
CREATE TABLE PrestamoLibro(
IdPrestamo bigint NOT NULL,
IdLector int NOT NULL,
IdLibro nchar (5) NOT NULL,
FecPrestamo nchar(10) NOT NULL,
FecEntrega nchar(10) NULL,
CONSTRAINT PK_PrestamoLibro PRIMARY KEY CLUSTERED (IdPrestamo),
CONSTRAINT FK_Libro FOREIGN KEY (IdLibro) REFERENCES Libro(IdLibro) ON UPDATE CASCADE,
CONSTRAINT FK_Lector FOREIGN KEY (IdLector) REFERENCES Lector(IdLector),
CONSTRAINT CK_FecPrestamo CHECK (FecPrestamo >=getdate()),
CONSTRAINT CK_FecEntrega CHECK (FecEntrega>FecPrestamo)
)

--INSERIÓN DE DATOS A LA TABLA PRESTAMOLIBRO
insert into PrestamoLibro values(1,'1','2','09-06-2019','15-06-2019');
insert into PrestamoLibro values(2,'1','1','10-06-2019','15-06-2019');
--VISUALIZAR DATOS DE LA TABLA PRESTAMO LIBRO
SELECT * FROM PrestamoLibro



