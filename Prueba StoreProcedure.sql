
CREATE PROCEDURE CopiarValorSiSerieEs12
AS

BEGIN
    -- Verificar si la tabla existe, si no existe, terminar el procedimiento
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ORDR')
    BEGIN
        PRINT 'La tabla mi_tabla no existe.';
        RETURN;
    END;

    -- Verificar si las columnas existen en la tabla, si no existen, terminar el procedimiento
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'Series' AND Object_ID = Object_ID(N'ORDR'))
        OR NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'U_IV_EC_DirentregaAbierta' AND Object_ID = Object_ID(N'ORDR'))
        OR NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'Address2' AND Object_ID = Object_ID(N'ORDR'))
    BEGIN
        PRINT 'Las columnas necesarias no existen en la tabla.';
        RETURN;
    END;


    -- Copiar el valor de columna_origen a columna_destino solo si la serie es igual a 12
    UPDATE ORDR
    SET Address2 = U_IV_EC_DirentregaAbierta
    WHERE Series = 76;
    
    PRINT 'Valores copiados exitosamente si la serie era 12.';

END;

---------------------------------------------------------------------------
-----Triger

CREATE TRIGGER TR_InsertarDocumento
ON ORDR
AFTER INSERT
AS
BEGIN
    -- Verificar si la serie del documento recién insertado es 12
    IF EXISTS (SELECT 1 FROM inserted WHERE Series = 76)
    BEGIN
        -- Ejecutar el procedimiento almacenado para copiar los valores si la serie es 12
        EXEC CopiarValorSiSerieEs12;
    END;
END;


****************Nueva version****************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DomicilioEnvio_tn]
AS

BEGIN
    -- Verificar si la tabla existe, si no existe, terminar el procedimiento
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ORDR')
    BEGIN
        PRINT 'La tabla mi_tabla no existe.';
        RETURN;
    END;

    -- Verificar si las columnas existen en la tabla, si no existen, terminar el procedimiento
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'Series' AND Object_ID = Object_ID(N'ORDR'))
        OR NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'U_IV_EC_DirentregaAbierta' AND Object_ID = Object_ID(N'ORDR'))
        OR NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'Address2' AND Object_ID = Object_ID(N'ORDR'))
    BEGIN
        PRINT 'Las columnas necesarias no existen en la tabla.';
        RETURN;
    END;


    -- Copiar el valor de columna_origen a columna_destino solo si la serie es igual a 12
    UPDATE ORDR
    SET Address2 = U_IV_EC_DirentregaAbierta
    WHERE Series = 76;
    
    PRINT 'Valores copiados exitosamente si la serie era 12.';

END;
GO
****************************nueva version********


ALTER TRIGGER InsertarDocumento_tn2
ON ORDR
AFTER INSERT
AS
BEGIN
    -- Verificar si la serie del documento recién insertado es 12
    IF EXISTS (SELECT 1 FROM inserted WHERE Series = 76)
    BEGIN
        -- Pausa de 5 segundos
        WAITFOR DELAY '00:00:05';
        
        -- Ejecutar el procedimiento almacenado para copiar los valores si la serie es 12
        EXEC DomicilioEnvio_tn;
    END;
END;




SELECT * FROM sys.triggers;


******************************

    
SELECT * FROM sys.triggers;


Disable TRIGGER InsertarDocumento_tn2 ON ORDR







------------------------------------------------------------------------------



SELECT DocNum, Series, U_IV_EC_DirentregaAbierta,Address2
FROM ORDR
WHERE Series = 76

SELECT DocNum, Series
FROM ORDR

--------------------------------


SELECT
Account,
AcctName,
BankCode
FROM DSC1



SELECT *
FROM DSC1
