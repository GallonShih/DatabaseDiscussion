-- https://www.postgresql.org/docs/15/datatype.html
-- https://www.cnblogs.com/vuenote/p/9606217.html
-- https://www.youtube.com/watch?v=u4B3HVvfXKo
-- https://m.xuite.net/blog/reshenchen/computer/30598491
-- https://www.postgresql.org/docs/15/datatype-character.html

-- check table exists or not
DROP TABLE IF EXISTS test.numeric_data_size;
-- create table with two columns
CREATE TABLE test.numeric_data_size (
	dt_int integer,
	dt_bigint bigint,
	dt_float32 real,
	dt_num numeric
);

SELECT
	pg_size_pretty (pg_table_size('test.numeric_data_size')) as pg_table_size,
	pg_size_pretty (pg_indexes_size('test.numeric_data_size')) as indexs,
	pg_size_pretty (pg_total_relation_size('test.numeric_data_size')) as total;

	
INSERT INTO test.numeric_data_size (dt_int, dt_bigint, dt_float32, dt_num) VALUES(
  1, 1, 1.0, 1.0
);
INSERT INTO test.numeric_data_size (dt_int, dt_bigint, dt_num) VALUES(
  1, 3147483647, -1.1
);
INSERT INTO test.numeric_data_size (dt_int, dt_num) VALUES(
  1, 1.1
);

INSERT INTO test.numeric_data_size (dt_int, dt_num) VALUES(
  1, 1.2
);

INSERT INTO test.numeric_data_size (dt_int, dt_num) VALUES(
  1, 2.0
);
INSERT INTO test.numeric_data_size (dt_int, dt_num) VALUES(
  1, 2.1
);
INSERT INTO test.numeric_data_size (dt_int, dt_num) VALUES(
  1, 2.2
);

INSERT INTO test.numeric_data_size (dt_int, dt_num) VALUES(
  1, -2.2
);

INSERT INTO test.numeric_data_size (dt_int, dt_num) VALUES(
  1, 100000000000
);
INSERT INTO test.numeric_data_size (dt_int, dt_num) VALUES(
  1, 10000000000000000001
);



SELECT dt_int, pg_column_size(dt_int) as dt_int_size,
	dt_bigint, pg_column_size(dt_bigint) as dt_bigint_size,
	dt_float32, pg_column_size(dt_float32) as dt_float32_size,
	dt_num, pg_column_size(dt_num) as dt_num_size
from test.numeric_data_size;


-- char data type
-- check table exists or not
DROP TABLE IF EXISTS test.char_data_size;
-- create table with two columns
CREATE TABLE test.char_data_size (
	dt_char_10 char(10),
	dt_vchar_10 varchar(10),
	dt_vchar varchar,
	dt_text text
);

SELECT
	pg_size_pretty (pg_table_size('test.char_data_size')) as pg_table_size,
	pg_size_pretty (pg_indexes_size('test.char_data_size')) as indexs,
	pg_size_pretty (pg_total_relation_size('test.char_data_size')) as total;

INSERT INTO test.char_data_size (dt_char_10, dt_vchar_10, dt_vchar, dt_text) VALUES(
  '12345', '12345', '12345', '12345'
);
INSERT INTO test.char_data_size (dt_char_10, dt_vchar_10, dt_vchar, dt_text) VALUES(
  'abcde', 'abcde', 'abcde', 'abcde'
);
INSERT INTO test.char_data_size (dt_char_10, dt_vchar_10, dt_vchar, dt_text) VALUES(
  '哈哈哈哈', '哈哈哈哈', '哈哈哈哈', '哈哈哈哈'
);
INSERT INTO test.char_data_size (dt_char_10, dt_vchar_10, dt_vchar, dt_text) VALUES(
  '哈哈哈哈哈', '哈哈哈哈哈', '哈哈哈哈哈', '哈哈哈哈哈'
);

SELECT dt_char_10, pg_column_size(dt_char_10) as dt_char_10_size,
	dt_vchar_10, pg_column_size(dt_vchar_10) as dt_vchar_10_size,
	dt_vchar, pg_column_size(dt_vchar) as dt_vchar_size,
	dt_text, pg_column_size(dt_text) as dt_text_size
from test.char_data_size;
