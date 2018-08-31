CREATE STREAM RawStream_AspNetRoles (
    Id VARCHAR, Name VARCHAR, NormalizedName VARCHAR)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetRoles',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetRoles WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetRoles',
    VALUE_FORMAT = 'JSON') AS
  SELECT Id, Name, NormalizedName
  FROM RawStream_AspNetRoles
  WHERE Id <> ''
  PARTITION BY Id;

CREATE TABLE AspNetRoles (
    Id VARCHAR, Name VARCHAR, NormalizedName VARCHAR)
  WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetRoles',
    VALUE_FORMAT = 'JSON',
    KEY = 'Id');
