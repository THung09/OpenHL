# OpenHL

**An AI-powered terminal workspace for chatting with multiple AI providers and using AI-assisted tools on your local machine.**

> **Project status: Beta** — OpenHL is experimental software. Features, compatibility, and behavior may change without notice.

## English

### What is OpenHL?

OpenHL is a command-line AI workspace for Windows, designed with a terminal interface inspired by tools such as OpenCode. It brings several AI providers into one place, so you can chat, switch models, manage supported accounts, attach files, and optionally let an AI agent work with files and commands on your computer.

OpenHL is intended to make AI tools easier to access from one terminal application. It is not an official product of Google, OpenAI, DeepSeek, Alibaba, or any other AI provider.

### Main features

- **Multiple AI providers:** supports Gemini, Google AI Studio, Qwen, DeepSeek, and an experimental ChatGPT integration.
- **Terminal workspace:** a text-based interface with conversations, tabs, provider selection, and model selection.
- **AI agent tools:** when enabled, the agent can read, create, edit, move, and organize files, and run PowerShell commands with permission checks.
- **Safety layer:** Guardian checks certain sensitive paths and commands and can ask for confirmation before actions.
- **File attachments:** provide supported documents, images, and text files as context for a conversation.
- **Account management:** manage supported sign-in profiles; DeepSeek supports multiple profiles and automatic switching in the current version.
- **Optional local gateway:** expose a local OpenAI-compatible endpoint for supported integrations.

Available features depend on the selected provider, model, account, and the current state of the upstream projects.

### Beta notice

OpenHL is currently in **beta development**. It may contain bugs, incomplete features, unstable integrations, or unexpected behavior. Some providers rely on unofficial community projects or browser-based sessions. Changes made by those services may cause an integration to stop working or require you to sign in again.

Please:
- Back up important files before allowing an agent to modify them.
- Review commands and file operations before approving them.
- Do not use OpenHL as the sole tool for important, sensitive, or production-critical work.
- Report bugs with useful logs, but remove passwords, cookies, access tokens, API keys, and other private information first.

Guardian is a risk-reduction feature, not a guarantee of safety. It may not detect every harmful or unintended action.

### Development

**OpenHL was created entirely with AI tools (100% AI-generated development).** This means its source code and documentation may contain mistakes, inconsistencies, or design limitations. The project is still being tested and improved, and no claim is made that every feature is complete or production-ready.

### Privacy and local operation

OpenHL is designed to run on your own computer. Its configuration and supported login-session data are stored locally. OpenHL does not operate an official cloud relay for your conversations.

When you use a provider, your prompts and any information you choose to submit are processed by that provider and may be subject to its own privacy policy and terms. Review the behavior and trustworthiness of any third-party integration before signing in or sending information. Do not share sensitive data unless you understand where it will be processed.

### Disclaimer

OpenHL is provided for learning, experimentation, and personal use. It is an unofficial third-party project and is not affiliated with, endorsed by, or supported by the AI service providers it connects to.

You are responsible for:
- how you use OpenHL and any output it generates;
- checking AI-generated answers, code, commands, and file changes before relying on them;
- ensuring that your use complies with applicable laws, regulations, platform rules, and third-party terms of service;
- obtaining any permissions or rights required for the content, accounts, files, and services you use.

The repository owner and contributors provide the project **“as is”** and make no guarantee that it will be accurate, secure, uninterrupted, error-free, or suitable for a particular purpose. To the maximum extent permitted by applicable law, they disclaim responsibility for loss, damage, claims, or legal issues arising from the use, misuse, modification, or distribution of this project.

This notice does not remove or limit any responsibility that cannot legally be excluded under applicable law. Nothing here is legal advice.

### License

OpenHL is distributed under the **OpenHL Non-Commercial License** in the `LICENSE` file. You may use, modify, and share it for non-commercial purposes, subject to the license conditions. Commercial use requires the author's prior written permission.

The original-author watermark must remain intact:

**Contact me via Discord: doki_doki_fuwa.fuwa**

Third-party components retain their own licenses. See the `LICENSE` file and the respective upstream repositories for details.

### Upstream projects

OpenHL uses or integrates with these community projects:

- [Gemini-Web2API](https://github.com/Mag1cFall/Gemini-Web2API)
- [AIStudio2API](https://github.com/Mag1cFall/AIStudio2API)
- [AIStudioToAPI](https://github.com/iBUHub/AIStudioToAPI)
- [qwen2api](https://github.com/smanx/qwen2api)
- [Deepseek-API](https://github.com/sums001/Deepseek-API)
- [ChatGPT-Web2API](https://github.com/Octo-Lex/ChatGPT-Web2API)

These integrations are maintained by their respective authors. OpenHL is not the owner of those services or projects.

---

## Tiếng Việt

### OpenHL là gì?

OpenHL là một ứng dụng AI chạy trong terminal dành cho Windows, có giao diện dòng lệnh lấy cảm hứng từ những công cụ như OpenCode. Dự án tập hợp nhiều nhà cung cấp AI vào cùng một nơi, giúp bạn trò chuyện, chuyển đổi model, quản lý các tài khoản được hỗ trợ, gửi tệp đính kèm và tùy chọn sử dụng AI Agent để thao tác với tệp hoặc chạy lệnh trên máy tính.

Mục tiêu của OpenHL là giúp việc sử dụng nhiều công cụ AI trở nên thuận tiện hơn thông qua một ứng dụng terminal duy nhất. OpenHL **không phải sản phẩm chính thức** của Google, OpenAI, DeepSeek, Alibaba hay bất kỳ nhà cung cấp AI nào khác.

### Tính năng chính

- **Nhiều nhà cung cấp AI:** hỗ trợ Gemini, Google AI Studio, Qwen, DeepSeek và tích hợp ChatGPT đang trong giai đoạn thử nghiệm.
- **Không gian làm việc trong terminal:** giao diện văn bản có hội thoại, tab, lựa chọn nhà cung cấp và lựa chọn model.
- **Công cụ AI Agent:** khi được bật, Agent có thể đọc, tạo, chỉnh sửa, di chuyển, sắp xếp tệp và chạy lệnh PowerShell sau khi kiểm tra quyền.
- **Lớp bảo vệ Guardian:** kiểm tra một số đường dẫn và lệnh nhạy cảm, đồng thời có thể yêu cầu xác nhận trước khi thực hiện thao tác.
- **Tệp đính kèm:** gửi tài liệu, hình ảnh và tệp văn bản được hỗ trợ để AI sử dụng làm ngữ cảnh.
- **Quản lý tài khoản:** quản lý các hồ sơ đăng nhập được hỗ trợ; phiên bản hiện tại hỗ trợ nhiều hồ sơ DeepSeek và tự chuyển đổi trong một số trường hợp.
- **Gateway cục bộ tùy chọn:** cung cấp endpoint tương thích OpenAI trên máy tính để kết nối với các công cụ được hỗ trợ.

Tính năng thực tế còn phụ thuộc vào nhà cung cấp, model, tài khoản và tình trạng của các dự án nền tảng.

### Lưu ý về giai đoạn Beta

OpenHL hiện vẫn đang trong **giai đoạn phát triển Beta**. Phần mềm có thể còn lỗi, tính năng chưa hoàn thiện, tích hợp thiếu ổn định hoặc phát sinh hành vi ngoài dự kiến. Một số nhà cung cấp sử dụng dự án cộng đồng không chính thức hoặc phiên đăng nhập qua trình duyệt. Nếu dịch vụ gốc thay đổi, tích hợp tương ứng có thể ngừng hoạt động hoặc yêu cầu đăng nhập lại.

Vui lòng:
- Sao lưu dữ liệu quan trọng trước khi cho phép Agent chỉnh sửa tệp.
- Đọc và kiểm tra lệnh cũng như thao tác với tệp trước khi xác nhận.
- Không sử dụng OpenHL như công cụ duy nhất cho công việc quan trọng, nhạy cảm hoặc yêu cầu độ tin cậy cao.
- Khi báo lỗi, hãy cung cấp log cần thiết nhưng phải xóa mật khẩu, cookie, access token, API key và thông tin riêng tư trước khi chia sẻ.

Guardian chỉ giúp giảm thiểu rủi ro, không thể bảo đảm phát hiện hoặc ngăn chặn mọi thao tác nguy hiểm hay ngoài ý muốn.

### Quá trình phát triển

**OpenHL được tạo ra hoàn toàn bằng các công cụ AI (100% quá trình phát triển do AI tạo ra).** Vì vậy, mã nguồn và tài liệu có thể tồn tại lỗi, điểm chưa nhất quán hoặc hạn chế trong thiết kế. Dự án vẫn đang được kiểm thử và cải thiện; không có cam kết rằng mọi tính năng đã hoàn thiện hoặc sẵn sàng cho môi trường thực tế.

### Quyền riêng tư và hoạt động cục bộ

OpenHL được thiết kế để chạy trên máy tính của người dùng. Tệp cấu hình và dữ liệu phiên đăng nhập được hỗ trợ sẽ được lưu trữ cục bộ. OpenHL không vận hành máy chủ trung gian đám mây chính thức để chuyển tiếp nội dung trò chuyện.

Khi sử dụng một nhà cung cấp AI, nội dung câu hỏi và dữ liệu bạn chủ động gửi sẽ được xử lý bởi nhà cung cấp đó, đồng thời có thể chịu sự điều chỉnh từ chính sách quyền riêng tư và điều khoản của họ. Hãy tự tìm hiểu cách hoạt động và mức độ đáng tin cậy của các tích hợp bên thứ ba trước khi đăng nhập hoặc gửi dữ liệu. Không gửi thông tin nhạy cảm nếu bạn chưa hiểu rõ dữ liệu sẽ được xử lý ở đâu.

### Tuyên bố miễn trừ trách nhiệm

OpenHL được cung cấp cho mục đích học tập, thử nghiệm và sử dụng cá nhân. Đây là dự án bên thứ ba không chính thức, không liên kết, không được chứng thực và không được hỗ trợ bởi các nhà cung cấp dịch vụ AI mà dự án kết nối.

Người dùng tự chịu trách nhiệm đối với:
- cách sử dụng OpenHL và nội dung do AI tạo ra;
- việc kiểm tra câu trả lời, mã nguồn, câu lệnh và thay đổi tệp do AI đề xuất hoặc thực hiện trước khi sử dụng;
- việc bảo đảm hoạt động sử dụng tuân thủ pháp luật, quy định, nội quy nền tảng và điều khoản dịch vụ của bên thứ ba;
- việc có đầy đủ quyền hoặc sự cho phép cần thiết đối với nội dung, tài khoản, tệp và dịch vụ được sử dụng.

Chủ repository và những người đóng góp cung cấp dự án theo hiện trạng **“nguyên trạng như đang có” (AS IS)**, không cam kết phần mềm luôn chính xác, an toàn, liên tục, không có lỗi hoặc phù hợp với một mục đích cụ thể. Trong phạm vi tối đa mà pháp luật hiện hành cho phép, chủ repository và những người đóng góp không chịu trách nhiệm đối với tổn thất, thiệt hại, khiếu nại hoặc vấn đề pháp lý phát sinh từ việc sử dụng, sử dụng sai mục đích, chỉnh sửa hoặc phân phối dự án.

Tuyên bố này không loại trừ hoặc giới hạn những trách nhiệm mà pháp luật không cho phép loại trừ. Nội dung trên không phải tư vấn pháp lý.

### Giấy phép

OpenHL được phát hành theo **OpenHL Non-Commercial License** trong tệp `LICENSE`. Bạn có thể sử dụng, chỉnh sửa và chia sẻ dự án cho mục đích phi thương mại nếu tuân thủ các điều kiện của giấy phép. Mọi mục đích thương mại đều cần có sự đồng ý trước bằng văn bản của tác giả.

Phải giữ nguyên watermark tác giả gốc:

**Contact me via Discord: doki_doki_fuwa.fuwa**

Các thành phần của bên thứ ba tiếp tục tuân theo giấy phép riêng. Vui lòng xem tệp `LICENSE` và repository tương ứng để biết chi tiết.

### Các dự án nền tảng

OpenHL sử dụng hoặc tích hợp những dự án cộng đồng sau:

- [Gemini-Web2API](https://github.com/Mag1cFall/Gemini-Web2API)
- [AIStudio2API](https://github.com/Mag1cFall/AIStudio2API)
- [AIStudioToAPI](https://github.com/iBUHub/AIStudioToAPI)
- [qwen2api](https://github.com/smanx/qwen2api)
- [Deepseek-API](https://github.com/sums001/Deepseek-API)
- [ChatGPT-Web2API](https://github.com/Octo-Lex/ChatGPT-Web2API)

Các tích hợp này do tác giả tương ứng duy trì. OpenHL không sở hữu những dịch vụ hoặc dự án nền tảng đó.
