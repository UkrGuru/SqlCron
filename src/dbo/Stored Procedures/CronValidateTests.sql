-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE   PROCEDURE [dbo].[CronValidateTests] 
AS
DECLARE @Tests TABLE (Expression varchar(100), Value int, Min int, Max int, Expected tinyint)
DECLARE @Min int, @Max int;

-- minute tests
--SELECT @Min = 0, @Max = 59	

--INSERT @Tests VALUES ('*/5', 0, @Min, @Max, 1)
--INSERT @Tests VALUES ('*/5', 55, @Min, @Max, 1)

--INSERT @Tests VALUES ('5/4', 5, @Min, @Max, 1)
--INSERT @Tests VALUES ('6/5', 11, @Min, @Max, 1)
--INSERT @Tests VALUES ('7/8', 55, @Min, @Max, 1)
--INSERT @Tests VALUES ('9/10', 59, @Min, @Max, 1)
--INSERT @Tests VALUES ('11/12', 23, @Min, @Max, 1)

--INSERT @Tests VALUES ('0/59', 59, @Min, @Max, 1)

--IF dbo.CronValidateStep('HOUR', '0/23', 23, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'HOUR_0/23_23';
--IF dbo.CronValidateStep('DAY', '1/30', 31, @Min, @Max) = 1 SET @Count += 1 ELSE		SET @ErrMsg = 'DAY_1/30_31';
--IF dbo.CronValidateStep('MONTH', '1/11', 12, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'MONTH_1/11_12';
--IF dbo.CronValidateStep('WEEKDAY', '1/6', 7, @Min, @Max) = 1 SET @Count += 1 ELSE	SET @ErrMsg = 'WEEKDAY_1/6_7';

--SELECT Expected, dbo.CronValidate(Expression, Value, Min, Max) Actual,
--	Expression + '_' + CAST(Value as varchar) + '_' + CAST(Min as varchar) + '_' + CAST(Max as varchar) Func
--FROM @Tests
--WHERE Expected <> dbo.CronValidate(Expression, Value, Min, Max)
