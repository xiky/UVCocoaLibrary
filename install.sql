drop table if exists [devices];
CREATE TABLE [devices] ([id_] INTEGER PRIMARY KEY AUTOINCREMENT, [port] SMALLINT, [type] SMALLINT, [ddnsPwd] VARCHAR(64), [ddnsType] VARCHAR(20), [ddnsUser] VARCHAR(32), [name] VARCHAR(255), [password] VARCHAR(64), [server] VARCHAR(128), [sn] VARCHAR(64), [username] VARCHAR(32));
drop table if exists [fav];
CREATE TABLE [fav] ([id_] INTEGER PRIMARY KEY AUTOINCREMENT, [deviceId] INTEGER, deviceType SMALLINT, isOnline BOOLEAN, isShared BOOLEAN, resSubtype INTEGER, resType INTEGER, ddnsUser VARCHAR(32), resCode VARCHAR(255), resName VARCHAR(255));
drop table if exists [resources];
CREATE TABLE [resources] ([id_] INTEGER PRIMARY KEY AUTOINCREMENT, [deviceId] INTEGER, isOnline BOOLEAN, isShared BOOLEAN, resSubtype INTEGER, resType INTEGER, resCode VARCHAR(255), resName VARCHAR(255));