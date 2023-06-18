DROP TABLE IF EXISTS test.students_without_pk;
-- create table with two columns
CREATE TABLE test.students_without_pk (
	student_account VARCHAR(50),
	student_name VARCHAR(50),
	score1 INT,
	score2 INT,
	score3 INT
);

DO $$
DECLARE 
	counter INTEGER := 0;
BEGIN
   WHILE counter < 1000 LOOP
      INSERT INTO test.students_without_pk VALUES(
		  'ABC' || MOD(counter, 1000),
		  'ABC' || MOD(counter, 1000),
		  floor(MOD(counter, 100)),
		  floor(MOD(counter, 100)),
		  floor(random() * 100)
	   );
	   IF counter%100 = 0 THEN
	   RAISE NOTICE 'counter %', counter;
	   END IF;
   counter := counter + 1;
   END LOOP;
END$$;

SELECT
	pg_size_pretty (pg_table_size('test.students_without_pk')) as pg_table_size,
	pg_size_pretty (pg_indexes_size('test.students_without_pk')) as indexs,
	pg_size_pretty (pg_total_relation_size('test.students_without_pk')) as total;