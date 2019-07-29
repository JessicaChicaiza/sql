/*
Universidad Tecnológica Israel
Nombre:Jessica Chicaiza
Paralelo:"D"
*/

use Northwind
go

--1)Crear una Vista para mostrar los productos comprados por cada cliente con el total de su 
--precio unitario y además se debe filtrar por el país de procedencia del cliente que debe ser Mexico, mostrar el producto, y total del precio unitario.

create view Cliente_Compras
as 
select c.ContactName as Cliente, p.ProductName as Producto , sum(od.UnitPrice* od.Quantity) as Total from Customers c
inner join Orders  o on
c.CustomerID=o.CustomerID
inner join [Order Details] od
on od.OrderID=o.OrderID
inner join Products p
on p.ProductID=od.ProductID
where c.Country='Mexico'
group by c.ContactName,p.ProductName

select * from  Cliente_Compras


--2)Crear una vista para mostrar el total del precio unitario de productos vendidos agrupando por producto
-- y país, mostrar producto, país y el total antes mencionado.

create view Productos_Vendidos
as 
select p.ProductName AS Producto,s.Country as Pais,sum(od.UnitPrice* od.Quantity) as Total   from Products p 
inner join [Order Details] od
on p.ProductID=od.ProductID
inner join Suppliers s
on s.SupplierID=p.SupplierID
group by p.ProductName,s.Country 

select * from  Productos_Vendidos


--3)Crear una vista para mostrar la cantidad total de productos vendidos los cuales estén en estado
-- discontinuado, mostrar producto, país y el total antes mencionado.

create view Productos_Vendidos_Dis
as 
select p.ProductName as Producto,s.Country as Pais, count(od.Quantity) as Total_cantidad  from Products p 
inner join [Order Details] od on 
p.ProductID=od.ProductID
inner join Suppliers s on
s.SupplierID=p.SupplierID
where p.Discontinued=1
group by p.ProductName, s.Country 

select * from  Productos_Vendidos_Dis


--4)Crear una vista que muestre los productos vendidos por cada empleado y los productos comprados por
-- cada cliente establecer las diferencias de compra o venta, mostrar empleado/cliente, producto y compra/venta.

create view Empleados_Clientes
as 
select e.FirstName+' '+e.LastName as nombre, p.ProductName as producto,
 'Empleado' as Tipo, 'Venta' as Compra_Venta from Employees e
inner join Orders o on 
o.EmployeeID=e.EmployeeID
inner join [Order Details] od on
od.OrderID=o.OrderID
inner join Products p on
p.ProductID=od.ProductID
group by  e.FirstName+' '+e.LastName, p.ProductName
union
select c.ContactName as nombre, p.ProductName as producto,
 'Cliente' as Tipo, 'Compra' as Compra_Venta from Customers c
inner join Orders o on 
o.CustomerID=c.CustomerID
inner join [Order Details] od on
od.OrderID=o.OrderID
inner join Products p on
p.ProductID=od.ProductID
group by  c.ContactName, p.ProductName

select * from  Empleados_Clientes

--5)Crear una vista que muestre cuantas órdenes ha realizado cada empleado (mostrar el nombre, apellidos y
-- número de pedidos) que sean mayores a 100.

create view Empleado_TotalVentas
as 

select e.FirstName+' '+e.LastName as nombre, count(o.orderId) as numero_pedidos 
from Employees e inner join Orders o 
on e.EmployeeID = o.EmployeeID
group by e.FirstName+' '+e.LastName 


select * from Empleado_TotalVentas
where numero_pedidos >100





