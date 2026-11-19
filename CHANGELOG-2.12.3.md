# OpenHL 2.12.3

## Sửa lỗi Google AI Studio không khởi động
- Giao diện trước đây chỉ bật tiến trình rồi đợi `/models`, không bật dịch vụ sinh nội dung (generation service) của AI Studio nên hay treo hoặc báo "backend chưa sẵn sàng". Giờ dùng chung một đường khởi động: đợi server, tự gọi `/api/control/start` (thử lại, coi 409/400 là đã chạy), rồi đợi `/models`.
- Tiến trình thoát ngay (lỗi cấu hình, thiếu trình duyệt, ...) được phát hiện tức thì và hiện đúng đoạn log của lần chạy đó, thay vì đợi hết 90 giây.
- Bản AI Studio không nhận tham số `-open-ui=false` ("flag provided but not defined") sẽ tự chạy lại không kèm tham số.
- Cổng 2048 đang bị chương trình/cửa sổ cũ giữ: nếu nó là backend khỏe thì dùng luôn; nếu không thì báo rõ cổng nào và cách đổi, không còn sinh tiến trình thứ hai rồi chết.
- Tiến trình treo (không bao giờ khỏe) bị dọn và khởi động lại thay vì dùng mãi.
- Chưa có tài khoản Google: báo ngay `openhl login aistudio` (trước đây tiến trình chạy rồi lỗi mơ hồ). Thông báo lỗi không còn gán nhầm mọi lỗi khởi động AI Studio thành "chưa đăng nhập".
- Thời gian chờ khởi động AI Studio mặc định 180 giây (đổi bằng `providers.aistudio.startTimeoutMs`).
- `config.json` dựng trên Linux (đường dẫn `/mnt/...`) không còn làm Windows tìm sai thư mục backend; bản đóng gói không còn chứa các đường dẫn đó.
- Log mỗi lần chạy có dòng phân cách, đoạn lỗi chỉ lấy từ lần chạy hiện tại.

## Ngôn ngữ giao diện
- Mặc định tiếng Anh. Đổi bằng `/lang vi` (hoặc `/lang en`, `/lang` để đảo) trong giao diện, hay `openhl lang vi` ngoài terminal. Lựa chọn lưu trong `config.json` (`ui.lang`); biến `OPENHL_LANG` ghi đè.
- Chữ cái đầu của mô tả lệnh, thông báo, lỗi, nhãn hoạt động đều được viết hoa (cả hai ngôn ngữ).
- `openhl help` hiện bản tiếng Anh khi ngôn ngữ là en.

## Ô nhập prompt
- Dòng gợi ý gọn hơn: `Ask anything… “Fix the failing tests”  (Ctrl+Enter: new line)`, không còn bị cắt giữa chừng ở khung hẹp.
