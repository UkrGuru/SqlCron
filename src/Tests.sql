--EXEC [dbo].[CronWeekDayTests]
EXEC [dbo].[CronValidatePartTests]
EXEC [dbo].[CronValidateRangeTests] 
EXEC [dbo].[CronValidateStepTests] 
EXEC [dbo].[CronValidateTests]

/*
SELECT * FROM dbo.CronTest('5 6-22/1 * * *', '2022-06-28')
*/
ALTER   FUNCTION [CronTest] (@Expression varchar(100), @Today smalldatetime)
RETURNS @Times TABLE (dt smalldatetime) 
AS
BEGIN
	DECLARE @Now smalldatetime = @Today;

	WHILE @Now < @Today + 1
	BEGIN
		IF dbo.CronValidate(@Expression, @Now) = 1 
			INSERT INTO @Times (dt) VALUES (@Now)

		SET @Now = DATEADD(MI, 1, @Now);
	END
	
	RETURN
END
