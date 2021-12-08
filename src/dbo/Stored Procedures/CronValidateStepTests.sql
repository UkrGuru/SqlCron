
CREATE PROCEDURE [dbo].[CronValidateStepTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

--IF dbo.CronValidateStep('MINUTE', '57-5/3', 0, 59) = 1 SET @Count += 1 ELSE SET @ErrMsg = '* * * * * 00:00';

IF @Count = 0 SELECT 'OK' ELSE SELECT CAST(@Count as varchar)
