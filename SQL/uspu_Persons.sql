if exists (select 1 from sysobjects where name = 'uspu_Persons')
drop procedure uspu_Persons
go

create procedure uspu_Persons
  @piPersonsId int = null,
	@piKodas nvarchar(255) = -131313,
	@piVardas int = -131313,
	@piPavarde int = -131313,
	@piUserId int = -131313
as  
--SP_Version = 1
--SP_GenDate = Fri Jan 22 14:14:19 2010
--SP_ErrVersion = 1.1
--Lina
/**/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
DECLARE @vErrCode Int, @vv Int, @vErrStr nvarchar(255), @vDataIki datetime, @vCurr char(7), @vMin char(7), @vPeriodaiId int

select 
	@piPersonsId = isnull(@piPersonsId, 1),
	@piKodas = isnull(@piKodas, ''),
	@piVardas = isnull(@piVardas, ''),
	@piPavarde = isnull(@piPavarde, ''),
	@piUserId = isnull(@piUserId, 1)

if @piPersonsId > 1
	update Persons set
		UserId = case when @piUserId = -131313 then UserId else @piUserId end,
		Kodas = case when @piKodas = -131313 then Kodas else @piKodas end,
		Vardas = case when @piVardas = -131313 then Vardas else @piVardas end,
		Pavarde = case when @piPavarde = -131313 then Pavarde else @piPavarde end	
	where PersonsId = @piPersonsId

else
	insert into Persons(
	PersonsId, 
	UserId, 
	Kodas, 
	Vardas,
	Pavarde)
select 
	PersonsId = @piPersonsId, 
	UserId = case when @piUserId = -131313 then 1 else @piUserId end,
	Kodas = case when @piKodas = -131313 then 1 else @piKodas end,
	Vardas = case when @piVardas = -131313 then 1 else @piVardas end,
	Pavarde = case when @piPavarde = -131313 then 1 else @piPavarde end

return

IF @@TRANCOUNT > 0
  ROLLBACK TRANSACTION
return
go