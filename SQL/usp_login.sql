CREATE procedure usp_login
	@piKodas nvarchar(255),
	@piPassword nvarchar(255)
 AS
 Select COUNT(*)
 From users
 where Kodas= @piKodas and Password=@piPassword
 GO

 exec usp_login
  @piKodas = '123',
  @piPassword = '456';

	select *from users