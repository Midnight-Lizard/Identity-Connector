CREATE STREAM RawStream_AspNetUsers (
    Id VARCHAR,
    UserName VARCHAR,
    DisplayName VARCHAR,
    NormalizedUserName VARCHAR,
    Email VARCHAR,
    NormalizedEmail VARCHAR,
    EmailConfirmed BOOLEAN,
    PhoneNumber VARCHAR,
    PhoneNumberConfirmed BOOLEAN)
  WITH (
    KAFKA_TOPIC = 'iddb.public.AspNetUsers',
    VALUE_FORMAT = 'JSON');

CREATE STREAM KeyedStream_AspNetUsers WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUsers',
    VALUE_FORMAT = 'JSON') AS
  SELECT
    u.Id, u.UserName,
    u.DisplayName, u.NormalizedUserName,
    u.Email, u.NormalizedEmail, u.EmailConfirmed,
    u.PhoneNumber, u.PhoneNumberConfirmed,
    ur.RoleId, ur.RoleName, ur.NormalizedRoleName,
    ur.RoleClaimType, ur.RoleClaimValue
  FROM RawStream_AspNetUsers u
  LEFT JOIN AspNetUserRoles ur on ur.UserId = u.Id
  WHERE u.Id <> ''
  PARTITION BY Id;

CREATE TABLE AspNetUsers (
    Id VARCHAR,
    UserName VARCHAR,
    DisplayName VARCHAR,
    NormalizedUserName VARCHAR,
    Email VARCHAR,
    NormalizedEmail VARCHAR,
    EmailConfirmed BOOLEAN,
    PhoneNumber VARCHAR,
    PhoneNumberConfirmed BOOLEAN,
    RoleId VARCHAR,
    RoleName VARCHAR, NormalizedRoleName VARCHAR,
    RoleClaimType VARCHAR, RoleClaimValue VARCHAR)
  WITH (
    KAFKA_TOPIC = 'ksql-stream_iddb.public.AspNetUsers',
    VALUE_FORMAT = 'JSON',
    KEY = 'Id');
