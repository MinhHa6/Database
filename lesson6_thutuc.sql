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
go 
-------cau 3 xay dung thu tuc liet ke cac cot du lieu trong bang pxuat va ctpxuat
select * from PXUAT
select * from CTPXUAT
select * from VATTU
GO
create proc spup_pxuat_bcaopxuat
@sophieuxuat nvarchar(50)= NULL
AS 
BEGIN 
IF 
@sophieuxuat IS NULL
SELECT * FROM PXUAT
ELSE 
SELECT * FROM PXUAT P
JOIN CTPXUAT T
ON P.SoPx = T.SoPx
JOIN VATTU V
ON T.Mavtu = V.Mavtu
WHERE P.SoPx =@sophieuxuat
END
------LAY TAT CA PHIEU XUAT NEU KO NHAP J CA 
EXEC spup_pxuat_bcaopxuat 
-----LAY PHIEU XUAT KHI NHAP GIA TRI 
EXEC spup_pxuat_bcaopxuat @sophieuxuat =N'X001'
DROP PROC  spup_pxuat_bcaopxuat
go
------ CAU 5 XAY DUNG THU TUC LIET KE CAC COT DU LIEU TRONG BANG TON KHO
select * from TONKHO
go
CREATE PROC spup_TONKHO_BCaotonkho 
@namthang nvarchar(6)
as 
select k.namthang,v.mavtu,k.SLDau,SLCuoi,TongSLX,k.SLCuoi,v.TenVTu
from TONKHO k
join VATTU v
on k.Mavtu = v.Mavtu
where @namthang =NamThang
-------ketqua
go
exec spup_TONKHO_BCaotonkho @namthang=N'201401'
drop proc spup_TONKHO_BCaotonkho
