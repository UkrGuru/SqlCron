-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE   PROCEDURE [dbo].[CronValidateRangeTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

IF dbo.CronValidateRange('MINUTE', '0-5', 0) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_0-5_0';
IF dbo.CronValidateRange('MINUTE', '0-5', 5) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_0-5_5';
IF dbo.CronValidateRange('MINUTE', '55-59', 55) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_55-59_55';
IF dbo.CronValidateRange('MINUTE', '55-59', 59) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_55-59_59';
IF dbo.CronValidateRange('MINUTE', '00-59', 0) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_00-59_0';

IF dbo.CronValidateRange('MINUTE', '55-5', 55) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_55';
IF dbo.CronValidateRange('MINUTE', '55-5', 59) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_59';
IF dbo.CronValidateRange('MINUTE', '55-5', 0) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_0';
IF dbo.CronValidateRange('MINUTE', '55-5', 3) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_3';
IF dbo.CronValidateRange('MINUTE', '55-5', 5) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_5';

IF dbo.CronValidateRange('MINUTE', '0-15/5', 0) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_0-15/5_0';
IF dbo.CronValidateRange('MINUTE', '0-15/5', 10) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_0-15/5_10';
IF dbo.CronValidateRange('MINUTE', '0-15/5', 15) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_0-15/5_15';
IF dbo.CronValidateRange('MINUTE', '55-5/5', 0) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5/5_0';
IF dbo.CronValidateRange('MINUTE', '55-5/5', 5) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5/5_5';

IF @Count = 15 SELECT 'OK' ELSE SELECT CAST(@Count as varchar)