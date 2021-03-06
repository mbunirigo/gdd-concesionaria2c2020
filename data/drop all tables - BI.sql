USE [GD2C2020]
GO

drop table [NO_HAY_BACKUP].[HECHOS]
drop table [NO_HAY_BACKUP].[DIM_CLIENTE]
drop table NO_HAY_BACKUP.DIM_POTENCIA
drop table NO_HAY_BACKUP.DIM_AUTO_MODELO
drop table NO_HAY_BACKUP.DIM_CIUDAD
drop table NO_HAY_BACKUP.DIM_SUCURSAL
drop table NO_HAY_BACKUP.DIM_AUTO_PARTE
drop table NO_HAY_BACKUP.DIM_FABRICANTE
drop table NO_HAY_BACKUP.DIM_TIEMPO
drop table NO_HAY_BACKUP.DIM_TIPO_AUTO
drop table NO_HAY_BACKUP.DIM_TIPO_CAJA
drop table NO_HAY_BACKUP.DIM_TIPO_MOTOR
drop table NO_HAY_BACKUP.DIM_TIPO_TRANSMISION

DROP FUNCTION [NO_HAY_BACKUP].fx_rango_edad

DROP FUNCTION [NO_HAY_BACKUP].fx_codigo_tiempo

DROP FUNCTION [NO_HAY_BACKUP].fx_codigo_potencia

drop FUNCTION [NO_HAY_BACKUP].fx_obtener_tiempo_en_stock

DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_AUTO_PARTE
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_TRANSMISION
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_CAJA
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_AUTO
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_CIUDAD
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_FABRICANTE
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIPO_MOTOR
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_AUTO_MODELO
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_POTENCIA
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_SUCURSAL
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_TIEMPO
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_DIM_CLIENTE
DROP PROCEDURE [NO_HAY_BACKUP].PRC_INSERT_HECHOS


DROP VIEW [NO_HAY_BACKUP].vw_op_x_mes_sucursal
DROP VIEW NO_HAY_BACKUP.vw_prec_promedio_auto
DROP VIEW [NO_HAY_BACKUP].vw_ganancias_x_sucursal_mes_auto
drop view NO_HAY_BACKUP.vw_temp_modelo_inicial
drop view NO_HAY_BACKUP.vw_temp_modelo_final
DROP VIEW NO_HAY_BACKUP.vw_promedio_auto_en_stock

DROP VIEW NO_HAY_BACKUP.vw_precio_promedio_autoparte
DROP VIEW [NO_HAY_BACKUP].vw_ganancias_x_sucursal_mes_autoparte
DROP VIEW [NO_HAY_BACKUP].vw_max_cant_stock_sucursal
