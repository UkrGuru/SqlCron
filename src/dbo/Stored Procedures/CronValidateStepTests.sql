-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE PROCEDURE [dbo].[CronValidateStepTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

DECLARE @Min int, @Max int;

-- minute
SELECT @Min = 0, @Max = 59	

IF dbo.CronValidateStep('*/5', 0, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_*/5_0';
IF dbo.CronValidateStep('*/5', 55, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_*/5_5';

IF dbo.CronValidateStep('5/4', 5, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_5/4_5';
IF dbo.CronValidateStep('6/5', 11, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_6/5_11';
IF dbo.CronValidateStep('7/8', 55, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_7/8_55';
IF dbo.CronValidateStep('9/10', 59, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_9/10_59';
IF dbo.CronValidateStep('11/12', 23, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_11/12_23';

IF dbo.CronValidateStep('0/59', 59, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MINUTE_0/59_59';
--IF dbo.CronValidateStep('HOUR', '0/23', 23, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'HOUR_0/23_23';
--IF dbo.CronValidateStep('DAY', '1/30', 31, @Min, @Max) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'DAY_1/30_31';
--IF dbo.CronValidateStep('MONTH', '1/11', 12, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MONTH_1/11_12';
--IF dbo.CronValidateStep('WEEKDAY', '1/6', 7, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'WEEKDAY_1/6_7';

IF @Count = 8 SELECT 'OK' ELSE SELECT CAST(@Count as varchar)
