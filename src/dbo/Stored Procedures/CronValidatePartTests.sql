-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE   PROCEDURE [dbo].[CronValidatePartTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

DECLARE @Min int, @Max int;

-- minute
SELECT @Min = 0, @Max = 59	

-- test invalid values
IF dbo.CronValidatePart('-1',    -1, @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_MINUTE_-1_-1';
IF dbo.CronValidatePart('60',    60, @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_MINUTE_60_60';

-- test valid values
IF dbo.CronValidatePart('*',	 0, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_*_0';
IF dbo.CronValidatePart('0',	 0, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'HOUR_0_0';
IF dbo.CronValidatePart('1',	 1, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'DAY_1_1';
IF dbo.CronValidatePart('0,1',   1, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MONTH_0,1_1';
IF dbo.CronValidatePart('1,2,3', 2, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'WEEKDAY_1,2,3_2';

IF dbo.CronValidatePart('3,4-5', 3, @Min, @Max)  = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_3,4-5_3';
IF dbo.CronValidatePart('3,4-5', 4, @Min, @Max)  = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_3,4-5_4';
IF dbo.CronValidatePart('3,4-5', 5, @Min, @Max)  = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_3,4-5_5';
IF dbo.CronValidatePart('4-5,3', 4, @Min, @Max)  = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_4-5,3_4';
IF dbo.CronValidatePart('4-5,3', 3, @Min, @Max)  = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_4-5,3_3';

IF dbo.CronValidatePart('6,7/8', 6,  @Min, @Max)  = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_6,7/8_6';
IF dbo.CronValidatePart('6,7/8', 7,  @Min, @Max)  = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_6,7/8_7';
IF dbo.CronValidatePart('6,7/8', 15, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_6,7/8_15';
IF dbo.CronValidatePart('7/8,6', 15, @Min, @Max) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_7/8,6_15';
IF dbo.CronValidatePart('7/8,6', 6,  @Min, @Max)  = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_7/8,6_6';

-- hour
SELECT @Min = 0, @Max = 23	

IF dbo.CronValidatePart('-1', -1,  @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_HOUR_-1_-1';
IF dbo.CronValidatePart('24', 24,  @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_HOUR_24_24';

-- day
SELECT @Min = 1, @Max = 31	

IF dbo.CronValidatePart('0', 0,  @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_DAY_0_0';
IF dbo.CronValidatePart('32', 32,  @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_DAY_32_32';

-- month
SELECT @Min = 1, @Max = 12	

IF dbo.CronValidatePart('0', 0,  @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_MONTH_0_0';
IF dbo.CronValidatePart('13', 13,  @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_MONTH_13_13';

-- weekday
SELECT @Min = 1, @Max = 7	

IF dbo.CronValidatePart('0', 0,  @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_WEEKDAY_-1_-1';
IF dbo.CronValidatePart('8', 8,  @Min, @Max) = 0 SET @Count += 1 ELSE SET @ErrMsg = '!_WEEKDAY_8_8';

IF @Count = 25 SELECT 'OK' ELSE SELECT @ErrMsg
