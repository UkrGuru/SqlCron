-- =============================================
-- Author:		Oleksandr Viktor (UkrGuru)
-- Create date: 2021-12-05
-- Samples:
-- SELECT dbo.[CronValidatePart]('MINUTE', '*', 0)
-- SELECT dbo.[CronValidatePart]('MINUTE', '0', 0)
-- SELECT dbo.[CronValidatePart]('MINUTE', '0', 5)

-- SELECT dbo.[CronValidatePart]('MINUTE', '0,5', 0)
-- SELECT dbo.[CronValidatePart]('MINUTE', '0,5', 5)
-- SELECT dbo.[CronValidatePart]('MINUTE', '0,5', 6)

-- SELECT dbo.[CronValidatePart]('MINUTE', '0/5', 0)
-- SELECT dbo.[CronValidatePart]('MINUTE', '0/5', 5)
-- SELECT dbo.[CronValidatePart]('MINUTE', '0/5', 6)

-- SELECT dbo.[CronValidatePart]('MINUTE', '0-5', 0)
-- SELECT dbo.[CronValidatePart]('MINUTE', '0-5', 5)
-- SELECT dbo.[CronValidatePart]('MINUTE', '0-5', 6)
-- =============================================
CREATE FUNCTION [dbo].[CronValidatePart](@Name varchar(10), @Expression varchar(100), @Value int)
RETURNS tinyint
AS
BEGIN
    IF CHARINDEX(',', @Expression, 0) > 0 BEGIN
        RETURN (SELECT MAX(dbo.CronValidatePart(@Name, value, @Value)) 
            FROM STRING_SPLIT(@Expression, ',') 
            WHERE LEN(value) > 0);
    END

    DECLARE @Min int, @Max int

    IF @Name = 'MINUTE' SELECT @Min = 0 , @Max = 59
    ELSE IF @Name = 'HOUR' SELECT @Min = 0 , @Max = 23
    ELSE IF @Name = 'DAY' SELECT @Min = 1 , @Max = 31
    ELSE IF @Name = 'MONTH' SELECT @Min = 1 , @Max = 12
    ELSE IF @Name = 'WEEKDAY' SELECT @Min = 0 , @Max = 6
        
    IF NOT @Value BETWEEN @Min AND @Max RETURN 0

    IF @Expression = '*' 
        RETURN 1

    ELSE IF CHARINDEX('-', @Expression, 0) > 0 
        RETURN dbo.CronValidateRange(@Name, @Expression, @Value, @Min, @Max)

    ELSE IF CHARINDEX('/', @Expression, 0) > 0 
        RETURN dbo.CronValidateStep(@Name, @Expression, @Value, @Min, @Max)

    ELSE IF TRY_CAST(@Expression as int) = @Value 
        RETURN 1

    RETURN 0
END
