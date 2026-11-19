# OpenHL 2.12.4 — CLI OpenCode-style và Multi-Account

## TUI / CLI
- Thiết kế lại bố cục TUI thành workspace hai cột: sidebar điều hướng bên trái và vùng chat riêng bên phải, thay vì chỉ thêm lệnh account vào giao diện cũ.
- Sidebar gồm workspace/new session, các phiên gần đây, lối tắt provider và nhóm account; hỗ trợ nhấp chuột để chuyển provider/mở account manager.
- Sidebar tự ẩn ở terminal hẹp; `Ctrl+B` và `/sidebar` dùng để ẩn/hiện thủ công.
- Giữ ứng dụng chat hoàn toàn trong terminal; không phụ thuộc Web UI.
- Bổ sung slash command `/accounts` để mở bảng tài khoản được chia theo provider.
- Thêm các lệnh `openhl accounts` và `openhl account ...` để quản lý tài khoản trực tiếp từ PowerShell/terminal.
- Ẩn các backend clone dùng nội bộ khỏi danh sách provider thông thường.

## Account management
- DeepSeek: tạo hồ sơ theo email, mỗi hồ sơ có thư mục `session/` riêng và cổng backend riêng.
- DeepSeek: đăng nhập, bật/tắt và xóa hồ sơ phụ bằng menu TUI hoặc CLI.
- DeepSeek: tự chuyển sang account đã đăng nhập kế tiếp khi upstream xác nhận quota đã cạn.
- Account quota được cooldown 15 phút; lỗi mạng và rate-limit HTTP 429 thông thường không kích hoạt chuyển account.
- Google AI Studio: hiển thị các auth file đã có và giữ nguyên cơ chế nhiều Google auth của backend.
- Gemini, Qwen, ChatGPT: hiển thị trạng thái cấu hình/đăng nhập hiện có; chưa hỗ trợ pool nhiều session độc lập ở bản này.

## Reliability
- Giữ nguyên lịch sử chat, model và nội dung request khi chuyển DeepSeek account.
- Cập nhật route trong Agent để các bước tiếp theo tiếp tục dùng account vừa chuyển.
- Thêm test cho account session isolation, quota fallback và tránh xoay account nhầm khi gặp rate-limit tạm thời.

## Windows quick start
```powershell
openhl
```

Trong TUI:
```text
/accounts
```

CLI:
```powershell
openhl accounts
openhl account add deepseek abc123@gmail.com --login
openhl account login deepseek abc123@gmail.com
openhl account enable deepseek abc123@gmail.com
openhl account disable deepseek abc123@gmail.com
openhl account remove deepseek abc123@gmail.com
```

Gói source không kèm cấu hình riêng (`config.json`), runtime hoặc session để tránh ghi đè khóa API, phiên đăng nhập và lịch sử của người dùng khi cập nhật.

## Kiểm thử bổ sung
- Test bố cục sidebar tại terminal rộng/hẹp và giới hạn chiều rộng dòng.
- Test account DeepSeek giữ đúng tên provider riêng khi mở menu đăng nhập hồ sơ phụ.
