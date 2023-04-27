-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER PROCEDURE [dbo].[CronWordTests]
AS
DECLARE @Tests TABLE (Expression varchar(100), Separator char(1), [Index] int, Expected varchar(100))
-- asd

INSERT @Tests VALUES (NULL, ' ', 0, NULL)
INSERT @Tests VALUES (NULL, ' ', 1, NULL)

INSERT @Tests VALUES ('', ' ', 0, NULL)
INSERT @Tests VALUES ('', ' ', 1, NULL)

INSERT @Tests VALUES ('1', NULL, NULL, NULL)
INSERT @Tests VALUES ('1', NULL, 0, NULL)
INSERT @Tests VALUES ('1', NULL, 1, '1')
INSERT @Tests VALUES ('1', NULL, 2, NULL)
INSERT @Tests VALUES ('1', ' ', NULL, NULL)

INSERT @Tests VALUES ('1', ' ', 0, NULL)
INSERT @Tests VALUES ('1', ' ', 1, '1')
INSERT @Tests VALUES ('1', ' ', 2, NULL)

INSERT @Tests VALUES ('1 2', ' ', 0, NULL)
INSERT @Tests VALUES ('1 2', ' ', 1, '1')
INSERT @Tests VALUES ('1 2', ' ', 2, '2')
INSERT @Tests VALUES ('1 2', ' ', 3, NULL)

INSERT @Tests VALUES ('1 2 3', ' ', 0, NULL)
INSERT @Tests VALUES ('1 2 3', ' ', 1, '1')
INSERT @Tests VALUES ('1 2 3', ' ', 2, '2')
INSERT @Tests VALUES ('1 2 3', ' ', 3, '3')
INSERT @Tests VALUES ('1 2 3', ' ', 4, NULL)

INSERT @Tests VALUES ('1 2 3 4', ' ', 0, NULL)
INSERT @Tests VALUES ('1 2 3 4', ' ', 1, '1')
INSERT @Tests VALUES ('1 2 3 4', ' ', 2, '2')
INSERT @Tests VALUES ('1 2 3 4', ' ', 3, '3')
INSERT @Tests VALUES ('1 2 3 4', ' ', 4, '4')
INSERT @Tests VALUES ('1 2 3 4', ' ', 5, NULL)

INSERT @Tests VALUES ('1 2 3 4 5', ' ', 0, NULL)
INSERT @Tests VALUES ('1 2 3 4 5', ' ', 1, '1')
INSERT @Tests VALUES ('1 2 3 4 5', ' ', 2, '2')
INSERT @Tests VALUES ('1 2 3 4 5', ' ', 3, '3')
INSERT @Tests VALUES ('1 2 3 4 5', ' ', 4, '4')
INSERT @Tests VALUES ('1 2 3 4 5', ' ', 5, '5')
INSERT @Tests VALUES ('1 2 3 4 5', ' ', 6, NULL)

SELECT * FROM (
	SELECT Expected, dbo.CronWord(Expression, ISNULL(Separator, ' '), [Index]) Actual,
		Expression + '_' + ISNULL(Separator, ' ') + '_' + ISNULL(CAST([Index] AS varchar), '') Func
	FROM @Tests
) T
WHERE ISNULL(Expected, 'X') != ISNULL(Actual, 'X')
