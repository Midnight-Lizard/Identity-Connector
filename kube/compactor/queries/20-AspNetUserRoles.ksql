CREATE STREAM RawStream_AspNetUserRoles (
    UserId VARCHAR, RoleId VARCHAR)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUserRoles',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetUserRoles WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUserRoles',
    VALUE_FORMAT = 'JSON') AS
  SELECT ur.UserId, ur.RoleId as RoleId, rc.RoleName, rc.NormalizedRoleName,
    rc.ClaimType as RoleClaimType, rc.ClaimValue as RoleClaimValue
  FROM RawStream_AspNetUserRoles ur
  JOIN AspNetRoleClaims rc on rc.RoleId = ur.RoleId
  WHERE ur.UserId <> ''
  PARTITION BY UserId;

CREATE TABLE AspNetUserRoles (
    UserId VARCHAR, RoleId VARCHAR,
    RoleName VARCHAR, NormalizedRoleName VARCHAR,
    RoleClaimType VARCHAR, RoleClaimValue VARCHAR)
  WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUserRoles',
    VALUE_FORMAT = 'JSON',
    KEY = 'UserId');
