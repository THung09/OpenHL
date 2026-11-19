# OpenHL 2.11.2

Sửa ChatGPT không gửi được tin (`No textarea found`, `Send failed: no send button`).

## Nguyên nhân
chatgpt.com đổi giao diện: ô nhập không còn `id="prompt-textarea"` (giờ là `div.ProseMirror` contenteditable) và nút gửi không còn `data-testid="send-button"` (giờ là `button[aria-label="Send"]`). ChatGPT-Web2API v0.2.0 vẫn tìm theo bản cũ.

## Sửa lỗi
- OpenHL tự vá `cdp_driver.py` của ChatGPT-Web2API: nhận ô `ProseMirror`, nhận nút `aria-label="Send"`, và nếu vẫn không bấm được nút thì nhấn Enter trong ô nhập.
- Bản vá chạy tự động sau `openhl install chatgpt` và mỗi lần provider khởi động; chạy lại nhiều lần không bị lặp (an toàn với file đã vá tay). File gốc được sao lưu thành `cdp_driver.py.openhl.bak`.
- Thêm test `test/chatgpt-patch.test.js`.

## Chưa xử lý
- Phần đọc câu trả lời (selector `[data-message-author-role="assistant"]`) chưa được vá vì chưa xác nhận nó có bị đổi hay không. Nếu tin đã gửi mà không thấy trả lời, gửi log `.runtime\logs\chatgpt.log`.
- ChatGPT-Web2API điều khiển Chrome thật; giữ cửa sổ Chrome mở và đã đăng nhập khi dùng.
