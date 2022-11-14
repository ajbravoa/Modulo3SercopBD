CREATE OR REPLACE FUNCTION fn_cons_planificacion(i_idPlanificacion integer)
RETURNS TABLE
(
	Id 				integer,
	Nombre 			varchar(200),
	Usuario			varchar(30),
	Anio			Integer,
	FechaRegistro	date
)
LANGUAGE plpgsql
as $$
BEGIN
	RETURN QUERY
	SELECT
		a.Id,
		a.Nombre,
		a.Usuario,
		a.anio,
		a.FechaRegistro
	
	FROM public.planificacionestudio as a
	where i_idPlanificacion=0 or a.Id=i_idPlanificacion;
END;
$$;

INSERT INTO  public.planificacionestudio(nombre, usuario, anio)
values('API','angelito',2022)

select id,nombre,usuario,anio,fecharegistro from fn_cons_planificacion(0) where id>0


