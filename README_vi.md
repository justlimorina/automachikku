# 🤖 Automachikku (オートマチック)

> [English](README.md) | **Tiếng Việt**

Các kịch bản shell tự động giúp thiết lập nhanh, cập nhật hệ thống và cài đặt các phần mềm thiết yếu trên nền tảng Debian/Ubuntu và Fedora.

---

## ✨ Tính năng

- **🛡️ Rào chắn quyền Root:** Đảm bảo cả hai kịch bản đều được chạy dưới quyền root/sudo để thực hiện cài đặt thành công.
- **💻 Xác minh hệ điều hành:** Tự động kiểm tra file `/etc/os-release` (thông qua `ID` và `ID_LIKE`) nhằm giới hạn chạy kịch bản trên các phân phối tương thích, tránh chạy nhầm trên hệ điều hành không được hỗ trợ.
- **🔄 Cập nhật & Nâng cấp hệ thống:** Tự động chạy lệnh cập nhật hệ thống gói phần mềm (`apt` hoặc `dnf`).
- **📦 Công cụ thiết yếu:** Cài đặt bộ công cụ tiện ích tiêu chuẩn (`curl`, `git`, các công cụ biên dịch mã nguồn, `htop`, công cụ giải nén zip, và `vlc`).
- **🧩 Tích hợp Flatpak & Flathub:** Cấu hình Flatpak và tự động đăng ký kho lưu trữ Flathub.
- **🌐 Google Chrome:** Cài đặt trình duyệt Google Chrome chính thức (thông qua gói `.deb` trên Debian/Ubuntu, và gói `.rpm` trên Fedora).
- **💬 Discord:** Cài đặt ứng dụng Discord (thông qua `.deb` trên Debian/Ubuntu, và qua Flatpak trên Fedora).
- **📝 VS Code:** Thiết lập kho lưu trữ và khóa bảo mật chính thức của Microsoft để cài đặt Visual Studio Code.
- **⚡ Thiết lập tự động All-in-One:** Tự động chạy tuần tự toàn bộ các tiến trình cài đặt trên chỉ với một lựa chọn duy nhất.

---

## 🖥️ Hướng dẫn khởi động

### Cài đặt & Chạy kịch bản

Sao chép kho lưu trữ về máy:

```bash
git clone https://github.com/justlimorina/automachikku.git
cd automachikku
```

Khởi chạy kịch bản phù hợp với hệ điều hành của bạn:

#### Dành cho Debian, Ubuntu và các phái sinh:

```bash
sudo ./debian.sh
```

#### Dành cho Fedora và các phái sinh:

```bash
sudo ./fedora.sh
```

---

## 🛠️ Công nghệ sử dụng

| Thành phần | Công nghệ |
|---|---|
| Kịch bản | Bash (Bourne Again Shell) |
| Nền tảng | Debian, Ubuntu, Fedora và các phái sinh tương ứng |
| Trình quản lý gói | APT (Advanced Package Tool), DNF (Dandified YUM), Flatpak |

---

## 📂 Cấu trúc dự án

```
automachikku/
├── LICENSE        # Giấy phép MIT
├── README.md      # Tài liệu tiếng Anh
├── README_vi.md   # Tài liệu tiếng Việt (Tệp này)
├── debian.sh      # Kịch bản cài đặt tự động cho Debian/Ubuntu
└── fedora.sh      # Kịch bản cài đặt tự động cho Fedora
```

---

## ⚖️ Giấy phép

Dự án phát hành theo **MIT License**.  
Xem [LICENSE](LICENSE) để biết toàn văn.
