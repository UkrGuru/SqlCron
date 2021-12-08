-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE   PROCEDURE [dbo].[CronValidateTests] 
AS
DECLARE @Count int = 0, @ErrMsg varchar(100);

--IF dbo.CronValidate('0 * * * *', '2021-11-01 00:00:00') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0 * * * * 2021-11-01 00:00:00';
--IF dbo.CronValidate('0 0 * * *', '2021-11-01 00:00:00') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0 0 * * * 2021-11-01 00:00:00';
--IF dbo.CronValidate('0 0 1 * *', '2021-11-01 00:00:00') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0 0 1 * * 2021-11-01 00:00:00';
--IF dbo.CronValidate('0 0 1 1 *', '2021-11-01 00:00:00') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0 0 1 1 * 2021-11-01 00:00:00';
--IF dbo.CronValidate('0 0 1 11 1', '2021-11-01 00:00:00') = 1 SET @Count += 1 ELSE SET @ErrMsg = '0 0 1 1 1 2021-11-01 00:00:00';

IF @Count = 0 SELECT 'OK' ELSE SELECT @ErrMsg


-- 0 0/5 14,18,3-39,52 ? JAN,MAR,SEP MON-FRI