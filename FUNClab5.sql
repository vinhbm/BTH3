use QLBH
go
create function fn_Timhang(@masp nvarchar(10))
returns nvarchar(20)
as
begin
declare @ten nvarchar(20)
set @ten = (select tenhang from hangsx inner join sanpham
on hangsx.mahangsx = sanpham.mahangsx
where masp = @masp)
return @ten
end
select dbo.fn_Timhang('SP01')

---cau2
create function fn_thongkenhaptheonam(@x int,@y int)
returns int
as
begin
declare @tongtien int
select @tongtien = sum(soluongN*dongiaN)
from nhap
where year(ngaynhap) between @x and @y
return @tongtien
end

---cau3
CREATE FUNCTION ThongKeNhapXuat(@tenSanPham NVARCHAR(50), @nam INT)
RETURNS INT
AS
BEGIN
  DECLARE @soLuongNhapXuat INT;
  SELECT @soLuongNhapXuat = SUM(soLuongNhapXuat) 
  FROM
    (SELECT SUM(soluongN) AS soLuongNhapXuat FROM Nhap 
      WHERE YEAR(ngaynhap) = @nam AND masp IN (SELECT masp FROM Sanpham WHERE tensp = @tenSanPham)
      UNION ALL
     SELECT SUM(soluongX) AS soLuongNhapXuat FROM Xuat 
      WHERE YEAR(ngayxuat) = @nam AND masp IN (SELECT masp FROM Sanpham WHERE tensp = @tenSanPham)
    ) AS nhapXuat;
  RETURN @soLuongNhapXuat;
END;
go
select dbo.ThongKeNhapXuat('07','12')
---cau4
create function fn_thongkenhaptheongay(@x int,@y int)
returns int
as
begin
declare @tongtien int
select @tongtien = sum(soluongN*dongiaN)
from NHAP
where day(Ngaynhap) between @x and @y
return @tongtien
end

drop function fn_thongkenhaptheongay

go
select dbo.fn_thongkenhaptheongay('07','22')
