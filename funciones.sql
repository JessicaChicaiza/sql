--UNIVERISIDAD TECNOLÓGICA ISRAEL
--NOMBRE:JESSICA CHICAIZA
--NIVEL: SÉPTIMO "D"
--MATERIA: BASES DE DATOS II

create database  semana11
use semana11


--Realizar una función que reciba 2 números y la operación y realice las 4 operaciones básicas (suma, resta, multiplicación, y división), 
--validar que no exista división para 0

create function operaciones
(
	@operador char(1),
	@num1 real,
	@num2 real
)
returns real
as
begin
	declare @resultado real


	if @operador='+'
	begin
		set @resultado = @num1+@num2
	end 
	else if @operador='-'
	begin
	 set @resultado = @num1-@num2
	end
	else if @operador='*'
	begin
		set @resultado = @num1*@num2
	end 
	else if @operador='/'
	begin
		if ( @num2=0)
		begin
		 set @resultado = -99999999
		end
		else
		begin
		  set @resultado = @num1/@num2
		end
	end
	return @resultado
end


select dbo.operaciones('/',2.5,0.6)



--Realizar un función que obtenga el resultado de un numero elevado a una potencia x^y, validar que el numero no exceda a 10000 y la potencia
-- a 100.

create function potencia
(
	
	@base bigint,
	@exponente bigint
)
returns real
as
begin
	declare @resultado bigint

	if(@base<10000 or @exponente <100)
	begin
		set @resultado=power(@base, @exponente)
	end 
	else
	begin
		 set @resultado = -9
	end
	return @resultado
end

select dbo.potencia(50,50)



--Realizar una función que permita calcular el total de ventas de un factura se debe tomar en cuenta la cantidad por el precio menos el 
--descuento.


create function factura_ventas
(
	
	@cantidad int,
	@precio real,
	@descuento real

)
returns real
as
begin
	declare @total real
	declare @des real

	set @total= @cantidad*@precio-((@cantidad*@precio)* @descuento)
	return @total
	
end

select dbo.factura_ventas(50,2,0.10)



--Usando Northwind

use Northwind
go

--Realizar una función que permita obtener los datos por empleado el total vendido por factura.

select e.FirstName+' '+e.LastName AS Empleado, sum (od.UnitPrice*od.Quantity) as Total from Employees  e 
inner join Orders  o  on o.EmployeeID = e. EmployeeID
inner join  [Order Details] od on od.OrderID =o.OrderID
where e.EmployeeID='1'
group by e.FirstName,e.LastName


create function empleado_ventas(@IdEmpleado int)
Returns Table
AS
       Return (select e.FirstName+' '+e.LastName AS Empleado, sum (od.UnitPrice*od.Quantity) as Total from Employees  e 
			inner join Orders  o  on o.EmployeeID = e. EmployeeID
			inner join  [Order Details] od on od.OrderID =o.OrderID
			where e.EmployeeID=@IdEmpleado
			group by e.FirstName,e.LastName)

select * from dbo.empleado_ventas(1)


 --Realizar una función que permita obtener los datos por cliente el total comprado por factura.

select ContactName as Cliente, sum (od.UnitPrice*od.Quantity) as Total
from Customers c 
inner join Orders  o  on o.CustomerID = c. CustomerID
inner join  [Order Details] od on od.OrderID =o.OrderID
where c.CustomerID='ALFKI'
group by ContactName

create function cliente_ventas(@IdCliente nchar(5))
Returns Table
AS
       Return (select ContactName as Cliente, sum (od.UnitPrice*od.Quantity) as Total
				from Customers c 
				inner join Orders  o  on o.CustomerID = c. CustomerID
				inner join  [Order Details] od on od.OrderID =o.OrderID
				where c.CustomerID=@IdCliente
				group by ContactName)

select * from dbo.cliente_ventas('ALFKI')




--Realizar una función que permita obtener el listado de productos por país procedencia, indicar 
--los datos principales de producto y proveedor.

select * from Products
select * from Suppliers

select p. ProductName, p.UnitsInStock, s.ContactName , S.CompanyName, s.Country  from Products p inner join 
Suppliers s on s.SupplierID =p.SupplierID
WHERE s.Country='Japan'


create function productos_pais(@Country nvarchar(15))
Returns Table
AS
       Return (select p. ProductName, p.UnitsInStock, s.ContactName , S.CompanyName, s.Country  from Products p inner join 
				Suppliers s on s.SupplierID =p.SupplierID
				WHERE s.Country=@Country)

select * from dbo.productos_pais('Japan')

DECLARE @Web varchar(100),          
	@diminutivo varchar(10)        
SET @diminutivo = 'UISRAEL'        
IF  @diminutivo = 'UISRAEL'        
BEGIN            
	PRINT 'www.uisrael.edu.ec'        
END    
ELSE      
BEGIN            
	PRINT 'Otra Web'        
END 

declare @operador char(1),
	@num1 int,
	@num2 int

set @operador='+'
set @num1=10
set @num2=5

if @operador='+'
begin
	select @num1+@num2
end
else if @operador='-'
begin
	select @num1-@num2
end
else
begin
	select 'operador no válido'
end


use Northwind
go
declare @tipo bit --1 empleado 0 cliente
set @tipo = 0
if @tipo=1
begin
	select FirstName+' '+LastName AS Empleado, COUNT(OrderID) as Fac_Vendidas 
	from Employees E inner join Orders O
	on E.EmployeeID = o.EmployeeID
	group by FirstName+' '+LastName
end
else
begin 
	select ContactName as Cliente, COUNT(OrderID) as Fac_Compradas
	from Customers C inner join Orders O
	on C.CustomerID = O.CustomerID
	group by ContactName
end


CREATE FUNCTION EnMayusculas
(
@Nombre Varchar(50),
@Apellido Varchar(50)
)
RETURNS Varchar(100)
AS
BEGIN
 RETURN (UPPER(@Nombre)+' '+UPPER(@Apellido))
END
--Ejecutar
Print dbo.EnMayusculas('henry','recalde')
select dbo.EnMayusculas('henry','recalde')
select dbo.EnMayusculas(LastName, FirstName), Country, BirthDate 
from Employees
go
create function Suma_Resta
(
	@operador char(1),
	@num1 int,
	@num2 int
)
returns int
AS
Begin
	declare @res int
	if @operador='+'
	begin
		set @res = @num1+@num2
	end
	else if @operador='-'
	begin
		set @res = @num1-@num2
	end
	else
	begin
		set @res = -999999
	end
	return @res
end

select dbo.Suma_Resta(',',5,6)

create function Prod_Ventas
(
	@tipo bit --1 Discontinuado 0 vigente
)
returns table
as
Return(
	select ProductName, SUM(OD.UnitPrice) as Ventas
	from Products O inner join [Order Details] OD
	on O.ProductID = OD.ProductID
	where Discontinued=@tipo
	group by ProductName
	)


alter function Prod_Tot_Ventas
(
	@tipo bit --1 Discontinuado 0 vigente
)
returns @ventas table
(
	Producto nvarchar(40), Total money
)
as
begin
	insert @ventas
	select ProductName, SUM(OD.UnitPrice) as Ventas
	from Products O inner join [Order Details] OD
	on O.ProductID = OD.ProductID
	where Discontinued=@tipo
	group by ProductName
	return
end

select * from dbo.Prod_Tot_Ventas(0)


