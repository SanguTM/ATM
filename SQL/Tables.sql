if not EXISTS(SELECT 1 FROM sysobjects WHERE sysobjects.name = 'Logins')
Create table Logins (LoginsId int not null identity(1,1), Users nvarchar(256), Password nvarchar(256), PersonsId int)

if not EXISTS(SELECT 1 FROM sysobjects WHERE sysobjects.name = 'Persons')
Create table Persons(PersonsId int not null identity(1,1), Kodas nvarchar(256), Vardas nvarchar(256), Pavarde nvarchar(256), UserId int)

if not EXISTS(SELECT 1 FROM sysobjects WHERE sysobjects.name = 'CardList')
Create table Cardlist (CardId int identity(1,1), Kodas nvarchar(256), PinCode int, Likutis numeric(17,4))

if not EXISTS(SELECT 1 FROM sysobjects WHERE sysobjects.name = 'Operations')
Create table Operations (OperationId int not null identity(1,1), Date datetime, Kryptis nvarchar(10), Suma numeric(17,4))