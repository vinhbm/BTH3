﻿USE QLBH
GO
---CAU1: HÃY THỐNG KÊ XEM MỖI HÃNG SẢN XUẤT CÓ BAO NHIÊU SẢN PHẨM---
SELECT*FROM HANGSX
SELECT*FROM SANPHAM
SELECT HANGSX.TENHANG, COUNT(SANPHAM.MASP) AS'So Luong San Pham'
FROM HANGSX
INNER JOIN SANPHAM ON HANGSX.MAHANGSX = SANPHAM.MAHANGSX
GROUP BY HANGSX.TENHANG
--CAU2: HÃY THỐNG KÊ XEM TỔNG TIỀN NHẬP CỦA MỖI SẢN PHẨM TRONG NĂM 2018---
SELECT*FROM NHAP
SELECT MASP, SUM(DONGIAN*SOLUONGN) AS'Tong Tien Nhap'
FROM NHAP
WHERE YEAR(NGAYNHAP)=2020
GROUP BY MASP
---CAU3: THỐNG KÊ SẢN PHẨM XUẤT NĂM 2018 >10000 CỦA SAMSUNG---
SELECT SANPHAM.MASP, SUM(XUAT.SOLUONGX) AS TONGSOLUONGXUAT
FROM XUAT
JOIN SANPHAM ON XUAT.MASP = SANPHAM.MASP
WHERE YEAR(XUAT.NGAYXUAT) = 2020 AND SANPHAM.MAHANGSX = (SELECT MAHANGSX FROM HANGSX WHERE TENHANG = N'SAMSUNG')
GROUP BY SANPHAM.MASP
HAVING SUM(XUAT.SOLUONGX) >=1

----CAU4: THỐNG KÊ SL NV NAM MỖI PHÒNG BAN---
SELECT PHONG, COUNT(*) AS'So Luong NV Nam'
FROM NHANVIEN 
WHERE GIOITINH=N'Nam'
GROUP BY PHONG
---CAU5:THỐNG KÊ SL NHẬP MỖI HÃNG SX NĂM 2018
SELECT HANGSX.TENHANG, SUM(NHAP.SOLUONGN) AS 'TongSoLuongNhap'
FROM HANGSX
INNER JOIN SANPHAM ON HANGSX.MAHANGSX= SANPHAM.MAHANGSX
INNER JOIN NHAP ON SANPHAM.MASP = NHAP.MASP
WHERE YEAR(NHAP.NGAYNHAP) = 2020
GROUP BY HANGSX.TENHANG
---CAU6: THỐNG KÊ SL TIỀN XUẤT MỖI NV NĂM 2018
SELECT NHANVIEN.TENNV, SUM(XUAT.SOLUONGX * SANPHAM.GIABAN) AS 'Tong Tien Xuat'
FROM NHANVIEN
INNER JOIN XUAT ON NHANVIEN.MANV = XUAT.MANV
INNER JOIN SANPHAM ON XUAT.MASP = SANPHAM.MASP
WHERE YEAR(XUAT.NGAYXUAT) = 2020
GROUP BY NHANVIEN.TENNV
---CAU7:
SELECT MANV, SUM(SOLUONGN*DONGIAN) AS TỔNG
FROM NHAP 
WHERE MONTH(NGAYNHAP) = 7 AND YEAR(NGAYNHAP) = 2020
GROUP BY MANV
HAVING SUM(SOLUONGN*DONGIAN) >100.000
---CAU8 : ĐƯA RA DANH SÁCH CÁC SẢN PHẨM ĐÃ NHẬP NHỮNG CHƯA XUẤT BAO GIỜ
SELECT SANPHAM.MASP, SANPHAM.TENSP
FROM SANPHAM
LEFT JOIN NHAP N ON SANPHAM.MASP = N.MASP
LEFT JOIN XUAT X ON SANPHAM.MASP = X.MASP
WHERE N.SOLUONGN IS NOT NULL AND X.MASP IS NULL
GROUP BY SANPHAM.MASP, SANPHAM.TENSP



