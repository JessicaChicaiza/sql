--UNIVERSIDAD TECNOLOGICA ISRAEL
--Jessica Chicaiza
--Septimo "D"
--fecha:27-02-2019

create database JessicaChicaizaT15
use JessicaChicaizaT15
go 

create table Jugador(
IdJugador int identity(1,1) not null,
IdEquipo varchar(10),
NomJugador varchar(50),
FecNacJugador datetime,
CedJugador varchar(10),
CiuJugador varchar(50),
EstJugador bit,
EmaJugador varchar(50),

)

create table Equipo(
IdEquipo varchar(10) not null,
NomEquipo varchar(50) not null,
FecCreaEquipo date,
EstEquipo bit,
EmaEquipo varchar(50)

)

 --clave primaria 
 alter table dbo.equipo
 add
 constraint pk_equipo primary key nonclustered (IdEquipo)

  --clave primaria  y foranea 
 alter table dbo.Jugador
 add
 Edad tinyint,
 constraint pk_jugador primary key nonclustered(IdJugador),
 constraint fk_jugador_equipo foreign key(IdEquipo) 
 references dbo.equipo(IdEquipo)

 --Realizar una funcion o procedimento que calcule la edad del jugador de acuerdo a las siguientes condiciones:
 --calcular la edad en base a la fecha de nacimiento y la fecha de hoy.
 --si la fecha es mayor a la de hor debera calculara como 0.

 
create function CalcularEdad
(
	@FechaNac date
)
returns tinyint
as
begin
	declare @edad tinyint

	if YEAR(@FechaNac) > YEAR(GETDATE())
	begin
		set @edad=0
	end 
	else 
	begin
	 set @edad=YEAR(getdate())-YEAR(@FechaNac)
	end
	
	return @edad
end

select dbo.CalcularEdad('16/08/1995')


--Crear procedimientos para insertar, actualizar y borrar.


create procedure sp_InsertarJugador
(@IdEquipo varchar(10),
@NomJugador varchar(50),
@FecNacJugador datetime,
@CedJugador varchar(10),
@CiuJugador varchar(50),
@EstJugador bit,
@EmaJugador varchar(50)
)
as
begin
begin try
declare @edad tinyint
select @edad=dbo.CalcularEdad(@FecNacJugador)
insert into jugador(IdEquipo,NomJugador,FecNacJugador,CedJugador,CiuJugador,EstJugador,EmaJugador,Edad)
values(@IdEquipo,@NomJugador,@FecNacJugador,@CedJugador,@CiuJugador,@EstJugador,@EmaJugador,@edad)
end try
begin catch
---error
end catch

end


create procedure sp_ActualizarJugador
(
@IdJugador int ,
@IdEquipo varchar(10),
@NomJugador varchar(50),
@FecNacJugador datetime,
@CedJugador varchar(10),
@CiuJugador varchar(50),
@EstJugador bit,
@EmaJugador varchar(50))
as
begin
begin try
declare @edad tinyint
select @edad=dbo.CalcularEdad(@FecNacJugador)

update jugador
set IdEquipo=@IdEquipo, NomJugador=@NomJugador, FecNacJugador=@FecNacJugador, CedJugador=@CedJugador,
CiuJugador=@CiuJugador, EstJugador=@EstJugador, EmaJugador=@EmaJugador,  Edad=@edad
where IdJugador=@IdJugador
end try
begin catch
---error
end catch

end


create procedure sp_EliminarJugador 
(@IdJugador int)
as
begin
begin try

delete jugador
where IdJugador=@IdJugador

end try
begin catch
---error
end catch

end


--Realizar auditoria para la tabla de jugador para la inserción, borrado y actualización.

 CREATE TABLE log_jugador (
	IdJugador int ,
	IdEquipo varchar(10),
	NomJugador varchar(50),
	FecNacJugador datetime,
	CedJugador varchar(10),
	CiuJugador varchar(50),
	EstJugador bit,
	EmaJugador varchar(50),
	usr_fch_cmb datetime NULL,
	usr_cmb varchar(80) NULL,
	usr_hos varchar(80) NULL,
	usr_tpo char(1) NULL
	
 );


 --insertar
 IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[tr_jugador_insert]'))
	DROP TRIGGER [tr_jugador_insert]
GO
create TRIGGER tr_jugador_insert
ON jugador
AFTER INSERT
AS 
BEGIN
-- SET NOCOUNT ON impide que se generen mensajes de texto 
-- con cada instrucción 
	SET NOCOUNT ON;
	INSERT INTO log_jugador(IdJugador, IdEquipo, NomJugador,FecNacJugador,CedJugador,CiuJugador,EstJugador,EmaJugador, usr_fch_cmb,usr_cmb, usr_hos, usr_tpo)
	SELECT IdJugador, IdEquipo, NomJugador,FecNacJugador,CedJugador,CiuJugador,EstJugador,EmaJugador,GETDATE(), SUSER_NAME(), HOST_NAME(),'I' FROM inserted
END
GO

--delete


IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[tr_jugador_delete]'))
	DROP TRIGGER [tr_jugador_delete]
GO
CREATE TRIGGER tr_jugador_delete
ON jugador
AFTER DELETE
AS 
BEGIN
-- SET NOCOUNT ON impide que se generen mensajes de texto 
-- con cada instrucción 
	SET NOCOUNT ON;
		INSERT INTO log_jugador(IdJugador, IdEquipo, NomJugador,FecNacJugador,CedJugador,CiuJugador,EstJugador,EmaJugador, usr_fch_cmb,usr_cmb, usr_hos, usr_tpo)
	SELECT IdJugador, IdEquipo, NomJugador,FecNacJugador,CedJugador,CiuJugador,EstJugador,EmaJugador,GETDATE(), SUSER_NAME(), HOST_NAME(),'D' FROM deleted
END
GO


--update
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[tr_jugador_update]'))
	DROP TRIGGER [tr_jugador_update]
GO
CREATE TRIGGER tr_jugador_update
ON jugador
AFTER UPDATE
AS 
BEGIN
-- SET NOCOUNT ON impide que se generen mensajes de texto 
-- con cada instrucción 
	SET NOCOUNT ON;
			INSERT INTO log_jugador(IdJugador, IdEquipo, NomJugador,FecNacJugador,CedJugador,CiuJugador,EstJugador,EmaJugador, usr_fch_cmb,usr_cmb, usr_hos, usr_tpo)
	SELECT IdJugador, IdEquipo, NomJugador,FecNacJugador,CedJugador,CiuJugador,EstJugador,EmaJugador,GETDATE(), SUSER_NAME(), HOST_NAME(),'U' FROM deleted

END
GO

SELECT * FROM dbo.Jugador


insert into equipo values('EQ1','LIGA','23-12-1978',0,'liga@gmail.com')


exec sp_InsertarJugador'EQ1','Luis Torres','16-08-1995','1721290508','Quito',1,'juan@gmail.com'
exec sp_ActualizarJugador'EQ1','Carlos Lopez','16-08-1996','1721290516','Quito',1,'carlosn@gmail.com'
exec sp_EliminarJugador 5


select * from log_jugador
select* from jugador 