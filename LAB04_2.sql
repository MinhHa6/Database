----in ra du lieu cac bang 
select * from [dbo].[Ketqua]
SELECT *  FROM [dbo].[Khoa]
SELECT * FROM [dbo].[MonHoc]
SELECT * FROM [dbo].[SinhVien]
---- cau 1
select * FROM MONHOC
--- LIET KE DANH SACH SINH VIEN CAU2  MA SINH VIEN TANG DAN 
GO 
SELECT MASV,HOSV,TENSV,HOCBONG FROM SinhVien
ORDER BY MASV ASC
-----CAU 3 ---DANH SACH DUOC SAP XEP THEO THU TU CUA TEN
GO
SELECT MASV,TENSV,PHAI,DAY(NGAYSINH) DAY FROM SinhVien
ORDER BY TENSV ASC 
------CAU4 NGAY SINH TANG DAN VA HOC BONG GIAM DAN
GO
SELECT HOSV+' '+TENSV HOTEN ,DAY(NGAYSINH) DAY,HOCBONG FROM SinhVien
ORDER BY DAY(NGAYSINH) ASC,
HOCBONG DESC 
----CAU5 DS MON HOC BAT DAU BANG CHU T CAU5 []%
GO
SELECT * FROM MONHOC 
WHERE TENMH LIKE N'[T]%'
-----LAY TAT CA SINH VIEN CO CHU CAI CUOI CUNG TRONG TEN LA I
GO 
SELECT HOSV+' '+TENSV HOTEN,PHAI,DAY(NGAYSINH) DAY 
FROM SINHVIEN
WHERE TenSV LIKE N'%[I]'
-----LAY DANH SACH KHOA CO KY TU THU2 LA 'N',% LA CAC KY TU DANG SAU
GO
SELECT MAKH,TENKH FROM Khoa
WHERE TenKH LIKE N'_N%'
GO
----LIET KE NHUNG SINH VIEN CO MA HO CO CHUA CHU THI CAU 8
SELECT * FROM SinhVien
WHERE LOWER(HOSV) LIKE N'%THỊ%'
GO
------CAU 9 KYTU DAU TIEN CUA TEN NAM TRONG KHOANG TU A DEN M TANG DAN THEO TEN SV 
SELECT MASV,HOSV+' '+TENSV HOTEN ,PHAI,HOCBONG
FROM SinhVien
---WHERE TENSV >= 'A 'AND TENSV <='M'
WHERE TENSV BETWEEN 'A' AND 'M'
ORDER BY TENSV ASC
----DS SACH SINH VIEN KHOA ANH VAN
GO
SELECT MASV,HOSV+' '+TENSV HOTEN,DAY(NGAYSINH) DAY,MAKH
FROM SinhVien
WHERE MAKH=N'AV'
----WHERE MAKH LIKE N'AV%'
GO
----DS SINH VIEN KHOA VAT LY SAP XEP THEO THU TU NGAY SINH GIAM DAN CAU12
SELECT MASV,HOSV+' '+TENSV HOTEN,DAY(NGAYSINH) DAY,MAKH
FROM SinhVien
WHERE MAKH LIKE N'VL%'
ORDER BY DAY(NGAYSINH) DESC
---DS SINH VIEN CO HK BONG LONNHON 500000 VA SAP XEP THEO THU TU MA KHOA GIAM DAN CAU 13 
GO
SELECT MASV,HOSV+' '+TENSV HOTEN,DAY(NGAYSINH) DAY,MAKH,HOCBONG
FROM SinhVien
WHERE HocBong >500000
ORDER BY MAKH DESC 
GO
---- LIET KE SINH VIEN CO NGAY SINH 20/12/1987 CAU 14 
SELECT MASV,HOSV+' '+TENSV HOTEN,HOCBONG,NgaySinh
FROM SinhVien
---WHERE NgaySinh >CONVERT(DATETIME,('19871220'))
WHERE NGAYSINH ='1987-12-20'

GO 
---CAC SINH VIEN SINH SAU NGAY 20-12-1987,SAP XEP THEO THU TU NGAY SINH GIAM DAN
SELECT MASV,HOSV+' '+TENSV HOTEN,HOCBONG,NgaySinh,NOISINH,DAY(NGAYSINH) DAY
FROM SinhVien
---WHERE NgaySinh >'1987-12-20'
WHERE NgaySinh >(CONVERT (DATETIME,'19871220'))
ORDER BY DAY(NGAYSINH) DESC
GO
-----LIET KE SINH VIEN CO HOC BONG LON HON 10000 VA SINH SONG O THANH PHO HCM
SELECT MASV,HOSV+' '+TENSV HOTEN,HOCBONG,NgaySinh,NoiSinh
FROM SinhVien
WHERE HocBong >10000 AND  NOISINH LIKE N'%Tp. HCM%'
GO
-----DS SINH VIEN KHOA ANH VAN VA KHOA TRIET 
SELECT MASV,MAKH,PHAI 
FROM SinhVien
WHERE MAKH IN ('AV','TR')
---WHERE MAKH = 'AV' OR MAKH='TR'

------DS SINH VIEN CO NGAY SINH TU 1-1-1968  DEN NGAY 5-6-1992 
SELECT MASV,NGAYSINH,HOCBONG,NOISINH 
FROM SINHVIEN
WHERE NGAYSINH BETWEEN CONVERT(DATE,'19680101') AND CONVERT (DATE,'19920605')
 GO 
 -----DS SINHHVIEN CO HOC BONG TU 200000 DEN 80000
 SELECT MASV,NGAYSINH,PHAI,MAKH,HOCBONG
 FROM SINHVIEN
 WHERE HOCBONG BETWEEN 20000 AND 800000 
   GO 
   ------cau 20 nhung mon hoc co so tiet  lon hon 40 va nho hon 
   select  mamh,tenmh,sotiet
   from monhoc
   where sotiet > 40 and sotiet < 60
   go
   ---cau 21 liet ke sinh vien nam cua khoa anh van
   select MaSV,HoSV,tensv,NgaySinh,Phai from sinhvien
   where makh='av' and Phai=1
   ----cau 22 ds sinh vien noi sinh hn va ngay sinh sau 1/1/1990
   go
   select hosv,tensv,noisinh,ngaysinh
   from sinhvien
   where NoiSinh ='HaNoi' and ngaysinh>CONVERT(date,'19900101')
   --- cau 23 liwt ke sinh vien nu ten co chua chu n
   go
   select *
   from sinhvien
   where phai=0 and TenSV like '[a-z]%'
   ---- cau 24 ds cac sinh vien nam khoa tin hoc co ngay sinh sau ngay 30/5/1986
   go 
   select * 
   from sinhvien
   where makh='th' and ngaysinh >CONVERT(date,'19860530') and phai=0
   -- cau 25  phan biet gioi tinh true false doi thanh nam nu
   go 
   select hosv+' '+tensv hoten, case when phai=1 then N'nam' else N'nu' end as gioitinh
   from sinhvien
   go
   -----cau 26  tinh tuoi hien tai cua sinh vien tu nam hien tai 
   select masv,noisinh,makh,DATEDIFF(year,ngaysinh,getdate()) as tuoi
   from SinhVien
   go 
   -----cau 27 cho bt sinh vien co tuoi lon hon 20 
   select hosv+' '+tensv,hocbong,DATEDIFF(year,ngaysinh,getdate()) as tuoi 
   from sinhvien
   where DATEDIFF(year,ngaysinh,getdate())>20
   go
   ---cau 28 cho bt sinh vien co tuoi tu 20 den 30
      select hosv+' '+tensv,hocbong,DATEDIFF(year,ngaysinh,getdate()) as tuoi 
   from sinhvien
   where DATEDIFF(year,ngaysinh,getdate()) BETWEEN 20 and 30
-----  BIEU DIEN GIOI TINH DUOI DANG SO NHI PHAN 
SELECT * ,CASE WHEN PHAI =1 THEN N'NAM'-- WHEN PHAI = 0 THEN N'NU' 
ELSE N'NU' END AS GIOITINH
 FROM SINHVIEN
 GO 
 -----TINH TUOI HIEN TAI CAU 26
 SELECT MASV,NOISINH,MAKH, DATEDIFF(YEAR, NGAYSINH, GETDATE()) AS TUOI
 FROM SINHVIEN
GO 
----TUOI >20
SELECT MASV,NOISINH,MAKH, DATEDIFF(YEAR, NGAYSINH, GETDATE()) AS TUOI
 FROM SINHVIEN
 WHERE NgaySinh >20
GO 
----- SU DUNG HAM TRU VAN 
SELECT *,CASE WHEN PHAI =1 THEN N'NAM'-- WHEN PHAI = 0 THEN N'NU' 
ELSE N'NU' END AS GIOITINH, DATEDIFF(YEAR, NGAYSINH, GETDATE()) AS TUOI
 FROM SINHVIEN
 ORDER BY NGAYSINH ASC
GO 
----DS SINH VIEN SINH VAO THANG 2-1994
SELECT * ,DAY(NGAYSINH) DAY
FROM SINHVIEN
WHERE YEAR(NGAYSINH) = 1994 AND MONTH(NGAYSINH) = 2;
-- CACH KHAC KO SU DUNG HAM THI DUNG SO SANH BETWEEN

------HK BONG >500000 CAO NGUOC LAI SE LA TRUNG BINH
SELECT *, CASE WHEN HOCBONG>=500000 THEN N'CAO'
ELSE  N'TRUNGBINH' END AS DANHGIA
FROM SINHVIEN
go 
------TINH TOAN THONG KE DU LIEU 
SELECT * FROM Ketqua
SELECT * FROM MONHOC 
------ DIEM TRUNG BINH THEO TUNG MON HOC 
SELECT MH.MAMH, MH.TENMH, AVG(KQ.DIEM) AS TRUNGBINHDIEM
FROM KETQUA KQ
JOIN MONHOC MH ON KQ.MAMH = MH.MAMH
GROUP BY MH.MAMH, MH.TENMH;
------SOMONTHI CUA TUNG SINH VIEN
GO
SELECT * FROM SINHVIEN
SELECT * FROM MONHOC
SELECT * FROM Khoa

SELECT SV.MASV, SV.HOSV + ' ' + SV.TENSV AS HOTEN, COUNT(KQ.MAMH) AS SOMONTHI
FROM SINHVIEN SV
JOIN KETQUA KQ ON SV.MASV = KQ.MASV
GROUP BY SV.MASV, SV.HOSV, SV.TENSV;

----SELECT <BOTU,TOP,PERCENT,...> <SELECT LIST---CAC COT>
----FROM <BANG 1>
----INMER JOIN,LEFT JOIN,RIGHT JOIN<TENBANG_2> ON <TEN.BANG _1>.<TENCOT> =<TENCOTBANG_2>.<TENCOT>...//AND <TENBIEUTHUCDK>
----WHERE <MENHDEDK_1> AND/OR <MENH DEDK_2>...
----GROUP BY
----HAVING 
----ORDER BY DESC,ASC

----SUBQUERY
----TRUY VAN SU DUNGTHAM SO


-----BAI 2.8
-----BAI6.5
SELECT * FROM SINHVIEN SV
INNER JOIN KHOA KH ON SV.MaKH=KH.MaKH
WHERE TenKH =N'TIN HỌC'
-------- SU DUNG HAM TRONG TRUY VAN DU LIEU
----cau1 gioi tinh mo ta duoi dang nam nu tinh tuoi,sap xep theo thu  tu tuoi giam dan 
select hosv+' '+tensv as hovaten,makh,DATEDIFF(year,ngaysinh,getdate()) as tuoi,
case when phai=1 then N'nam'
else N'nu' end gioitinh
from sinhvien
order by datediff(year,ngaysinh,GETDATE()) desc
--------- cau 2 ds sinh vien sinh vao thang 2 nam 1994
go
select hosv+' '+tensv as hoten ,phai,day(ngaysinh) ngaysinh
from SinhVien
where month(ngaysinh)=2 
and YEAR(ngaysinh)=1994
------ cau 3 sap xxep du lieu giam dan theo cot ngay sinh 
go
select * from sinhvien 
order by day(ngaysinh) desc
-------cau4 hoc bong lon hon 50000 la cao con lai la trung binh 
go
SELECT masv, phai, makh,
       ISNULL(
           CASE 
               WHEN hocbong > 500000 THEN N'cao'
               ELSE N'trungbinh' 
           END, 
           N'không có'
       ) AS MucHocbong
FROM sinhvien;
go
------cau 5 dua diem thi cua sinh vien,hoten va mamon tang dan 
select sv.HoSV+' '+sv.tensv hoten,kq.diem,kq.mamh
from sinhvien sv
join ketqua kq 
on sv.masv = kq.masv 
group by sv.HoSV,sv.tensv ,kq.diem,kq.mamh
order by sv.HoSV+' '+sv.tensv  asc,mamh asc
----cau 6 ds sinh vien khoa anh van 
go
select sv.tensv, case when sv.phai=1 then N'nam' else N'nu' end  as gioitinh,kh.tenkh
from sinhvien sv 
join khoa kh
on sv.MaKH = kh.MaKH
where kh.TenKH=N'Anh van'
go
--- cau 7 liet ke bang diem cua sinh vien khoa tin hoc 
select * from monhoc
select *  from khoa
select * from ketqua
select kh.tenkh,sv.tensv,mh.tenmh,mh.sotiet,kq.diem
from Ketqua kq 
join MonHoc mh
on kq.MaMH = mh.MaMH
join sinhvien sv
on kq.MaSV = sv.MaSV
join khoa kh
on sv. MaKH = kh.MaKH
where kh.TenKH = N'Tin học'
---- cau 8 ket qua hoc tap cau sinh vien 
go
select kh.tenkh,sv.tensv,mh.tenmh,mh.sotiet,case when kq.diem >8 then N'gioi'
 when kq.diem >=6 and kq.diem <8 then N'kha'
else N'trungbinh' end as loai
from Ketqua kq 
join MonHoc mh
on kq.MaMH = mh.MaMH
join sinhvien sv
on kq.MaSV = sv.MaSV
join khoa kh
on sv. MaKH = kh.MaKH
----- cach ngan gon hon 
SELECT kh.tenkh, sv.tensv, mh.tenmh, mh.sotiet,
       IIF(kq.diem > 8, N'giỏi',
           IIF(kq.diem >= 6, N'khá', N'trung bình')
       ) AS loai
FROM Ketqua kq
JOIN MonHoc mh ON kq.MaMH = mh.MaMH
JOIN SinhVien sv ON kq.MaSV = sv.MaSV
JOIN Khoa kh ON sv.MaKH = kh.MaKH;


go
-----Phan 3 tinh toan thong ke du lieu 
-----cau 1 trung binh diem thi tung mon
select mh.mamh,mh.tenmh,AVG(kq.diem) tbd
from Ketqua kq
join MonHoc mh
on kq.MaMH = mh.MaMH
group by mh.MaMH,mh.TenMH
go
select * from MonHoc
select * from khoa
select * from Ketqua
-----cau 2 ds so mon thi cua tung sinh vien
select sv.tensv,kh.tenkh,COUNT( distinct kq.MaMH) tongsomonthi
from SinhVien sv
join khoa kh 
on sv.MaKH =kh.MaKH
join Ketqua kq
on sv.MaSV = kq.MaSV
group by sv.tensv,kh.tenkh
go
---- cau 3 tong diem thi cau tung sinh vien 
select sv.tensv,sv.phai,kh.tenkh,sum(kq.diem)tongdiemthi
from SinhVien sv 
join khoa kh 
on sv.MaKH = kh.MaKH
join Ketqua kq 
on sv.MaSV = kq.MaSV
group by sv.tensv,sv.phai,kh.TenKH
go 
------ cau 4 tong so sinh vien cua moi khoa 
select kh.tenkh,count(sv.masv)tongsvmoikhoa
from khoa kh 
join SinhVien sv 
on kh.MaKH = sv.MaKH
group by kh.tenkh
go
------ cau 5 diem cao nhat cua moi sinh vien 
select sv.tensv,max(kq.diem) diem
from sinhvien sv
join Ketqua kq
on sv.MaSV = kq.MaSV
group by sv.TenSV
go 
------cau 6 thong tin cua mon hoc co so tiet nhieu nhat 
select tenmh,sotiet
from MonHoc
where Sotiet=(select max(sotiet) from MonHoc)
------ cau 7 cho bt hoc bong cao nhat cua tung khoa 
select sv.makh,kh.tenkh,isnull(max(sv.hocbong),0)hocbongcaonhat
from sinhvien sv
join khoa kh 
on sv.MaKH = kh.MaKH
group by  sv.makh,kh.tenkh
go
------ cau 8 cho bt diem cao nhat cua moi mon 
select mh.tenmh,max(kq.diem)diemcaonhat
from Ketqua kq 
join monhoc mh
on kq.MaMH = mh.mamh
group by mh.TenMH
go 
------cau 9 thong ke so sinh vien hoc cua tung mon 
select mh.mamh,mh.tenmh,count(kq.masv)sosinhviendanghoc
from MonHoc mh
join Ketqua kq
on mh.MaMH = kq.MaMH
group by mh.mamh,mh.tenmh
go
------ cau 10 cho bt mon nao co diem thi cao nhat 
SELECT mh.tenmh,
       mh.sotiet,
       sv.tensv,
       kq.diem
FROM Ketqua kq
JOIN MonHoc mh ON mh.MaMH = kq.MaMH
JOIN SinhVien sv ON sv.MaSV = kq.MaSV
WHERE kq.diem = (
    SELECT MAX(kq2.diem)
    FROM Ketqua kq2
    WHERE kq2.MaMH = kq.MaMH
);
------- cau 11 khoa nao co dong sinh vien nhat 
select top 1 kh.makh,kh.tenkh,count(sv.masv) tongsinhvien
from khoa kh 
join sinhvien sv
on kh.MaKH = sv.MaKH
group by kh.MaKH,kh.TenKH
order by count(sv.masv) desc
go 
------- cau 12  khoa sinh vien lanh hoc bong cao nhat 
select kh.tenkh,sv.tensv,sv.hocbong
from khoa kh 
join sinhvien sv
on kh.MaKH = sv.MaKH
where hocbong=(select max(sv2.HocBong)hb from SinhVien sv2 )
go
------ cau 13 sinh vien khoa tin hoc co hoc bong cao nhat
select top 1 sv.tensv, sv.masv, kh.tenkh, sv.hocbong
from SinhVien sv
join Khoa kh
  on sv.MaKH = kh.MaKH
where sv.MaKH = N'TH'
order by sv.hocbong desc;
 
select sv.tensv,sv.masv,kh.tenkh,sv.hocbong hb
from sinhvien as sv
join khoa kh
on sv.makh= kh.MaKH
where sv.makh = N'TH'and sv.HocBong=(select max(sv2.hocbong)hb from SinhVien sv2) 
------ cau 14 cho bt sinh sinh vien nao co diem mon co so du lieu cao nhat
select * from MonHoc
select top 1 sv.tensv,mh.tenmh, kq.diem
from Ketqua kq 
join MonHoc mh 
on kq.MaMH = mh.MaMH
join sinhvien sv
on kq.MaSV = sv.MaSV
 WHERE mh.TenMH LIKE N'%Cơ sở dữ liệu%'
 order by kq.diem desc
 ---- cau 15 diem thi 3 sinh vien co diem thi mon do hoa thap nhat
 select top 3 sv.tensv,kh.tenkh,mh.tenmh,kq.diem
 from sinhvien sv
 join Ketqua kq 
 on sv.MaSV = kq.masv
 join MonHoc mh 
 on kq.MaMH = mh.MaMH
 join khoa kh 
 on sv.MaKH = kh.MaKH 
 where mh.TenMH like  N'%Đồ họa ứng dụng%'
 order by kq.diem asc
 ---- cau 16 cho bt khoa nao co sinh vien nu nhat 
select top 1 kh.tenkh, count(*) as SoLuongNu
from sinhvien sv
join khoa kh on sv.MaKH = kh.MaKH
where sv.phai = 1
group by kh.tenkh
order by count(*) desc;
--- cau 17 thong so so sinh vien  theo khoa,tong so sinh vien,tong so sinh vien nu
select sv.makh,kh.tenkh,count(sv.masv) tongsosinhvien ,    sum(case when sv.phai = 1 then 1 else 0 end) as TongSoSinhVienNu

from sinhvien sv
join khoa kh
on sv.MaKH = kh.MaKH 
group by sv.makh,kh.tenkh
------ cau 18 cho bt ket qua hoc tap cua sinh vien kq se la dau neu ko co mon nao diem <4
select sv.tensv,kh.tenkh,case when min(kq.diem )>=4 then N'dau' else N'truot' end ketqua
from sinhvien sv
join khoa kh
on sv.MaKH = kh.MaKH 
join Ketqua kq
on sv.MaSV = kq.masv
group by sv.tensv,kh.tenkh
--- cau 19 ds nhung sinh ko co mon naof deim nho hon 4
select sv.tensv, kh.tenkh, sv.phai
from sinhvien sv
join khoa kh on sv.MaKH = kh.MaKH
join Ketqua kq on sv.MaSV = kq.MaSV
group by sv.tensv, kh.tenkh, sv.phai
having min(kq.diem) >= 4;
---- cau 20 cho bt ds nhung mon ko co diem thi <4
go 
select kq.mamh,mh.tenmh
from ketqua kq
join monhoc mh
on kq.MaMH = mh.MaMH
group by kq.mamh,mh.tenmh
having min(kq.diem)>=4
go 
------- cau 21 thong ke khoa nao ko sinh vien rot 
select sv.makh,kh.tenkh
from sinhvien sv
join khoa kh 
on sv.MaKH = kh.MaKH 
join Ketqua kq 
on sv.masv = kq.MaSV 
group by sv.makh,kh.tenkh
having min(kq.diem) >= 5
go
------ cau 22 thong ke so sinh vien dau va rot cua tung mon 
SELECT 
    mh.MaMH,
    mh.TenMH,
    SUM(CASE WHEN kq.Diem >= 5 THEN 1 ELSE 0 END) AS SoSinhVienDau,
    SUM(CASE WHEN kq.Diem < 5 THEN 1 ELSE 0 END) AS SoSinhVienRot
FROM MonHoc mh
JOIN KetQua kq 
    ON mh.MaMH = kq.MaMH
JOIN SinhVien sv
    ON kq.MaSV = sv.MaSV
GROUP BY mh.MaMH, mh.TenMH;
------ cau 23 cho bt mon nao ko co sinh vien rot 
select kq.mamh,mh.tenmh
from monhoc mh 
join ketqua kq 
on mh.MaMH = kq .MaMH
group by kq.mamh,mh.TenMH
having min(kq.diem)>=4
------- cau 24 ds sinh vien ko co mon nao rot 
select sv.masv,sv.tensv,sv.makh
from sinhvien sv
join ketqua kq 
on sv.MaSV = kq.MaSV 
group by sv.masv,sv.tensv,sv.makh
having min(kq.diem) >=5
------ cau 25 ds sinh vien rot tren 2 mon 
select sv.masv,sv.tensv,sv.makh,SUM(CASE WHEN kq.Diem < 5 THEN 1 ELSE 0 END) AS SoSinhVienRot
from sinhvien sv 
join Ketqua kq 
on sv.MaSV = kq.MaSV
group by sv.masv,sv.tensv,sv.makh
having SUM(CASE WHEN kq.Diem < 5 THEN 1 ELSE 0 END) >=2
------ cau 26 cho bt ds nhung khoa co nhieu hon 10 sinh vien 
select kh.makh,kh.tenkh,count(sv.makh) tongsosinhviencuakhoa
from sinhvien sv 
join khoa kh
on sv.MaKH = kh.MaKH 
group by kh.makh,kh.tenkh
having count(sv.Makh) >=5
----- cau 27 ds sinh vien thi nhieu hon 4 
select sv.masv,sv.tensv,count(*)somonthi
from sinhvien sv
join ketqua kq 
on sv.MaSV = kq.MaSV 
group by sv.MaSV,sv.TenSV
having count(*) >=4
------ cau 28 cho bt 5 sinh vien nam tro nen 
select kh.makh,kh.tenkh,
count(case when phai =1 then 1  end )tongsosinhviennam
from sinhvien sv
join khoa kh 
on sv.MaKH = kh.MaKH
group by kh.makh,kh.tenkh
having count(case when phai =1 then 1  end ) >= 5
----- cau 29 ds sinh vien co diem trung binh lon hon 4 
select sv.tensv,kh.tenkh,sv.phai,avg(kq.diem) diemtrungbinhcacmon
from sinhvien sv
join khoa kh
on sv.MaKH = kh.makh
join ketqua kq 
on sv.masv = kq.MaSV
group by sv.tensv,kh.tenkh,sv.phai
having avg(kq.diem) >4 
----- cau 30 
SELECT 
    sv.MaSV,
    sv.TenSV,
    AVG(CASE WHEN kq.Diem > 6 THEN kq.Diem END) AS DiemTrungBinh
FROM SinhVien sv
LEFT JOIN KetQua kq ON sv.MaSV = kq.MaSV
GROUP BY sv.MaSV, sv.TenSV;
------------------------------------------------------SU DUNG THAM TRONG  TRUY VAN ---------------
GO 
---------CCAU 1 CHO BT DS SINH VIEN CUA KHOA MAKHOA LA THAM SO TRUY VAN 
select * from khoa 
declare @tenkh Nvarchar(50)
set @tenkh =N'Anh Văn'
SELECT sv.MaSV,SV.TENSV,SV.PHAI,KH.TENKH
FROM sinhvien sv
JOIN KHOA KH 
ON SV.MAKH = KH.MAKH
where kh.TenKH = @tenkh
--------- cau 2 liet ke ds sinh vien co diem mon co so du lieu lon hon so voi bat ki gia tri nao nguoi dung nhap vao 
declare @diem int 
set @diem =7
select sv.masv,sv.tensv,mh.tenmh,kq.diem
from sinhvien sv
join ketqua kq 
on sv.masv = kq.MaSV
join MonHoc mh 
on kq.MaMH = mh.MaMH
where mh.tenmh like N'%Cơ sở dữ liệu%' and kq.Diem >= @diem
go
---- cau 3 cho ket qua thi cua sinh vien theo mon 
declare @tenmon Nvarchar(50)
set @tenmon =N'Cơ sở dữ liệu'
select sv.masv,kh.tenkh,mh.tenmh,kq.diem
from sinhvien sv
join khoa kh
on sv.MaKH = kh.MaKH
join Ketqua kq
on sv.MaSV = kq.MaSV 
join MonHoc mh
on kq.MaMH = mh.MaMH
where mh.TenMH =@tenmon
select * from MonHoc
select * from ketqua
------truy van con 
go 
-- cau 1 ds sinh vien chua thi mon nao 
SELECT sv.MaSV, sv.TenSV, sv.Phai, sv.MaKH
FROM SinhVien sv
WHERE sv.MaSV NOT IN (
    SELECT kq.MaSV
    FROM KetQua kq
);
---- cau 2 ds nhung sinh vien chua thi mon co so du lieu
select sv.masv,sv.tensv,sv.makh
from sinhvien sv 
where sv.masv not in 
(select kq.masv 
from Ketqua kq 
join monhoc mh 
on kq.MaMH = mh.MaMH 
where mh.TenMH like '%Cơ sở dữ liệu%'
)
---- cau 3 cho bt mon nao chua co sinh vien thi 
SELECT mh.MaMH, mh.TenMH, mh.SoTiet
FROM MonHoc mh
WHERE mh.MaMH NOT IN (
    SELECT kq.MaMH
    FROM KetQua kq
    JOIN SinhVien sv ON kq.MaSV = sv.MaSV
);
------ cau 4 khoa nao chua co sinh vien hoc 
SELECT kh.MaKH, kh.TenKH
FROM Khoa kh
WHERE NOT EXISTS (
    SELECT 1
    FROM SinhVien sv
    WHERE sv.MaKH = kh.MaKH
);
------ cau 5  lay sinh vien khoa anh van chua thi mon co so du lieu
select * from sinhvien
select * from khoa
select sv.masv,sv.makh,sv.tensv,sv.phai
from sinhvien sv
join khoa kh
on sv.MaKH = kh.MaKH
where kh.MaKH = N'AV' and sv.masv not in(select kq.masv 
from Ketqua kq join monhoc mh 
on kq.MaMH = mh.MaMH 
where mh.TenMH like '%Cơ sở dữ liệu%')
---------- cau 6 cho bt mon nao chua co sinh vien khoa triet  
select mh.mamh,mh.tenmh,mh.sotiet
from monhoc mh 
where mh.mamh not in  (select kq.mamh
from ketqua kq 
join sinhvien sv 
on kq.MaSV = sv.MaSV 
where sv.MaKH = N'Tr')
----- cau 7 ds nhung sinh vien co diem thi mon do hoa nho hon diem thi mon do hoa nho nhat cua sinhvien khoa tin hoc 
select sv.masv, sv.tensv, sv.makh, kq.diem
from sinhvien sv
join ketqua kq on sv.masv = kq.masv
join monhoc mh on kq.mamh = mh.mamh
where mh.tenmh = N'Đồ họa'
  and kq.diem < (
      select min(kq2.diem)
      from ketqua kq2
      join sinhvien sv2 on kq2.masv = sv2.masv
      join monhoc mh2 on kq2.mamh = mh2.mamh
      where sv2.makh = N'TH' and mh2.tenmh = N'Đồ họa'
  );
  -------- cau 8 liet ke sinh vien co tuoi nhat trong khoa anh van 

----- cau 
---- cau4 
----bai5.11
--SINHVIEN :MASV,HOTENSV 
--KETQUA :DIEM
--MON: TENMON
-----> DS SINH VIEN CO DIEM CAO NHAT VOI MOI MON
SELECT MASV,HOSV+' '+TENSV AS HOTEN FROM SINHVIEN
SELECT * FROM MONHOC
SELECT * FROM KETQUA

SELECT  KQ.MaSV,HoSV + ' ' + TenSV AS N'Họ và tên',MH.TenMH, KQ.Diem FROM  Ketqua KQ
INNER JOIN 
(SELECT MaMH, MAX(Diem) AS Diem FROM  Ketqua GROUP BY MaMH) KQM ON KQ.MaMH = KQM.MaMH AND KQ.Diem = KQM.Diem
INNER JOIN [dbo].[SinhVien] SV ON KQ.MaSV = SV.MaSV
INNER JOIN MonHoc MH ON MH.MaMH = KQ.MaMH
-------tinh toan thong ke so lieu 
----bai3.3
----sinhvien: tensinhvien,phai
----khoa: ten khoa 
----ketqua: tong diem thi
SELECT * FROM SINHVIEN
SELECT * FROM KHOA
SELECT * FROM KETQUA

SELECT 
    KQ.MaSV,
    SV.TENSV,
    SV.PHAI,
    KH.TENKH,
    SUM(KQ.DIEM) AS TONGDIEM
FROM 
    KETQUA KQ
INNER JOIN 
    SINHVIEN SV ON KQ.MaSV = SV.MaSV
INNER JOIN 
    KHOA KH ON SV.MaKH = KH.MaKH
GROUP BY  
    KQ.MaSV, SV.TENSV, SV.PHAI, KH.TENKH;
GO 
----CACH2 DUNG SUBQUERY
SELECT SV.MASV,SV.TENSV,SV.PHAI,KH.TENKH,KQ.TONGDIEM FROM SINHVIEN SV
INNER JOIN KHOA KH ON SV.MaKH =KH.MAKH
INNER JOIN (SELECT MASV,SUM(DIEM) TONGDIEM FROM Ketqua GROUP BY MASV) KQ  ON KQ.MASV =SV.MaSV
go
-----BAI 3.4
---KHOA : TEN KHOA 
-----> TONG SO SINHVIEN MOI KHOA
SELECT * FROM SINHVIEN
SELECT * FROM KHOA 

SELECT KH.TENKH,COUNT(SV.MASV) TONGSOHS FROM SinhVien SV
INNER JOIN KHOA KH ON SV.MAKH = KH.MAKH
GROUP BY KH.TenKH
GO
----SUDUNG SUBQUERY
SELECT KH.TENKH,SV.TONGSOSV FROM KHOA KH 
INNER JOIN (SELECT COUNT(MASV) TONGSOSV,MAKH FROM SINHVIEN  GROUP BY MAKH) SV ON KH.MaKH =SV.MaKH
GO
----CAU 3.5 
----SINHVIEN: HOTENSINHVIEN
----KETQUA : DIEM
------> DIEM CAO NHAT CUA MOI SINH VIEN 
SELECT * FROM KETQUA
SELECT * FROM SINHVIEN

SELECT KQ.MASV,SV.TENSV,MAX(KQ.DIEM) DIEMCAONHAT FROM KETQUA KQ 
INNER JOIN SINHVIEN SV ON KQ.MaSV =SV.MaSV
GROUP BY SV.TENSV,KQ.MASV
---DUNG SUBQUERY 
SELECT SV.MASV,SV.TENSV,KQ.DIEMCAONHAT FROM SINHVIEN SV
INNER JOIN (SELECT MASV,MAX(DIEM) DIEMCAONHAT FROM Ketqua  GROUP BY MASV) KQ ON SV.MASV =KQ.MASV
GO 
-----BAI 3.6 THONG TIN MON HOC CO SO TIET NHIEU NHAT  TEN MONHOC SO TIET 
SELECT TENMH, SOTIET
FROM MONHOC
WHERE SOTIET = (
    SELECT MAX(SOTIET)
    FROM MONHOC
);
GO 
----3.7 CHO BT HOC BONG CAO NHAT CUA TUNG KHOA 
SELECT * FROM KHOA 
SELECT * FROM SINHVIEN
SELECT KH.MAKH,KH.TENKH,MAX(SV.HOCBONG) MAXHB FROM KHOA KH
INNER JOIN SINHVIEN SV ON KH.MaKH =SV.MaKH
GROUP BY KH.MAKH,KH.TENKH
-----truy van con 
GO 
----5.1 DS SINH VIEN CHUA THI MON NAO
SELECT * FROM SINHVIEN
SELECT * FROM Khoa
SELECT * FROM MonHoC
SELECT * FROM KETQUA
SELECT 
  SV.MASV, 
  SV.TENSV, 
  SV.PHAI, 
  KH.TENKH
FROM 
  SINHVIEN SV
JOIN 
  KHOA KH ON SV.MAKH = KH.MAKH
WHERE 
  SV.MASV NOT IN (
    SELECT DISTINCT MASV 
    FROM KETQUA
  );
  go 
------bai5.12 SINH VIEN CO HOC BONG CAO NHAT MOI KHOA 
SELECT* FROM SINHVIEN
SELECT * FROM KHOA 
GO 
SELECT SV.MASV,KH.TENKH,ISNULL(SV.HOCBONG,0) HOCBONG FROM KHOA KH
INNER JOIN (SELECT MASV,MAKH,MAX(HOCBONG) AS HOCBONG FROM SINHVIEN GROUP BY MAKH,MASV) SV ON KH.MaKH = SV.MAKH
go 
SELECT SV.MASV,KH.TENKH,SV.HOCBONG FROM SINHVIEN SV
INNER JOIN
KHOA KH ON SV.MaKH =KH.MaKH
INNER JOIN 
(SELECT MAKH,MAX(HOCBONG) AS MAX_HOCBONG FROM SINHVIEN GROUP BY MAKH) HB ON SV.MAKH =HB.MaKH AND SV.HocBong=HB.MAX_HOCBONG
GO 
SELECT SV.MASV, SV.HOCBONG, SV.NOISINH, KH.TENKH
FROM SINHVIEN SV
INNER JOIN KHOA KH ON SV.MaKH = KH.MaKH
WHERE EXISTS (
    SELECT 1
    FROM SINHVIEN SV_TIN
    INNER JOIN KHOA KH_TIN ON SV_TIN.MaKH = KH_TIN.MaKH
    WHERE KH_TIN.TENKH =N'TIN HỌC'
      AND SV.HOCBONG = SV_TIN.HOCBONG
      AND SV.NOISINH = SV_TIN.NOISINH
)
go
------5.5 cho bt nhung sinh vien khoa anh van chua thi mon co so du lieu
SELECT * FROM SINHVIEN
SELECT * FROM KHOA 
SELECT * FROM MONHOC
SELECT * FROM KETQUA

-- Danh sách những sinh viên khoa Anh Văn chưa thi môn Cơ sở dữ liệu
SELECT SV.MASV, SV.TENSV
FROM SINHVIEN SV
INNER JOIN KHOA KH ON SV.MAKH = KH.MAKH
WHERE KH.TENKH = 'Anh Văn' 
AND SV.MASV NOT IN (
    SELECT MASV 
    FROM KETQUA KQ
    INNER JOIN MONHOC MH ON KQ.MAMH = MH.MAMH
    WHERE MH.TENMH = 'Cơ sở dữ liệu'
);
----------cau 5.6 danhsach sinh vien KHOA LY CHUA THI MON NAO
SELECT SV.MASV, SV.TENSV
FROM SinhVien SV
JOIN Khoa KH ON SV.MAKH = KH.MAKH
WHERE KH.TENKH = 'Tin học'
  AND SV.MASV NOT IN (
    SELECT DISTINCT MASV
    FROM KetQua
  );
  ------
  SELECT SV.MASV, SV.TENSV
FROM SinhVien SV
JOIN Khoa KH ON SV.MAKH = KH.MAKH
LEFT JOIN KetQua KQ ON SV.MASV = KQ.MASV
WHERE KH.TENKH = 'Tin học'
  AND KQ.MASV IS NULL;
  ---------5.11------ds sinh vien co diem cao nhat ung voi moi mon 
 SELECT KQ.MASV,SV.TENSV,MH.TENMH,KQ.DIEM FROM Ketqua KQ 
 INNER JOIN SinhVien SV ON KQ.MaSV =SV.MASV
 INNER JOIN MonHoc MH ON KQ.MaMH = MH.MaMH
 INNER JOIN (SELECT MAMH,MAX(DIEM) MAXDIEM FROM Ketqua GROUP BY MAMH) MAXDIEMTUNGMON ON KQ.MaMH =MAXDIEMTUNGMON.MAMH AND KQ.Diem =MAXDIEMTUNGMON.MAXDIEM
 ----------5.12-------cac sinh vien co hoc bong cao nhat theo tung khoa 
 SELECT SV.MASV,KH.TENKH,SV.HOCBONG FROM SinhVien SV
 INNER JOIN KHOA KH ON SV.MaKH =KH.MaKH
 INNER JOIN (SELECT MAKH,MAX(HOCBONG) MAXHB,NoiSinh FROM SINHVIEN GROUP BY MaKH) MAXHBB ON SV.MaKH = MAXHBB.MAKH AND SV.HocBong = MAXHBB.MAXHB
 ---------cau 5.10 in ra ds sinh vien khoa ly co cung noi sinh sinh voi sinh vien co hoc bong cao nhat
SELECT SV.MASV, SV.TENSV, SV.NOISINH, KH.TENKH
FROM SinhVien SV
JOIN Khoa KH ON SV.MAKH = KH.MAKH
WHERE KH.TenKH = N'Tin học'
  AND SV.NOISINH IN (
      SELECT SV2.NOISINH
      FROM SinhVien SV2
      JOIN Khoa KH2 ON SV2.MAKH = KH2.MAKH
      WHERE KH2.TenKH = N'Tin học'
        AND SV2.HocBong = (
            SELECT MAX(HocBong)
            FROM SinhVien SV3
            JOIN Khoa KH3 ON SV3.MAKH = KH3.MAKH
            WHERE KH3.TenKH = N'Tin học'
        )
  );
-------6.1
insert into SinhVien ([MaSV], [HoSV], [TenSV], [Phai], [NgaySinh], [NoiSinh], [MaKH], [HocBong]) values 
(N'C02',N'LE NGUYEN',N'THANH',1,'1980-10-20',N'HCM',N'TH',8500000)
