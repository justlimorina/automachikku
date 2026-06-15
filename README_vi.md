# 🤖 Automachikku (オートマチック)

> [English](README.md) | **Tiếng Việt**

Kịch bản shell tự động giúp thiết lập nhanh, cập nhật hệ thống và cài đặt các phần mềm thiết yếu trên Debian, Ubuntu cùng các hệ điều hành phái sinh.

---

## ✨ Tính năng

- **🛡️ Rào chắn quyền Root:** Đảm bảo kịch bản được chạy với quyền root/sudo để thực hiện cài đặt thành công.
- **💻 Xác minh hệ điều hành:** Tự động kiểm tra file `/etc/os-release` (thông qua `ID` và `ID_LIKE`) nhằm giới hạn chạy kịch bản chỉ trên Debian, Ubuntu hoặc các phái sinh trực tiếp của chúng, tránh chạy nhầm trên các hệ điều hành không tương thích.
- **🔄 Cập nhật & Nâng cấp hệ thống:** Tự động chạy `apt update` và `apt upgrade` để cập nhật mọi gói phần mềm trong hệ thống.
- **📦 Công cụ thiết yếu:** Cài đặt bộ công cụ tiện ích tiêu chuẩn (`curl`, `git`, `build-essential`, `htop`, `unzip`, `zip`, `p7zip-full`, `vlc`).
- **🧩 Tích hợp Flatpak & Flathub:** Cấu hình Flatpak, tích hợp với GNOME Software và tự động thêm kho lưu trữ Flathub.
- **🌐 Google Chrome:** Tải xuống gói cài đặt `.deb` chính thức của Google Chrome, cài đặt vào hệ thống và tự động dọn dẹp file cài sau khi hoàn tất.
- **💬 Discord:** Tải xuống và cài đặt ứng dụng chat Discord (phiên bản `.deb` chính thức).
- **📝 VS Code:** Thiết lập khóa bảo mật GPG cùng kho lưu trữ chính thức của Microsoft để cài đặt Visual Studio Code.
- **⚡ Thiết lập tự động All-in-One:** Tự động chạy tuần tự toàn bộ các tiến trình cài đặt trên chỉ với một lựa chọn duy nhất.

---

## 🖥️ Hướng dẫn khởi động

### Điều kiện tiên quyết

Đảm bảo bạn đang sử dụng hệ điều hành thuộc nhánh **Debian** hoặc **Ubuntu**.

### Cài đặt & Chạy kịch bản

Sao chép kho lưu trữ về máy và khởi chạy kịch bản với quyền root:

```bash
git clone https://github.com/justlimorina/automachikku.git
cd automachikku
sudo ./run.sh
```

---

## 🛠️ Công nghệ sử dụng

| Thành phần | Công nghệ |
|---|---|
| Kịch bản | Bash (Bourne Again Shell) |
| Nền tảng | Debian / Ubuntu và các phái sinh |
| Trình quản lý gói | APT (Advanced Package Tool), Flatpak |

---

## 📂 Cấu trúc dự án

```
automachikku/
├── LICENSE        # Giấy phép MIT
├── README.md      # Tài liệu tiếng Anh
├── README_vi.md   # Tài liệu tiếng Việt (Tệp này)
└── run.sh         # Kịch bản cài đặt tự động chính
```

---

## ⚖️ Giấy phép

Dự án phát hành theo **MIT License**.  
Xem [LICENSE](LICENSE) để biết toàn văn.
