-- =============================================
-- Author: Oleksandr Viktor (UkrGuru)
-- =============================================
CREATE FUNCTION [dbo].[CronWord](@Expression varchar(100), @Separator char(1) = ' ', @Index int)
RETURNS varchar(100)
AS
BEGIN
    DECLARE @i int = 0, @v varchar(100);

    SELECT @i = @i + 1, @v = CASE WHEN @i <= @Index THEN value ELSE @v END   
    FROM STRING_SPLIT(@Expression, @Separator)
    WHERE LEN(value) > 0

    RETURN CASE WHEN @i < @Index THEN NULL ELSE @v END
END

