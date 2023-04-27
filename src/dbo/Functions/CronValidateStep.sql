-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER FUNCTION [dbo].[CronValidateStep](@Expression varchar(100), @Value int, @Min int, @Max int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE '%[^0-9*/]%' RETURN 0
    IF @Value IS NULL OR @Min IS NULL OR @Max IS NULL OR NOT @Value BETWEEN @Min AND @Max RETURN 0  

    DECLARE @Start int = ISNULL(TRY_CAST(dbo.CronWord(@Expression, '/', 1) as int), 0),
        @Step int = TRY_CAST(dbo.CronWord(@Expression, '/', 2) as int);

    IF @Start IS NULL OR @Step IS NULL OR ISNULL(@Step, 0) <= 0 RETURN 0;

    DECLARE @i int = @Start;
    WHILE @i <= @Max 
    BEGIN
        IF @i = @Value RETURN 1;
            
        SET @i += @Step;
    END

    RETURN 0
END
