if exists (select 1 from sysobjects where name = 'uspu_CardList')
drop procedure uspu_CardList
go

create procedure uspu_CardList
  @piCardId int = null,
	@piKodas nvarchar(255) = -131313,
	@piPinCode int = -131313,
	@piLikutis numeric(17,4) = -131313
as  
--SP_Version = 1
--SP_GenDate = Fri Jan 22 14:14:19 2010
--SP_ErrVersion = 1.1
--Lina
/**/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
DECLARE @vErrCode Int, @vv Int, @vErrStr nvarchar(255), @vDataIki datetime, @vCurr char(7), @vMin char(7), @vPeriodaiId int

select 
	@piCardId = isnull(@piCardId, 1),
	@piKodas = isnull(@piKodas, ''),
	@piPinCode = isnull(@piPinCode, ''),
	@piLikutis = isnull(@piLikutis, 0)

if @piCardId > 1
	update Cardlist set
		Kodas = case when @piKodas = -131313 then Kodas else @piKodas end,
		PinCode = case when @piPinCode = -131313 then PinCode else @piPinCode end,
		Likutis = case when @piLikutis = -131313 then Likutis else @piLikutis end	
	where CardId = @piCardId

else
	insert into Cardlist(
	Cardid, 
	Kodas, 
	PinCode, 
	Likutis)
select 
	CardId = @piCardId, 
	Kodas = case when @piKodas = -131313 then 1 else @piKodas end,
	PinCode = case when @piPinCode = -131313 then 1 else @piPinCode end,
	Likutis = case when @piLikutis = -131313 then 1 else @piLikutis end

return

IF @@TRANCOUNT > 0
  ROLLBACK TRANSACTION
return
go