-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER   FUNCTION [dbo].[CronValidateRange](@Expression varchar(100), @Value int, @Min int, @Max int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE '%[^0-9*/-]%' RETURN 0
    IF @Value IS NULL OR @Min IS NULL OR @Max IS NULL OR NOT @Value BETWEEN @Min AND @Max RETURN 0  

    DECLARE @Begin int, @End int, @Step int

    IF CHARINDEX('/', @Expression, 0) > 0 BEGIN
        SET @Step = TRY_CAST(dbo.CronWord(@Expression, '/', 2) as int);
        IF ISNULL(@Step, 0) <= 0 RETURN 0;

        SET @Expression = dbo.CronWord(@Expression, '/', 1);
    END

    SET @Begin = TRY_CAST(dbo.CronWord(@Expression, '-', 1) as int);
    SET @End = TRY_CAST(dbo.CronWord(@Expression, '-', 2) as int);
    SET @Step = ISNULL(@Step, 1);

    IF @Begin IS NULL OR @End IS NULL RETURN 0;

    DECLARE @i int = @Begin, @OneMore int = CASE WHEN @End < @Begin THEN 1 ELSE 0 END 
    
    IF @OneMore = 0 AND @End < @Max SET @Max = @End 

    WHILE @i <= @Max BEGIN

        IF @i = @Value RETURN 1

        SET @i += @Step;

        IF @i > @Max AND @OneMore = 1 BEGIN
            SET @i -= (@Max + 1);
            SET @Max = @End
            SET @OneMore = 0; 
        END
    END
   
    RETURN 0
END
GO


