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

-- before we create index, check the table & index size first
SELECT
	pg_size_pretty (pg_table_size('test.students')) as pg_table_size,
	pg_size_pretty (pg_indexes_size('test.students')) as indexs,
	pg_size_pretty (pg_total_relation_size('test.students')) as total;