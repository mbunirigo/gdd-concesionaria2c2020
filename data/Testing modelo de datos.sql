--SELECT * INTO [NO_HAY_BACKUP].CIUDAD 

SELECT SUCURSAL_CIUDAD FROM gd_esquema.Maestra
GROUP BY SUCURSAL_CIUDAD

SELECT FAC_SUCURSAL_CIUDAD FROM gd_esquema.Maestra
GROUP BY FAC_SUCURSAL_CIUDAD


SELECT DISTINCT SUCURSAL_CIUDAD INTO [NO_HAY_BACKUP].CIUDAD
FROM gd_esquema.Maestra

INSERT INTO [NO_HAY_BACKUP].CIUDAD SELECT DISTINCT SUCURSAL_CIUDAD FROM gd_esquema.Maestra WHERE SUCURSAL_CIUDAD IS NOT NULL

SELECT * FROM [NO_HAY_BACKUP].CIUDAD

--TIPO_CAJA_CODIGO	TIPO_CAJA_DESC

SELECT DISTINCT  TIPO_CAJA_CODIGO, TIPO_CAJA_DESC FROM gd_esquema.Maestra

SELECT DISTINCT  TIPO_CAJA_CODIGO, TIPO_CAJA_DESC FROM gd_esquema.Maestra WHERE TIPO_CAJA_CODIGO IS NOT NULL

INSERT INTO [NO_HAY_BACKUP].TIPO_CAJA SELECT DISTINCT  TIPO_CAJA_CODIGO, TIPO_CAJA_DESC FROM gd_esquema.Maestra WHERE TIPO_CAJA_CODIGO IS NOT NULL

SELECT * FROM [NO_HAY_BACKUP].TIPO_CAJA
--


--TIPO_TRANSMISION_CODIGO	TIPO_TRANSMISION_DESC

SELECT DISTINCT  TIPO_TRANSMISION_CODIGO, TIPO_TRANSMISION_DESC FROM gd_esquema.Maestra WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL

INSERT INTO [NO_HAY_BACKUP].TIPO_TRANSMISION SELECT DISTINCT  TIPO_TRANSMISION_CODIGO, TIPO_TRANSMISION_DESC FROM gd_esquema.Maestra WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL

SELECT * FROM [NO_HAY_BACKUP].TIPO_TRANSMISION 



-- AUTO_PARTE_CODIGO	AUTO_PARTE_DESCRIPCION

SELECT DISTINCT AUTO_PARTE_CODIGO,	AUTO_PARTE_DESCRIPCION   FROM gd_esquema.Maestra WHERE AUTO_PARTE_CODIGO IS NOT NULL

INSERT INTO [NO_HAY_BACKUP].AUTO_PARTE SELECT DISTINCT AUTO_PARTE_CODIGO,	AUTO_PARTE_DESCRIPCION   FROM gd_esquema.Maestra WHERE AUTO_PARTE_CODIGO IS NOT NULL

SELECT COUNT(*) FROM [NO_HAY_BACKUP].AUTO_PARTE


---SUCURSAL_DIRECCION, SUCURSAL_MAIL,	SUCURSAL_TELEFONO , SUCURSAL_CIUDAD


--insert into 


select C.CIUDAD_CODIGO, m.SUCURSAL_DIRECCION, m.SUCURSAL_MAIL, m.SUCURSAL_TELEFONO
from   gd_esquema.Maestra m, [NO_HAY_BACKUP].CIUDAD c
where  m.SUCURSAL_CIUDAD = c.CIUDAD_DESCRIPCION aND    m.sucursal_ciudad IS NOT NULL
group by c.CIUDAD_CODIGO, SUCURSAL_DIRECCION, SUCURSAL_MAIL, sucursal_telefono

--SUCURSAL_DIRECCION, SUCURSAL_MAIL,	SUCURSAL_TELEFONO

SELECT DISTINCT SUCURSAL_DIRECCION FROM gd_esquema.Maestra



--
AUTO_PARTE_CODIGO	AUTO_PARTE_DESCRIPCION


INSERT INTO [NO_HAY_BACKUP].AUTO_PARTE 
SELECT DISTINCT AUTO_PARTE_CODIGO,	AUTO_PARTE_DESCRIPCION FROM gd_esquema.Maestra WHERE AUTO_PARTE_CODIGO IS NOT NULL

TIPO_AUTO_CODIGO	TIPO_AUTO_DESC

INSERT INTO [NO_HAY_BACKUP].TIPO_AUTO
SELECT DISTINCT TIPO_AUTO_CODIGO,	TIPO_AUTO_DESC FROM gd_esquema.Maestra WHERE TIPO_AUTO_CODIGO IS NOT NULL

--


--FAC_CLIENTE_APELLIDO	FAC_CLIENTE_NOMBRE	FAC_CLIENTE_DIRECCION	FAC_CLIENTE_DNI	FAC_CLIENTE_FECHA_NAC	FAC_CLIENTE_MAIL
--CLIENTE_APELLIDO	CLIENTE_NOMBRE	CLIENTE_DIRECCION	CLIENTE_DNI	CLIENTE_FECHA_NAC	CLIENTE_MAIL

SELECT DISTINCT CLIENTE_APELLIDO,	CLIENTE_NOMBRE,	CLIENTE_DIRECCION,	CLIENTE_DNI,	CLIENTE_FECHA_NAC,	CLIENTE_MAIL  FROM gd_esquema.Maestra

SELECT DISTINCT FAC_CLIENTE_APELLIDO,	FAC_CLIENTE_NOMBRE,	FAC_CLIENTE_DIRECCION,	FAC_CLIENTE_DNI,	FAC_CLIENTE_FECHA_NAC,	FAC_CLIENTE_MAIL  FROM gd_esquema.Maestra
WHERE NOT EXISTS (SELECT DISTINCT CLIENTE_DNI  FROM gd_esquema.Maestra)


---

AUTO_NRO_CHASIS	AUTO_NRO_MOTOR	AUTO_PATENTE	AUTO_FECHA_ALTA	AUTO_CANT_KMS

INSERT INTO [NO_HAY_BACKUP].AUTO
SELECT DISTINCT AUTO_NRO_MOTOR, AUTO_NRO_CHASIS, AUTO_PATENTE, AUTO_CANT_KMS, AUTO_FECHA_ALTA, TIPO_AUTO_CODIGO FROM gd_esquema.Maestra
WHERE AUTO_NRO_MOTOR IS NOT NULL AND AUTO_NRO_CHASIS IS NOT NULL AND TIPO_AUTO_CODIGO IS NOT NULL

SELECT * FROM NO_HAY_BACKUP.AUTO
--71946

--

-- MODELO_CODIGO	MODELO_NOMBRE	MODELO_POTENCIA	TIPO_TRANSMISION_CODIGO	TIPO_TRANSMISION_DESC	TIPO_CAJA_CODIGO

INSERT INTO [NO_HAY_BACKUP].AUTO_MODELO
SELECT DISTINCT MODELO_CODIGO,	MODELO_NOMBRE,	MODELO_POTENCIA, TIPO_CAJA_CODIGO, TIPO_TRANSMISION_CODIGO, TIPO_MOTOR_CODIGO FROM gd_esquema.Maestra
WHERE MODELO_POTENCIA IS NOT NULL AND TIPO_CAJA_CODIGO IS NOT NULL AND TIPO_TRANSMISION_CODIGO IS NOT NULL AND TIPO_MOTOR_CODIGO IS NOT NULL
--1008

SELECT * FROM NO_HAY_BACKUP.AUTO_MODELO


--

INSERT INTO [NO_HAY_BACKUP].TIPO_X_MODELO
SELECT DISTINCT TIPO_AUTO_CODIGO, MODELO_CODIGO FROM gd_esquema.Maestra	WHERE 	TIPO_AUTO_CODIGO IS NOT NULL AND MODELO_CODIGO IS NOT NULL
--1008

SELECT * FROM [NO_HAY_BACKUP].TIPO_X_MODELO

--
INSERT INTO [NO_HAY_BACKUP].AUTO_PARTE_X_FABRICANTE
SELECT DISTINCT M.AUTO_PARTE_CODIGO, F.FABRICANTE_CODIGO FROM gd_esquema.Maestra M, [NO_HAY_BACKUP].FABRICANTE F
WHERE F.FABRICANTE_NOMBRE = M.FABRICANTE_NOMBRE AND M.AUTO_PARTE_CODIGO IS NOT NULL 


SELECT * FROM NO_HAY_BACKUP.AUTO_PARTE_X_FABRICANTE

**PRECIO_FACTURADO , COMPRA_PRECIO

SELECT * FROM NO_HAY_BACKUP.AUTO
--71946
---------

PRECIO_FACTURADO	CANT_FACTURADA	FACTURA_FECHA	FACTURA_NRO

SELECT DISTINCT FACTURA_NRO, FACTURA_FECHA, PRECIO_FACTURADO, CANT_FACTURADA, S.SUCURSAL_CODIGO, C.CODIGO_CLIENTE, A.AUTO_CODIGO, 'Auto' 
FROM gd_esquema.Maestra M INNER JOIN [NO_HAY_BACKUP].SUCURSAL S
ON M.SUCURSAL_DIRECCION = S.SUCURSAL_DIRECCION AND M.SUCURSAL_MAIL = S.SUCURSAL_MAIL AND M.SUCURSAL_TELEFONO = S.SUCURSAL_TELEFONO
INNER JOIN [NO_HAY_BACKUP].CLIENTE C
ON  M.CLIENTE_DNI = C.CLIENTE_DNI AND M.CLIENTE_FECHA_NAC = C.CLIENTE_FECHA_NAC
INNER JOIN [NO_HAY_BACKUP].AUTO A
ON M.AUTO_NRO_MOTOR = A.AUTO_NRO_MOTOR AND M.AUTO_NRO_CHASIS = A.AUTO_NRO_CHASIS
WHERE FACTURA_FECHA IS NOT NULL

SELECT DISTINCT M.COMPRA_NRO, M.COMPRA_FECHA, M.COMPRA_PRECIO, M.COMPRA_CANT, S.SUCURSAL_CODIGO, C.CODIGO_CLIENTE, A.AUTO_CODIGO, 'Auto' 
FROM gd_esquema.Maestra M INNER JOIN [NO_HAY_BACKUP].SUCURSAL S
ON M.SUCURSAL_DIRECCION = S.SUCURSAL_DIRECCION AND M.SUCURSAL_MAIL = S.SUCURSAL_MAIL AND M.SUCURSAL_TELEFONO = S.SUCURSAL_TELEFONO
INNER JOIN [NO_HAY_BACKUP].CLIENTE C
ON  M.CLIENTE_DNI = C.CLIENTE_DNI AND M.CLIENTE_FECHA_NAC = C.CLIENTE_FECHA_NAC
INNER JOIN [NO_HAY_BACKUP].AUTO A
ON M.AUTO_NRO_MOTOR = A.AUTO_NRO_MOTOR AND M.AUTO_NRO_CHASIS = A.AUTO_NRO_CHASIS
WHERE M.COMPRA_NRO IS NOT NULL




SELECT DISTINCT CLIENTE_DNI, CLIENTE_FECHA_NAC FROM [NO_HAY_BACKUP].CLIENTE
--72504





SELECT DISTINCT AUTO_NRO_CHASIS, AUTO_NRO_MOTOR FROM NO_HAY_BACKUP.AUTO A,

--------------
SELECT DISTINCT FACTURA_NRO, FACTURA_FECHA, PRECIO_FACTURADO, CANT_FACTURADA, S.SUCURSAL_CODIGO, C.CODIGO_CLIENTE, M.AUTO_PARTE_CODIGO, 'Autoparte'
FROM gd_esquema.Maestra M INNER JOIN [NO_HAY_BACKUP].SUCURSAL S
ON M.SUCURSAL_DIRECCION = S.SUCURSAL_DIRECCION AND M.SUCURSAL_MAIL = S.SUCURSAL_MAIL AND M.SUCURSAL_TELEFONO = S.SUCURSAL_TELEFONO
INNER JOIN [NO_HAY_BACKUP].CLIENTE C
ON  M.CLIENTE_DNI = C.CLIENTE_DNI AND M.CLIENTE_FECHA_NAC = C.CLIENTE_FECHA_NAC
WHERE FACTURA_FECHA IS NOT NULL AND M.AUTO_PARTE_CODIGO IS NOT NULL

SELECT DISTINCT M.COMPRA_NRO, M.COMPRA_FECHA, M.COMPRA_PRECIO, M.COMPRA_CANT, S.SUCURSAL_CODIGO, C.CODIGO_CLIENTE, M.AUTO_PARTE_CODIGO, 'Autoparte'
FROM gd_esquema.Maestra M INNER JOIN [NO_HAY_BACKUP].SUCURSAL S
ON M.SUCURSAL_DIRECCION = S.SUCURSAL_DIRECCION AND M.SUCURSAL_MAIL = S.SUCURSAL_MAIL AND M.SUCURSAL_TELEFONO = S.SUCURSAL_TELEFONO
INNER JOIN [NO_HAY_BACKUP].CLIENTE C
ON  M.CLIENTE_DNI = C.CLIENTE_DNI AND M.CLIENTE_FECHA_NAC = C.CLIENTE_FECHA_NAC
WHERE FACTURA_FECHA IS NOT NULL AND M.AUTO_PARTE_CODIGO IS NOT NULL


----

INSERT INTO [NO_HAY_BACKUP].PRODUCTO_OPERACION
SELECT COMPRA_PRODUCTO_COD, COMPRA_PRODUCTO_TIPO, 'Compra' FROM [NO_HAY_BACKUP].COMPRA