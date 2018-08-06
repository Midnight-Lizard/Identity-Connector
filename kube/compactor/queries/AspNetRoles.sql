CREATE STREAM RawStream_AspNetRoles (
  after STRUCT<
    Id VARCHAR,
    Name VARCHAR,
    NormalizedName VARCHAR>)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetRoles',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetRoles WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetRoles',
    VALUE_FORMAT = 'JSON') AS
  SELECT
    after->Id as Id,
    after->Name as Name,
    after->NormalizedName as NormalizedName
  FROM RawStream_AspNetRoles
  WHERE after->Id <> ''
  PARTITION BY Id;
