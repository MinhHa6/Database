----------trigger
--------- tao trigger them moi du lieu dung de kiem tra cac rang buoc toan ven 
select * from PNHAP
select * from DONDH
create trigger tg_PNhap_them on [dbo].[PNHAP]
for insert 
AS
BEGIN
    -- Kiểm tra số đặt hàng có trong DONDH
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN DONDH d ON i.SoDH = d.SoDH
        WHERE d.SoDH IS NULL
    )
    BEGIN
        RAISERROR(N'Số đặt hàng không tồn tại trong bảng DONDH', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Kiểm tra ngày nhập hàng phải sau ngày đặt hàng
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN DONDH d ON i.SoDH = d.SoDH
        WHERE i.NgayNhap <= d.NgayDH
    )
    BEGIN
        RAISERROR(N'Ngày nhập hàng phải sau ngày đặt hàng', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
End;
INSERT INTO PNHAP (SoPN, SoDH, NgayNhap)
VALUES ('PN002', 'DH999', '2025-09-05');