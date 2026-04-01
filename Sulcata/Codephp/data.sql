CREATE DATABASE QLQuanNet;
USE QLQuanNet;

-- Bảng cấu hình máy
CREATE TABLE CauHinhMay (
    CAUHINHID INT AUTO_INCREMENT PRIMARY KEY,
    CPU VARCHAR(100),
    RAM VARCHAR(100),
    VGA VARCHAR(100),
    MOTA VARCHAR(225)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng dịch vụ
CREATE TABLE DichVu (
    DICHVUID INT AUTO_INCREMENT PRIMARY KEY,
    TENDICHVU VARCHAR(100),
    GIA DECIMAL(10,2),
    LOAIDICHVUID INT,
    SOLUONGTONKHO INT,
    HINH VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng hóa đơn
CREATE TABLE HoaDon (
    HOADONID INT AUTO_INCREMENT PRIMARY KEY,
    NGUOIDUNGID INT,
    NGAYLAP DATETIME,
    TONGTIEN DECIMAL(10,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng chi tiết hóa đơn
CREATE TABLE ChiTietHoaDon (
    CHITIETHOADONID INT AUTO_INCREMENT PRIMARY KEY,
    HOADONID INT,
    DICHVUID INT,
    SOLUONG INT,
    DONGIA DECIMAL(10,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng máy
CREATE TABLE May (
    MAYID INT AUTO_INCREMENT PRIMARY KEY,
    TENMAY VARCHAR(50),
    TRANGTHAI VARCHAR(25),
    GIATHEOPHUT DECIMAL(18,2),
    CAUHINHID INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng người dùng
CREATE TABLE NguoiDung (
    NGUOIDUNGID INT AUTO_INCREMENT PRIMARY KEY,
    TEN VARCHAR(50),
    EMAIL VARCHAR(50),
    SDT VARCHAR(15),
    DIACHI VARCHAR(100),
    NGAYSINH DATE,
    GIOITINH VARCHAR(10),
    MATKHAU VARCHAR(100),
    LOAINGUOIDUNGID INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng tài khoản
CREATE TABLE TaiKhoan (
    TAIKHOANID INT AUTO_INCREMENT PRIMARY KEY,
    NGUOIDUNGID INT,
    SODU DECIMAL(18,2),
    NGAYTAO DATETIME,
    TRANGTHAI VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng khuyến mãi
CREATE TABLE KhuyenMai (
    KHUYENMAIID INT AUTO_INCREMENT PRIMARY KEY,
    TENKHUYENMAI VARCHAR(50),
    GIAM DECIMAL(5,2),
    NGAYBATDAU DATE,
    NGAYKETTHUC DATE,
    TRANGTHAI VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng lịch sử sử dụng
CREATE TABLE LichSuSuDung (
    LICHSUID INT AUTO_INCREMENT PRIMARY KEY,
    NGUOIDUNGID INT,
    MAYID INT,
    THOIGIANBATDAU DATETIME,
    THOIGIANKETTHUC DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng loại dịch vụ
CREATE TABLE LoaiDichVu (
    LOAIDICHVUID INT AUTO_INCREMENT PRIMARY KEY,
    TENLOAIDICHVU VARCHAR(100),
    MOTA VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng loại người dùng
CREATE TABLE LoaiNguoiDung (
    LOAINGUOIDUNGID INT AUTO_INCREMENT PRIMARY KEY,
    TENLOAINGUOIDUNG VARCHAR(100),
    MOTA VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--Khóa ngoại
-- Liên kết dịch vụ với loại dịch vụ
ALTER TABLE DichVu
ADD CONSTRAINT FK_DichVu_LoaiDichVu
FOREIGN KEY (LOAIDICHVUID) REFERENCES LoaiDichVu(LOAIDICHVUID);

-- Liên kết hóa đơn với người dùng
ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_NguoiDung
FOREIGN KEY (NGUOIDUNGID) REFERENCES NguoiDung(NGUOIDUNGID);

-- Liên kết chi tiết hóa đơn với hóa đơn
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT FK_ChiTietHoaDon_HoaDon
FOREIGN KEY (HOADONID) REFERENCES HoaDon(HOADONID);

-- Liên kết chi tiết hóa đơn với dịch vụ
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT FK_ChiTietHoaDon_DichVu
FOREIGN KEY (DICHVUID) REFERENCES DichVu(DICHVUID);

-- Liên kết máy với cấu hình máy
ALTER TABLE May
ADD CONSTRAINT FK_May_CauHinhMay
FOREIGN KEY (CAUHINHID) REFERENCES CauHinhMay(CAUHINHID);

-- Liên kết người dùng với loại người dùng
ALTER TABLE NguoiDung
ADD CONSTRAINT FK_NguoiDung_LoaiNguoiDung
FOREIGN KEY (LOAINGUOIDUNGID) REFERENCES LoaiNguoiDung(LOAINGUOIDUNGID);

-- Liên kết tài khoản với người dùng
ALTER TABLE TaiKhoan
ADD CONSTRAINT FK_TaiKhoan_NguoiDung
FOREIGN KEY (NGUOIDUNGID) REFERENCES NguoiDung(NGUOIDUNGID);

-- Liên kết lịch sử sử dụng với người dùng
ALTER TABLE LichSuSuDung
ADD CONSTRAINT FK_LichSuSuDung_NguoiDung
FOREIGN KEY (NGUOIDUNGID) REFERENCES NguoiDung(NGUOIDUNGID);

-- Liên kết lịch sử sử dụng với máy
ALTER TABLE LichSuSuDung
ADD CONSTRAINT FK_LichSuSuDung_May
FOREIGN KEY (MAYID) REFERENCES May(MAYID);
--Dữ liệu
-- Thêm dữ liệu cho bảng CauHinhMay
INSERT INTO CauHinhMay (CPU, RAM, VGA, MOTA)
VALUES 
('Intel Core i5', '8GB', 'NVIDIA GTX 1050', 'Máy cấu hình trung bình'),
('Intel Core i7', '16GB', 'NVIDIA GTX 1660', 'Máy cấu hình cao'),
('AMD Ryzen 5', '16GB', 'AMD RX 580', 'Máy chơi game phổ thông');

-- Thêm dữ liệu cho bảng LoaiDichVu
INSERT INTO LoaiDichVu (TENLOAIDICHVU, MOTA)
VALUES
('Đồ ăn/uống', 'Các loại thực phẩm, nước giải khát'),
('Thẻ giờ chơi', 'Thẻ nạp thời gian chơi máy');

-- Thêm dữ liệu cho bảng DichVu
INSERT INTO DichVu (TENDICHVU, GIA, LOAIDICHVUID, SOLUONGTONKHO, HINH)
VALUES
('Nước ngọt', 10000, 1, 50, 'https://th.bing.com/th/id/R.96a1e19dc12929c8bc01cd7a8cc9ea59?rik=KVHFOphN%2bQ2Hpg&riu=http%3a%2f%2ffile.hstatic.net%2f1000394081%2farticle%2fnuoc-ngot_f959f1b7921240f49c1c6842dc5d7894.jpg&ehk=ksdYg63f6T%2bpJf7toyou6N%2br4569hC6G6A%2bSYLSSzo8%3d&risl=&pid=ImgRaw&r=0'),
('Mì tôm', 15000, 1, 100, 'https://i.ytimg.com/vi/uUKPoovJ7LE/maxresdefault.jpg'),
('Thẻ giờ chơi 1h', 5000, 2, 9999, 'thegio.jpg');

-- Thêm dữ liệu cho bảng LoaiNguoiDung
INSERT INTO LoaiNguoiDung (TENLOAINGUOIDUNG, MOTA)
VALUES
('Khách hàng', 'Người sử dụng dịch vụ'),
('Quản trị viên', 'Quản lý hệ thống');

-- Thêm dữ liệu cho bảng NguoiDung
INSERT INTO NguoiDung (TEN, EMAIL, SDT, DIACHI, NGAYSINH, GIOITINH, MATKHAU, LOAINGUOIDUNGID)
VALUES
('Nguyễn Văn A', 'vana@example.com', '0912345678', '123 Lê Lợi, Đắk Lắk', '2000-05-20', 'Nam', '123456', 1),
('Trần Thị B', 'thib@example.com', '0987654321', '456 Nguyễn Huệ, Đắk Lắk', '1999-08-15', 'Nữ', 'abcdef', 1),
('Admin', 'admin@example.com', '0909090909', 'Trung tâm Net', '1990-01-01', 'Nam', 'admin123', 2);

-- Thêm dữ liệu cho bảng TaiKhoan
INSERT INTO TaiKhoan (NGUOIDUNGID, SODU, NGAYTAO, TRANGTHAI)
VALUES
(1, 50000, '2026-03-25 08:00:00', 'Hoạt động'),
(2, 20000, '2026-03-25 08:10:00', 'Hoạt động'),
(3, 0, '2026-03-25 08:20:00', 'Khóa');

-- Thêm dữ liệu cho bảng May
INSERT INTO May (TENMAY, TRANGTHAI, GIATHEOPHUT, CAUHINHID)
VALUES
('Máy 01', 'Đang sử dụng', 200, 1),
('Máy 02', 'Trống', 200, 2),
('Máy 03', 'Đang bảo trì', 250, 3);

-- Thêm dữ liệu cho bảng HoaDon
INSERT INTO HoaDon (NGUOIDUNGID, NGAYLAP, TONGTIEN)
VALUES
(1, '2026-03-25 08:30:00', 20000),
(2, '2026-03-25 09:00:00', 15000);

-- Thêm dữ liệu cho bảng ChiTietHoaDon
INSERT INTO ChiTietHoaDon (HOADONID, DICHVUID, SOLUONG, DONGIA)
VALUES
(1, 1, 2, 10000),   -- 2 chai nước ngọt
(1, 2, 1, 15000),   -- 1 gói mì
(2, 3, 3, 5000);    -- 3 thẻ giờ chơi

-- Thêm dữ liệu cho bảng KhuyenMai
INSERT INTO KhuyenMai (TENKHUYENMAI, GIAM, NGAYBATDAU, NGAYKETTHUC, TRANGTHAI)
VALUES
('Giảm giá hè', 10.00, '2026-06-01', '2026-06-30', 'Sắp diễn ra'),
('Khuyến mãi Tết', 20.00, '2026-01-20', '2026-02-10', 'Đã kết thúc');

-- Thêm dữ liệu cho bảng LichSuSuDung
INSERT INTO LichSuSuDung (NGUOIDUNGID, MAYID, THOIGIANBATDAU, THOIGIANKETTHUC)
VALUES
(1, 1, '2026-03-25 08:00:00', '2026-03-25 09:00:00'),
(2, 2, '2026-03-25 08:15:00', '2026-03-25 09:15:00');
