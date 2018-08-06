CREATE STREAM RawStream_AspNetUsers (
  after STRUCT<
    Id VARCHAR,
    UserName VARCHAR,
    DisplayName VARCHAR,
    NormalizedUserName VARCHAR,
    Email VARCHAR,
    NormalizedEmail VARCHAR,
    EmailConfirmed BOOLEAN,
    PhoneNumber VARCHAR,
    PhoneNumberConfirmed BOOLEAN>)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUsers',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetUsers WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUsers',
    VALUE_FORMAT = 'JSON') AS
  SELECT
    after->Id as Id,
    after->UserName as UserName,
    after->DisplayName as DisplayName,
    after->NormalizedUserName as NormalizedUserName,
    after->Email as Email,
    after->NormalizedEmail as NormalizedEmail,
    after->EmailConfirmed as EmailConfirmed,
    after->PhoneNumber as PhoneNumber,
    after->PhoneNumberConfirmed as PhoneNumberConfirmed
  FROM RawStream_AspNetUsers
  WHERE after->Id <> ''
  PARTITION BY Id;
