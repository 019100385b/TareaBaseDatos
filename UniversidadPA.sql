-- Procedimiento almacenados
-- Condori Contreras, Mike Marco
-- 10/08/22

--PA para Escuelas

use BDUniversidad
go
if OBJECT_ID('spListarEscuela') is not null
	drop proc splistarEscuela
go
create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go


if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go
create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as begin
	--CodEscuela  no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
	--Escuela no puede ser duplicado
		if not exists (select Escuela from TEscuela where Escuela=@Escuela)
		begin
			insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
			select CodError = 0, Mensaje = 'Se inserto correctamente escuela'
		end
		else select CodError = 1, Mensaje = 'Error: Escuela duplicada'
	else select CodError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go

exec spAgregarEscuela @CodEscuela = 'E06', @Escuela = 'Derechoo', @Facultad = 'CEACC';
go


-- Actividad Implementar Eliminar, Actualizar y Buscar
-- Presentado para el dia miecoles 10 de agosto a traves de Aula Virtual
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create proc spEliminarEscuela
@CodEscuela char(3)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			delete from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se elimino correctamente escuela'
		end
	else select CodError = 1, Mensaje = 'Error: CodEscuela no existe'
end
go

exec spEliminarEscuela @CodEscuela = 'E06';
go

select * from TEscuela

-- Actualizar 
if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go
create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			update TEscuela set Escuela = @Escuela, Facultad = @Facultad where CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Se actualizo correctamente escuela'
		end
	else select CodError = 1, Mensaje = 'Error: CodEscuela no existe'
end
go

exec spActualizarEscuela @CodEscuela = 'E06', @Escuela = 'Derecho', @Facultad = 'CEAC';
go

select * from TEscuela

-- Buscar
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create proc spBuscarEscuela
@CodEscuela char(3)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			select CodEscuela from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se encontro correctamente escuela'
		end
	else select CodError = 1, Mensaje = 'Error: CodEscuela no existe'
end
go

exec spBuscarEscuela @CodEscuela = 'E06';
go