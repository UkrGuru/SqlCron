-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER PROCEDURE [dbo].[CronValidateRangeTests] 
AS
DECLARE @Tests TABLE (Expression varchar(100), Value int, Min int, Max int, Expected tinyint)
DECLARE @Min int, @Max int; -- asd

-- minute tests
SELECT @Min = 0, @Max = 59	

INSERT @Tests VALUES ('0', 0, @Min, @Max, 0)

INSERT @Tests VALUES ('0-1', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('0-1', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('0-1', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('0-1', 2, @Min, @Max, 0)

INSERT @Tests VALUES ('0-2', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('0-2', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('0-2', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('0-2', 2, @Min, @Max, 1)
INSERT @Tests VALUES ('0-2', 3, @Min, @Max, 0)

INSERT @Tests VALUES ('59-0', 58, @Min, @Max, 0)
INSERT @Tests VALUES ('59-0', 59, @Min, @Max, 1)
INSERT @Tests VALUES ('59-0', 60, @Min, @Max, 0)
INSERT @Tests VALUES ('59-0', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('59-0', 1, @Min, @Max, 0)

INSERT @Tests VALUES ('58-1', 57, @Min, @Max, 0)
INSERT @Tests VALUES ('58-1', 58, @Min, @Max, 1)
INSERT @Tests VALUES ('58-1', 59, @Min, @Max, 1)
INSERT @Tests VALUES ('58-1', 60, @Min, @Max, 0)
INSERT @Tests VALUES ('58-1', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('58-1', 1, @Min, @Max, 1)
INSERT @Tests VALUES ('58-1', 2, @Min, @Max, 0)

INSERT @Tests VALUES ('0-15/5', -5, @Min, @Max, 0)
INSERT @Tests VALUES ('0-15/5', -1, @Min, @Max, 0)
INSERT @Tests VALUES ('0-15/5', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('0-15/5', 1, @Min, @Max, 0)
INSERT @Tests VALUES ('0-15/5', 2, @Min, @Max, 0)
INSERT @Tests VALUES ('0-15/5', 3, @Min, @Max, 0)
INSERT @Tests VALUES ('0-15/5', 4, @Min, @Max, 0)
INSERT @Tests VALUES ('0-15/5', 5, @Min, @Max, 1)
INSERT @Tests VALUES ('0-15/5', 10, @Min, @Max, 1)
INSERT @Tests VALUES ('0-15/5', 15, @Min, @Max, 1)
INSERT @Tests VALUES ('0-15/5', 16, @Min, @Max, 0)
INSERT @Tests VALUES ('0-15/5', 20, @Min, @Max, 0)

INSERT @Tests VALUES ('58-1/2', 57, @Min, @Max, 0)
INSERT @Tests VALUES ('58-1/2', 58, @Min, @Max, 1)
INSERT @Tests VALUES ('58-1/2', 59, @Min, @Max, 0)
INSERT @Tests VALUES ('58-1/2', 60, @Min, @Max, 0)
INSERT @Tests VALUES ('58-1/2', 0, @Min, @Max, 1)
INSERT @Tests VALUES ('58-1/2', 1, @Min, @Max, 0)
INSERT @Tests VALUES ('58-1/2', 2, @Min, @Max, 0)

SELECT * FROM (
	SELECT Expected, dbo.CronValidateRange(Expression, Value, Min, Max) Actual,
		Expression + '_' + CAST(Value as varchar) + '_' + CAST(Min as varchar) + '_' + CAST(Max as varchar) Func
	FROM @Tests
) T
WHERE ISNULL(Expected, 255) != ISNULL(Actual, 255)