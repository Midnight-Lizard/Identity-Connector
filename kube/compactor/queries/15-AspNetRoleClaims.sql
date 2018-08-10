CREATE STREAM RawStream_AspNetRoleClaims (
  Id VARCHAR, RoleId VARCHAR, ClaimType VARCHAR, ClaimValue VARCHAR)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetRoleClaims',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetRoleClaims WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetRoleClaims',
    VALUE_FORMAT = 'JSON') AS
  SELECT RoleId, ClaimType, ClaimValue
  FROM RawStream_AspNetRoleClaims
  WHERE RoleId <> ''
  PARTITION BY RoleId;

CREATE TABLE KeyedTable_AspNetRoleClaims (
    RoleId VARCHAR, ClaimType VARCHAR, ClaimValue VARCHAR)
  WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetRoleClaims',
    VALUE_FORMAT = 'JSON',
    KEY = 'RoleId');

CREATE TABLE JoinedTable_AspNetRoleClaims WITH (
    KAFKA_TOPIC = 'ksql-table_iddb.public.AspNetRoleClaims',
    VALUE_FORMAT = 'JSON') AS
  SELECT r.Id as RoleId,
    r.Name as RoleName,
    r.NormalizedName as NormalizedRoleName,
    rc.ClaimType, rc.ClaimValue
  FROM AspNetRoles r
  LEFT JOIN KeyedTable_AspNetRoleClaims rc on rc.RoleId = r.Id;

CREATE TABLE AspNetRoleClaims (
    RoleId VARCHAR,
    RoleName VARCHAR, NormalizedRoleName VARCHAR,
    ClaimType VARCHAR, ClaimValue VARCHAR)
  WITH (
    KAFKA_TOPIC = 'ksql-table_iddb.public.AspNetRoleClaims',
    VALUE_FORMAT = 'JSON',
    KEY = 'RoleId');