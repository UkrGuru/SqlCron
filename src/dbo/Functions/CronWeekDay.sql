-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE FUNCTION [dbo].[CronWeekDay](@Now datetime)
RETURNS int
AS
BEGIN
    RETURN (DATEPART(weekday, @Now) + @@DATEFIRST + 6) % 7
END