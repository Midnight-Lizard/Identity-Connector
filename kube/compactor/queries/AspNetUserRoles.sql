CREATE STREAM RawStream_AspNetUserRoles (
  after STRUCT<
    UserId VARCHAR,
    RoleId VARCHAR>)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUserRoles',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetUserRoles WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUserRoles',
    VALUE_FORMAT = 'JSON') AS
  SELECT
    after->UserId + '-' + after->RoleId as Id,
    after->UserId as UserId,
    after->RoleId as RoleId
  FROM RawStream_AspNetUserRoles
  WHERE after->UserId <> ''
  PARTITION BY Id;
