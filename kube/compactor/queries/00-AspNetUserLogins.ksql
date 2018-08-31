CREATE STREAM RawStream_AspNetUserLogins (
    LoginProvider VARCHAR,
    ProviderKey VARCHAR,
    ProviderDisplayName VARCHAR,
    UserId VARCHAR)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUserLogins',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetUserLogins WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUserLogins',
    VALUE_FORMAT = 'JSON') AS
  SELECT UserId, LoginProvider, ProviderKey, ProviderDisplayName
  FROM RawStream_AspNetUserLogins
  WHERE UserId <> ''
  PARTITION BY UserId;
