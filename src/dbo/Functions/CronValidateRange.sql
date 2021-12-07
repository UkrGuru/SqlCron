-- =============================================
-- Author:		Oleksandr Viktor (UkrGuru)
-- Create date: 2021-12-05
-- Samples:
 --SELECT dbo.[CronValidateRange]('MINUTE', '0-5', 0)
 --SELECT dbo.[CronValidateRange]('HOUR', '0-5', 5)
 --SELECT dbo.[CronValidateRange]('DAY', '0-5', 6)
-- =============================================
CREATE FUNCTION [dbo].[CronValidateRange](@Name varchar(10), @Expression varchar(100), @Value int, @Min int, @Max int)
RETURNS tinyint
AS
BEGIN
    DECLARE @Begin int = TRY_CAST(dbo.CronWord(@Expression, '-', 1) as int)
        ,@End int = TRY_CAST(dbo.CronWord(@Expression, '-', 2) as int)

    IF @Begin IS NULL OR @End IS NULL RETURN 0;
    IF NOT (@Begin BETWEEN @Min AND @Max AND @End BETWEEN @Min AND @Max) RETURN 0;

    IF @Begin > @End BEGIN
        SET @Expression = CAST(@Min AS varchar) + '-' + CAST(@End as varchar) + ',' + CAST(@Begin AS varchar) + '-' + CAST(@Max as varchar);
        RETURN dbo.CronValidatePart(@Name, @Expression, @Value);
    END

    DECLARE @j int = @Begin;

    WHILE @j <= @End
    BEGIN
        IF @j = @Value RETURN 1
            
        SET @j += 1;
    END
    
    RETURN 0
END

