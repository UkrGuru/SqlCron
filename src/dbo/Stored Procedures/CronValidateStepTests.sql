-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER PROCEDURE [dbo].[CronValidateStepTests] 
AS
DECLARE @Tests TABLE (Expression varchar(100), Value int, Min int, Max int, Expected tinyint)
DECLARE @Min int, @Max int;

-- minute tests
SELECT @Min = 0, @Max = 59	

INSERT @Tests VALUES ('0', 0, @Min, @Max, 0)

INSERT @Tests VALUES ('*/2', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('*/2', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('*/2', 1, @Min, @Max, 0)
INSERT @Tests VALUES ('*/2', 2, @Min, @Max, 1)
INSERT @Tests VALUES ('*/2', 3, @Min, @Max, 0)
INSERT @Tests VALUES ('*/2', 4, @Min, @Max, 1)

INSERT @Tests VALUES ('58/2', 56, @Min, @Max, 0)
INSERT @Tests VALUES ('58/2', 57, @Min, @Max, 0)
INSERT @Tests VALUES ('58/2', 58, @Min, @Max, 1)
INSERT @Tests VALUES ('58/2', 59, @Min, @Max, 0)
INSERT @Tests VALUES ('58/2', 60, @Min, @Max, 0)
INSERT @Tests VALUES ('58/2', 0, @Min, @Max, 0)
INSERT @Tests VALUES ('58/2', 2, @Min, @Max, 0)

INSERT @Tests VALUES ('0/59', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('0/59', 59, @Min, @Max, 1)

-- hour tests
SELECT @Min = 0, @Max = 23	
INSERT @Tests VALUES ('0/23', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('0/23', 23, @Min, @Max, 1)
INSERT @Tests VALUES ('0/24', 24, @Min, @Max, 0)

-- day tests
SELECT @Min = 1, @Max = 31	
INSERT @Tests VALUES ('1/30',  1, @Min, @Max, 1)
INSERT @Tests VALUES ('1/30', 31, @Min, @Max, 1)
INSERT @Tests VALUES ('1/31', 32, @Min, @Max, 0)

-- month tests
SELECT @Min = 1, @Max = 12	
INSERT @Tests VALUES ('1/11',  1, @Min, @Max, 1)
INSERT @Tests VALUES ('1/11', 12, @Min, @Max, 1)
INSERT @Tests VALUES ('1/12', 13, @Min, @Max, 0)

-- weekday tests
SELECT @Min = 1, @Max = 7	
INSERT @Tests VALUES ('1/6', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('1/6', 7, @Min, @Max, 1)
INSERT @Tests VALUES ('1/7', 8, @Min, @Max, 0)

SELECT * FROM (
	SELECT Expected, dbo.CronValidateStep(Expression, Value, Min, Max) Actual,
		Expression + '_' + CAST(Value as varchar) + '_' + CAST(Min as varchar) + '_' + CAST(Max as varchar) Func
	FROM @Tests
) T
WHERE ISNULL(Expected, 255) != ISNULL(Actual, 255)