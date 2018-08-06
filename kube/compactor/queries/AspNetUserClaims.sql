CREATE STREAM RawStream_AspNetUserClaims (
  after STRUCT<Id VARCHAR, UserId VARCHAR, ClaimType VARCHAR, ClaimValue VARCHAR>)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUserClaims',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetUserClaims WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUserClaims',
    VALUE_FORMAT = 'JSON') AS
  SELECT
    after->Id as Id,
    after->UserId as UserId,
    after->ClaimType as ClaimType,
    after->ClaimValue as ClaimValue
  FROM RawStream_AspNetUserClaims
  WHERE after->Id <> '-1'
  PARTITION BY Id;
