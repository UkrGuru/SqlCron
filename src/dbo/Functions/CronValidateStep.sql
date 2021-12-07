-- =============================================
-- Author:		Oleksandr Viktor (UkrGuru)
-- Create date: 2021-12-05
-- Samples:
 --SELECT dbo.[CronValidateStep]('MINUTE', '0-5', 0)
 --SELECT dbo.[CronValidateStep]('HOUR', '0-5', 5)
 --SELECT dbo.[CronValidateStep]('DAY', '0-5', 6)
-- =============================================
CREATE FUNCTION [dbo].[CronValidateStep](@Name varchar(10), @Expression varchar(100), @Value int, @Min int, @Max int)
RETURNS tinyint
AS
BEGIN
    DECLARE @Start int = TRY_CAST(dbo.CronWord(@Expression, '/', 1) as int)
        ,@Step int = TRY_CAST(dbo.CronWord(@Expression, '/', 2) as int)

    IF @Start IS NULL OR @Step IS NULL OR ISNULL(@Step, 0) <= 0 RETURN 0;

    DECLARE @i int = CASE WHEN @Start > @Min THEN @Start ELSE @Min END;
    WHILE @i <= @Max 
    BEGIN
        IF @i = @Value RETURN 1
            
        SET @i += @Step;
    END
    
    RETURN 0
END
