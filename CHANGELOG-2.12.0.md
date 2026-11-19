# OpenHL 2.12.0

## Thêm / sửa
- **Giọng văn kiểu Claude**: lớp system prompt dựng sẵn (`CORE_STYLE` trong `src/prompt.js`) luôn gửi trước, tách riêng khỏi System Prompt của người dùng (cái hiện trong trình soạn). Nó chỉ định hình giọng điệu và thói quen làm việc; Guardian vẫn kiểm tra mọi tool như cũ.
- **AI tự hỏi người dùng**: tool `ask_user {question, options}`. Có lựa chọn thì hiện hộp chọn; chọn "Trả lời bằng chữ…" hoặc không có lựa chọn thì gõ vào ô soạn rồi Enter. Esc = bỏ qua.
- **Tự sao lưu**: trước khi `write_file`, `append_file`, `replace_in_file`, `move_path`, `delete_path` đụng vào tệp có sẵn trong workspace, OpenHL chép vào `.openhl-backup/<thời gian>/`. Không bao giờ sao lưu hay chạm vùng hệ điều hành/nhạy cảm (dùng lại danh sách của Guardian). Thêm `list_backups`, `restore_backup`, và `discard_backup`: khi AI đã xác định tệp ổn (đọc lại, test qua) nó tự xóa bản sao lưu của tệp đó; chỉ xóa được trong `.openhl-backup/`.
- **Xuống dòng bằng Ctrl+Enter** (cũng Alt+Enter, Ctrl+J, hoặc `\` rồi Enter). Enter và Shift+Enter đều gửi. Đã sửa hướng dẫn, placeholder, README.
- **Thinking theo khả năng từng model**: AI Studio chỉ hiện điều khiển với model có hỗ trợ được xác minh; Gemini 4 Argon/Carbon có Low/Medium/High, Hydrogen có thêm XHigh. Gemini 3 và các model ảnh chỉ hiện đúng mức Google công bố. Gemini 2.5 dùng ngân sách token riêng (theo min/max từng model), không giả làm Low/Medium/High. Gemma và model không hỗ trợ không hiện nút. Claude/DeepSeek giữ hành vi tương ứng; backend từ chối `reasoning_effort` thì tự gửi lại không kèm tham số.
- Nguồn đối chiếu: [Google — Thinking models and supported levels](https://docs.cloud.google.com/gemini-enterprise-agent-platform/models/thinking), [AIStudio2API — model catalog/protocol](https://github.com/Mag1cFall/AIStudio2API/blob/main/docs/protocol.md).
- **Agent làm việc lâu hơn**: mặc định 40 bước (trước là 12); prompt yêu cầu lập kế hoạch, tự kiểm tra, tự chạy test/lint/build bằng `run_command`, sửa rồi chạy lại.
- **ChatGPT trả lời "rỗng"**: nếu backend trả về phản hồi trống, OpenHL thử lại một lần rồi báo lỗi rõ ràng (kèm đường dẫn log) thay vì lưu một tin nhắn rỗng.

## Chưa xác nhận
- Selector đọc câu trả lời của ChatGPT-Web2API (`[data-message-author-role="assistant"]`) chưa được vá vì không có mã nguồn driver để kiểm chứng. Nếu vẫn rỗng, gửi `.runtime\logs\chatgpt.log` và `cdp_driver.py` để vá đúng chỗ.

## Đổi model/provider giữa chừng
- Lịch sử chat vẫn được giữ khi đổi model hoặc provider (trước đó chỉ là chữ). Giờ các lượt trả lời của agent còn kèm tóm tắt công cụ đã chạy (đọc/sửa tệp nào, kết quả), để model mới biết việc đã làm.
- Lượt đầu sau khi đổi, model mới nhận ghi chú tiếp quản từ model cũ để tiếp tục liền mạch.
