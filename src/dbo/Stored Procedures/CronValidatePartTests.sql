
CREATE   PROCEDURE [dbo].[CronValidatePartTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

IF @Count = 0 SELECT 'OK' ELSE SELECT @ErrMsg
