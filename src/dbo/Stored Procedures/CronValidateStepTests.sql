
CREATE   PROCEDURE [dbo].[CronValidateStepTests] 
AS
DECLARE @Count int = 0; 

SET @Count += dbo.CronValidate('* * * * *', '2020-01-01 00:00:00')

IF @Count = 1 SELECT 'OK'
