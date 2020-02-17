/*
Created: 10/2/2020
Modified: 10/2/2020
Model: Oracle 11g Release 2
Database: Oracle 11g Release 2
*/


-- Create tables section -------------------------------------------------

-- Table cliente

CREATE TABLE "cliente"(
  "cli_id" Char(20 ) NOT NULL,
  "cli_cedula" Char(20 ),
  "cli_nombres" Char(100 ),
  "cli_apellidos" Char(100 ),
  "cli_fecregistro" Date,
  "cli_fecnacimiento" Date,
  "cli_telefono" Char(20 ),
  "cli_direccion" Char(100 ),
  "cli_email" Char(50 )
)
/

-- Add keys for table cliente

ALTER TABLE "cliente" ADD CONSTRAINT "Key1" PRIMARY KEY ("cli_id")
/

-- Table empleado

CREATE TABLE "empleado"(
  "emp_id" Char(20 ) NOT NULL,
  "emp_cedula" Char(20 ),
  "emp_nombres" Char(100 ),
  "emp_apellidos" Char(100 ),
  "emp_fecnacimiento" Date,
  "emp_fecregistro" Date,
  "emp_telefono" Char(20 ),
  "emp_direccion" Char(100 ),
  "emp_email" Char(50 ),
  "emp_tipo" Char(50 ),
  "emp_contrasena" Char(20 )
)
/

-- Add keys for table empleado

ALTER TABLE "empleado" ADD CONSTRAINT "Key2" PRIMARY KEY ("emp_id")
/

-- Table producto

CREATE TABLE "producto"(
  "pro_id" Char(20 ) NOT NULL,
  "pro_tipo" Char(50 ),
  "pro_nombre" Char(50 ),
  "pro_marca" Char(50 ),
  "pro_descripcion" Char(100 ),
  "pro_stock" Integer,
  "pro_preciocompra" Float,
  "pro_precioventa" Float
)
/

-- Add keys for table producto

ALTER TABLE "producto" ADD CONSTRAINT "Key3" PRIMARY KEY ("pro_id")
/

-- Table iva

CREATE TABLE "iva"(
  "iva_id" Char(20 ) NOT NULL,
  "iva_valor" Integer
)
/

-- Add keys for table iva

ALTER TABLE "iva" ADD CONSTRAINT "Key4" PRIMARY KEY ("iva_id")
/

-- Table proveedor

CREATE TABLE "proveedor"(
  "prov_id" Char(20 ) NOT NULL,
  "prov_cedula" Char(20 ),
  "prov_nombres" Char(100 ),
  "prov_apellidos" Char(100 ),
  "prov_fecregistro" Date,
  "prov_telefono" Char(20 ),
  "prov_compania" Char(50 ),
  "prov_email" Char(50 )
)
/

-- Add keys for table proveedor

ALTER TABLE "proveedor" ADD CONSTRAINT "Key5" PRIMARY KEY ("prov_id")
/

-- Table facturacompra

CREATE TABLE "facturacompra"(
  "facc_id" Char(20 ) NOT NULL,
  "facc_fecha" Date,
  "facc_iva" Integer,
  "facc_total" Float,
  "prov_id" Char(20 )
)
/

-- Create indexes for table facturacompra

CREATE INDEX "IX_Relationship1" ON "facturacompra" ("prov_id")
/

-- Add keys for table facturacompra

ALTER TABLE "facturacompra" ADD CONSTRAINT "Key6" PRIMARY KEY ("facc_id")
/

-- Table fac_com_det

CREATE TABLE "fac_com_det"(
  "fcd_id" Char(20 ) NOT NULL,
  "facc_id" Char(20 ),
  "pro_id" Char(20 ),
  "fcd_cantidad" Integer,
  "fcd_preunitario" Float
)
/

-- Create indexes for table fac_com_det

CREATE INDEX "IX_Relationship2" ON "fac_com_det" ("facc_id")
/

CREATE INDEX "IX_Relationship3" ON "fac_com_det" ("pro_id")
/

-- Add keys for table fac_com_det

ALTER TABLE "fac_com_det" ADD CONSTRAINT "Key7" PRIMARY KEY ("fcd_id")
/

-- Table facturaventa

CREATE TABLE "facturaventa"(
  "facv_id" Char(20 ) NOT NULL,
  "facv_fecha" Date,
  "facv_iva" Integer,
  "facv_total" Float,
  "cli_id" Char(20 ),
  "emp_id" Char(20 )
)
/

-- Create indexes for table facturaventa

CREATE INDEX "IX_Relationship4" ON "facturaventa" ("cli_id")
/

CREATE INDEX "IX_Relationship5" ON "facturaventa" ("emp_id")
/

-- Add keys for table facturaventa

ALTER TABLE "facturaventa" ADD CONSTRAINT "Key8" PRIMARY KEY ("facv_id")
/

-- Table fac_ven_det

CREATE TABLE "fac_ven_det"(
  "fvd_id" Char(20 ) NOT NULL,
  "facv_id" Char(20 ),
  "pro_id" Char(20 ),
  "fvd_cantidad" Integer,
  "fvd_preunitario" Float
)
/

-- Create indexes for table fac_ven_det

CREATE INDEX "IX_Relationship6" ON "fac_ven_det" ("facv_id")
/

CREATE INDEX "IX_Relationship7" ON "fac_ven_det" ("pro_id")
/

-- Add keys for table fac_ven_det

ALTER TABLE "fac_ven_det" ADD CONSTRAINT "Key9" PRIMARY KEY ("fvd_id")
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE "facturacompra" ADD CONSTRAINT "Relationship1" FOREIGN KEY ("prov_id") REFERENCES "proveedor" ("prov_id")
/



ALTER TABLE "fac_com_det" ADD CONSTRAINT "Relationship2" FOREIGN KEY ("facc_id") REFERENCES "facturacompra" ("facc_id")
/



ALTER TABLE "fac_com_det" ADD CONSTRAINT "Relationship3" FOREIGN KEY ("pro_id") REFERENCES "producto" ("pro_id")
/



ALTER TABLE "facturaventa" ADD CONSTRAINT "Relationship4" FOREIGN KEY ("cli_id") REFERENCES "cliente" ("cli_id")
/



ALTER TABLE "facturaventa" ADD CONSTRAINT "Relationship5" FOREIGN KEY ("emp_id") REFERENCES "empleado" ("emp_id")
/



ALTER TABLE "fac_ven_det" ADD CONSTRAINT "Relationship6" FOREIGN KEY ("facv_id") REFERENCES "facturaventa" ("facv_id")
/



ALTER TABLE "fac_ven_det" ADD CONSTRAINT "Relationship7" FOREIGN KEY ("pro_id") REFERENCES "producto" ("pro_id")
/





