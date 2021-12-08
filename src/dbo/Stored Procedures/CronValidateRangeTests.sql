-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE   PROCEDURE [dbo].[CronValidateRangeTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

DECLARE @Min int, @Max int;

-- minute
SELECT @Min = 0, @Max = 59	

IF dbo.CronValidateRange('0-5', 0, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_0-5_0';
IF dbo.CronValidateRange('0-5', 5, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_0-5_5';
IF dbo.CronValidateRange('55-59', 55, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_55-59_55';
IF dbo.CronValidateRange('55-59', 59, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_55-59_59';
IF dbo.CronValidateRange('00-59', 0, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_00-59_0';

IF dbo.CronValidateRange('55-5', 55, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_55';
IF dbo.CronValidateRange('55-5', 59, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_59';
IF dbo.CronValidateRange('55-5', 0, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_0';
IF dbo.CronValidateRange('55-5', 3, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_3';
IF dbo.CronValidateRange('55-5', 5, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5_5';

IF dbo.CronValidateRange('0-15/5', 0, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_0-15/5_0';
IF dbo.CronValidateRange('0-15/5', 10, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_0-15/5_10';
IF dbo.CronValidateRange('0-15/5', 15, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_0-15/5_15';
IF dbo.CronValidateRange('55-5/5', 0, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5/5_0';
IF dbo.CronValidateRange('55-5/5', 5, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_55-5/5_5';

IF @Count = 15 SELECT 'OK' ELSE SELECT CAST(@Count as varchar)