-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE   PROCEDURE [dbo].[CronValidatePartTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

IF dbo.CronValidatePart('MINUTE', '*', 0) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_*_0';
IF dbo.CronValidatePart('HOUR', '0', 0) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'HOUR_0_0';
IF dbo.CronValidatePart('DAY', '1', 1) = 1 SET @Count += 1 ELSE			SET @ErrMsg = 'DAY_1_1';
IF dbo.CronValidatePart('MONTH', '0,1', 1) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MONTH_0,1_1';
IF dbo.CronValidatePart('WEEKDAY', '0,1,2', 2) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'WEEKDAY_0,1,2_2';

IF dbo.CronValidatePart('MINUTE', '3,4-5', 3) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_3,4-5_3';
IF dbo.CronValidatePart('MINUTE', '3,4-5', 4) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_3,4-5_4';
IF dbo.CronValidatePart('MINUTE', '3,4-5', 5) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_3,4-5_5';
IF dbo.CronValidatePart('MINUTE', '4-5,3', 4) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_4-5,3_4';
IF dbo.CronValidatePart('MINUTE', '4-5,3', 3) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_4-5,3_3';

IF dbo.CronValidatePart('MINUTE', '6,7/8', 6) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_6,7/8_6';
IF dbo.CronValidatePart('MINUTE', '6,7/8', 7) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_6,7/8_7';
IF dbo.CronValidatePart('MINUTE', '6,7/8', 15) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_6,7/8_15';
IF dbo.CronValidatePart('MINUTE', '7/8,6', 15) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_7/8,6_15';
IF dbo.CronValidatePart('MINUTE', '7/8,6', 6) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'MINUTE_7/8,6_6';

IF @Count = 15 SELECT 'OK' ELSE SELECT @ErrMsg
