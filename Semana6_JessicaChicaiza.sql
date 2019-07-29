/*
Universidad Tecnológica Israel
Nombre:Jessica Chicaiza
Paralelo:"D"
Fecha:05-06-19
*/


create database ejercicio
go
use ejercicio
go

create table Clientes(
usuario char(7),
nombre char(10),
cedula char(13),
fechNac date
constraint PK_Cliente primary key clustered (usuario),
constraint U_Cliente_Cedula unique nonclustered(cedula),
constraint CK_Cliente_FechNac check(fechNac>dateadd(year,-18, getdate()))
)

create table Pedidos(
cliente char(7),
numpedido int,
fecha date,
total varchar(45)
constraint PK_Pedidos primary key clustered (numpedido),
constraint CK_Pedidos_Fecha check(fecha > dateadd(year,0,'1900-01-01') and fecha <= getdate()),
constraint CK_Pedidos_Total check(total>0),
constraint FK_Clientes_Pedidos foreign key (cliente) references Clientes (usuario) on update cascade
)

create table Productos(
id int,
nombre char(20) constraint DF_Productos_nombre default ('Sin Nombre'),
proveedor varchar(20),
deducible bit
constraint PK_Productos primary key clustered (id)
)

create table Lineas_Pedido(
cliente char(7),
pedido int,
producto int,
precio int,
cantidad int
constraint PK_Lineas_Pedido primary key clustered (cliente, pedido, producto),
constraint CK_Lineas_Pedido_Precio check(precio>0),
constraint CK_Lineas_Pedido_Cantidad check(cantidad>0),
constraint FK_Productos_Lineas_Pedido foreign key (producto) references Productos (id),
)

