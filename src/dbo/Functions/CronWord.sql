-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER FUNCTION [dbo].[CronWord](@Words varchar(100), @Separator char(1) = ' ', @Index int)
RETURNS varchar(100)
AS
BEGIN
	RETURN (SELECT TOP 1 s.value FROM (
		SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ordinal
		FROM STRING_SPLIT(@Words, @Separator)) s
	WHERE s.ordinal = @Index);
END