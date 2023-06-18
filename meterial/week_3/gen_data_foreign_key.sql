select *
from test.students_with_pk f1
limit 10;

DROP TABLE IF EXISTS test.students_attend;
-- create table with two columns
CREATE TABLE test.students_attend (
	id SERIAL PRIMARY KEY,
	student_account VARCHAR(50),
	attend_date DATE
);

INSERT INTO test.students_attend (student_account, attend_date) VALUES(
  'ABC0', DATE '2023-06-18'
);
INSERT INTO test.students_attend (student_account, attend_date) VALUES(
  'ABC1', DATE '2023-06-18'
);
INSERT INTO test.students_attend (student_account, attend_date) VALUES(
  'ABC2', DATE '2023-06-18'
);
INSERT INTO test.students_attend (student_account, attend_date) VALUES(
  'ABC3', DATE '2023-06-18'
);

select *
from test.students_attend;

SELECT
	pg_size_pretty (pg_table_size('test.students_attend')) as pg_table_size,
	pg_size_pretty (pg_indexes_size('test.students_attend')) as indexs,
	pg_size_pretty (pg_total_relation_size('test.students_attend')) as total;
	
ALTER TABLE test.students_attend
ADD CONSTRAINT fk_student_account
FOREIGN KEY (student_account)
REFERENCES test.students_with_pk (student_account);


SELECT
	pg_size_pretty (pg_table_size('test.students_attend')) as pg_table_size,
	pg_size_pretty (pg_indexes_size('test.students_attend')) as indexs,
	pg_size_pretty (pg_total_relation_size('test.students_attend')) as total;
	
INSERT INTO test.students_attend (student_account, attend_date) VALUES(
  'ABC4', DATE '2023-06-18'
);

INSERT INTO test.students_attend (student_account, attend_date) VALUES(
  'ABC40000', DATE '2023-06-18'
);