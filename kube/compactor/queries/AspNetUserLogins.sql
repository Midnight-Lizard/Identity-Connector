CREATE STREAM RawStream_AspNetUserLogins (
  after STRUCT<
    LoginProvider VARCHAR,
    ProviderKey VARCHAR,
    ProviderDisplayName VARCHAR,
    UserId VARCHAR>)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUserLogins',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetUserLogins WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUserLogins',
    VALUE_FORMAT = 'JSON') AS
  SELECT
    after->LoginProvider + '-' + after->ProviderKey as Id,
    after->LoginProvider as LoginProvider,
    after->ProviderKey as ProviderKey,
    after->ProviderDisplayName as ProviderDisplayName,
    after->UserId as UserId
  FROM RawStream_AspNetUserLogins
  WHERE after->ProviderKey <> ''
  PARTITION BY Id;
