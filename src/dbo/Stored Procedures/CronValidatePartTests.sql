-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER PROCEDURE [dbo].[CronValidatePartTests] 
AS
DECLARE @Tests TABLE (Expression varchar(100), Value int, Min int, Max int, Expected tinyint)
DECLARE @Min int, @Max int;

-- minute tests
SELECT @Min = 0, @Max = 59	

INSERT @Tests VALUES ('-1', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('60', 60, @Min, @Max, 0)

INSERT @Tests VALUES ('*',	   0, @Min, @Max, 1)
INSERT @Tests VALUES ('0',	   0, @Min, @Max, 1)
INSERT @Tests VALUES ('1',	   1, @Min, @Max, 1)
INSERT @Tests VALUES ('2',	   2, @Min, @Max, 1)
INSERT @Tests VALUES ('3',	   3, @Min, @Max, 1)
INSERT @Tests VALUES ('4',	   4, @Min, @Max, 1)
INSERT @Tests VALUES ('5',	   5, @Min, @Max, 1)
INSERT @Tests VALUES ('6',	   6, @Min, @Max, 1)
INSERT @Tests VALUES ('7',	   7, @Min, @Max, 1)
INSERT @Tests VALUES ('8',	   8, @Min, @Max, 1)
INSERT @Tests VALUES ('9',	   9, @Min, @Max, 1)
INSERT @Tests VALUES ('10',	   10, @Min, @Max, 1)

INSERT @Tests VALUES ('0,1',   -1, @Min, @Max, 0)
INSERT @Tests VALUES ('0,1',   0, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1',   1, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1',   2, @Min, @Max, 0)

INSERT @Tests VALUES ('0,1-2', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('0,1-2', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1-2', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1-2', 2, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1-2', 3, @Min, @Max, 0)
INSERT @Tests VALUES ('1-2,0', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('1-2,0', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('1-2,0', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('1-2,0', 2, @Min, @Max, 1)
INSERT @Tests VALUES ('1-2,0', 3, @Min, @Max, 0)

INSERT @Tests VALUES ('0,1/2', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('0,1/2', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1/2', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1/2', 2, @Min, @Max, 0)
INSERT @Tests VALUES ('0,1/2', 3, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1/2', 4, @Min, @Max, 0)
INSERT @Tests VALUES ('1/2,0', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('1/2,0', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('1/2,0', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('1/2,0', 2, @Min, @Max, 0)
INSERT @Tests VALUES ('1/2,0', 3, @Min, @Max, 1)
INSERT @Tests VALUES ('1/2,0', 4, @Min, @Max, 0)

INSERT @Tests VALUES ('0,1-4/2', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('0,1-4/2', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1-4/2', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1-4/2', 2, @Min, @Max, 0)
INSERT @Tests VALUES ('0,1-4/2', 3, @Min, @Max, 1)
INSERT @Tests VALUES ('0,1-4/2', 4, @Min, @Max, 0)
INSERT @Tests VALUES ('1-4/2,0', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('1-4/2,0', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('1-4/2,0', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('1-4/2,0', 2, @Min, @Max, 0)
INSERT @Tests VALUES ('1-4/2,0', 3, @Min, @Max, 1)
INSERT @Tests VALUES ('1-4/2,0', 4, @Min, @Max, 0)

INSERT @Tests VALUES ('1/2,1-2', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('1/2,1-2', 0, @Min, @Max, 0)
INSERT @Tests VALUES ('1/2,1-2', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('1/2,1-2', 2, @Min, @Max, 1)
INSERT @Tests VALUES ('1/2,1-2', 3, @Min, @Max, 1)
INSERT @Tests VALUES ('1/2,1-2', 4, @Min, @Max, 0)
INSERT @Tests VALUES ('1-2,1/2', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('1-2,1/2', 0, @Min, @Max, 0)
INSERT @Tests VALUES ('1-2,1/2', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('1-2,1/2', 2, @Min, @Max, 1)
INSERT @Tests VALUES ('1-2,1/2', 3, @Min, @Max, 1)
INSERT @Tests VALUES ('1-2,1/2', 4, @Min, @Max, 0)

INSERT @Tests VALUES ('1/3,1/4', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('1/3,1/4', 0, @Min, @Max, 0)
INSERT @Tests VALUES ('1/3,1/4', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('1/3,1/4', 2, @Min, @Max, 0)
INSERT @Tests VALUES ('1/3,1/4', 3, @Min, @Max, 0)
INSERT @Tests VALUES ('1/3,1/4', 4, @Min, @Max, 1)
INSERT @Tests VALUES ('1/3,1/4', 5, @Min, @Max, 1)
INSERT @Tests VALUES ('1/3,1/4', 6, @Min, @Max, 0)
INSERT @Tests VALUES ('1/3,1/4', 7, @Min, @Max, 1)

-- hour tests
SELECT @Min = 0, @Max = 23	
INSERT @Tests VALUES ('-1', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('24', 24, @Min, @Max, 0)

-- day tests
SELECT @Min = 1, @Max = 31	
INSERT @Tests VALUES ('0',  0, @Min, @Max, 0)
INSERT @Tests VALUES ('32', 32, @Min, @Max, 0)

-- month tests
SELECT @Min = 1, @Max = 12	
INSERT @Tests VALUES ('0',  0, @Min, @Max, 0)
INSERT @Tests VALUES ('13', 13, @Min, @Max, 0)

-- weekday tests
SELECT @Min = 1, @Max = 7	
INSERT @Tests VALUES ('0', 0, @Min, @Max, 0)
INSERT @Tests VALUES ('8', 8, @Min, @Max, 0)

SELECT * FROM (
	SELECT Expected, dbo.CronValidatePart(Expression, Value, Min, Max) Actual,
		Expression + '_' + CAST(Value as varchar) + '_' + CAST(Min as varchar) + '_' + CAST(Max as varchar) Func
	FROM @Tests
) T
WHERE ISNULL(Expected, 255) != ISNULL(Actual, 255)