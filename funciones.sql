---select fn_consulta_usuarios(0)
--EXPLAIN
-----FUNCION DE CONSULTA DE USUARIOS (RETURNS QUERY)------
drop function fn_consulta_usuarios(i_secuencial int);
create or replace function fn_consulta_usuarios(i_secuencial int)
returns table 
(
	
	usuarios		varchar(20),
	nombre			varchar(200),
	apellido		varchar(200),
	email			varchar(200)
	--last_login		timestamp,
	--NombreCompleto	varying
	

)
as $$
BEGIN
	RETURN QUERY
	select 
		p.usuarios,
		p.nombre,
		p.apellido,
		u.email
		--u.last_login,
		--concat(p.nombre,'  ',p.apellido) as NombreCompleto
	from public."Universidad_persona" as p 
	inner join public.auth_user as u
		on p.usuarios=u.username
	where p.Id>i_secuencial;

END;
$$ LANGUAGE PLPGSQL;

----CREACION DE LA VISTA----
drop view if exists Persona;
create or replace view Persona
as
	select  p.usuarios, p.nombre, p.apellido, u.email from public."Universidad_persona" as p  inner join public.auth_user as u on p.usuarios=u.username where p.Id>0;


-----FUNCION DE TIPO TABLA------
drop function fn_cons_usuarios_table;
create or replace function fn_cons_usuarios_table
(
	i_secuencial int
)
returns table 
(
	
	usuarios		varchar(20),
	nombre			varchar(200),
	apellido		varchar(200),
	email			varchar(200)
	--last_login		timestamp,
	--NombreCompleto	varying
	

)
as $$
declare w_tbl_usuario record;
BEGIN
	for w_tbl_usuario in 
	(
		select 
			p.usuarios,
			p.nombre,
			p.apellido,
			u.email
			--u.last_login,
			--concat(p.nombre,'  ',p.apellido) as NombreCompleto
		from public."Universidad_persona" as p 
		inner join public.auth_user as u
			on p.usuarios=u.username
		where p.Id>i_secuencial
	
	)
	----ASIGNANDO LOS VALORES A LAS VARIABLES DE LA VARIABLE TIPO TABLA----
	loop usuarios:=w_tbl_usuario.usuarios;
		 nombre=w_tbl_usuario.nombre;
		 apellido=w_tbl_usuario.apellido;
		 email=w_tbl_usuario.email;
	return next;
	end loop;


END;
$$ LANGUAGE PLPGSQL

--"ProjectSet  (cost=0.00..5.27 rows=1000 width=32)"
--"  ->  Result  (cost=0.00..0.01 rows=1 width=0)"
--explain select fn_consulta_usuarios(0)

---select fn_cons_usuarios_table(0)
--explain select fn_cons_usuarios_table(0)

--explain select *from Persona

/*explain
select 
			(select username from public.auth_user as a where a.username=p.usuarios) as Usuario,
			p.nombre,
			p.apellido,
			u.email
			--u.last_login,
			--concat(p.nombre,'  ',p.apellido) as NombreCompleto
		from public."Universidad_persona" as p 
		inner join public.auth_user as u
			on p.usuarios=u.username
		--where p.Id>i_secuencial
*/