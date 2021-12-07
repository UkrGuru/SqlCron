-- =============================================
-- Author: Oleksandr Viktor (UkrGuru)
-- =============================================
CREATE FUNCTION [dbo].[CronValidateStep](@PartName varchar(10), @Expression varchar(100), @Value int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE '%[^0-9*/]%' OR @Value IS NULL RETURN 0

    DECLARE @Start int = ISNULL(TRY_CAST(dbo.CronWord(@Expression, '-', 1) as int), 0),
        @Step int = TRY_CAST(dbo.CronWord(@Expression, '-', 2) as int);

    IF @Start IS NULL OR @Step IS NULL OR ISNULL(@Step, 0) <= 0 RETURN 0;

    DECLARE @Min int, @Max int
    IF @PartName = 'MINUTE' SELECT @Min = 0, @Max = 59
    ELSE IF @PartName = 'HOUR' SELECT @Min = 0, @Max = 23
    ELSE IF @PartName = 'DAY' SELECT @Min = 1, @Max = 31
    ELSE IF @PartName = 'MONTH' SELECT @Min = 1, @Max = 12
    ELSE IF @PartName = 'WEEKDAY' SELECT @Min = 1, @Max = 7
    
    DECLARE @i int = @Start;
    WHILE @i <= @Max 
    BEGIN
        IF @i = @Value RETURN 1;
            
        SET @i += @Step;
    END

    RETURN 0
END
