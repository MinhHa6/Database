-----lay ds bang vat tu 
select * from VATTU
go 
create proc spup_LayDsVatTu
as 
SELECT * FROM VATTU ORDER BY TenVTu ASC 
GO
EXECUTE spup_LayDsVatTu
------liet ke cac cot du lieu trong bang nhacc
select * from NHACC
go
create proc spup_layds_nhacc
@mancc nvarchar(50) = NULL
as 
begin
if @mancc is null
select * from NHACC
else 
select * from nhacc
where MaNCC =@mancc
end
go
--- TRUONG HOP KO TRUYEN THAM SO 
execute spup_layds_nhacc 
----- TRUONG HOP TRUYEN THAM SO @MANCC=C01
exec spup_layds_nhacc @mancc=N'C01'
go
drop proc spup_layds_nhacc;