------TAO VIEW 
----CAU 1
SELECT * FROM SinhVien
SELECT HOSV+' '+TENSV AS HOTEN ,MAKH,NOISINH,HOCBONG FROM SinhVien WHERE HOCBONG >10000 AND NOISINH =N'Tp. HCM'
GO
CREATE VIEW vw_HocBong
AS
SELECT HOSV + ' ' + TENSV AS HOTEN, MAKH, NOISINH, HOCBONG
FROM SinhVien
WHERE HOCBONG > 100000 AND NOISINH = N'Tp. HCM'
GO
SELECT * FROM vw_HocBong
GO 
DROP VIEW vw_HocBong
-----DS SINH VIEN KHOA ANH VAN VA KHOA TRIET 
SELECT * FROM SINHVIEN WHERE MAKH IN ('AV','TR')
GO
CREATE VIEW vw_Khoa
as 
SELECT MASV,MAKH,PHAI FROM SinhVien WHERE MAKH IN ('AV','TR')
GO
SELECT * FROM vw_Khoa
GO 
-----CHO BT NHUNG SINH VIEN sinh ngay 1/1/1986 den 5/6/1992
SELECT * FROM SINHVIEN
WHERE NgaySinh BETWEEN '1986-01-01' AND '1992-06-05'
GO
CREATE VIEW vw_NGAYSINH
as 
SELECT MASV,NgaySinh,NoiSinh,HocBong FROM SINHVIEN
WHERE NgaySinh BETWEEN '1986-01-01' AND '1992-06-05'
GO
-----HOCBONG
CREATE VIEW vw_HOCBONG
as 
SELECT MASV,NgaySinh,PHAI,MAKH FROM SINHVIEN
WHERE HOCBONG BETWEEN 20000 AND 80000
GO
------SOTIET 
SELECT * FROM MonHoc
GO
CREATE VIEW vw_monhoc
as 
select MAMH,TENMH,SOTIET FROM MonHoc WHERE SOTIET BETWEEN 40 AND 60
GO
SELECT * FROM vw_monhoc
--------cau 6- liet ke so hs cua khoa anh van
go
CREATE VIEW vw_cau6
as
select MaSV,hosv+''+TenSV AS HOTEN,CASE PHAI WHEN 1 THEN N'NAM' ELSE N'NU' END AS GIOITINH
from sinhvien
WHERE PHAI = 1  AND MAKH =N'AV'
go
SELECT  * FROM vw_cau6
go
--------cau 7----
CREATE VIEW vw_cau7
as
SELECT HOSV,TENSV,NgaySinh,NoiSinh
FROM SINHVIEN
WHERE NOISINH =N'Hà Nội' AND NGAYSINH > CONVERT(DATETIME,'19900101')
go
select * from vw_cau7
go
------cau 8
CREATE VIEW vw_cau8
as 
select * from sinhvien
where phai = 0 and tensv like N'%n%'
go
select * from vw_cau8
go
-----cau9 
CREATE VIEW vw_cau9
as
select * from sinhvien
where phai=1 and makh =N'TH' and ngaysinh > CONVERT(DATETIME,'19860530')
go
------cau10 
CREATE VIEW vw_cau10
as 
SELECT HOSV+' ' +TENSV AS HOTEN,CASE PHAI WHEN 1 THEN N'NAM' ELSE N'NU' END AS GIOITINH,
CONVERT(nvarchar,NgaySinh,111) AS NGAYSINH
FROM SINHVIEN
go 
SELECT * FROM vw_cau10
GO 
-----cau11----
CREATE VIEW vw_cau11
as
select MaSV,MaKH,NoiSinh,DATEDIFF(YEAR,NgaySinh,GETDATE())AS TUOI
from sinhvien
go
-------cau 12 ---
SELECT * FROM KHOA
GO 
CREATE VIEW vw_cau12
as
select hosv +' ' +tensv as HOTEN,DATEDIFF(YEAR,NGAYSINH,GETDATE()) AS TUOI,KH.TENKH FROM SINHVIEN
JOIN KHOA KH ON SINHVIEN.MaKH =KH.MaKH
WHERE DATEDIFF(YEAR, NgaySinh, GETDATE()) BETWEEN 20 AND 30;
go
select * from vw_cau12
go
-------cau 13 ------
select MASV,PHAI,MAKH,CASE WHEN HOCBONG>500000 THEN N'CAO' ELSE N'THAP' END AS MUCHOCBONG  
from sinhvien
SELECT MASV,PHAI,MAKH,IIF(HOCBONG>500000,N'CAO',N'THAP') AS MUCBOCBONG
FROM SINHVIEN
GO
CREATE VIEW vw_cau13 
as 
SELECT MASV,PHAI,MAKH,IIF(HOCBONG>500000,N'CAO',N'THAP') AS MUCBOCBONG
FROM SINHVIEN
go 
----------cau 14 ------
SELECT * FROM KHOA
go 
CREATE VIEW vw_cau14 
as 
SELECT HOSV+' '+TENSV AS HOTEN,IIF(PHAI=1,N'NAM',N'NU') AS GIOITINH,KH.TENKH FROM SinhVien
JOIN KHOA KH ON SINHVIEN.MAKH =KH.MaKH
WHERE TenKH =N'Anh Văn'
go 
--------cau 15 -------
SELECT * FROM SinhVien
SELECT * FROM Ketqua
SELECT * FROM MonHoc
SELECT * FROM KHOA
GO 
CREATE VIEW vw_cau15 
as
SELECT SV.TENSV,KH.TENKH,MH.TENMH,KQ.DIEM FROM Ketqua KQ
JOIN SINHVIEN SV ON KQ.MaSV = SV.MaSV 
JOIN KHOA KH ON SV.MaKH =KH.MaKH
JOIN MONHOC MH  ON KQ.MaMH = MH.MaMH
WHERE KH.TenKH =N'Tin học'
go 
--------cau 16 ----
select SV.TENSV,SV.MAKH,KQ.DIEM,(CASE WHEN KQ.DIEM>8 THEN N'GIOI'
WHEN KQ.DIEM >=6 THEN N'KHA' ELSE N'TRUNGBINH' END ) AS LOAI FROM Ketqua KQ 
JOIN SINHVIEN SV ON KQ.MaSV =SV.MaSV
GO 
-----CACH 2
SELECT SV.TENSV, SV.MAKH, KQ.DIEM,
       IIF(KQ.DIEM > 8, N'GIOI',
           IIF(KQ.DIEM >= 6, N'KHA', N'TRUNGBINH')) AS LOAI
FROM Ketqua KQ
JOIN SINHVIEN SV ON KQ.MaSV = SV.MaSV
GO 
CREATE VIEW vw_cau16 
as 
SELECT SV.TENSV, SV.MAKH, KQ.DIEM,
       IIF(KQ.DIEM > 8, N'GIOI',
           IIF(KQ.DIEM >= 6, N'KHA', N'TRUNGBINH')) AS LOAI
FROM Ketqua KQ
JOIN SINHVIEN SV ON KQ.MaSV = SV.MaSV
go
------cau 17-----
CREATE VIEW vw_cau17
as 
SELECT KH.MAKH,KH.TENKH,ISNULL(MAX(SV.HOCBONG),0)AS HBMAX FROM KHOA KH 
JOIN SINHVIEN SV ON KH.MaKH = SV.MaKH
GROUP BY KH.MAKH,KH.TenKH
go
------cau 18-----
select * from sinhvien 
select * from monhoc 
select * from ketqua
go 
CREATE VIEW vw_cau18 
as 
SELECT COUNT(KQ.MASV) TONG ,KQ.MAMH,MH.TENMH FROM Ketqua KQ
JOIN MONHOC MH ON KQ.MaMH =MH.MaMH
GROUP BY KQ.MaMH,MH.TenMH
go 
---cau 19-----
select * from sinhvien
select * from monhoc 
select * from ketqua
go
CREATE VIEW vw_cau19
as
select MH.TENMH,MH.SOTIET,SV.TENSV,KQ.DIEM AS DIEM
FROM KETQUA KQ
INNER JOIN MonHoc MH ON KQ.MaMH =MH.MaMH
INNER JOIN SINHVIEN SV ON KQ.MaSV =SV.MaSV
INNER JOIN (SELECT MAMH,MAX(DIEM) DIEM FROM KETQUA GROUP BY MaMH) MHMAX ON KQ.MaMH =MHMAX.MaMH AND KQ.DIEM =MHMAX.DIEM
go
-------------------------
SELECT 
    MH.TENMH,
    MH.SOTIET,
    SV.TENSV,
    KQ.DIEM
FROM 
    KETQUA KQ
INNER JOIN MonHoc MH ON KQ.MaMH = MH.MaMH
INNER JOIN SINHVIEN SV ON KQ.MaSV = SV.MaSV
WHERE 
    KQ.DIEM = (
        SELECT MAX(KQ2.DIEM)
        FROM KETQUA KQ2
        WHERE KQ2.MaMH = KQ.MaMH
    )
----------cau20-----
select * from sinhvien
select * from khoa
go
CREATE VIEW vw_cau20
as
select KH.MAKH,KH.TENKH,COUNT(SV.MASV) AS TONGSOSV FROM KHOA KH
JOIN SINHVIEN SV ON KH.MaKH = SV.MaKH
GROUP BY KH.MaKH,KH.TenKH
HAVING 
    COUNT(SV.MASV) = (
        SELECT MAX(TONG) 
        FROM (
            SELECT COUNT(SV2.MASV) AS TONG
            FROM KHOA KH2
            JOIN SINHVIEN SV2 ON KH2.MaKH = SV2.MaKH
            GROUP BY KH2.MAKH
        ) AS Temp
    )
go
----------cau21-------
create view vw_cau21
as
SELECT kh.TenKH, sv.TenSV, sv.HocBong
FROM SinhVien sv
INNER JOIN Khoa kh ON sv.MaKH = kh.MaKH
WHERE sv.HocBong = (
    SELECT MAX(sv2.HocBong)
    FROM SinhVien sv2
    WHERE sv2.MaKH = sv.MaKH
)
go

SELECT * FROM KHOA
GO
CREATE VIEW vw_cau22
as
 SELECT SV.MASV,SV.HOSV+' '+SV.TENSV AS HOTEN,KH.TENKH,SV.HOCBONG FROM SINHVIEN SV
 INNER JOIN KHOA KH ON SV.MaKH = KH.MaKH
 INNER JOIN (SELECT MAKH,MAX(HOCBONG) MAXHOCB FROM SINHVIEN WHERE MAKH =N'TH' GROUP BY MAKH) HBMAX ON SV.MaKH =HBMAX.MAKH AND  SV.HOCBONG = HBMAX.MAXHOCB
 go
 SELECT * FROM MonHoc
 select SV.HOSV+' '+SV.TENSV AS HOTEN,MH.TENMH,KQ.DIEM FROM Ketqua KQ
 INNER JOIN 
 MonHoc MH ON KQ.MaMH = MH.MaMH
 INNER JOIN SinhVien SV  ON KQ.MaSV =SV.MaSV
 INNER JOIN (SELECT MAMH,MAX(DIEM) MAXDIEM FROM Ketqua WHERE MaMH=01 GROUP BY MAMH) DIEMMAX ON KQ.MaMH =DIEMMAX.MaMH AND KQ.DIEM =DIEMMAX.MAXDIEM 
go
-----cau 24 ------
SELECT * FROM MonHoc
SELECT TOP 3 
    sv.hosv + ' ' + sv.tensv AS HOTEN,
    kh.tenkh,
    MH.TENMH,
    KQ.DIEM 
FROM KETQUA KQ
INNER JOIN MONHOC MH ON KQ.MAMH = MH.MaMH
INNER JOIN SINHVIEN SV ON KQ.MaSV = SV.MaSV
INNER JOIN KHOA KH ON SV.MaKH = KH.MaKH
WHERE KQ.MaMH = 04
ORDER BY KQ.DIEM ASC
-------------cau 25 -------
go
SELECT TOP 1 kh.MaKH, kh.TenKH, COUNT(*) AS SoNu
FROM Khoa kh
JOIN SinhVien sv ON kh.MaKH = sv.MaKH
WHERE sv.Phai = 1
GROUP BY kh.MaKH, kh.TenKH
ORDER BY SoNu DESC
-------------cau 26------
go
SELECT 
  KH.MaKH,
  KH.TenKH,
  COUNT(SV.MaSV) AS TongSoSinhVien,
  COUNT(CASE WHEN SV.Phai = 0 THEN 0 END) AS SoSinhVienNu
FROM Khoa KH
INNER JOIN SinhVien SV ON KH.MaKH = SV.MaKH
GROUP BY KH.MaKH, KH.TenKH
ORDER BY SoSinhVienNu DESC;
---------cau 27------
go
select SV.HOSV+' '+SV.TENSV HOTEN ,KH.TENKH,(CASE WHEN kq.DIEM >4 THEN N'DAU' ELSE N'ROT'END ) as ketqua from Ketqua KQ
JOIN SINHVIEN SV ON KQ.MaSV =SV.MaSV
JOIN KHOA KH ON SV.MaKH =KH.MaKH
----------CAU 28------------
go
SELECT 
  SV.HOSV + ' ' + SV.TENSV AS HOTEN,
  SV.PHAI,
N'DAU' AS KETQUA FROM Ketqua KQ
INNER JOIN SINHVIEN SV ON KQ.MaSV=SV.MASV
WHERE NOT EXISTS (
SELECT 1 FROM Ketqua KQ
WHERE SV.MASV= KQ.MASV AND KQ.DIEM<4);
---------cau 29 --------
select kq.mamh,mh.tenmh from ketqua kq 
inner join monhoc mh on kq.mamh =mh.mamh
where NOT EXISTS (SELECT 1 FROM KETQUA KQ2 WHERE MH.MaMH= KQ2.MAMH AND KQ2.DIEM <4)
GROUP BY KQ.MaMH,MH.TENMH
----------CAU 30------
SELECT * FROM SINHVIEN
SELECT * FROM KETQUA
select sv.makh,KH.TENKH FROM Ketqua KQ 
INNER JOIN SINHVIEN SV ON KQ.MaSV =SV.MaSV
INNER JOIN KHOA KH ON KH.MaKH =SV.MaKH
WHERE NOT EXISTS (SELECT 1 FROM KETQUA KQ2 WHERE SV.MaSV =KQ2.MaSV AND KQ2.DIEM<5)
GROUP BY SV.MAKH,KH.TENKH
--------- cau 31 -------
go 
select kq.mamh,mh.tenmh, COUNT(CASE WHEN kq.diem > 5 THEN 1 END) AS svdau,
       COUNT(CASE WHEN kq.diem <= 5 THEN 1 END) AS svrot from Ketqua kq
inner join MonHoc mh on kq.MaMH =mh.MaMH
group by kq.MaMH,mh.TenMH
go
---------- cau 32 -------
select kq.mamh,mh.tenmh from Ketqua kq
inner join monhoc mh on kq.MaMH =mh.MaMH
group by kq.MaMH,mh.TenMH
having min(kq.diem)>5
--------cau 33 ------
select kq.masv,sv.makh,sv.hosv+' '+sv.tensv hoten from Ketqua kq
inner join SinhVien sv on kq.masv =sv.MaSV
group by kq.masv,sv.makh,sv.HoSV,sv.TenSV
having min(kq.diem)>5
-------cau 34 -------
SELECT 
    kq.masv, 
    sv.makh, 
    sv.hosv + ' ' + sv.tensv AS hoten,
    COUNT(*) AS SoMonRot
FROM Ketqua kq
INNER JOIN SinhVien sv ON kq.masv = sv.masv
WHERE kq.diem < 5
GROUP BY kq.masv, sv.makh, sv.hosv, sv.tensv
HAVING COUNT(*) > 1;
---------cau 35 -------
select sv.makh,kh.tenkh,count(*) as tongsosvkh from SinhVien sv
inner join khoa kh on sv.MaKH =kh.makh
group by sv.MaKH,kh.tenkh
having COUNT(*) >2
-------cau 36------
SELECT 
    kq.masv, 
    sv.makh, 
    sv.hosv + ' ' + sv.tensv AS hoten,
    COUNT(kq.MaMH) AS somonthi
FROM Ketqua kq
INNER JOIN SinhVien sv ON kq.masv = sv.masv
GROUP BY kq.masv, sv.makh, sv.hosv, sv.tensv
HAVING COUNT(kq.MaMH) > 4;
-------cau 37------
select * from SinhVien
SELECT 
    kh.makh,
	kh.TenKH,
    COUNT(sv.MaSV) AS tsSvNam
FROM SinhVien sv 
INNER JOIN Khoa kh ON sv.MaKH =kh.MaKH
where sv.Phai =1
GROUP BY 
    kh.makh,
	kh.TenKH
HAVING COUNT(sv.MaSV) > 1;