# OpenHL 2.12.5 — OpenCode-style workspace thực sự trong terminal

## TUI Workspace
- Thay bố cục chat toàn chiều ngang bằng workspace hai cột: sidebar điều hướng trái và main chat pane bên phải.
- Sidebar gồm Workspace/New Session, phiên gần đây, provider switcher và account summary theo nhóm provider.
- Nhấp chuột vào phiên gần đây để mở, provider để chuyển nhanh, Account summary để mở Account Manager.
- Thêm `Ctrl+B` và slash command `/sidebar` để ẩn/hiện sidebar.
- Responsive: mặc định hiện sidebar ở terminal rộng; tự về bố cục một cột ở terminal nhỏ.
- Sửa vị trí composer/cursor, điểm nhấp chuột và padding sidebar trong bố cục split-pane.

## Accounts
- Giữ nguyên `/accounts` và các lệnh CLI `openhl accounts`, `openhl account ...`.
- Sửa danh sách DeepSeek để giữ `providerName` của từng hồ sơ; đăng nhập lại hồ sơ phụ sẽ dùng đúng backend/session riêng, không rơi về tài khoản mặc định.
- Cơ chế xoay vòng vẫn chỉ kích hoạt khi backend xác nhận quota cạn; không chuyển chỉ vì lỗi mạng/rate limit thông thường.

## Verification
- 92/92 automated tests passed.
- Kiểm tra cú pháp toàn bộ JavaScript trong `bin/`, `src/`, `test/`.
- Kiểm tra lệnh `openhl accounts` và kiểm tra ZIP sau khi giải nén.
