-- Manually create the "test" database and "test" schema

-- check table exists or not
DROP TABLE IF EXISTS test.students;
-- create table with two columns
CREATE TABLE test.students (
	student_name VARCHAR(50),
	student_account VARCHAR(50),
	score1 INT,
	score2 INT,
	score3 INT
);

-- ref: https://www.postgresql.org/docs/current/indexes-types.html
-- create index on student_name
CREATE INDEX student_name_1 ON test.students USING btree (student_name varchar_pattern_ops);
CREATE INDEX score1_1 ON test.students USING btree (score1 ASC);

-- use while loop to generate fake date
DO $$
DECLARE 
	counter INTEGER := 0;
BEGIN
   WHILE counter < 10000000 LOOP
      INSERT INTO test.students VALUES(
		  'ABC' || MOD(counter, 10000),
		  'ABC' || MOD(counter, 10000),
		  floor(MOD(counter, 100)),
		  floor(MOD(counter, 100)),
		  floor(random() * 100)
	   );
	   IF counter%1000000 = 0 THEN
	   RAISE NOTICE 'counter %', counter;
	   END IF;
   counter := counter + 1;
   END LOOP;
END$$;

-- check the table & index size again
SELECT
	pg_size_pretty (pg_table_size('test.students')) as pg_table_size,
	pg_size_pretty (pg_indexes_size('test.students')) as indexs,
	pg_size_pretty (pg_total_relation_size('test.students')) as total;


-- read compare
-- Operator: =
select *
from test.students f1
where f1.student_account = 'ABC0';

select *
from test.students f1
where f1.student_name = 'ABC0';

-- Operator: like
select *
from test.students f1
where f1.student_account like 'ABC0%';

select *
from test.students f1
where f1.student_name like 'ABC0%';

select *
from test.students f1
where f1.student_account like '%0';

select *
from test.students f1
where f1.student_name like '%0'; -- not work

-- Operator: between
select *
from test.students f1
where f1.score2 between 0 and 10;

select *
from test.students f1
where f1.score1 between 0 and 10; -- work, but not improve performance in this case

-- Operator: in
select *
from test.students f1
where f1.student_account in ('ABC0', 'ABC1', 'ABC2');

select *
from test.students f1
where f1.student_name in ('ABC0', 'ABC1', 'ABC2');

-- update compare
-- ref: https://docs.postgresql.tw/reference/sql-commands/reindex
UPDATE test.students
SET score3 = 100
WHERE student_account = 'ABC10';

UPDATE test.students
SET score3 = 100
WHERE student_name = 'ABC10'; -- work


-- delete compare
DELETE FROM test.students
WHERE student_account = 'ABC11';

DELETE FROM test.students
WHERE student_name = 'ABC12';
