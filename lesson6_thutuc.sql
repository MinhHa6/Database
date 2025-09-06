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
--------thu tuc cap nhat du lieu 
select * from VATTU
go 
create proc spud_VatTu_them 
@mavtu nvarchar(50) ,
@tenvtu nvarchar(50),
@dvtinh nvarchar(50)='',
@phantram int 
as
BEGIN
    -- 1. Kiểm tra trùng mã vật tư
    IF EXISTS (SELECT 1 FROM VATTU WHERE MaVTU = @mavtu)
    BEGIN
        RAISERROR(N'Mã vật tư đã tồn tại!', 16, 1);
        RETURN;
    END;

    -- 2. Kiểm tra trùng tên vật tư
    IF EXISTS (SELECT 1 FROM VATTU WHERE TenVTU = @tenvtu)
    BEGIN
        RAISERROR(N'Tên vật tư đã tồn tại!', 16, 1);
        RETURN;
    END;

    -- 3. Kiểm tra phần trăm hợp lệ
    IF @phantram < 0 OR @phantram > 100
    BEGIN
        RAISERROR(N'Phần trăm phải từ 0 đến 100!', 16, 1);
        RETURN;
    END;

    -- Nếu hợp lệ thì thêm vào
    INSERT INTO VATTU (MaVTU, TenVTU, DVTinh, PhanTram)
    VALUES (@mavtu, @tenvtu, @dvtinh, @phantram);
END;
GO
drop proc spud_VatTu_Them 
------ them vat tu moi 
EXEC spud_VatTu_Them 
    @mavtu = 'VT02',
    @tenvtu = N'Xi măng1',
    @dvtinh = N'Bao',
    @phantram = 10;
----------xay dung thu tuc xoa mot vat tu trong bang vat tu 
GO
CREATE PROC spud_VATTU_Xoa
    @MaVTu NVARCHAR(50)
AS
BEGIN
    -- Chỉ xóa nếu mã vật tư không tồn tại trong bất kỳ bảng nào
    IF NOT EXISTS (SELECT 1 FROM CTDONDH WHERE MaVTu = @MaVTu)
       AND NOT EXISTS (SELECT 1 FROM CTPNHAP WHERE MaVTu = @MaVTu)
       AND NOT EXISTS (SELECT 1 FROM CTPXUAT WHERE MaVTu = @MaVTu)
       AND NOT EXISTS (SELECT 1 FROM TONKHO WHERE MaVTu = @MaVTu)
    BEGIN
        DELETE FROM VATTU
        WHERE MaVTu = @MaVTu;

        PRINT N'Xóa vật tư thành công!';
    END
    ELSE
    BEGIN
        PRINT N'Mã vật tư đang tồn tại trong các bảng khác, không thể xóa!';
    END
END
GO
---- xoa vat tu @mavattu canxoa @
exec  spud_VATTU_Xoa @mavtu =N' VT01'
