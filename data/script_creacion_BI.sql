USE [GD2C2020]
GO

CREATE TABLE [NO_HAY_BACKUP].[DIM_AUTO_PARTE] (
  [AUTO_PARTE_CODIGO] decimal(18,0),
  [AUTO_PARTE_DESCRIPCION] nvarchar(255),
  PRIMARY KEY ([AUTO_PARTE_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_TIPO_TRANSMISION] (
  [TIPO_TRANSMISION_CODIGO] decimal(18,0),
  [TIPO_TRANSMISION_DESC] nvarchar(255),
  PRIMARY KEY ([TIPO_TRANSMISION_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_CLIENTE] (
  [CODIGO_CLIENTE] decimal(18,0),
  [CLIENTE_NOMBRE] nvarchar(255) NOT NULL,
  [CLIENTE_APELLIDO] nvarchar(255) NOT NULL,
  [CLIENTE_DNI] decimal(18,0) NOT NULL,
  [CLIENTE_EDAD] nvarchar(255) NOT NULL,
  [CLIENTE_MAIL] nvarchar(255) NOT NULL,
  [CLIENTE_DIRECCION] nvarchar(255),
  [CLIENTE_SEXO] nvarchar(255),
  PRIMARY KEY ([CODIGO_CLIENTE]),
  CONSTRAINT ck_cliente_edad CHECK ([CLIENTE_EDAD] IN ('18-30anios','31-50anios', '>50anios'))
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_SUCURSAL] (
  [SUCURSAL_CODIGO] decimal(18,0),
  [SUCURSAL_DIRECCION] nvarchar(255) NOT NULL,
  [SUCURSAL_MAIL] nvarchar(255) NOT NULL,
  [SUCURSAL_TELEFONO] decimal(18,0) NOT NULL,
  PRIMARY KEY ([SUCURSAL_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_AUTO_MODELO] (
  [MODELO_CODIGO] decimal(18,0),
  [MODELO_NOMBRE] nvarchar(255),
  PRIMARY KEY ([MODELO_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_FABRICANTE] (
  [FABRICANTE_CODIGO] decimal(18,0),
  [FABRICANTE_NOMBRE] nvarchar(255),
  PRIMARY KEY ([FABRICANTE_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_TIPO_CAJA] (
  [TIPO_CAJA_CODIGO] decimal(18,0),
  [TIPO_CAJA_DESC] nvarchar(255),
  PRIMARY KEY ([TIPO_CAJA_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_CIUDAD] (
  [CIUDAD_CODIGO] decimal(18,0),
  [CIUDAD_DESCRIPCION] nvarchar(255) NOT NULL,
  PRIMARY KEY ([CIUDAD_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_TIPO_AUTO] (
  [TIPO_AUTO_CODIGO] decimal(18,0),
  [TIPO_AUTO_DESC] nvarchar(255),
  PRIMARY KEY ([TIPO_AUTO_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_POTENCIA] (
  [POTENCIA_CODIGO] decimal(18,0),
  [POTENCIA_RANGO] nvarchar(255)  NOT NULL,
  PRIMARY KEY ([POTENCIA_CODIGO]),
  CONSTRAINT ck_potencia_rango CHECK ([POTENCIA_RANGO] IN ('50-150cv','151-300cv', '>300cv'))
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_TIEMPO] (
  [TIEMPO_CODIGO] decimal(18,0) IDENTITY (1,1),
  [TIEMPO_MES] decimal(18,0),
  [TIEMPO_ANIO] decimal(18,0),
  PRIMARY KEY ([TIEMPO_CODIGO]),
  CONSTRAINT ck_tiempo_mes CHECK ([TIEMPO_MES] BETWEEN 1 AND 12)
);

CREATE TABLE [NO_HAY_BACKUP].[DIM_TIPO_MOTOR] (
  [TIPO_MOTOR_CODIGO] decimal(18,0),
  PRIMARY KEY ([TIPO_MOTOR_CODIGO])
);

CREATE TABLE [NO_HAY_BACKUP].[HECHOS] (
  [PRODUCTO_TIPO] nvarchar(255) NOT NULL,
  [PRODUCTO_TIPO_TRANSACT] nvarchar(255) NOT NULL,
  [NRO_DOCUMENTO] decimal(18,0) NOT NULL,
  [PRECIO] decimal(18,2) NOT NULL,
  [CANTIDAD] decimal(18,0),
  [CIUDAD_CODIGO] decimal(18,0) REFERENCES [NO_HAY_BACKUP].DIM_CIUDAD,
  [SUCURSAL_CODIGO] decimal(18,0) REFERENCES [NO_HAY_BACKUP].DIM_SUCURSAL,
  [CODIGO_CLIENTE] decimal(18,0) REFERENCES [NO_HAY_BACKUP].DIM_CLIENTE,
  [TIPO_MOTOR_CODIGO] decimal(18,0) REFERENCES [NO_HAY_BACKUP].DIM_TIPO_MOTOR,
  [TIPO_CAJA_CODIGO] decimal(18,0) REFERENCES [NO_HAY_BACKUP].DIM_TIPO_CAJA,
  [TIPO_TRANSMISION_CODIGO] decimal(18,0) REFERENCES [NO_HAY_BACKUP].DIM_TIPO_TRANSMISION,
  [TIPO_AUTO_CODIGO] decimal(18,0) REFERENCES [NO_HAY_BACKUP].DIM_TIPO_AUTO,
  [POTENCIA_CODIGO] decimal(18,0) REFERENCES [NO_HAY_BACKUP].DIM_POTENCIA,
  [MODELO_CODIGO] decimal(18,0) REFERENCES  [NO_HAY_BACKUP].DIM_AUTO_MODELO,
  [FABRICANTE_CODIGO] decimal(18,0) REFERENCES  [NO_HAY_BACKUP].DIM_FABRICANTE,
  [PRODUCTO_CODIGO] decimal(18,0),
  [TIEMPO_CODIGO] decimal(18,0) REFERENCES  [NO_HAY_BACKUP].DIM_TIEMPO
);
GO

/* ***** DEFINICION FUNCIONES ***** */

CREATE FUNCTION [NO_HAY_BACKUP].fx_rango_edad(@fecha DATETIME2(3))
RETURNS NVARCHAR(255) AS
BEGIN

	DECLARE @EDAD decimal(18,0) = year(getdate()) - year(@fecha)
	DECLARE @RETORNO NVARCHAR(255) = ' '
	
	SET @RETORNO = CASE
	WHEN (@EDAD >= 18 and @EDAD <= 30) THEN '18-30anios'
	WHEN @EDAD >= 31 and @EDAD <= 50 THEN '31-50anios'
	ELSE '>50anios'
	END

	RETURN @RETORNO

END
GO

CREATE FUNCTION [NO_HAY_BACKUP].fx_codigo_tiempo(@fecha DATETIME2(3))
RETURNS decimal(18,0) AS
BEGIN

	DECLARE @RETORNO decimal(18,0) = 0
	
	SET @RETORNO =	(SELECT TIEMPO_CODIGO from [NO_HAY_BACKUP].DIM_TIEMPO 
					WHERE TIEMPO_MES = MONTH(@fecha) AND TIEMPO_ANIO = YEAR(@fecha))

	RETURN @RETORNO

END
GO

CREATE FUNCTION [NO_HAY_BACKUP].fx_codigo_potencia(@potencia decimal(18,0))
RETURNS decimal(18,0) AS
BEGIN

	DECLARE @RETORNO decimal(18,0) = 0
	
	SET @RETORNO = CASE
	WHEN (@potencia >= 50 and @potencia <= 150) THEN 1
	WHEN @potencia >= 151 and @potencia <= 300 THEN 2
	ELSE 3
	END

	RETURN @RETORNO

END
GO

CREATE FUNCTION [NO_HAY_BACKUP].fx_obtener_tiempo_en_stock(@fechaInicialCod decimal(18,0), @fechaFinalCod decimal(18,0))
RETURNS decimal(18,0) AS
BEGIN
	DECLARE @MES_INICIAL decimal(18,0) = (SELECT TIEMPO_MES FROM NO_HAY_BACKUP.DIM_TIEMPO WHERE TIEMPO_CODIGO = @fechaInicialCod)
	DECLARE @ANIO_INICIAL decimal(18,0) = (SELECT TIEMPO_ANIO FROM NO_HAY_BACKUP.DIM_TIEMPO WHERE TIEMPO_CODIGO = @fechaInicialCod)
	
	DECLARE @ANIO_FINAL decimal(18,0) = IIF (@FechaFinalCOd = 0, YEAR(GETDATE()), (SELECT TIEMPO_ANIO FROM NO_HAY_BACKUP.DIM_TIEMPO WHERE TIEMPO_CODIGO = @fechaFinalCod))
	DECLARE @MES_FINAL decimal(18,0) = IIF(@FechaFinalCOd = 0, MONTH(GETDATE()), (SELECT TIEMPO_MES FROM NO_HAY_BACKUP.DIM_TIEMPO WHERE TIEMPO_CODIGO = @fechaFinalCod))
	
	DECLARE @RETORNO decimal(18,0) = 0

	SET @RETORNO = (@ANIO_FINAL - @ANIO_INICIAL) * 12 + (@MES_FINAL - @MES_INICIAL)

	RETURN @RETORNO

END 
GO

/* ***** DEFINICION STORED PROCEDURES ***** */

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_AUTO_PARTE
AS
BEGIN TRANSACTION

/* AUTO PARTE */
INSERT INTO [NO_HAY_BACKUP].DIM_AUTO_PARTE SELECT * FROM [NO_HAY_BACKUP].AUTO_PARTE


COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_TRANSMISION
AS
BEGIN TRANSACTION

/* TIPO TRANSMISION */

INSERT INTO [NO_HAY_BACKUP].[DIM_TIPO_TRANSMISION] SELECT * FROM [NO_HAY_BACKUP].[TIPO_TRANSMISION] 

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_CAJA
AS
BEGIN TRANSACTION

/* TIPO CAJA */

INSERT INTO [NO_HAY_BACKUP].[DIM_TIPO_CAJA] SELECT * FROM [NO_HAY_BACKUP].[TIPO_CAJA] 

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_AUTO
AS
BEGIN TRANSACTION

/* TIPO AUTO */

INSERT INTO [NO_HAY_BACKUP].[DIM_TIPO_AUTO] SELECT * FROM [NO_HAY_BACKUP].[TIPO_AUTO] 

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_CIUDAD
AS
BEGIN TRANSACTION

/* CIUDAD */

INSERT INTO [NO_HAY_BACKUP].[DIM_CIUDAD] SELECT * FROM [NO_HAY_BACKUP].CIUDAD 

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_FABRICANTE
AS
BEGIN TRANSACTION

/* FABRICANTE */

INSERT INTO [NO_HAY_BACKUP].[DIM_FABRICANTE] SELECT * FROM [NO_HAY_BACKUP].FABRICANTE 

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_MOTOR
AS
BEGIN TRANSACTION

/* TIPO MOTOR */

INSERT INTO [NO_HAY_BACKUP].[DIM_TIPO_MOTOR] SELECT DISTINCT MODELO_TIPO_MOTOR_CODIGO FROM [NO_HAY_BACKUP].AUTO_MODELO 

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_AUTO_MODELO
AS
BEGIN TRANSACTION

/* AUTO MODELO */

INSERT INTO [NO_HAY_BACKUP].[DIM_AUTO_MODELO] SELECT DISTINCT MODELO_CODIGO, MODELO_NOMBRE FROM [NO_HAY_BACKUP].AUTO_MODELO 

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_POTENCIA
AS
BEGIN TRANSACTION

/* POTENCIA */

INSERT INTO [NO_HAY_BACKUP].[DIM_POTENCIA] VALUES (1, '50-150cv'), (2,'151-300cv'), (3,'>300cv') 

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_SUCURSAL
AS
BEGIN TRANSACTION

/* SUCURSAL */

INSERT INTO [NO_HAY_BACKUP].[DIM_SUCURSAL] SELECT SUCURSAL_CODIGO, SUCURSAL_DIRECCION, SUCURSAL_MAIL, SUCURSAL_TELEFONO FROM [NO_HAY_BACKUP].SUCURSAL

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIEMPO
AS
BEGIN TRANSACTION

/* TIEMPO */

INSERT INTO [NO_HAY_BACKUP].[DIM_TIEMPO] VALUES (1,2018),(2,2018),(3,2018),(4,2018),(5,2018),(6,2018),(7,2018),(8,2018),(9,2018),(10,2018),(11,2018),(12,2018),
(1,2019),(2,2019),(3,2019),(4,2019),(5,2019),(6,2019),(7,2019),(8,2019),(9,2019),(10,2019),(11,2019),(12,2019),
(1,2020),(2,2020),(3,2020),(4,2020),(5,2020),(6,2020),(7,2020),(8,2020),(9,2020),(10,2020),(11,2020),(12,2020)

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_CLIENTE
AS
BEGIN TRANSACTION

/* CLIENTE */

INSERT INTO [NO_HAY_BACKUP].[DIM_CLIENTE] SELECT CODIGO_CLIENTE, CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DNI, 
[NO_HAY_BACKUP].fx_rango_edad(CLIENTE_FECHA_NAC) ,CLIENTE_MAIL, CLIENTE_DIRECCION, NULL FROM [NO_HAY_BACKUP].CLIENTE

COMMIT;
GO

CREATE PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_HECHOS
AS
BEGIN TRANSACTION

/* HECHOS */

BEGIN TRANSACTION
INSERT INTO [NO_HAY_BACKUP].HECHOS
SELECT COMPRA_PRODUCTO_TIPO, 'Compra', COMPRA_NRO, COMPRA_PRECIO, COMPRA_CANT, SUCURSAL_CIUDAD_COD, SUCURSAL_CODIGO, CODIGO_CLIENTE, 
M.MODELO_TIPO_MOTOR_CODIGO, M.MODELO_CAJA_COD, M.MODELO_TRANSMISION_COD, AUTO_TIPO_COD, NO_HAY_BACKUP.fx_codigo_potencia(M.MODELO_POTENCIA),
M.MODELO_CODIGO, null, COMPRA_PRODUCTO_COD, NO_HAY_BACKUP.fx_codigo_tiempo(COMPRA_FECHA) AS FECHA
FROM NO_HAY_BACKUP.COMPRA
JOIN NO_HAY_BACKUP.SUCURSAL 
ON COMPRA_SUCURSAL_COD = SUCURSAL_CODIGO
JOIN NO_HAY_BACKUP.CLIENTE
ON COMPRA_CLIENTE_COD = CODIGO_CLIENTE
JOIN NO_HAY_BACKUP.AUTO
ON COMPRA_PRODUCTO_COD = AUTO_CODIGO
JOIN NO_HAY_BACKUP.AUTO_MODELO M
ON AUTO_MODELO_CODIGO = M.MODELO_CODIGO
WHERE COMPRA_PRODUCTO_TIPO = 'Auto'
COMMIT;

BEGIN TRANSACTION

INSERT INTO [NO_HAY_BACKUP].HECHOS
SELECT TIPO_PRODUCTO, 'Venta', FACTURA_NRO, FACTURA_PRECIO, FACTURA_CANT, SUCURSAL_CIUDAD_COD, SUCURSAL_CODIGO, CODIGO_CLIENTE, 
M.MODELO_TIPO_MOTOR_CODIGO, M.MODELO_CAJA_COD, M.MODELO_TRANSMISION_COD, AUTO_TIPO_COD, NO_HAY_BACKUP.fx_codigo_potencia(M.MODELO_POTENCIA),
M.MODELO_CODIGO, null, FACT_PRODUCTO_COD, NO_HAY_BACKUP.fx_codigo_tiempo(FACTURA_FECHA) AS FECHA
FROM NO_HAY_BACKUP.FACTURA
JOIN NO_HAY_BACKUP.SUCURSAL 
ON FACT_SUCURSAL_COD = SUCURSAL_CODIGO
JOIN NO_HAY_BACKUP.CLIENTE
ON FACT_CLIENTE_COD = CODIGO_CLIENTE
JOIN NO_HAY_BACKUP.AUTO
ON FACT_PRODUCTO_COD = AUTO_CODIGO
JOIN NO_HAY_BACKUP.AUTO_MODELO M
ON AUTO_MODELO_CODIGO = M.MODELO_CODIGO
WHERE TIPO_PRODUCTO = 'Auto'
COMMIT;

/* AUTO PARTE */

BEGIN TRANSACTION

INSERT INTO [NO_HAY_BACKUP].HECHOS
SELECT COMPRA_PRODUCTO_TIPO, 'Compra', COMPRA_NRO, COMPRA_PRECIO, COMPRA_CANT, SUCURSAL_CIUDAD_COD, SUCURSAL_CODIGO, CODIGO_CLIENTE, 
NULL, NULL, NULL, NULL, NULL, NULL, AUTO_PARTE_FABRICANTE_COD, AUTO_PARTE_CODIGO, NO_HAY_BACKUP.fx_codigo_tiempo(COMPRA_FECHA) AS FECHA
FROM NO_HAY_BACKUP.COMPRA
JOIN NO_HAY_BACKUP.SUCURSAL 
ON COMPRA_SUCURSAL_COD = SUCURSAL_CODIGO
JOIN NO_HAY_BACKUP.CLIENTE
ON COMPRA_CLIENTE_COD = CODIGO_CLIENTE
JOIN NO_HAY_BACKUP.AUTO_PARTE
ON AUTO_PARTE_CODIGO = COMPRA_PRODUCTO_COD
JOIN NO_HAY_BACKUP.AUTO_PARTE_X_FABRICANTE
ON AUTO_PARTE_CODIGO = AUTO_PARTE_FABRICANTE_COD
WHERE COMPRA_PRODUCTO_TIPO = 'Autoparte'
COMMIT;

BEGIN TRANSACTION
INSERT INTO [NO_HAY_BACKUP].HECHOS
SELECT TIPO_PRODUCTO, 'Venta', FACTURA_NRO, FACTURA_PRECIO, FACTURA_CANT, SUCURSAL_CIUDAD_COD, SUCURSAL_CODIGO, CODIGO_CLIENTE, 
NULL, NULL, NULL, NULL, NULL, NULL, AUTO_PARTE_FABRICANTE_COD, AUTO_PARTE_CODIGO, NO_HAY_BACKUP.fx_codigo_tiempo(FACTURA_FECHA) AS FECHA
FROM NO_HAY_BACKUP.FACTURA
JOIN NO_HAY_BACKUP.SUCURSAL 
ON FACT_SUCURSAL_COD = SUCURSAL_CODIGO
JOIN NO_HAY_BACKUP.CLIENTE
ON FACT_CLIENTE_COD = CODIGO_CLIENTE
JOIN NO_HAY_BACKUP.AUTO_PARTE
ON AUTO_PARTE_CODIGO = FACT_PRODUCTO_COD
JOIN NO_HAY_BACKUP.AUTO_PARTE_X_FABRICANTE
ON AUTO_PARTE_CODIGO = AUTO_PARTE_FABRICANTE_COD
WHERE TIPO_PRODUCTO = 'Autoparte'
COMMIT;

COMMIT;
GO

/* ***** EJECUCION DE LA MIGRACION ***** */

EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_AUTO_PARTE
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_TRANSMISION
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_CAJA
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_AUTO
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_CIUDAD
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_FABRICANTE
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_MOTOR
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_AUTO_MODELO
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_POTENCIA
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_SUCURSAL
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_TIEMPO
EXEC [NO_HAY_BACKUP].PRC_INSERT_DIM_CLIENTE
EXEC [NO_HAY_BACKUP].PRC_INSERT_HECHOS
GO

/* ***** VISTAS ***** */

/* Cantidad de autom�viles, vendidos y comprados x sucursal y mes */

CREATE VIEW [NO_HAY_BACKUP].vw_op_x_mes_sucursal AS
SELECT ISNULL((SELECT COUNT(*) FROM NO_HAY_BACKUP.HECHOS HE WHERE PRODUCTO_TIPO = 'Auto' and PRODUCTO_TIPO_TRANSACT = 'Compra' and HE.SUCURSAL_CODIGO = H.SUCURSAL_CODIGO AND HE.TIEMPO_CODIGO = H.TIEMPO_CODIGO
GROUP BY HE.SUCURSAL_CODIGO, HE.TIEMPO_CODIGO),0) AS CANTIDAD_DE_COMPRAS,
ISNULL((SELECT COUNT(*) FROM NO_HAY_BACKUP.HECHOS HE WHERE PRODUCTO_TIPO = 'Auto' and PRODUCTO_TIPO_TRANSACT = 'Venta' and HE.SUCURSAL_CODIGO = H.SUCURSAL_CODIGO AND HE.TIEMPO_CODIGO = H.TIEMPO_CODIGO
GROUP BY HE.SUCURSAL_CODIGO, HE.TIEMPO_CODIGO),0) AS CANTIDAD_DE_VENTAS,
SUCURSAL_CODIGO, TIEMPO_MES, TIEMPO_ANIO
FROM [NO_HAY_BACKUP].HECHOS H
JOIN [NO_HAY_BACKUP].DIM_TIEMPO T
ON H.TIEMPO_CODIGO = T.TIEMPO_CODIGO
WHERE PRODUCTO_TIPO = 'Auto' 
GROUP BY SUCURSAL_CODIGO, H.TIEMPO_CODIGO, TIEMPO_MES, TIEMPO_ANIO
GO

/* Precio promedio de autom�viles, vendidos y comprados */

CREATE VIEW [NO_HAY_BACKUP].vw_prec_promedio_auto AS
SELECT (SELECT ROUND(CAST(AVG(PRECIO) as decimal(18,2)),2) FROM NO_HAY_BACKUP.HECHOS
WHERE PRODUCTO_TIPO = 'Auto' and PRODUCTO_TIPO_TRANSACT = 'Compra') as PROMEDIO_COMPRA,
(SELECT ROUND(CAST(AVG(PRECIO) as decimal(18,2)),2) FROM NO_HAY_BACKUP.HECHOS
WHERE PRODUCTO_TIPO = 'Auto' and PRODUCTO_TIPO_TRANSACT = 'Venta') as PROMEDIO_VENTA
GO

/* Ganancias (precio de venta � precio de compra) x Sucursal x mes */

CREATE VIEW [NO_HAY_BACKUP].vw_ganancias_x_sucursal_mes_auto AS
SELECT ISNULL((SELECT SUM(PRECIO) FROM NO_HAY_BACKUP.HECHOS HE WHERE PRODUCTO_TIPO = 'Auto' and PRODUCTO_TIPO_TRANSACT = 'Venta' and HE.SUCURSAL_CODIGO = H.SUCURSAL_CODIGO AND HE.TIEMPO_CODIGO = H.TIEMPO_CODIGO
GROUP BY HE.SUCURSAL_CODIGO, HE.TIEMPO_CODIGO) - (SELECT SUM(PRECIO) FROM NO_HAY_BACKUP.HECHOS HE WHERE PRODUCTO_TIPO = 'Auto' and PRODUCTO_TIPO_TRANSACT = 'Compra' and HE.SUCURSAL_CODIGO = H.SUCURSAL_CODIGO AND HE.TIEMPO_CODIGO = H.TIEMPO_CODIGO
GROUP BY HE.SUCURSAL_CODIGO, HE.TIEMPO_CODIGO),0) AS GANANCIAS,
SUCURSAL_CODIGO, TIEMPO_MES, TIEMPO_ANIO
FROM [NO_HAY_BACKUP].HECHOS H
JOIN [NO_HAY_BACKUP].DIM_TIEMPO T
ON H.TIEMPO_CODIGO = T.TIEMPO_CODIGO
WHERE PRODUCTO_TIPO = 'Auto' 
GROUP BY SUCURSAL_CODIGO, H.TIEMPO_CODIGO, TIEMPO_MES, TIEMPO_ANIO
GO

CREATE VIEW [NO_HAY_BACKUP].vw_temp_modelo_inicial AS
SELECT PRODUCTO_CODIGO, MODELO_CODIGO, TIEMPO_CODIGO as fecha_inicial FROM NO_HAY_BACKUP.HECHOS WHERE PRODUCTO_TIPO = 'Auto' AND PRODUCTO_TIPO_TRANSACT = 'Compra'
GO

CREATE VIEW [NO_HAY_BACKUP].vw_temp_modelo_final AS
SELECT PRODUCTO_CODIGO, MODELO_CODIGO, TIEMPO_CODIGO AS fecha_final FROM NO_HAY_BACKUP.HECHOS WHERE PRODUCTO_TIPO = 'Auto' AND PRODUCTO_TIPO_TRANSACT = 'Venta'
GO

/* Promedio de tiempo en stock de cada modelo de autom�vil */
--
CREATE VIEW [NO_HAY_BACKUP].vw_promedio_auto_en_stock AS
SELECT I.MODELO_CODIGO, ROUND(CAST(AVG(NO_HAY_BACKUP.fx_obtener_tiempo_en_stock(I.fecha_inicial, ISNULL(F.fecha_final,0))) AS decimal(18,1)),1) AS STOCK_PROMEDIO_POR_MES
FROM NO_HAY_BACKUP.vw_temp_modelo_inicial I LEFT JOIN NO_HAY_BACKUP.vw_temp_modelo_final F
on I.PRODUCTO_CODIGO = F.PRODUCTO_CODIGO
GROUP BY I.MODELO_CODIGO
GO

/* Precio promedio de cada autoparte, vendida y comprada */

CREATE VIEW [NO_HAY_BACKUP].vw_precio_promedio_autoparte AS
SELECT (SELECT ROUND(CAST(AVG(PRECIO) as decimal(18,2)),2) FROM NO_HAY_BACKUP.HECHOS
WHERE PRODUCTO_TIPO = 'Autoparte' and PRODUCTO_TIPO_TRANSACT = 'Compra') as PROMEDIO_COMPRA,
(SELECT ROUND(CAST(AVG(PRECIO) as decimal(18,2)),2) FROM NO_HAY_BACKUP.HECHOS
WHERE PRODUCTO_TIPO = 'Autoparte' and PRODUCTO_TIPO_TRANSACT = 'Venta') as PROMEDIO_VENTA
GO

/* Ganancias (precio de venta � precio de compra) x Sucursal x mes */

CREATE VIEW [NO_HAY_BACKUP].vw_ganancias_x_sucursal_mes_autoparte AS
SELECT ISNULL((SELECT SUM(PRECIO) FROM NO_HAY_BACKUP.HECHOS HE WHERE PRODUCTO_TIPO = 'Autoparte' and PRODUCTO_TIPO_TRANSACT = 'Venta' and HE.SUCURSAL_CODIGO = H.SUCURSAL_CODIGO AND HE.TIEMPO_CODIGO = H.TIEMPO_CODIGO
GROUP BY HE.SUCURSAL_CODIGO, HE.TIEMPO_CODIGO) - (SELECT SUM(PRECIO) FROM NO_HAY_BACKUP.HECHOS HE WHERE PRODUCTO_TIPO = 'Autoparte' and PRODUCTO_TIPO_TRANSACT = 'Compra' and HE.SUCURSAL_CODIGO = H.SUCURSAL_CODIGO AND HE.TIEMPO_CODIGO = H.TIEMPO_CODIGO
GROUP BY HE.SUCURSAL_CODIGO, HE.TIEMPO_CODIGO),0) AS GANANCIAS,
SUCURSAL_CODIGO, TIEMPO_MES, TIEMPO_ANIO
FROM [NO_HAY_BACKUP].HECHOS H
JOIN [NO_HAY_BACKUP].DIM_TIEMPO T
ON H.TIEMPO_CODIGO = T.TIEMPO_CODIGO
WHERE PRODUCTO_TIPO = 'Autoparte' 
GROUP BY SUCURSAL_CODIGO, H.TIEMPO_CODIGO, TIEMPO_MES, TIEMPO_ANIO
GO

/* M�xima cantidad de stock por cada sucursal (anual) */

CREATE VIEW [NO_HAY_BACKUP].vw_max_cant_stock_sucursal AS
SELECT (ISNULL((SELECT COUNT(*) FROM NO_HAY_BACKUP.HECHOS HE 
JOIN [NO_HAY_BACKUP].DIM_TIEMPO TI
ON HE.TIEMPO_CODIGO = TI.TIEMPO_CODIGO
WHERE PRODUCTO_TIPO = 'Autoparte' and PRODUCTO_TIPO_TRANSACT = 'Compra' and HE.SUCURSAL_CODIGO = H.SUCURSAL_CODIGO AND TI.TIEMPO_ANIO = T.TIEMPO_ANIO
GROUP BY HE.SUCURSAL_CODIGO, TI.TIEMPO_ANIO),0) -
ISNULL((SELECT COUNT(*) FROM NO_HAY_BACKUP.HECHOS HE 
JOIN [NO_HAY_BACKUP].DIM_TIEMPO TI
ON HE.TIEMPO_CODIGO = TI.TIEMPO_CODIGO
WHERE PRODUCTO_TIPO = 'Autoparte' and PRODUCTO_TIPO_TRANSACT = 'Venta' and HE.SUCURSAL_CODIGO = H.SUCURSAL_CODIGO AND TI.TIEMPO_ANIO = T.TIEMPO_ANIO
GROUP BY HE.SUCURSAL_CODIGO, TI.TIEMPO_ANIO),0)) AS STOCK,
SUCURSAL_CODIGO, TIEMPO_ANIO
FROM [NO_HAY_BACKUP].HECHOS H
JOIN [NO_HAY_BACKUP].DIM_TIEMPO T
ON H.TIEMPO_CODIGO = T.TIEMPO_CODIGO
WHERE PRODUCTO_TIPO = 'Autoparte' 
GROUP BY SUCURSAL_CODIGO, TIEMPO_ANIO
GO