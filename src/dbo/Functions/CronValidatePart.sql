-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE FUNCTION [dbo].[CronValidatePart](@Name varchar(10), @Expression varchar(100), @Value int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE '%[^0-9*,-/]%' RETURN 0

    IF CHARINDEX(',', @Expression, 0) > 0 BEGIN
        RETURN (SELECT MAX(dbo.CronValidatePart(@Name, value, @Value)) 
            FROM STRING_SPLIT(@Expression, ',') 
            WHERE LEN(value) > 0);
    END

    IF @Expression = '*' RETURN 1

    IF CHARINDEX('-', @Expression, 0) > 0 
        RETURN dbo.CronValidateRange(@Name, @Expression, @Value)

    ELSE IF CHARINDEX('/', @Expression, 0) > 0 
        RETURN dbo.CronValidateStep(@Name, @Expression, @Value)

    ELSE IF TRY_CAST(@Expression as int) = @Value 
        RETURN 1

    RETURN 0
END
