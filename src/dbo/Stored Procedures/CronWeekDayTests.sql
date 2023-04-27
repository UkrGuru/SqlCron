-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER PROCEDURE [dbo].[CronWeekDayTests] 
AS
DECLARE @Now datetime = '2021-11-07'

SET DATEFIRST 1
SELECT dbo.CronWeekDay(@Now)

SET DATEFIRST 2
SELECT dbo.CronWeekDay(@Now)

SET DATEFIRST 3
SELECT dbo.CronWeekDay(@Now)

SET DATEFIRST 4
SELECT dbo.CronWeekDay(@Now)

SET DATEFIRST 5
SELECT dbo.CronWeekDay(@Now)

SET DATEFIRST 6
SELECT dbo.CronWeekDay(@Now)

SET DATEFIRST 7
SELECT dbo.CronWeekDay(@Now)
