CREATE STREAM RawStream_AspNetUserRoles (
  after STRUCT<
    UserId VARCHAR,
    RoleId VARCHAR>)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUserRoles',
    VALUE_FORMAT = 'JSON');

CREATE TABLE Table_AspNetUserRoles WITH (
    KAFKA_TOPIC = 'ksql-table_iddb.public.AspNetUserRoles',
    VALUE_FORMAT = 'JSON') AS
  SELECT
    after->UserId as UserId,
    after->RoleId as RoleId
  FROM RawStream_AspNetUserRoles;
