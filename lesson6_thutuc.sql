-----lay ds bang vat tu 
select * from VATTU
go 
create proc spup_LayDsVatTu
as 
SELECT * FROM VATTU ORDER BY TenVTu ASC 
GO
EXECUTE spup_LayDsVatTu
------