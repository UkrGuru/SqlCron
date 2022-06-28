-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE FUNCTION [dbo].[CronValidatePart](@Expression varchar(100), @Value int, @Min int, @Max int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE '%[^0-9*,/-]%' RETURN 0
    IF @Value IS NULL OR @Min IS NULL OR @Max IS NULL OR NOT @Value BETWEEN @Min AND @Max RETURN 0  

    IF @Expression = '*' RETURN 1

    IF CHARINDEX(',', @Expression, 0) > 0 BEGIN
        RETURN (SELECT MAX(dbo.CronValidatePart(value, @Value, @Min, @Max)) 
            FROM STRING_SPLIT(@Expression, ',') 
            WHERE LEN(value) > 0);
    END

    IF CHARINDEX('-', @Expression, 0) > 0 
        RETURN dbo.CronValidateRange(@Expression, @Value, @Min, @Max)

    ELSE IF CHARINDEX('/', @Expression, 0) > 0 
        RETURN dbo.CronValidateStep(@Expression, @Value, @Min, @Max)

    ELSE IF TRY_CAST(@Expression as int) = @Value 
        RETURN 1

    RETURN 0
END
