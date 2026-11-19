# OpenHL 2.12.1

## TUI nhân vật AI và sửa luồng hỏi
- Hiển thị nhân vật theo provider/model: ChatGPT, Gemini, Qwen và DeepSeek; biểu tượng có animation khi AI đang hoạt động.
- Trạng thái hoạt động có ngữ cảnh: suy nghĩ, lập kế hoạch, viết câu trả lời, đọc/chỉnh sửa/di chuyển/sao chép tệp, chạy lệnh và chờ người dùng trả lời.
- `ask_user` không có lựa chọn hiện câu hỏi ngay trên ô nhập; nhập câu trả lời rồi Enter, Esc để bỏ qua. Ctrl+C hủy tác vụ kể cả khi đang chờ câu trả lời.
- Giữ tên provider/model của từng lượt trả lời để lịch sử không bị đổi nhân vật khi chuyển backend.
- Thông báo kết nối nhận diện thêm `ECONNRESET`, `ETIMEDOUT`, `ENOTFOUND`, `EAI_AGAIN` và các lỗi mạng tương tự.

