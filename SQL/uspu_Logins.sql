if exists (select 1 from sysobjects where name = 'uspu_logins')
drop procedure uspu_logins
go

create procedure uspu_logins
  @piLoginsId int = null,
	@piUsers nvarchar(255) = -131313,
	@piPassword nvarchar(255) = -131313,
	@piPersonsId int = -131313
as  
--SP_Version = 1
--SP_GenDate = Fri Jan 22 14:14:19 2010
--SP_ErrVersion = 1.1
--Lina
/**/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
DECLARE @vErrCode Int, @vv Int, @vErrStr nvarchar(255), @vDataIki datetime, @vCurr char(7), @vMin char(7), @vPeriodaiId int

select 
	@piLoginsId = isnull(@piLoginsId, 1),
	@piUsers = isnull(@piUsers, 1),
	@piPersonsId = isnull(@piPersonsId, 1),
	@piPassword = isnull(@piPassword, '')

if @piLoginsId > 1
	update Logins set
		Users = case when @piUsers = -131313 then Users else @piUsers end,
		Password = case when @piPassword = -131313 then Password else @piPassword end,
		PersonsId = case when @piPersonsId = -131313 then PersonsId else @piPersonsId end
	where LoginsId = @piLoginsId

else
	insert into Logins(
	LoginsId, 
	Users, 
	Password, 
	PersonsId)
select 
	LoginsId = @piLoginsId, 
	Users = case when @piUsers = -131313 then 1 else @piUsers end,
	Password = case when @piPassword = -131313 then 1 else @piPassword end,
	PersonsId = case when @piPersonsId = -131313 then 1 else @piPassword end

return

IF @@TRANCOUNT > 0
  ROLLBACK TRANSACTION
return
go