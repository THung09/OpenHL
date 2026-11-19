# OpenHL 2.11.1

Bản vá lỗi cài ChatGPT.

## Sửa lỗi
- **`openhl install chatgpt` báo `No matching distribution found for chatgpt-web2api`**: OpenHL cài từ PyPI nhưng ChatGPT-Web2API không có trên PyPI. Giờ OpenHL cài thẳng từ GitHub, ghim theo tag release `v0.2.0` (zip, rồi dự phòng `git+https` nếu máy có git). Không còn tự rơi về tên gói trên PyPI để tránh cài nhầm gói lạ trùng tên.
- Nhận diện "đã cài" không còn bắt buộc có `chatgpt-web2api.exe`; chỉ cần gói `chatgpt_web2api` có trong venv (OpenHL chạy bằng `python -m chatgpt_web2api`). Người đã tự cài bằng pip chỉ cần chạy `openhl install chatgpt --force` một lần để tạo file đánh dấu.
- Nếu cả hai nguồn đều lỗi, thông báo giờ hiện lỗi của từng nguồn.

## Ghi chú
- Cần truy cập được github.com và Python 3.11+. Muốn dùng bản khác, đổi `CHATGPT_WEB2API_REF` trong `src/providers.js`.
