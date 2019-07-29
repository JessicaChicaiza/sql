/*
Universidad Tecnológica Israel
Nombre:Jessica Chicaiza
Paralelo:"D"
Fecha:05-06-2019
*/

/* Ejercicio 1*/
create database ejercicioA
go
use ejercicioA
go


create table Autor(
idAutor varchar(5),
nombre varchar(45) not null,
apellido varchar(45) not null,
edad int,
estado bit constraint DF_Autor_Estado Default (1)
constraint PK_Autor primary key clustered (idAutor) not null,
constraint CK_Autor_Edad check (edad>18)
)


create table Libro(
idLibro int identity(1,1) not null,
nombre varchar(45) not null,
descripcion varchar(45),
nro_paginas int constraint DF_Libro_Nro_Paginas Default(10),
Autor_idAutor varchar (5),
isbn varchar(20)
constraint PK_Libro primary key clustered (idLibro),
constraint CK_Libro_Nro_Paginas check(nro_paginas>=10),
constraint U_Libro_Isbn unique nonclustered (isbn),
constraint FK_Autor_Libro foreign key (Autor_idAutor) references Autor (idAutor) on update cascade
)

/* Ejercicio 2*/
create database ejercicioB
go
use ejercicioB
go 


create table Venta(
codigoVenta int identity(1,1) not null,
cliente varchar(100) not null,
fecha datetime not null,
cedRuc varchar(13)
constraint PK_Venta primary key clustered (codigoVenta),
constraint CK_Venta_Fecha check(fecha >= dateadd(year,0,'1900-01-01') and fecha <= getdate()),
)


create table Producto(
codigoProducto varchar(10) not null,
nombre varchar(100) not null,
precio decimal(18,2) not null
constraint PK_Producto primary key clustered (codigoProducto),
constraint U_Producto_Nombre unique nonclustered(nombre),
constraint CK_Producto_Precio check(precio>=0)
)

create table DetalleVenta(
codigoVenta int not null, 
codigoProducto varchar(10)not null,
cantidad decimal(18,2) constraint DF_DetalleVenta_Cantidad default (1),
descuento decimal(18,2) constraint DF_DetalleVenta_Descuento default (0)
constraint PK_DetalleVenta primary key clustered (codigoVenta, codigoProducto),
constraint CK_DetalleVenta_Cantidad check (cantidad>0),
constraint CK_DetalleVenta_Descuento check (descuento>=0),
constraint FK_Venta_DetalleVenta foreign key (codigoVenta) references Venta (codigoVenta),
constraint FK_Producto_DetalleVenta foreign key (codigoProducto) references Producto (codigoProducto) on update cascade
)

