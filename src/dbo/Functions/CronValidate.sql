-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE FUNCTION [dbo].[CronValidate] (@Expression varchar(100), @Now datetime)
RETURNS bit
AS
BEGIN
    SET @Expression =   REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
		                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
		                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                        UPPER(@Expression), 
		                'JAN', '1'),'FEB', '2'),'MAR', '3'),'APR', '4'),'MAY', '5'),'JUN', '6'),
		                'JUL', '7'),'AUG', '8'),'SEP', '9'),'OCT', '10'),'NOV', '11'),'DEC', '12'),
		                'SUN', '1'),'MON', '2'),'TUE', '3'),'WED', '4'),'THU', '5'),'FRI', '6'),'SAT', '7')

    IF @Expression LIKE '%[^0-9*,-/ ]%' RETURN 0

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, ' ', 1), DATEPART(MINUTE, @Now), 0, 59) = 0 RETURN 0;

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, ' ', 2), DATEPART(HOUR, @Now), 0, 23) = 0 RETURN 0;

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, ' ', 3), DATEPART(DAY, @Now), 1, 31) = 0 RETURN 0;

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, ' ', 4), DATEPART(MONTH, @Now), 1, 12) = 0 RETURN 0;

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, ' ', 5), DATEPART(WEEKDAY, @Now), 1, 7) = 0 RETURN 0;

    RETURN 1
END