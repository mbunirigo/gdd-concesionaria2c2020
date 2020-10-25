CREATE TABLE [AUTO_PARTE] (
  [AUTO_PARTE_CODIGO] decimal(18,0),
  [AUTO_PARTE_DESCRIPCION] nvarchar(255),
  [AUTO_PARTE_FABRICANTE_COD] decimal(18,0),
  PRIMARY KEY ([AUTO_PARTE_CODIGO])
);

CREATE TABLE [TIPO_TRANSMISION] (
  [TIPO_TRANSMISION_CODIGO] decimal(18,0),
  [TIPO_TRANSMISION_DESC] nvarchar(255),
  PRIMARY KEY ([TIPO_TRANSMISION_CODIGO])
);

CREATE TABLE [AUTO_MODELO] (
  [MODELO_CODIGO] decimal(18,0),
  [MODELO_NOMBRE] nvarchar(255),
  [MODELO_POTENCIA] decimal(18,0),
  [MODELO_CAJA_COD] decimal(18,0),
  [MODELO_TRANSMISION_COD] decimal(18,0),
  [MODELO_TIPO_MOTOR_CODIGO] decimal(18,0),
  PRIMARY KEY ([MODELO_CODIGO])
);

CREATE TABLE [PRODUCTO_OPERACION] (
  [PRODUCTO_CODIGO] decimal(18,0),
  [] <type>,
  [PRODUCTO_TIPO] nvarchar(255),
  [PRODUCTO_TIPO_DESC] nvarchar(255),
  [PRODUCTO_PRECIO_UNITARIO] decimal(18,2),
  [PRODUCTO_TIPO_TRANSACT] nvarchar(255),
  PRIMARY KEY ([PRODUCTO_CODIGO], [PRODUCTO_TIPO])
);

CREATE TABLE [AUTO] (
  [AUTO_CODIGO] decimal(18,0),
  [AUTO_NRO_MOTOR] nvarchar(50),
  [AUTO_NRO_CHASIS] nvarchar(50),
  [AUTO_PATENTE] nvarchar(50),
  [AUTO_CANT_KMS] decimal(18,0),
  [AUTO_FECHA_ALTA] datetime2(3),
  [AUTO_TIPO_COD] decimal(18,0),
  PRIMARY KEY ([AUTO_CODIGO])
);

CREATE TABLE [CLIENTE] (
  [CODIGO_CLIENTE] decimal(18,0),
  [CLIENTE_NOMBRE] nvarchar(255),
  [CLIENTE_APELLIDO] nvarchar(255),
  [CLIENTE_DNI] decimal(18,0),
  [CLIENTE_FECHA_NAC] datetime2(3),
  [CLIENTE_MAIL] nvarchar(255),
  [CLIENTE_DIRECCION] nvarchar(255),
  PRIMARY KEY ([CODIGO_CLIENTE])
);

CREATE TABLE [TIPO_X_MODELO] (
  [TIPO_X_MODELO_COD] decimal(18,0),
  [TIPO_AUTO_CODIGO] decimal(18,0),
  [MODELO_CODIGO] decimal(18,0),
  PRIMARY KEY ([TIPO_X_MODELO_COD])
);

CREATE TABLE [SUCURSAL] (
  [SUCURSAL_CODIGO] decimal(18,0),
  [SUCURSAL_CIUDAD_COD] decimal(18,0),
  [SUCURSAL_DIRECCION] nvarchar(255),
  [SUCURSAL_MAIL] nvarchar(255),
  [SUCURSAL_TELEFONO] decimal(18,0),
  PRIMARY KEY ([SUCURSAL_CODIGO])
);

CREATE TABLE [FABRICANTE] (
  [FABRICANTE_CODIGO] decimal(18,0),
  [FABRICANTE_NOMBRE] nvarchar(255),
  PRIMARY KEY ([FABRICANTE_CODIGO])
);

CREATE TABLE [AUTO_PARTE_X_FABRICANTE] (
  [AUTO_PARTE_X_FABRICANTE_COD] decimal(18,0),
  [AUTO_PARTE_FABRICANTE_COD] decimal(18,0),
  [FABRICANTE_CODIGO] decimal(18,0),
  PRIMARY KEY ([AUTO_PARTE_X_FABRICANTE_COD])
);

CREATE TABLE [TIPO_CAJA] (
  [TIPO_CAJA_CODIGO] decimal(18,0),
  [TIPO_CAJA_DESC] nvarchar(255),
  PRIMARY KEY ([TIPO_CAJA_CODIGO])
);

CREATE TABLE [TIPO_AUTO] (
  [TIPO_AUTO_CODIGO] decimal(18,0),
  [TIPO_AUTO_DESC] nvarchar(255),
  [TIPO_AUTO_MODELO_COD] decimal(18,0),
  PRIMARY KEY ([TIPO_AUTO_CODIGO])
);

CREATE TABLE [CIUDAD] (
  [CIUDAD_CODIGO] decimal(18,0),
  [CIUDAD_DESCRIPCION] nvarchar(255),
  PRIMARY KEY ([CIUDAD_CODIGO])
);

CREATE TABLE [FACTURA] (
  [FACTURA_NRO] decimal(18,0),
  [FACTURA_FECHA] datetime2(3),
  [FACTURA_PRECIO] decimal(18,2),
  [FACTURA_CANT] decimal(18,0),
  [FACT_SUCURSAL_COD] decimal(18,0),
  [FACT_CLIENTE_COD] decimal(18,0),
  [FACT_PRODUCTO_COD] decimal(18,0),
  [TIPO_PRODUCTO] nvarchar(255),
  PRIMARY KEY ([FACTURA_NRO])
);

CREATE TABLE [COMPRA] (
  [COMPRA_NRO] decimal(18,0),
  [COMPRA_FECHA] datetime2(3),
  [COMPRA_PRECIO] decimal(18,2),
  [COMPRA_CANT] decimal(18,0),
  [COMPRA_SUCURSAL_COD] decimal(18,0),
  [COMPRA_CLIENTE_COD] decimal(18,0),
  [COMPRA_PRODUCTO_COD] decimal(18,0),
  [COMPRA_PRODUCTO_TIPO] nvarchar(255),
  PRIMARY KEY ([COMPRA_NRO])
);
