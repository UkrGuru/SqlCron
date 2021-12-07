
CREATE   PROCEDURE [dbo].[CronValidateRangeTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

IF dbo.CronValidateRange('MINUTE', '57-5/3', 57) = 1 SET @Count += 1 ELSE SET @ErrMsg = 'MINUTE_57-5/3_0_57';

IF @Count = 1 SELECT 'OK' ELSE SELECT CAST(@Count as varchar)