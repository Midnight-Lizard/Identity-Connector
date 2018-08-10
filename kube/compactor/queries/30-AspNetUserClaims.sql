CREATE STREAM RawStream_AspNetUserClaims (
  Id VARCHAR, UserId VARCHAR, ClaimType VARCHAR, ClaimValue VARCHAR)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUserClaims',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetUserClaims WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUserClaims',
    VALUE_FORMAT = 'JSON') AS
  SELECT UserId, ClaimType, ClaimValue
  FROM RawStream_AspNetUserClaims
  PARTITION BY UserId;

CREATE TABLE KeyedTable_AspNetUserClaims (
    UserId VARCHAR, ClaimType VARCHAR, ClaimValue VARCHAR)
  WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUserClaims',
    VALUE_FORMAT = 'JSON',
    KEY = 'UserId');

CREATE TABLE AspNetUserClaims WITH (
    KAFKA_TOPIC = 'ksql-table_iddb.public.AspNetUserClaims',
    VALUE_FORMAT = 'JSON') AS
  SELECT
    u.Id as UserId, u.UserName,
    u.DisplayName, u.NormalizedUserName,
    u.Email, u.NormalizedEmail, u.EmailConfirmed,
    u.PhoneNumber, u.PhoneNumberConfirmed,
    u.RoleId, u.RoleName, u.NormalizedRoleName,
    u.RoleClaimType, u.RoleClaimValue,
    uc.ClaimType as UserClaimType, uc.ClaimValue as UserClaimValue
  FROM AspNetUsers u
  LEFT JOIN KeyedTable_AspNetUserClaims uc on uc.UserId = u.Id;
