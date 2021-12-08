
CREATE   PROCEDURE [dbo].[CronValidateTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

IF dbo.CronValidate('* * * * *', '00:00') = 1 SET @Count += 1 ELSE SET @ErrMsg = '* * * * * 00:00';
IF dbo.CronValidate('0 * * * *', '00:00') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0 * * * * 00:00';
IF dbo.CronValidate('0,5 * * * *', '00:05') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0,5 * * * * 00:05';
IF dbo.CronValidate('0/5 * * * *', '00:05') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0/5 * * * * 00:05';
IF dbo.CronValidate('5-10 * * * *', '00:05') = 1 SET @Count += 1 ELSE SET @ErrMsg = '5-10 * * * * 00:05';

IF dbo.CronValidate('0,5/5 * * * *', '00:10') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0,5/5 * * * * 00:10';
IF dbo.CronValidate('0,5-10 * * * *', '00:10') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0,5-10 * * * * 00:10';
IF dbo.CronValidate('0,20-22 * * * *', '00:20') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0,20-22 * * * * 00:20';
IF dbo.CronValidate('55-5,10 * * * *', '00:10') = 1 SET @Count += 1 ELSE SET @ErrMsg = '55-5,10 * * * * 00:10';
IF dbo.CronValidate('57-5/3 * * * *', '00:03') = 1 SET @Count += 1 ELSE SET @ErrMsg = '57-5/3 * * * * 00:03';

IF @Count = 10 SELECT 'OK' ELSE SELECT @ErrMsg