﻿-------
USE master
GO
----TAO DABASE MOI 
CREATE DATABASE TEST01 
 ON  PRIMARY 
( NAME = N'TEST01', FILENAME = N'F:\Database\TEST01.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TEST01_log', FILENAME = N'F:\Database\TEST01_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
---THEM SUA XOA BANG 
CREATE TABLE MONHOC (
ID BIGINT ,NAME NVARCHAR (100)
)
GO
-----CAP NHAT BANG 
ALTER TABLE MONHOC 
----SUA COT 
ALTER COLUMN NAME NVARCHAR (50)
 GO
 ----THEM COT 
 ALTER TABLE MONHOC 
 ADD PHONGHOC NVARCHAR (20)
 ----SUA TEN TOT 
GO
EXEC sp_rename '[dbo].[MONHOC].[ID]','ID_MONHOC','COLUMN'
GO 
SELECT * FROM MONHOC
GO
------XOA COT 
ALTER TABLE MONHOC 
DROP COLUMN NAME
------ XOA BANG
-----DROP TABLE MONHOC
---THEMDU LIEU 
GO 
INSERT INTO MONHOC ([ID_MONHOC], [NAME]) VALUES 
(01,'TOAN'),
(02,'van')
 ---Thêm dữ liệu

