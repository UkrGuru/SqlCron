-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE PROCEDURE [dbo].[CronValidateTests] 
AS
DECLARE @Tests TABLE (Expression varchar(100), Value datetime, Expected tinyint)

-- minute tests
INSERT @Tests VALUES ('* * * * *', '2022-01-01 00:00:00', 1)
INSERT @Tests VALUES ('0 * * * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('1 * * * *', '2021-11-01 00:01:00', 1)

INSERT @Tests VALUES ('0,1 * * * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('0,1 * * * *', '2021-11-01 00:01:00', 1)
INSERT @Tests VALUES ('0,1 * * * *', '2021-11-01 00:02:00', 0)

INSERT @Tests VALUES ('0,1-2 * * * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('0,1-2 * * * *', '2021-11-01 00:01:00', 1)
INSERT @Tests VALUES ('0,1-2 * * * *', '2021-11-01 00:02:00', 1)
INSERT @Tests VALUES ('0,1-2 * * * *', '2021-11-01 00:03:00', 0)

INSERT @Tests VALUES ('0,1/2 * * * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('0,1/2 * * * *', '2021-11-01 00:01:00', 1)
INSERT @Tests VALUES ('0,1/2 * * * *', '2021-11-01 00:02:00', 0)
INSERT @Tests VALUES ('0,1/2 * * * *', '2021-11-01 00:03:00', 1)

-- hour tests
INSERT @Tests VALUES ('* 1 * * *', '2021-11-01 01:00:00', 1)

INSERT @Tests VALUES ('* 0,1 * * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* 0,1 * * *', '2021-11-01 01:01:00', 1)
INSERT @Tests VALUES ('* 0,1 * * *', '2021-11-01 02:02:00', 0)

INSERT @Tests VALUES ('* 0,1-2 * * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* 0,1-2 * * *', '2021-11-01 01:01:00', 1)
INSERT @Tests VALUES ('* 0,1-2 * * *', '2021-11-01 02:02:00', 1)
INSERT @Tests VALUES ('* 0,1-2 * * *', '2021-11-01 03:03:00', 0)

INSERT @Tests VALUES ('* 0,1/2 * * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* 0,1/2 * * *', '2021-11-01 01:01:00', 1)
INSERT @Tests VALUES ('* 0,1/2 * * *', '2021-11-01 02:02:00', 0)
INSERT @Tests VALUES ('* 0,1/2 * * *', '2021-11-01 03:03:00', 1)

-- day tests
INSERT @Tests VALUES ('* * 1 * *', '2021-11-01 00:00:00', 1)

INSERT @Tests VALUES ('* * 1,2 * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * 1,2 * *', '2021-11-02 00:00:00', 1)
INSERT @Tests VALUES ('* * 1,2 * *', '2021-11-03 00:00:00', 0)

INSERT @Tests VALUES ('* * 1,2-3 * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * 1,2-3 * *', '2021-11-02 00:00:00', 1)
INSERT @Tests VALUES ('* * 1,2-3 * *', '2021-11-03 00:00:00', 1)
INSERT @Tests VALUES ('* * 1,2-3 * *', '2021-11-04 00:00:00', 0)

INSERT @Tests VALUES ('* * 1,2/3 * *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * 1,2/3 * *', '2021-11-02 00:00:00', 1)
INSERT @Tests VALUES ('* * 1,2/3 * *', '2021-11-03 00:00:00', 0)
INSERT @Tests VALUES ('* * 1,2/3 * *', '2021-11-04 00:00:00', 0)
INSERT @Tests VALUES ('* * 1,2/3 * *', '2021-11-05 00:00:00', 1)

-- month tests
INSERT @Tests VALUES ('* * * 1 *', '2021-01-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * jan *', '2021-01-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * Jan *', '2021-01-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * JAN *', '2021-01-01 00:00:00', 1)

INSERT @Tests VALUES ('* * * JAN *', '2021-01-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * FEB *', '2021-02-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * MAR *', '2021-03-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * APR *', '2021-04-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * MAY *', '2021-05-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * JUN *', '2021-06-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * JUL *', '2021-07-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * AUG *', '2021-08-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * SEP *', '2021-09-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * OCT *', '2021-10-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * NOV *', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * DEC *', '2021-12-01 00:00:00', 1)

INSERT @Tests VALUES ('* * * 1,2 *', '2021-01-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * 1,2 *', '2021-02-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * 1,2 *', '2021-03-01 00:00:00', 0)

INSERT @Tests VALUES ('* * * 1,2-3 *', '2021-01-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * 1,2-3 *', '2021-02-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * 1,2-3 *', '2021-03-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * 1,2-3 *', '2021-04-01 00:00:00', 0)

INSERT @Tests VALUES ('* * * 1,2/3 *', '2021-01-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * 1,2/3 *', '2021-02-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * 1,2/3 *', '2021-03-01 00:00:00', 0)
INSERT @Tests VALUES ('* * * 1,2/3 *', '2021-04-01 00:00:00', 0)
INSERT @Tests VALUES ('* * * 1,2/3 *', '2021-05-01 00:00:00', 1)

-- weekday tests
INSERT @Tests VALUES ('* * * * 1', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * * mon', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * * Mon', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * * MON', '2021-11-01 00:00:00', 1)

INSERT @Tests VALUES ('* * * * SUN', '2021-10-31 00:00:00', 1)
INSERT @Tests VALUES ('* * * * MON', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * * TUE', '2021-11-02 00:00:00', 1)
INSERT @Tests VALUES ('* * * * WED', '2021-11-03 00:00:00', 1)
INSERT @Tests VALUES ('* * * * THU', '2021-11-04 00:00:00', 1)
INSERT @Tests VALUES ('* * * * FRI', '2021-11-05 00:00:00', 1)
INSERT @Tests VALUES ('* * * * SAT', '2021-11-06 00:00:00', 1)

INSERT @Tests VALUES ('* * * * 0,1', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * * 0,1', '2021-11-02 00:00:00', 0)
INSERT @Tests VALUES ('* * * * SUN,MON', '2021-10-31 00:00:00', 1)

INSERT @Tests VALUES ('* * * * SUN,MON-TUE', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * * 0,1-2', '2021-11-02 00:00:00', 1)
INSERT @Tests VALUES ('* * * * 0,1-2', '2021-11-03 00:00:00', 0)
INSERT @Tests VALUES ('* * * * 0,1-2', '2021-11-04 00:00:00', 0)

INSERT @Tests VALUES ('* * * * SUN,MON/3', '2021-11-01 00:00:00', 1)
INSERT @Tests VALUES ('* * * * 0,1/2', '2021-11-02 00:00:00', 0)
INSERT @Tests VALUES ('* * * * 0,1/2', '2021-11-03 00:00:00', 1)
INSERT @Tests VALUES ('* * * * 0,1/2', '2021-11-04 00:00:00', 0)
INSERT @Tests VALUES ('* * * * 0,1/2', '2021-11-05 00:00:00', 1)

SELECT * FROM (
	SELECT Expected, dbo.CronValidate(Expression, Value) Actual,
		Expression + '_' + CAST(Value as varchar(20)) Func
	FROM @Tests
) T
WHERE ISNULL(Expected, -1) != ISNULL(Actual, -1)