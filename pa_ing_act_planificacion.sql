CREATE OR REPLACE PROCEDURE pa_ing_act_planificacion
(
	i_id			integer,
	i_nombrePlan	varchar(200),
	i_usuario		varchar(30),
	i_anio			int
)
language plpgsql
as $$

----DECLARACION DE VARIABLES LOCALES------
declare w_existe  integer;
BEGIN
	
	----PROCEDO A VALIDAR EL RESULTADO------
	----SI EXISTE EL CODIGO DE PLANIFICAICON ACTUALIZO CASO CONTRARIO INSERTO-----
	select
		coalesce(nullif(count(*),0),0)
	INTO w_existe
	from public.planificacionestudio
	where id=i_id;
	
	---CUANDO EXISTE SEA IGUAL A CERO ES UNA INSERCION-----
	IF(w_existe=0) then
		INSERT INTO public.planificacionestudio(nombre, usuario, anio)
		values(i_nombrePlan,i_usuario,i_anio);
		
	ELSE
	
		update public.planificacionestudio
			set nombre=i_nombrePlan,
				usuario=i_usuario,
				anio=i_anio,
				fecharegistro=(select now())
		--from public.planificacionestudio
		where id=i_id;
	
	END IF;


END; $$;

--SELECT *FROM public.planificacionestudio
explain CALL pa_ing_act_planificacion (2,'PLANIFICACION SERCOP','sercop', 2022)
