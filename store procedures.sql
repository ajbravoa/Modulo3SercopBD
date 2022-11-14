drop table if exists PlanificacionEstudio;
create table PlanificacionEstudio
(
	Id 				serial,
	Nombre			varchar(100),
	Usuario			varchar(20),
	Anio			int,
	FechaRegistro	date default current_date
);

DROP PROCEDURE IF EXISTS pa_ingreso_planificacion;
CREATE OR REPLACE PROCEDURE pa_ingreso_planificacion
(
	i_nombre		varchar(100),
	i_usuario		varchar(20),
	i_anio			int
)
language plpgsql
as $$
BEGIN
	INSERT INTO PlanificacionEstudio(Nombre,Usuario,Anio)
	VALUES(i_nombre,i_usuario,i_anio);

END;
$$

call pa_ingreso_planificacion('Prueba','angelito',2022 )

select *from PlanificacionEstudio



