# OpenHL 2.11.0

Sửa giao diện chat theo phản hồi: thanh tab gọn, mở lại đúng tab cũ, chuột/cuộn hoạt động, hết lệch con trỏ và lệch khung tin nhắn.

## Sửa lỗi
- **Mỗi lần mở lên ra tab mới**: `sessions.latest()` bị lỗi (biến `list` trùng tên hàm) và constructor luôn tạo thêm một phiên trống ở tab đầu. Giờ OpenHL nhớ danh sách tab + tab đang mở (`ui-state.json` cạnh thư mục `.sessions`) và mở lại đúng tab đó. Phiên trống cũ không nằm trong tab sẽ được dọn.
- **Không cuộn / không bấm được**: 2.10.5 tắt chuột mặc định. Giờ chuột bật mặc định (lăn chuột cuộn, bấm tab/nút). Giữ **Shift** khi kéo để bôi đen chữ; đặt `OPENHL_MOUSE=0` để tắt hẳn. Thêm Shift/Ctrl+↑/↓ để cuộn, bỏ hành vi "bấm vào vùng chat là cuộn lên".
- **Con trỏ ô soạn tin nằm xa chữ**: khung soạn tin không được dịch theo `x` còn con trỏ thì có, nên trên terminal rộng con trỏ lệch cả chục cột. Đã canh lại (khung và tin nhắn cùng lề trái).
- **Tin nhắn bị "cắt"/lệch một cột bên phải** (ví dụ `Test      |`): bỏ viền phải; tin của bạn là khối nền có vạch `┃` bên trái, tin của OpenHL là chữ thường. Tin của bạn được hiển thị đúng như đã gõ (không qua Markdown nên không bị nuốt khoảng trắng/`|`/`*`).
- Con trỏ trong trình soạn System Prompt lệch 1 dòng.

## Giao diện gọn hơn (giống OpenCode)
- Phần đầu chỉ còn **1 dòng**: tab ở bên trái (tab đang mở có `×`), `+` tạo tab mới, `⚙ prompt` ở góc phải (có chấm xanh khi đã đặt System Prompt). Bỏ hàng tab 3 dòng, dòng "Đang mở: …", dòng nút và dòng kẻ ngang.
- `×` trên tab giờ **đóng tab** (giữ lại cuộc trò chuyện trên đĩa). Xoá hẳn: `/tab delete [n]`.
- Khung soạn tin: vạch accent bên trái, bỏ viền hộp; trình soạn System Prompt bớt 1 dòng phụ.

## Bản vá thêm
- `/provider` hiển thị đủ mọi provider; ChatGPT (mặc định đang tắt) không còn bị ẩn. Provider chưa cài hiện gợi ý `openhl install <tên>`; provider đã cài nhưng đang tắt sẽ tự bật khi chọn.
- Giữa các tin nhắn có đúng 1 dòng trống cho thoáng.
- Cuộc trò chuyện mới/trống có màn hình chào kiểu OpenCode: logo OPENHL ở giữa, ô nhập căn giữa phía dưới logo, gợi ý phím bên dưới. Gửi tin đầu tiên thì chuyển sang giao diện chat bình thường.

## Bám sát giao diện OpenCode
- Menu `/lệnh`: bỏ khung viền, hiện thành danh sách ngay trên ô nhập (cột tên lệnh in đậm + cột mô tả xám), dòng đang chọn tô màu đào, cuộn tối đa 10 dòng.
- Placeholder `Hỏi bất cứ điều gì… "Sửa các test bị lỗi"`, con trỏ khối, dòng `Build · model · provider` (Build xanh, model trắng).
- Tab: `+ Chat mới` là nút nền riêng; màn chào có đường dẫn bên trái và phím tắt bên phải dưới ô nhập, không còn thanh trạng thái dưới cùng.
- Dòng chân mỗi câu trả lời: `Build · model · 8m 52s · 166.3 tok/s`; nhiều lệnh công cụ được gộp thành `+ 18 run_command, 31 write_file`.
- Khi cuộn lên: nút `Nhảy xuống cuối ↓` (bấm được) ngay trên ô nhập. Thanh dưới cùng hiện tổng token và phím tắt, phím in sáng, nhãn xám.

## Quét khối & xuống dòng
- **Quét khối ngay trong OpenHL** (giống OpenCode): giữ chuột trái và kéo để bôi đen (đảo màu), nhả chuột là tự sao chép vào clipboard. Không cần giữ Shift nữa (Shift+kéo kiểu terminal vẫn dùng được). Nhấn phím bất kỳ hoặc bấm chỗ khác để bỏ chọn. Khi sao chép, vạch `┃` đầu dòng được lược bỏ.
- **Xuống dòng**: Ctrl+J, hoặc gõ `\` rồi Enter (luôn hoạt động). Windows Terminal gửi Shift+Enter giống hệt Enter nên không phân biệt được; để dùng Shift+Enter, thêm vào `actions` trong settings.json của Windows Terminal:
  `{ "command": { "action": "sendInput", "input": "\u001b[13;2u" }, "keys": "shift+enter" }`
