USE master
GO 
--- TAO DATABASE QL SINH VIEN
CREATE DATABASE QLSV ON
(NAME = Qlsv,
    FILENAME = 'F:\Database\Qlsv.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
(NAME = Qlsv_log,
    FILENAME = 'F:\Database\Qlsvlog.ldf',
    SIZE = 5 MB,
    MAXSIZE = 25 MB,
    FILEGROWTH = 5 MB);
GO
use QLSV
--Tạo bảng lớp học
Create table  Class
(
	ClassId int identity(1,1) primary key,
	ClassName varchar(10) unique not null
)
go
--Tạo bảng môn học
Create table [Subject]
(
	SubjectId varchar(6) primary key,
	SubjectName nvarchar(100) not null,
	Hours int default 0
)
go
--Tạo bảng Sinh viên
Create table Student
(
	StudentId char(5) primary key,
	ClassId int foreign key references Class(ClassId),
	FirstName nvarchar(25) not null,
	LastName nvarchar(10) not null,
	[Address] nvarchar(100),
	BirthDay datetime,
	Gender bit,
	Phone varchar(12)
)
go
--Tạo bảng điểm
Create table Result
(
	StudentId char(5) foreign key references [Student](StudentId),
	SubjectId varchar(6) foreign key references [Subject](Subjectid),
	Mark float Check(Mark>=0 and Mark<=25),
	primary key(SubjectId,StudentId)
)
go
--Tạo bảng
Create table StudentGrant
(
	StudentId char(5) foreign key references Student(StudentId),
	SubjectId varchar(6) foreign key references [Subject](SubjectId),
	Amount float,
	Primary key(StudentId,SubjectId)	
)
--Thêm dữ liệu cho bảng lớp
Insert into Class(ClassName) values('T0709H1')
Insert into Class(ClassName) values('T0709H4')
Insert into Class(ClassName) values('T0709H7')
Insert into Class(ClassName) values('T0709I')
Insert into Class(ClassName) values('T0801H')
Insert into Class(ClassName) values('T0808H1')
Insert into Class(ClassName) values('T0803L')
--Thêm dữ liệu cho bảng môn học
Insert into [Subject] values('CF',N'Computer Foundation',16)
Insert into [Subject] values('EPC',N'Elementary Programming C',30)
Insert into [Subject] values('HDJ',N'HTML, DHTML and JavaScript',30)
Insert into [Subject] values('RDBMS',N'RDBMS and Data Management',24)
Insert into [Subject] values('JAVA',N'Learn Java by Example',28)
Insert into [Subject] values('ASP',N'Active Server Page',10)
Insert into [Subject] values('PRJ1',N'Project Sem I',10)
--Thêm dữ liệu vào bảng Sinh viên
Insert into Student values('B0001',1,N'Hoàng Văn',N'Mạnh',N'Hà Nội','2/13/1988',1,'098789768')
Insert into Student values('B0002',1,N'Nguyễn Thùy',N'Dung',N'Quảng Ninh','6/23/1989',0,'0123987567')
Insert into Student values('B0003',1,N'Lê Văn',N'Nam',N'Hà Nội','3/24/1990',1,'0123788766')
Insert into Student values('B0004',2,N'Nguyễn Văn',N'Tiến',N'Hà Tây','6/14/1986',1,'0123987654')
Insert into Student values('B0005',2,N'Hoàng Thu',N'Thủy',N'Hải Phòng','4/21/1989',0,'0987674554')
Insert into Student values('B0006',2,N'Lê Hải',N'Yến',N'Hà Nội','4/25/1988',0,'0989876543')
Insert into Student values('B0007',2,N'Nguyễn Văn',N'Tiến',N'Ninh Bình','5/18/1988',1,'0904876542')
Insert into Student values('B0008',3,N'Trần Mạnh',N'Hà',N'Nam Định','6/16/1990',1,'0904987654')
Insert into Student values('B0009',3,N'Bùi Văn',N'Mạnh',N'Hà Nội','7/13/1987',1,'0934567900')
Insert into Student values('B0010',3,N'Nguyễn Thị Quỳnh',N'Quyên',N'Hà Nội','2/13/1988',0,'0956789763')
Insert into Student values('B0011',4,N'Lê Ngọc',N'Đạt',N'Tuyên Quang','2/19/1986',1,'04567098')
Insert into Student values('B0012',4,N'Sùng A',N'Cỡ',N'Lào Cai','2/28/1981',1,'04567897')
Insert into Student values('B0013',4,N'Nguyễn Như',N'Quỳnh',N'Hà Nội','5/30/1988',0,'0987876554')
Insert into Student values('B0014',4,N'Nguyễn Cửu',N'Long',N'Hà Nam','4/23/1985',1,'091567654')
Insert into Student values('B0015',4,N'Trịnh Công',N'Trung',N'Hà Nội','10/29/1987',1,'096789765')
--Thêm dữ liệu vào bảng điểm
Insert into Result values('B0001','CF',12)
Insert into Result values('B0001','EPC',12.5)
Insert into Result values('B0001','HDJ',22.5)
Insert into Result values('B0001','RDBMS',15)
Insert into Result values('B0002','CF',22)
Insert into Result values('B0002','EPC',16.5)
Insert into Result values('B0002','HDJ',23)
Insert into Result values('B0002','RDBMS',24)
Insert into Result values('B0008','CF',12)
Insert into Result values('B0008','EPC',9)
Insert into Result values('B0008','HDJ',6)
Insert into Result values('B0008','RDBMS',21)
Insert into Result values('B0011','CF',6)
Insert into Result values('B0011','EPC',9.5)
Insert into Result values('B0011','HDJ',14)
Insert into Result values('B0011','RDBMS',20)
Insert into Result values('B0015','CF',24)
Insert into Result values('B0015','EPC',21)
Insert into Result values('B0015','HDJ',19.5)
Insert into Result values('B0015','RDBMS',22.5)
--Cập nhật bảng học bổng
Insert into StudentGrant(StudentId,SubjectId,Amount) select StudentId,SubjectId,100 from Result where Mark>=22.5
Go
Select * from StudentGrant
--- TRUY VAN CHI TIET DS CAC MON HOC 
SELECT * FROM Subject
SELECT [SubjectId], [SubjectName], [Hours] FROM Subject
--- LIET KE CAC SINH VIEN GOM MASV HOSV TENSV HOCBONG va xep theo thu tu ma sinh vien
SELECT * FROM Student
SELECT 
    S.StudentId,
    S.FirstName + ' ' + S.LastName AS FullName,
    SG.Amount AS Scholarship
FROM 
    Student S
JOIN 
    StudentGrant SG ON S.StudentId = SG.StudentId
ORDER BY 
    S.StudentId ASC;
	--- liet ke danh sach sach sinh vien masv,hoten,gioi tinh ngaysinh  ds duoc xep theo thu tu cua ten
	go 
SELECT [StudentId],[FirstName]+' '+[LastName],CONVERT (DATE,BIRTHDAY,103)AS BIRTHDAY,GENDER FROM Student 
ORDER BY 
    LastName ASC, FirstName ASC;
	---- LIET KE SIINH VIEN CO CHU THI
GO 
SELECT * FROM Student
GO
SELECT FirstName 
FROM Student 
WHERE FirstName LIKE N'%thị%';
-----TIM TAT CA SINH VIEN KO CO CHU THI
SELECT FirstName 
FROM Student 
WHERE FirstName NOT LIKE N'%Thi%';
--- LIET KE SINH VIEN CO CHU CAI CUOI CUNG LA I
SELECT FIRSTNAME +' '+ LASTNAME AS FULLNAME, DAY(BIRTHDAY) AS DAY,GENDER FROM Student WHERE LASTNAME LIKE N'%i'
--- LIET KE DANH SACH SINH VIEN CO KY TU DAU TIEN CUA TEN NAM TRONG KHOANG TU A DEN M
GO 
SELECT 
    S.StudentId,
    S.FirstName + ' ' + S.LastName AS FullName,
    SG.Amount AS Scholarship
FROM 
    Student S
JOIN 
    StudentGrant SG ON S.StudentId = SG.StudentId
WHERE LEFT(LASTNAME,1) BETWEEN 'A' AND 'M';
GO
---DS SINH VIEN CO TEN NAM TRONG KHOANG TU A DEN M VA DC SAP XEP TANG DAN CUA TEN
SELECT 
    S.FirstName + ' ' + S.LastName AS FullName,
    DAY(S.BirthDay) AS [Day],
    S.Address,
    SG.Amount AS Scholarship
FROM 
    Student S
JOIN 
    StudentGrant SG ON S.StudentId = SG.StudentId
WHERE 
    LEFT(S.LastName, 1) BETWEEN 'A' AND 'M'
ORDER BY 
    S.LastName ASC, S.FirstName ASC;



