# OpenHL 2.10.4 — Chat UI and System Prompt editor

## Giao diện chat
- Tạo vùng soạn tin nhắn riêng cố định ở đáy terminal, gần hết chiều rộng và có tối thiểu ba dòng nhập ngay cả khi trống.
- Ô nhập tự tăng chiều cao khi viết nhiều dòng, hỗ trợ xuống dòng bằng Shift+Enter và cuộn theo vị trí con trỏ.
- Tách tin nhắn người dùng và OpenHL thành thẻ riêng có nhãn vai trò, màu sắc và đường viền.
- Chuẩn hoá khoảng trắng của nội dung thường; giữ nguyên khoảng trắng bên trong code block.

## Tab hội thoại
- Tăng kích thước tab thành ba hàng (viền trên, nội dung, viền dưới), mở rộng vùng bấm chuột.
- Tăng chiều rộng tab để tên dễ đọc hơn; tên đầy đủ của tab đang mở được hiển thị ở dòng riêng bên dưới.
- Giữ nguyên thao tác chuyển, tạo mới và xoá tab.

## System Prompt
- Thêm nút giao diện **Chỉnh sửa System Prompt** ngay trong màn hình chat.
- Bấm nút hoặc gõ `/system` để mở trình soạn thảo nhiều dòng độc lập, thay vì chỉ có các lệnh CLI.
- Hỗ trợ Ctrl+S để lưu, Ctrl+R để xoá bản nháp, Esc để huỷ; prompt lưu vào cấu hình và áp dụng cho lượt chat tiếp theo.

## Tham khảo
- Cách tổ chức prompt editor và các vùng tương tác được tham khảo về mặt ý tưởng từ OpenCode: https://github.com/anomalyco/opencode
- Không sao chép nguyên mã nguồn hoặc nhận diện thương hiệu OpenCode; ứng dụng vẫn là OpenHL.
