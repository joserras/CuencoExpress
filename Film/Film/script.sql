dbug: Film.Startup[0]
      this is a debug message
info: Microsoft.EntityFrameworkCore.Infrastructure[10403]
      Entity Framework Core 2.1.8-servicing-32085 initialized 'ApplicationDbContext' using provider 'Microsoft.EntityFrameworkCore.SqlServer' with options: MaxPoolSize=128 
info: Microsoft.EntityFrameworkCore.Infrastructure[10403]
      Entity Framework Core 2.1.8-servicing-32085 initialized 'ApplicationDbContext' using provider 'Microsoft.EntityFrameworkCore.SqlServer' with options: MaxPoolSize=128 
IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [Users] (
    [Id] nvarchar(450) NOT NULL,
    [UserName] nvarchar(max) NULL,
    [NormalizedUserName] nvarchar(max) NULL,
    [Email] nvarchar(max) NULL,
    [NormalizedEmail] nvarchar(max) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    [Nombre] nvarchar(max) NULL,
    [Apellidos] nvarchar(max) NULL,
    [Admin] bit NOT NULL,
    [Estado] bit NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [UserDates] (
    [Id] nvarchar(450) NOT NULL,
    [Direccion] nvarchar(max) NULL,
    [Telefono] nvarchar(max) NULL,
    [Puntuacion] float NOT NULL,
    CONSTRAINT [PK_UserDates] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_UserDates_Users_Id] FOREIGN KEY ([Id]) REFERENCES [Users] ([Id]) ON DELETE NO ACTION
);

GO

CREATE TABLE [Trabajo] (
    [Id] nvarchar(450) NOT NULL,
    [Puntuacion] float NOT NULL,
    [Estado] int NOT NULL,
    [TrabajadorId] nvarchar(450) NULL,
    CONSTRAINT [PK_Trabajo] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [Cliente] (
    [Id] nvarchar(450) NOT NULL,
    [UserId] nvarchar(450) NULL,
    CONSTRAINT [PK_Cliente] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Cliente_Trabajo_Id] FOREIGN KEY ([Id]) REFERENCES [Trabajo] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Cliente_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE NO ACTION
);

GO

CREATE TABLE [Trabajador] (
    [Id] nvarchar(450) NOT NULL,
    [UserId] nvarchar(450) NULL,
    [TrabajoId] nvarchar(450) NULL,
    CONSTRAINT [PK_Trabajador] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Trabajador_Trabajo_TrabajoId] FOREIGN KEY ([TrabajoId]) REFERENCES [Trabajo] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Trabajador_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE NO ACTION
);

GO

CREATE INDEX [IX_Cliente_UserId] ON [Cliente] ([UserId]);

GO

CREATE INDEX [IX_Trabajador_TrabajoId] ON [Trabajador] ([TrabajoId]);

GO

CREATE INDEX [IX_Trabajador_UserId] ON [Trabajador] ([UserId]);

GO

CREATE INDEX [IX_Trabajo_TrabajadorId] ON [Trabajo] ([TrabajadorId]);

GO

ALTER TABLE [Trabajo] ADD CONSTRAINT [FK_Trabajo_Cliente_TrabajadorId] FOREIGN KEY ([TrabajadorId]) REFERENCES [Cliente] ([Id]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181226115755_k', N'2.1.8-servicing-32085');

GO

ALTER TABLE [Cliente] DROP CONSTRAINT [FK_Cliente_Users_UserId];

GO

ALTER TABLE [Trabajador] DROP CONSTRAINT [FK_Trabajador_Users_UserId];

GO

ALTER TABLE [UserDates] DROP CONSTRAINT [FK_UserDates_Users_Id];

GO

ALTER TABLE [Users] DROP CONSTRAINT [PK_Users];

GO

EXEC sp_rename N'[Users]', N'AspNetUsers';

GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'UserName');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [AspNetUsers] ALTER COLUMN [UserName] nvarchar(256) NULL;

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'NormalizedUserName');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [AspNetUsers] ALTER COLUMN [NormalizedUserName] nvarchar(256) NULL;

GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'NormalizedEmail');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [AspNetUsers] ALTER COLUMN [NormalizedEmail] nvarchar(256) NULL;

GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'Email');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [AspNetUsers] ALTER COLUMN [Email] nvarchar(256) NULL;

GO

ALTER TABLE [AspNetUsers] ADD CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id]);

GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);

GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);

GO

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;

GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);

GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;

GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);

GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);

GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);

GO

ALTER TABLE [Cliente] ADD CONSTRAINT [FK_Cliente_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION;

GO

ALTER TABLE [Trabajador] ADD CONSTRAINT [FK_Trabajador_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION;

GO

ALTER TABLE [UserDates] ADD CONSTRAINT [FK_UserDates_AspNetUsers_Id] FOREIGN KEY ([Id]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181227125525_tu4', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181231112150_asdasd2', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181231123202_tokens', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190101160217_defaultvalue', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190121104610_norequired', N'2.1.8-servicing-32085');

GO

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'Apellidos');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [AspNetUsers] DROP COLUMN [Apellidos];

GO

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'Nombre');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [AspNetUsers] DROP COLUMN [Nombre];

GO

EXEC sp_rename N'[UserDates].[Telefono]', N'Surname', N'COLUMN';

GO

EXEC sp_rename N'[UserDates].[Puntuacion]', N'Score', N'COLUMN';

GO

EXEC sp_rename N'[UserDates].[Direccion]', N'State', N'COLUMN';

GO

EXEC sp_rename N'[AspNetUsers].[Estado]', N'Status', N'COLUMN';

GO

ALTER TABLE [UserDates] ADD [Address1] nvarchar(max) NULL;

GO

ALTER TABLE [UserDates] ADD [Address2] nvarchar(max) NULL;

GO

ALTER TABLE [UserDates] ADD [City] nvarchar(max) NULL;

GO

ALTER TABLE [UserDates] ADD [Country] nvarchar(max) NULL;

GO

ALTER TABLE [UserDates] ADD [Name] nvarchar(max) NULL;

GO

ALTER TABLE [UserDates] ADD [Phone] nvarchar(max) NULL;

GO

ALTER TABLE [UserDates] ADD [PostalCode] nvarchar(max) NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190121113954_cambios', N'2.1.8-servicing-32085');

GO

ALTER TABLE [UserDates] DROP CONSTRAINT [FK_UserDates_AspNetUsers_Id];

GO

ALTER TABLE [UserDates] ADD CONSTRAINT [FK_UserDates_AspNetUsers_Id] FOREIGN KEY ([Id]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190121132745_cambios2', N'2.1.8-servicing-32085');

GO

CREATE TABLE [Knowledges] (
    [Id] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    [Explanation] nvarchar(max) NULL,
    CONSTRAINT [PK_Knowledges] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [UserKnowledges] (
    [KnowledgesId] nvarchar(450) NOT NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_UserKnowledges] PRIMARY KEY ([UserId], [KnowledgesId]),
    CONSTRAINT [FK_UserKnowledges_Knowledges_KnowledgesId] FOREIGN KEY ([KnowledgesId]) REFERENCES [Knowledges] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_UserKnowledges_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_UserKnowledges_KnowledgesId] ON [UserKnowledges] ([KnowledgesId]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190121145426_skills', N'2.1.8-servicing-32085');

GO

ALTER TABLE [UserDates] DROP CONSTRAINT [FK_UserDates_AspNetUsers_Id];

GO

ALTER TABLE [UserDates] ADD CONSTRAINT [FK_UserDates_AspNetUsers_Id] FOREIGN KEY ([Id]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190121145702_skills2', N'2.1.8-servicing-32085');

GO

ALTER TABLE [UserDates] DROP CONSTRAINT [FK_UserDates_AspNetUsers_Id];

GO

ALTER TABLE [UserDates] ADD [UserRef] nvarchar(450) NULL;

GO

CREATE UNIQUE INDEX [IX_UserDates_UserRef] ON [UserDates] ([UserRef]) WHERE [UserRef] IS NOT NULL;

GO

ALTER TABLE [UserDates] ADD CONSTRAINT [FK_UserDates_AspNetUsers_UserRef] FOREIGN KEY ([UserRef]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190121160511_tudelsky', N'2.1.8-servicing-32085');

GO

ALTER TABLE [UserDates] DROP CONSTRAINT [FK_UserDates_AspNetUsers_UserRef];

GO

DROP INDEX [IX_UserDates_UserRef] ON [UserDates];

GO

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[UserDates]') AND [c].[name] = N'UserRef');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [UserDates] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [UserDates] DROP COLUMN [UserRef];

GO

ALTER TABLE [UserDates] ADD CONSTRAINT [FK_UserDates_AspNetUsers_Id] FOREIGN KEY ([Id]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190121165240_asdasdoi', N'2.1.8-servicing-32085');

GO

ALTER TABLE [UserDates] ADD [PersonalInfo] nvarchar(max) NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190128151540_asaddd8', N'2.1.8-servicing-32085');

GO

ALTER TABLE [UserDates] ADD [ProfileImg] varbinary(max) NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190129130804_images', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190205122048_asdasds', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190212192813_asdd', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190212195756_asddxx', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190212195815_asddxxs', N'2.1.8-servicing-32085');

GO

ALTER TABLE [Cliente] DROP CONSTRAINT [FK_Cliente_Trabajo_Id];

GO

DROP TABLE [Trabajador];

GO

DROP TABLE [Trabajo];

GO

DROP TABLE [Cliente];

GO

CREATE TABLE [Job] (
    [Id] nvarchar(450) NOT NULL,
    [UserCreatorId] nvarchar(450) NULL,
    [UserWorkerId] nvarchar(450) NULL,
    [Description] nvarchar(max) NULL,
    [Tittle] nvarchar(max) NULL,
    CONSTRAINT [PK_Job] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Job_AspNetUsers_UserCreatorId] FOREIGN KEY ([UserCreatorId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Job_AspNetUsers_UserWorkerId] FOREIGN KEY ([UserWorkerId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION
);

GO

CREATE TABLE [Images] (
    [Id] nvarchar(450) NOT NULL,
    [Img] varbinary(max) NULL,
    [JobId] nvarchar(450) NULL,
    [JobId1] nvarchar(450) NULL,
    CONSTRAINT [PK_Images] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Images_AspNetUsers_JobId] FOREIGN KEY ([JobId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Images_Job_JobId1] FOREIGN KEY ([JobId1]) REFERENCES [Job] ([Id]) ON DELETE NO ACTION
);

GO

CREATE TABLE [JobKnowledges] (
    [KnowledgesId] nvarchar(450) NULL,
    [Id] nvarchar(450) NOT NULL,
    [JobId] nvarchar(450) NULL,
    CONSTRAINT [PK_JobKnowledges] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_JobKnowledges_Job_JobId] FOREIGN KEY ([JobId]) REFERENCES [Job] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_JobKnowledges_Knowledges_KnowledgesId] FOREIGN KEY ([KnowledgesId]) REFERENCES [Knowledges] ([Id]) ON DELETE NO ACTION
);

GO

CREATE INDEX [IX_Images_JobId] ON [Images] ([JobId]);

GO

CREATE INDEX [IX_Images_JobId1] ON [Images] ([JobId1]);

GO

CREATE INDEX [IX_Job_UserCreatorId] ON [Job] ([UserCreatorId]);

GO

CREATE INDEX [IX_Job_UserWorkerId] ON [Job] ([UserWorkerId]);

GO

CREATE INDEX [IX_JobKnowledges_JobId] ON [JobKnowledges] ([JobId]);

GO

CREATE INDEX [IX_JobKnowledges_KnowledgesId] ON [JobKnowledges] ([KnowledgesId]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190308151453_aaqp', N'2.1.8-servicing-32085');

GO

ALTER TABLE [JobKnowledges] DROP CONSTRAINT [FK_JobKnowledges_Job_JobId];

GO

ALTER TABLE [JobKnowledges] DROP CONSTRAINT [FK_JobKnowledges_Knowledges_KnowledgesId];

GO

ALTER TABLE [JobKnowledges] DROP CONSTRAINT [PK_JobKnowledges];

GO

DROP INDEX [IX_JobKnowledges_JobId] ON [JobKnowledges];

GO

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[JobKnowledges]') AND [c].[name] = N'Id');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [JobKnowledges] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [JobKnowledges] DROP COLUMN [Id];

GO

DROP INDEX [IX_JobKnowledges_KnowledgesId] ON [JobKnowledges];
DECLARE @var8 sysname;
SELECT @var8 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[JobKnowledges]') AND [c].[name] = N'KnowledgesId');
IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [JobKnowledges] DROP CONSTRAINT [' + @var8 + '];');
ALTER TABLE [JobKnowledges] ALTER COLUMN [KnowledgesId] nvarchar(450) NOT NULL;
CREATE INDEX [IX_JobKnowledges_KnowledgesId] ON [JobKnowledges] ([KnowledgesId]);

GO

DECLARE @var9 sysname;
SELECT @var9 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[JobKnowledges]') AND [c].[name] = N'JobId');
IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [JobKnowledges] DROP CONSTRAINT [' + @var9 + '];');
ALTER TABLE [JobKnowledges] ALTER COLUMN [JobId] nvarchar(450) NOT NULL;

GO

ALTER TABLE [JobKnowledges] ADD CONSTRAINT [PK_JobKnowledges] PRIMARY KEY ([JobId], [KnowledgesId]);

GO

ALTER TABLE [JobKnowledges] ADD CONSTRAINT [FK_JobKnowledges_Job_JobId] FOREIGN KEY ([JobId]) REFERENCES [Job] ([Id]) ON DELETE CASCADE;

GO

ALTER TABLE [JobKnowledges] ADD CONSTRAINT [FK_JobKnowledges_Knowledges_KnowledgesId] FOREIGN KEY ([KnowledgesId]) REFERENCES [Knowledges] ([Id]) ON DELETE CASCADE;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190308152632_aaqpio', N'2.1.8-servicing-32085');

GO

ALTER TABLE [Job] ADD [CreatedDate] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190314193057_addee', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190420140906_dd2', N'2.1.8-servicing-32085');

GO

ALTER TABLE [Job] ADD [Status] smallint NOT NULL DEFAULT CAST(0 AS smallint);

GO

ALTER TABLE [AspNetUsers] ADD [JobId] nvarchar(450) NULL;

GO

CREATE INDEX [IX_AspNetUsers_JobId] ON [AspNetUsers] ([JobId]);

GO

ALTER TABLE [AspNetUsers] ADD CONSTRAINT [FK_AspNetUsers_Job_JobId] FOREIGN KEY ([JobId]) REFERENCES [Job] ([Id]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190518101900_dddddd', N'2.1.8-servicing-32085');

GO

ALTER TABLE [Images] DROP CONSTRAINT [FK_Images_Job_JobId1];

GO

DROP INDEX [IX_Images_JobId1] ON [Images];

GO

DECLARE @var10 sysname;
SELECT @var10 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Images]') AND [c].[name] = N'JobId1');
IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [Images] DROP CONSTRAINT [' + @var10 + '];');
ALTER TABLE [Images] DROP COLUMN [JobId1];

GO

ALTER TABLE [Job] ADD [JobImages] varbinary(max) NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190522110026_ddasda', N'2.1.8-servicing-32085');

GO

DECLARE @var11 sysname;
SELECT @var11 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Job]') AND [c].[name] = N'JobImages');
IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [Job] DROP CONSTRAINT [' + @var11 + '];');
ALTER TABLE [Job] DROP COLUMN [JobImages];

GO

ALTER TABLE [Images] ADD [JobId1] nvarchar(450) NULL;

GO

CREATE INDEX [IX_Images_JobId1] ON [Images] ([JobId1]);

GO

ALTER TABLE [Images] ADD CONSTRAINT [FK_Images_Job_JobId1] FOREIGN KEY ([JobId1]) REFERENCES [Job] ([Id]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190523115051_addadsgg', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190523134936_addadsggk', N'2.1.8-servicing-32085');

GO

ALTER TABLE [Images] DROP CONSTRAINT [FK_Images_AspNetUsers_JobId];

GO

ALTER TABLE [Images] DROP CONSTRAINT [FK_Images_Job_JobId1];

GO

DROP INDEX [IX_Images_JobId1] ON [Images];

GO

DECLARE @var12 sysname;
SELECT @var12 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Images]') AND [c].[name] = N'JobId1');
IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [Images] DROP CONSTRAINT [' + @var12 + '];');
ALTER TABLE [Images] DROP COLUMN [JobId1];

GO

ALTER TABLE [Images] ADD CONSTRAINT [FK_Images_Job_JobId] FOREIGN KEY ([JobId]) REFERENCES [Job] ([Id]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190523140057_addadsggii', N'2.1.8-servicing-32085');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190606095638_asdasda', N'2.1.8-servicing-32085');

GO

ALTER TABLE [AspNetUsers] DROP CONSTRAINT [FK_AspNetUsers_Job_JobId];

GO

DROP INDEX [IX_AspNetUsers_JobId] ON [AspNetUsers];

GO

DECLARE @var13 sysname;
SELECT @var13 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'JobId');
IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var13 + '];');
ALTER TABLE [AspNetUsers] DROP COLUMN [JobId];

GO

CREATE TABLE [JobPreWorker] (
    [JobId] nvarchar(450) NOT NULL,
    [UserPreWorkeId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_JobPreWorker] PRIMARY KEY ([JobId], [UserPreWorkeId]),
    CONSTRAINT [FK_JobPreWorker_AspNetUsers_JobId] FOREIGN KEY ([JobId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_JobPreWorker_Job_UserPreWorkeId] FOREIGN KEY ([UserPreWorkeId]) REFERENCES [Job] ([Id]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_JobPreWorker_UserPreWorkeId] ON [JobPreWorker] ([UserPreWorkeId]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190606113423_asdasda4', N'2.1.8-servicing-32085');

GO


