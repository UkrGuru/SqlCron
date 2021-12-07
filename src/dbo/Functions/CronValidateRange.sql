-- =============================================
-- Author: Oleksandr Viktor (UkrGuru)
-- =============================================
CREATE FUNCTION [dbo].[CronValidateRange](@PartName varchar(10), @Expression varchar(100), @Value int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE '%[^0-9-/]%' OR @Value IS NULL RETURN 0

    DECLARE @Min int, @Max int;
    IF @PartName = 'MINUTE' SELECT @Min = 0, @Max = 59
    ELSE IF @PartName = 'HOUR' SELECT @Min = 0, @Max = 23
    ELSE IF @PartName = 'DAY' SELECT @Min = 1, @Max = 31
    ELSE IF @PartName = 'MONTH' SELECT @Min = 1, @Max = 12
    ELSE IF @PartName = 'WEEKDAY' SELECT @Min = 1, @Max = 7

    DECLARE @Begin int, @End int, @Step int

    IF CHARINDEX('/', @Expression, 0) > 0 BEGIN
        SET @Step = TRY_CAST(dbo.CronWord(@Expression, '/', 2) as int);
        IF ISNULL(@Step, 0) <= 0 RETURN 0;

        SET @Expression = dbo.CronWord(@Expression, '/', 1);
    END

    SET @Begin = TRY_CAST(dbo.CronWord(@Expression, '-', 1) as int);
    SET @End = TRY_CAST(dbo.CronWord(@Expression, '-', 2) as int);

    IF @Begin IS NULL OR @End IS NULL RETURN 0;

    DECLARE @i int = @Begin, @OneMore int = CASE WHEN @End < @Begin THEN 1 ELSE 0 END 
       
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
