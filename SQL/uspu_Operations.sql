if exists (select 1 from sysobjects where name = 'uspu_Operations')
drop procedure uspu_Operations
go

create procedure uspu_Operations
  @piOperationId int = null,
	@piDate datetime = null,
	@piKryptis int = null,
	@piSuma numeric(17,4) = -131313
as  
--SP_Version = 1
--SP_GenDate = Fri Jan 22 14:14:19 2010
--SP_ErrVersion = 1.1
--Lina
/**/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
DECLARE @vErrCode Int, @vv Int, @vErrStr nvarchar(255), @vDataIki datetime, @vCurr char(7), @vMin char(7), @vPeriodaiId int

select 
	@piOperationId = isnull(@piOperationId, 1),
	@piDate = isnull(@piDate, getdate()),
	@piKryptis = isnull(@piKryptis, 1),
	@piSuma = isnull(@piSuma, 0)

if @piOperationId > 1
	update Operations set
		Date = @piDate,
		Kryptis = @piKryptis,
		Suma = @piSuma 	
	where OperationId = @piOperationId

else
	insert into Operations(
	OperationId,
	Date,
	Kryptis, 
	Suma)
select 
	OperationId = @piOperationId, 
	Date = @piDate,
	Kryptis = @piKryptis,
	Suma = @piSuma

return

IF @@TRANCOUNT > 0
  ROLLBACK TRANSACTION
return
go