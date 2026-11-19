# OPENHL

OpenHL is an AI agent that runs in the terminal (PowerShell / Windows Terminal), with an interface inspired by OpenCode. It integrates various web AI backends into one place, allowing you to chat, read/write files, run commands, and create skills — but all dangerous operations go through Guardian.

Version: 2.12.5

| Backend | Original Project | Port | Login |
| --- | --- | --- | --- |
| gemini | [Mag1cFall/Gemini-Web2API](https://github.com/Mag1cFall/Gemini-Web2API) | 8007 | Optional (guest available) |
| aistudio | [Mag1cFall/AIStudio2API](https://github.com/Mag1cFall/AIStudio2API) | 2048 | Google Account (one-time login, Playground) |
| qwen | [smanx/qwen2api](https://github.com/smanx/qwen2api) | 7860 | One-time Qwen login in Chrome |
| deepseek | [sums001/Deepseek-API](https://github.com/sums001/Deepseek-API) | 8000 | One-time browser login |
| chatgpt | ChatGPT — OpenHL auto-installs [ChatGPT-Web2API](https://github.com/Octo-Lex/ChatGPT-Web2API) into `vendor/chatgpt` | 8080 | Login in Chrome opened by OpenHL (one-time) |

Status of each AI backend

| Backend | Status | Notes |
| --- | --- | --- |
| Gemini | 🟢 Stable | Runs as guest immediately, no account needed. |
| Google AI Studio | 🟢 Stable | Requires one-time Google login (Playground). |
| DeepSeek | 🟢 Stable | Supports multiple accounts, auto-rotates when quota expires. |
| Qwen | 🟡 Incomplete | Often encounters `RGV587_ERROR` (WAF block), tokens last ~15 minutes, multi-profile support not yet complete. |
| ChatGPT | 🟡 Incomplete | Driver (`cdp_driver.py`) often breaks due to ChatGPT UI changes affecting send/receive selectors; sometimes returns empty responses. |

This table reflects the status at the time of this release; update when changes occur.

Safety & Privacy
OpenHL runs entirely on your machine (local-only). All logins (Google, Qwen, DeepSeek, ChatGPT) open in your real browser on your machine; OpenHL only saves session tokens/cookies locally in `config.json` and `vendor/<backend>/auth|session` so you don’t have to log in every time — there is no intermediate OpenHL server, and the source code does not send your cookies or account information anywhere other than the service you are logging into (Google/Qwen/DeepSeek/OpenAI).

License
OpenHL source code is released under a non-commercial license — see the `LICENSE` file. Summary: you are free to download, run, modify, and share for personal/non-profit purposes, but you may not use this source code (original or modified) for commercial purposes (selling, integrating into paid products/services, etc.) without the author’s consent.

Watermark / original author: Contact me via Discord: doki_doki_fuwa.fuwa — keep this line when sharing or forking.

### 2.12.5 — True OpenCode-style workspace in terminal

This version changes the TUI layout, not just adding account management commands:
- Left sidebar separate includes Workspace/New Session, Recent Sessions, Providers and Account summary.
- Right chat area has tabs, chat content and separate composer.
- Click sidebar to open session, switch provider or open Account Manager; supports `Ctrl+B` and `/sidebar`.
- Auto-hide sidebar in narrow terminal windows; single-column layout remains when terminal is small.
- Fix cursor/composer position and mouse hit region in two-column layout.
- Fix account listing so DeepSeek sub-profiles keep correct backend name when opening login flow.
- Regression tests: 92/92 tests passed.

### 2.12.4 — CLI/TUI and multiple accounts

This version runs entirely in the terminal; does not open Web UI or browser to display chat interface. TUI has two-column workspace layout inspired by OpenCode: left sidebar displays workspace, recent sessions, provider and account group; right area for conversation, tabs and fixed compose box. Sidebar auto-hides in narrow terminals, can be toggled with `Ctrl+B` or `/sidebar`.

Workspace and TUI navigation
- Left sidebar: `WORKSPACE`, recent sessions, `PROVIDERS` and `ACCOUNTS` summary.
- Click provider to switch quickly; click `Manage accounts` or type `/accounts` to manage profiles.
- `Ctrl+B` or `/sidebar` to hide/show sidebar. Narrow terminals automatically switch to single-column layout.

Account management in TUI
Type `/accounts` in OpenHL to open account table divided by provider, e.g.:
```
──────── Gemini ────────
──────── Google AI Studio ────────
──────── Qwen ────────
──────── DeepSeek ────────
  ● user@example.com   ready · enabled
  ◷ second@example.com quota · resting until ...
  ＋ Add DeepSeek account
──────── ChatGPT ────────
```
Select a DeepSeek account to enable/disable; select unlogged profile to run separate login process. When current account returns clear quota error, OpenHL automatically switches to next logged-in DeepSeek profile. Accounts with exhausted quota are put into 15-minute rest period. Network errors and HTTP 429 rate-limit temporary errors do not automatically trigger account rotation.

Account commands in terminal
```powershell
# List recognized accounts, divided by provider
openhl accounts
# Add and login a new DeepSeek account
openhl account add deepseek abc123@gmail.com --login
# Re-login existing profile
openhl account login deepseek abc123@gmail.com
# Enable / disable / remove sub-profile
openhl account enable deepseek abc123@gmail.com
openhl account disable deepseek abc123@gmail.com
openhl account remove deepseek abc123@gmail.com
```

Scope of account support in this version: DeepSeek supports multiple separate login sessions and auto-switches when quota expires. Google AI Studio lists saved auth files and continues using existing multi-Google auth mechanism in AIStudio2API backend. Gemini, Qwen and ChatGPT currently grouped/display existing login status; no mechanism yet to clone multiple independent profiles and auto-rotate for those providers.

When updating from old version, extract new package over existing OpenHL source directory. Release package does not contain `config.json`, `.runtime/` or `.sessions/`; keep these directories to preserve your configuration, login sessions and chat history.

## 1. Installation

Requirements: Node.js >= 20 (recommend 22+ to use Qwen login via Chrome).

```powershell
cd C:\Users\HP\openhl
.\install.ps1 -Register
```

This command adds `openhl` function to PowerShell profile and creates `openhl.cmd` shim in `WindowsApps` (already on PATH). Open new terminal then type:
```powershell
openhl
```

Don't want to register? Run directly:
```powershell
cd C:\Users\HP\openhl
.\openhl.ps1
```
or `.\openhl.cmd`.

## 2. Interface

```powershell
openhl
```

First time, OpenHL auto-starts configured backend (default Gemini guest) and opens interface. Type question, press Enter.

AI Character and activity status
OpenHL automatically recognizes character based on actually configured backend/model: ChatGPT, Gemini, Qwen or DeepSeek; custom backends not recognized will display OpenHL character. This version has not integrated Claude backend, so does not display fake Claude Code label. When processing, character icon animates and status line describes what it's doing, e.g., Thinking, Reading file, Moving file, Running command or Writing answer.

When agent needs your decision, selection box appears as interactive CLI: use ↑/↓ then Enter to select, or select Reply with text…. If AI only asks open question, type answer in compose box then press Enter; Esc skips, Ctrl+C cancels waiting task.

Chat frame and message compose box
Compose Message box fixed at bottom of screen, nearly full terminal width; even when empty has large enough multi-line input area.
When content long, compose box auto-increases height and scrolls with cursor. `Enter` sends; `Ctrl+Enter` new line.
User and OpenHL messages presented as separate cards, with role labels and distinguishing colors. Regular text whitespace normalized; whitespace inside code blocks preserved.
Chat tabs have top/bottom borders, three-line high click area; full name of currently open conversation displayed below tab bar.

Shortcuts

| Key | Action |
| --- | --- |
| Enter | send message |
| Ctrl+Enter, Alt+Enter, Ctrl+J | new line in input |
| ↑ / ↓ | move between lines; at start/end opens history |
| Home / End | start/end of line |
| Ctrl+Home / Ctrl+End | start/end of entire input |
| PgUp / PgDn, mouse wheel | scroll chat history |
| Tab | change Thinking level of current model (if model supports); DeepSeek toggle |
| Ctrl+S | toggle web search (DeepSeek) |
| Ctrl+F | select attachment file (any file) |
| Ctrl+X | remove attachment |
| Ctrl+P | select model |
| Ctrl+O | select backend |
| Ctrl+N | new chat |
| Ctrl+T | new chat tab |
| Ctrl+← / Ctrl+→ | switch previous / next tab |
| Ctrl+L | clear chat screen |
| Ctrl+C | stop answer / clear input / exit |

Can click mouse on `Build · model · provider`, `think`, `search` lines to open picker or quick toggle. Click `[⧉ copy]` above each code block to copy that block separately; click tab name to switch, `×` to delete conversation, `+ tab` to open new tab. Full name of currently open tab displayed on `Currently open` line below tab bar.

Chat tabs
Each tab is separate conversation, with separate session saved in `.sessions/`. Use `Ctrl+T` or `/tab new` to open tab, `Ctrl+←` / `Ctrl+→` or click tab name to switch, click `×` or `/tab delete [n]` to permanently delete conversation, `/tab close` to close tab from current session. Can reorder with `/tab left` and `/tab right`. On restart, OpenHL restores up to 8 recent sessions as tabs for you to continue.

Copy
Each Markdown code block wrapped in triple backticks has separate `[⧉ copy]` button at top right of block.
Regular text answers do not show redundant copy button; use `/copy` when want to copy entire answer.
`/copy` copies most recent entire answer (preserves Markdown).
`/copy code` copies last code block; `/copy 2` copies code block number 2.
Can highlight text to copy using terminal selection operation; when terminal capturing mouse events, hold `Shift` while dragging to select if needed.

Your own System Prompt
You don't need to type command to edit prompt. In main interface, click [⚙ Edit System Prompt] button right below conversation name; or type `/system` to open same multi-line editor.
In SYSTEM PROMPT screen, you can write role, style, rules, response format and things AI should avoid. This is separate text input area occupying full screen, not command selection box.

| Key | Action |
| --- | --- |
| Type text | Compose system prompt freely, multi-line |
| Enter | New line |
| Ctrl+S | Save prompt to OpenHL configuration |
| Ctrl+R | Clear current draft content |
| Esc | Cancel and close without saving |

Prompt saved to `config.json` (`chat.systemPrompt`) and applied to subsequent chat turns. Both chat mode and agent mode instructed to ask again when missing important information; rules you write will be appended to OpenHL background instructions.

Commands in interface

| Command | Action |
| --- | --- |
| /model | select model |
| /provider | select backend (Gemini, Google AI Studio, Qwen, DeepSeek, ChatGPT) |
| /file [path] | attach file; no path opens file picker |
| /agent | toggle agent mode (default on) |
| /skill | select skill, save prompt as skill, enable/disable skill |
| /allow | auto-approve operations in current session (Guardian still blocks system areas) |
| /guard | view Guardian log and protected directories |
| /thinking [level\|auto\|token-budget] | adjust Thinking according to model capability; DeepSeek toggle |
| /search | toggle web search (DeepSeek) |
| /copy [code\|n] | copy answer or code block |
| /system [set\|file\|reset] | view or edit personal system prompt |
| /tab [new\|next\|prev\|close\|delete [n]\|left\|right\|n] | manage, reorder and delete chat tabs |
| /new | new chat session |
| /clear | clear current chat content |
| /help | help |
| /exit | exit |

Type `/` to open command suggestions. Use `↑`/`↓`, `Tab` or `Enter` to select.

Install ChatGPT directly from OpenHL
ChatGPT is a provider inside OpenHL. OpenHL auto-installs ChatGPT-Web2API in separate Python environment under `vendor/chatgpt`; you don't need to clone repo yourself, create virtualenv or install package manually.

Requirements: Python 3.11+, Google Chrome and ChatGPT Plus account (per current requirements of ChatGPT-Web2API project). Installing provider does not change OpenHL application or package name.

```powershell
# 1. Install ChatGPT-Web2API managed by OpenHL
openhl install chatgpt
# 2. First startup and login in separate Chrome window
openhl login chatgpt
# 3. Open OpenHL with ChatGPT
openhl --provider chatgpt
```

After first login, OpenHL saves provider runtime in separate data directory managed by ChatGPT-Web2API. When need to reinstall/update package, use `openhl install chatgpt --force`. Default backend only listens on local machine, port `8080`; internal API key saved in OpenHL configuration and sent to proxy via environment variable.

Original project documentation: [Octo-Lex/ChatGPT-Web2API](https://github.com/Octo-Lex/ChatGPT-Web2API). This is unofficial bridge using ChatGPT web interface, not official OpenAI API; requires ChatGPT login in Chrome and may need re-login when session expires.

Default backend uses `auto` model. After installing and logging in once, OpenHL auto-starts proxy along with enabled backends. One Chrome session is shared resource; avoid sending many simultaneous requests. Access depends on login session, service status and proxy limits.

## 3. Agent and tools

When agent enabled, model can request OpenHL to perform following operations on your machine:

| Tool | Action |
| --- | --- |
| read_file | read file |
| list_dir | list directory |
| search_files | search content in files |
| write_file | create/write file |
| append_file | append to file |
| replace_in_file | edit file content |
| make_dir | create directory |
| move_path | move/rename |
| copy_path | copy |
| delete_path | delete file/directory |
| run_command | run PowerShell command |
| update_plan | create multi-step plan |
| write_skill | package process into skill |

Agent always displays progress, plan and results of each tool. If needs permission, OpenHL shows dialog:
`y` — allow this time
`a` — allow in current session
`n` / `Esc` — deny

Want to return to chat-only mode: type `/agent` or run `openhl --chat`.

## 4. Guardian

Guardian is independent protection layer, not dependent on model:
- Blocks write/delete in `C:\Windows`, `Program Files`, `ProgramData`, drive root, `.ssh`, `.aws`, etc.
- Blocks dangerous commands: `format`, `diskpart`, `bcdedit`, `shutdown`, delete system directories, encoded PowerShell, edit registry/service…
- Requires confirmation when deleting, writing outside working directory, moving files or running commands.
- Logs JSONL at `.runtime/security.log`.

Quick view:
```powershell
openhl guard
```

Guardian reduces risk but does not replace your checking before approving.

## 5. Skill

OpenHL has built-in skills: `architect`, `debugger`, `writer`, `researcher`, `file-organizer`, `skill-creator`, `guardian`.

```powershell
openhl skills
openhl skills use debugger
openhl skills off debugger
```

In interface, `/skill` allows:
- select/enable/disable skill
- save recent prompt as new skill
- use `/skill save <name> | <description>`
- use `/skill delete <name>`

Skills saved as Markdown in `skills/` and can be edited directly.

## 6. File attachments

- `Ctrl+F` opens file picker.
- `/file C:\path\to\file.txt` attaches directly.
- Drag-drop file into terminal (Windows Terminal supports pasting path) to attach.
- Maximum 10 files. Images: PNG/JPG/GIF/WEBP/BMP (max 10 MB). Text/code: max 512 KB.
- Documents: `.docx`, `.xlsx`, `.pptx`, `.odt`, `.ods`, `.odp`, `.epub`, `.rtf` and `.pdf` (max 40 MB). OpenHL extracts text locally, does not send original binary file.
- UTF-8 text/code files: accepts both common extensions and strange extensions if content really is text. File picker displays `All files (*.*)`; being selectable does not mean all binary formats can be decoded.
- PDF extraction experimental (best-effort): scanned image PDFs or complex encryption may not read; when so OpenHL reports clearly instead of sending empty data.
- Text files sent as context; images sent as data URL if backend supports.
- If backend rejects images, OpenHL auto-retries with text only.

## 7. Backend login

### Gemini
Optional. Guest usable but fewer models. Want to use Google account:
```powershell
openhl login gemini
```

### Google AI Studio Playground
Backend is [Mag1cFall/AIStudio2API](https://github.com/Mag1cFall/AIStudio2API) (Go, MIT license). OpenHL auto-downloads Windows Release; no need to install Git, Go or npm to use this backend.

```powershell
openhl login aistudio
```

First time, OpenHL downloads `aistudio2api.exe` to `vendor\aistudio`. By default OpenHL opens Camoufox (Firefox version specific to AIStudio2API) for you to login Google right in that window — no need to pre-login in Chrome. Account saved in `vendor\aistudio\auth`; next time no need to re-login and Camoufox not deleted between sessions.

```powershell
openhl login aistudio                    # Camoufox (default)
openhl login aistudio --browser chrome   # input existing account in Chrome
openhl login aistudio --browser thorium  # other Chromium: edge|thorium|brave|vivaldi|opera|chromium
openhl login aistudio --browser-path "C:\path\to\browser.exe"
openhl login aistudio --browser auto     # try Chrome first, if not then Camoufox
openhl login aistudio --browser camoufox # Camoufox, keep downloaded version
openhl login aistudio --force            # add another Google account
openhl login aistudio --fresh            # delete saved account then re-login
openhl doctor aistudio                   # check connection and models
openhl models                            # view available models
```

Browser you choose saved to `config.json` (`providers.aistudio.browser`) so next times OpenHL uses same choice, doesn't change arbitrarily. OpenHL only forces one browser when technique requires — e.g., Qwen needs Chromium browser because login flow uses CDP, while Camoufox is Firefox so cannot use CDP. For AI Studio, content generation runs via SpiderMonkey in process when you choose Chromium, and via Camoufox when you choose Camoufox.

Camoufox (default): separate Firefox window of AIStudio2API, can login Google itself, download once and reuse.
Chrome: reads existing Chrome profile on machine (fastest if already logged into Google in Chrome).
Edge/Thorium/Brave/Vivaldi/Opera/Chromium: AIStudio2API does not read profiles of these browsers from disk, so OpenHL opens them with separate profile at `vendor\aistudio\runtime\<name>-profile`, you login Google once, then OpenHL inputs account via `setup --cdp`. Want to use different Chromium build, pass `.exe` file directly with `--browser-path`.
auto: tries Chrome first, if no account found switches to Camoufox.

No Camoufox directory deleted automatically. `--fresh` only deletes account in `vendor\aistudio\auth` so you can choose different Google account.

Backend uses Playground as default content generation channel. Old Build channel disabled by default in upstream because Google stopped supporting that flow. OpenHL starts API at `http://127.0.0.1:2048/v1` and requires content generation service to be in `RUNNING` state.

No need for Google Gemini API Key. `openhl-local` is local key between OpenHL and backend on your machine, not Google key. OpenHL sets this key when starting backend.

### Qwen
```powershell
openhl login qwen
```

This command opens Chrome/Edge/Thorium… existing on machine (no additional browser download) with separate OpenHL profile at `chat.qwen.ai`. You login free Qwen account once. OpenHL waits until account actually logged in, then saves token + `auth-session` to `config.json` (`providers.qwen.env.QWEN_TOKEN`, `QWEN_AUTH_COOKIE`) and checks real chat before reporting success. Password not saved. Then:

You can choose specific browser for Qwen:
```powershell
openhl login qwen --browser chrome   # default when Chrome available
openhl login qwen --browser edge     # use Microsoft Edge
openhl login qwen --browser thorium  # Thorium, Brave, Vivaldi, Opera, Chromium…
openhl login qwen --browser "C:\path\to\browser.exe"
openhl login qwen --browser auto     # auto-select
```

Qwen requires Chromium browser because login flow needs Chrome DevTools Protocol; Camoufox based on Firefox so does not support CDP. This is only case where OpenHL forces browser type.

```powershell
openhl --provider qwen
```

Next time OpenHL reuses token — no need to re-login. Qwen token only lives about 15 minutes, but OpenHL auto-refreshes using saved `auth-session`; if cookie completely expired then need:
```powershell
openhl login qwen --force
```

Already have token (Network → `Authorization: Bearer ...`):
```powershell
openhl login qwen --token "<token>"
```

Note: guest mode not requiring smanx account currently blocked by Qwen/Aliyun WAF (`RGV587_ERROR`), so OpenHL uses account mode. Backend still smanx/qwen2api running Node, port 7860.

### DeepSeek
```powershell
openhl login deepseek
openhl --provider deepseek
```

`login` opens Chrome or Edge existing on machine (no additional browser download) to login `chat.deepseek.com` once. Session saved in `vendor\deepseek\session`.

After entering interface:
- `think:on` → sends `thinking: true`
- `search:on` → sends `search: true`

Reasoning part shown in gray under `~ thinking` label. If account muted by DeepSeek, OpenHL clearly reports reopen time instead of returning empty answer.

### Change account
Each backend saves separate session. Use `--fresh` to delete old session then login different account; no need to delete files manually.

```powershell
openhl login qwen --fresh
openhl login deepseek --fresh
openhl login aistudio --fresh
openhl login gemini --fresh
```

Qwen: close OpenHL's Chrome window first (if still open), run above command, then login new Qwen account. `--force` only reopens Chrome with current session, does not change account.

DeepSeek: command will delete `vendor\deepseek\session` (Chrome profile + token) and open new login page.

AI Studio: command deletes `vendor\aistudio\auth`, then reruns to input Google account from Chrome or use fallback login flow.

Gemini: default is guest, no account needed. `--fresh` deletes old Google session; if backend doesn't show account selection step, use AI Studio to chat with Google account.

After changing, check again:
```powershell
openhl status
openhl --provider qwen
```

## 8. Terminal commands

```powershell
openhl                          # open agent interface
openhl --chat                   # open chat-only interface
openhl --once "Hello"           # run one turn (agent)
openhl --once --chat "2+2?"     # run one turn, chat only
openhl login <backend>          # login
openhl install <backend>        # gemini | aistudio | qwen | deepseek | all
openhl start [backend|all]      # start backend
openhl stop [backend|all]       # stop backend
openhl restart [backend|all]
openhl status                   # status table
openhl models                   # available models
openhl serve                    # OpenAI-compatible gateway
openhl doctor                   # diagnose environment
openhl config get|set|path
openhl sessions
openhl skills [list|use|off]
openhl guard
openhl --provider deepseek --model deepseek-expert
openhl --continue               # continue most recent session
openhl --demo                   # print test interface
```

Useful options:
```
--provider <name>     backend when opening
--model <id>          model when opening
--attach <file>       attach file (repeatable)
--thinking / --no-thinking
--search / --no-search
--reasoning           print reasoning part with --once
--yes                 auto-approve agent operations (still through Guardian)
--allow               allow in session
--skill <name>        enable skill (can repeat)
--max-steps <n>       limit agent steps
```

## 9. Gateway (optional)

```powershell
openhl serve
```

Base URL: `http://127.0.0.1:8787/v1`
API key: `openhl-local`
Model: `gemini/<id>`, `aistudio/<id>`, `qwen/<id>`, `deepseek/<id>`

```powershell
$body = '{"model":"gemini/gemini-3.8-flash","messages":[{"role":"user","content":"Hello"}]}'
curl.exe http://127.0.0.1:8787/v1/chat/completions `
  -H "Authorization: Bearer openhl-local" `
  -H "Content-Type: application/json" -d $body
```

Gateway only binds to `127.0.0.1`.

## 10. Configuration

`config.json`:
```json
{
   "version": 2,
   "brand": "OpenHL",
   "gateway": { "port": 8787, "apiKey": "openhl-local" },
   "chat": {
     "provider": "gemini",
     "model": "",
     "thinking": true,
     "search": true,
     "temperature": null,
     "systemPrompt": ""
   },
   "agent": {
     "enabled": true,
     "maxSteps": 12,
     "allowSession": false,
     "activeSkills": []
   },
   "providers": {
     "gemini": { "kind": "gemini-web2api", "port": 8007 },
     "aistudio": { "kind": "aistudio2api", "port": 2048, "exe": "aistudio2api.exe" },
     "qwen": { "kind": "qwen2api-node", "port": 7860, "env": { "QWEN_TOKEN": "" } },
     "deepseek": { "kind": "deepseek-api", "port": 8000 }
   }
}
```

Quick edit:
```powershell
openhl config path
openhl config set chat.provider deepseek
openhl config set agent.enabled true
openhl config set agent.maxSteps 16
openhl config set chat.thinking true
openhl config set chat.search true
```

Environment variables: `OPENHL_HOME` (change data directory), `NO_COLOR=1`, `OPENHL_DEBUG=1`.

## 11. Troubleshooting

| Symptom | Solution |
| --- | --- |
| `openhl` not found | run `.\install.ps1 -Register`, open new terminal |
| PowerShell blocks `.ps1` | use `openhl` (cmd shim) or `.\openhl.cmd` |
| Backend not ready | `openhl status`, check `.runtime\logs\<backend>.log` |
| DeepSeek reports mute | wait for time stated in notification, use different account, or switch to Gemini/AI Studio |
| DeepSeek 503 | `openhl login deepseek` then reopen |
| AI Studio no account / service not running | `openhl login aistudio`, click/start service then `openhl doctor aistudio` |
| Qwen `RGV587_ERROR` or no token | `openhl login qwen` (login Chrome once) |
| Qwen token expired | OpenHL auto-refreshes when opening; if not: `openhl login qwen --force` |
| Qwen logged in but no response | `openhl doctor qwen` (check token, port 7860, send test message) |
| Gemini guest doesn't accept images | login Google or send text file |
| Want to exit | `Ctrl+C` (twice if text in input box) |

## 12. Credits & license

- [Mag1cFall/Gemini-Web2API](https://github.com/Mag1cFall/Gemini-Web2API) — MIT
- [iBUHub/AIStudioToAPI](https://github.com/iBUHub/AIStudioToAPI) — CC BY-NC 4.0
- [smanx/qwen2api](https://github.com/smanx/qwen2api) — MIT
- [sums001/Deepseek-API](https://github.com/sums001/Deepseek-API) — MIT

OpenHL is interface/management layer and agent. Use your accounts and comply with each service's terms. Guardian reduces risk but does not replace your checking before approving agent to run commands.

OpenHL source code: non-commercial license (see `LICENSE`) — free to use/modify/share non-commercially, not allowed to sell or use for commercial purposes. Watermark/original author: Contact me via Discord: doki_doki_fuwa.fuwa.

### Multi-line input and copy answer

Press `Ctrl+Enter` to new line in compose box; press `Enter` to send.
If terminal cannot send `Ctrl+Enter`, try `Alt+Enter`, `Ctrl+J`, or type `\` then Enter.

By default OpenHL does not capture terminal mouse, so you can drag mouse to highlight conversation content then press `Ctrl+Shift+C` (Windows Terminal) to copy.

If want to use mouse to click buttons/tabs in interface, set environment variable `OPENHL_MOUSE=1` before running OpenHL. This mode will enable mouse tracking and may make text highlighting depend on terminal; remove this variable to prioritize select/copy.

### Language / Ngôn ngữ

The interface is English by default. Type `/lang vi` in the app (or run `openhl lang vi`) to switch to Vietnamese, and `/lang en` to switch back. The choice is saved in `config.json` (`ui.lang`); the `OPENHL_LANG` environment variable overrides it.

Giao diện mặc định là tiếng Anh. Gõ `/lang vi` trong ứng dụng (hoặc `openhl lang vi`) để chuyển sang tiếng Việt, `/lang en` để quay lại.

### Prepare before pushing to GitHub

Before `git push` to public repo, check:
- [ ] File `.gitignore` exists in repo (included in this release) — excludes `config.json`, `.runtime/`, `.sessions/`, `vendor/*/auth`, `vendor/*/session`, `node_modules/`, logs, `.env`. This is where your real login tokens/cookies stored — do not commit these directories/files.
- [ ] Run `git status` before `git add .` to ensure no `config.json` or `vendor/*/auth|session` directories slipped in.
- [ ] File `LICENSE` has watermark/author name you want to keep (see "License" section above).
- [ ] No real email, token or API key remaining in `config.example.json` or in test files.
- [ ] `package.json` keeps `"private": true` to avoid accidental `npm publish` to npm registry.

---

# OpenHL

**OpenHL 2.12.5 — Không gian làm việc TUI phong cách OpenCode**

Xem `CHANGELOG-2.12.5.md`.

---

## ⚠️ Lưu ý quan trọng

> **Dự án này đang trong giai đoạn Beta.**
> **Dự án này được làm 100% bằng AI.**
>
> **Miễn trừ trách nhiệm:** Chủ sở hữu kho mã nguồn không chịu trách nhiệm cho bất kỳ vấn đề pháp lý, thiệt hại hay rắc rối nào phát sinh từ việc sử dụng phần mềm này. Vui lòng tự chịu rủi ro khi sử dụng.

---

OpenHL là một AI agent chạy trong terminal (PowerShell / Windows Terminal), giao diện lấy cảm hứng từ OpenCode. Nó tích hợp các backend web AI vào một chỗ, có thể trò chuyện, đọc/ghi tệp, chạy lệnh, tạo skill — nhưng mọi thao tác nguy hiểm đều đi qua Guardian.

Phiên bản: 2.12.5

| Backend | Dự án gốc | Cổng | Đăng nhập |
| --- | --- | --- | --- |
| gemini | [Mag1cFall/Gemini-Web2API](https://github.com/Mag1cFall/Gemini-Web2API) | 8007 | Không bắt buộc (guest dùng được) |
| aistudio | [Mag1cFall/AIStudio2API](https://github.com/Mag1cFall/AIStudio2API) | 2048 | Tài khoản Google (đăng nhập một lần, Playground) |
| qwen | [smanx/qwen2api](https://github.com/smanx/qwen2api) | 7860 | Đăng nhập Qwen một lần trong Chrome |
| deepseek | [sums001/Deepseek-API](https://github.com/sums001/Deepseek-API) | 8000 | Đăng nhập browser một lần |
| chatgpt | ChatGPT — OpenHL tự cài [ChatGPT-Web2API](https://github.com/Octo-Lex/ChatGPT-Web2API) vào `vendor/chatgpt` | 8080 | Đăng nhập trong Chrome do OpenHL mở (một lần) |

Trạng thái hoạt động của từng AI backend

| Backend | Trạng thái | Ghi chú |
| --- | --- | --- |
| Gemini | 🟢 Ổn định | Chạy guest được ngay, không cần tài khoản. |
| Google AI Studio | 🟢 Ổn định | Cần đăng nhập Google một lần (Playground). |
| DeepSeek | 🟢 Ổn định | Hỗ trợ nhiều tài khoản, tự xoay vòng khi hết quota. |
| Qwen | 🟡 Chưa hoàn thiện | Hay gặp `RGV587_ERROR` (WAF chặn), token chỉ sống ~15 phút, chưa hỗ trợ nhiều hồ sơ. |
| ChatGPT | 🟡 Chưa hoàn thiện | Driver (`cdp_driver.py`) hay bị ChatGPT đổi giao diện làm hỏng selector gửi/nhận tin; đôi khi trả lời rỗng. |

Bảng này phản ánh tình trạng tại thời điểm phát hành bản này; cập nhật lại khi có thay đổi.

An toàn & quyền riêng tư
OpenHL chạy hoàn toàn trên máy của bạn (local-only). Mọi đăng nhập (Google, Qwen, DeepSeek, ChatGPT) đều mở ngay trình duyệt thật trên máy bạn; OpenHL chỉ lưu lại token/cookie phiên đăng nhập cục bộ trong `config.json` và `vendor/<backend>/auth|session` để bạn không phải đăng nhập lại mỗi lần mở — không có máy chủ trung gian nào của OpenHL, và mã nguồn không gửi cookie hay thông tin tài khoản của bạn ra bất kỳ nơi nào khác ngoài chính dịch vụ bạn đăng nhập (Google/Qwen/DeepSeek/OpenAI).

Giấy phép
Mã nguồn OpenHL phát hành theo giấy phép phi thương mại — xem file `LICENSE`. Tóm tắt: bạn được tự do tải về, chạy, sửa, chia sẻ lại cho mục đích cá nhân/phi lợi nhuận, nhưng không được dùng mã nguồn này (nguyên bản hay sửa đổi) vào mục đích thương mại (bán, tích hợp vào sản phẩm/dịch vụ thu phí, v.v.) nếu chưa có sự đồng ý của tác giả.

Watermark / tác giả gốc: Contact me via Discord: doki_doki_fuwa.fuwa — giữ nguyên dòng này khi chia sẻ lại hoặc fork.

### 2.12.5 — Không gian làm việc OpenCode-style thực sự trong terminal

Bản này thay đổi bố cục giao diện TUI, không chỉ thêm lệnh quản lý tài khoản:
- Sidebar trái riêng gồm Workspace/New Session, Sessions gần đây, Providers và Account summary.
- Vùng hội thoại bên phải có tab, nội dung chat và composer riêng.
- Nhấp sidebar để mở phiên, chuyển provider hoặc mở Account Manager; hỗ trợ `Ctrl+B` và `/sidebar`.
- Tự ẩn sidebar ở cửa sổ terminal hẹp; bố cục cột đơn vẫn giữ khi terminal nhỏ.
- Sửa vị trí con trỏ/composer và hit region chuột trong bố cục hai cột.
- Sửa account listing để hồ sơ DeepSeek phụ giữ đúng tên backend riêng khi mở luồng đăng nhập.
- Kiểm thử hồi quy: 92/92 test qua.

### 2.12.4 — CLI/TUI và nhiều tài khoản

Bản này chạy hoàn toàn trong terminal; không mở Web UI hoặc trình duyệt để hiển thị giao diện chat. TUI có bố cục workspace hai cột lấy cảm hứng từ OpenCode: sidebar trái hiển thị workspace, phiên gần đây, provider và nhóm account; vùng bên phải dành cho hội thoại, tab và ô soạn cố định. Sidebar tự ẩn ở terminal hẹp, có thể bật/tắt bằng `Ctrl+B` hoặc `/sidebar`.

Workspace và điều hướng TUI
- Sidebar trái: `WORKSPACE`, phiên gần đây, `PROVIDERS` và tóm tắt `ACCOUNTS`.
- Nhấp provider để chuyển nhanh; nhấp `Manage accounts` hoặc gõ `/accounts` để quản lý hồ sơ.
- `Ctrl+B` hoặc `/sidebar` để ẩn/hiện sidebar. Terminal hẹp tự chuyển về bố cục một cột.

Quản lý tài khoản trong TUI
Gõ `/accounts` trong OpenHL để mở bảng tài khoản được chia theo provider, ví dụ:
```
──────── Gemini ────────
──────── Google AI Studio ────────
──────── Qwen ────────
──────── DeepSeek ────────
  ● user@example.com   sẵn sàng · bật
  ◷ second@example.com quota · nghỉ đến ...
  ＋ Thêm tài khoản DeepSeek
──────── ChatGPT ────────
```
Chọn một tài khoản DeepSeek để bật/tắt; chọn hồ sơ chưa đăng nhập để chạy quy trình đăng nhập riêng. Khi tài khoản đang dùng trả về lỗi quota rõ ràng, OpenHL tự chuyển sang hồ sơ DeepSeek kế tiếp đã đăng nhập. Tài khoản cạn quota được đưa vào thời gian nghỉ 15 phút. Lỗi mạng và HTTP 429 dạng rate-limit tạm thời không tự kích hoạt xoay tài khoản.

Lệnh account trong terminal
```powershell
# Liệt kê tài khoản đã nhận diện, chia theo provider
openhl accounts
# Thêm và đăng nhập một tài khoản DeepSeek mới
openhl account add deepseek abc123@gmail.com --login
# Đăng nhập lại hồ sơ đã tạo
openhl account login deepseek abc123@gmail.com
# Bật / tắt / xóa hồ sơ phụ
openhl account enable deepseek abc123@gmail.com
openhl account disable deepseek abc123@gmail.com
openhl account remove deepseek abc123@gmail.com
```

Phạm vi hỗ trợ tài khoản trong bản này: DeepSeek hỗ trợ nhiều phiên đăng nhập tách biệt và tự chuyển khi hết quota. Google AI Studio liệt kê các auth file đã lưu và tiếp tục dùng cơ chế nhiều Google auth hiện có trong backend AIStudio2API. Gemini, Qwen và ChatGPT hiện được nhóm/hiển thị trạng thái đăng nhập hiện có; chưa có cơ chế nhân bản nhiều hồ sơ độc lập và tự xoay vòng cho các provider đó.

Khi cập nhật từ bản cũ, giải nén gói mới đè lên thư mục mã nguồn OpenHL hiện tại. Gói phát hành không chứa `config.json`, `.runtime/` hoặc `.sessions/`; giữ nguyên các thư mục này để bảo toàn cấu hình, phiên đăng nhập và lịch sử chat của bạn.

## 1. Cài đặt

Yêu cầu: Node.js >= 20 (khuyến nghị 22+ để dùng đăng nhập Qwen qua Chrome).

```powershell
cd C:\Users\HP\openhl
.\install.ps1 -Register
```

Lệnh này thêm hàm `openhl` vào PowerShell profile và tạo shim `openhl.cmd` trong `WindowsApps` (đã có trên PATH). Mở terminal mới rồi gõ:
```powershell
openhl
```

Không muốn đăng ký? Chạy trực tiếp:
```powershell
cd C:\Users\HP\openhl
.\openhl.ps1
```
hoặc `.\openhl.cmd`.

## 2. Giao diện

```powershell
openhl
```

Lần đầu, OpenHL tự bật backend đang cấu hình (mặc định Gemini guest) và mở giao diện. Gõ câu hỏi, nhấn Enter.

Nhân vật AI và trạng thái hoạt động
OpenHL tự nhận diện nhân vật theo backend/model thực sự được cấu hình: ChatGPT, Gemini, Qwen hoặc DeepSeek; backend tùy chỉnh chưa nhận diện được sẽ hiển thị nhân vật OpenHL. Bản này chưa tích hợp backend Claude, vì vậy không hiển thị nhãn Claude Code giả. Khi xử lý, biểu tượng nhân vật chuyển động và dòng trạng thái mô tả việc đang làm, ví dụ Đang suy nghĩ, Đang đọc tệp, Đang di chuyển tệp, Đang chạy lệnh hoặc Đang viết câu trả lời.

Khi agent cần bạn quyết định, hộp chọn sẽ xuất hiện như một CLI tương tác: dùng ↑/↓ rồi Enter để chọn, hoặc chọn Trả lời bằng chữ…. Nếu AI chỉ hỏi câu hỏi mở, nhập câu trả lời vào ô soạn rồi nhấn Enter; Esc bỏ qua, Ctrl+C hủy tác vụ đang chờ.

Khung chat và ô soạn tin nhắn
Khung Soạn Tin nhắn nằm cố định ở đáy màn hình, gần hết chiều rộng terminal; ngay cả khi chưa nhập gì cũng có vùng nhập nhiều dòng đủ lớn.
Khi nội dung dài, ô soạn tự tăng chiều cao và cuộn theo con trỏ. `Enter` gửi; `Ctrl+Enter` xuống dòng.
Tin nhắn người dùng và OpenHL được trình bày thành các thẻ riêng, có nhãn vai trò và màu phân biệt. Văn bản thường được chuẩn hoá khoảng trắng; khoảng trắng bên trong code block được giữ nguyên.
Các tab hội thoại có viền trên/dưới, vùng bấm cao ba dòng; tên đầy đủ của cuộc trò chuyện đang mở hiển thị bên dưới thanh tab.

Phím tắt

| Phím | Việc |
| --- | --- |
| Enter | gửi tin nhắn |
| Ctrl+Enter, Alt+Enter, Ctrl+J | xuống dòng trong ô nhập |
| ↑ / ↓ | di chuyển giữa các dòng; ở đầu/cuối thì mở lịch sử |
| Home / End | đầu/cuối dòng |
| Ctrl+Home / Ctrl+End | đầu/cuối toàn bộ ô nhập |
| PgUp / PgDn, lăn chuột | cuộn lịch sử chat |
| Tab | đổi mức Thinking của model hiện tại (nếu model hỗ trợ); DeepSeek bật/tắt |
| Ctrl+S | bật/tắt web search (DeepSeek) |
| Ctrl+F | chọn tệp đính kèm (mọi tệp) |
| Ctrl+X | bỏ tệp đính kèm |
| Ctrl+P | chọn model |
| Ctrl+O | chọn backend |
| Ctrl+N | chat mới |
| Ctrl+T | tab hội thoại mới |
| Ctrl+← / Ctrl+→ | chuyển tab trước / sau |
| Ctrl+L | xoá màn hình chat |
| Ctrl+C | dừng câu trả lời / xoá input / thoát |

Có thể click chuột vào dòng `Build · model · provider`, `think`, `search` để mở picker hoặc bật/tắt nhanh. Nhấp vào `[⧉ copy]` ngay trên từng khối code để sao chép riêng khối đó; nhấp tên tab để chuyển, `×` để xoá hội thoại, `+ tab` để mở tab mới. Tên đầy đủ của tab đang mở sẽ được hiển thị ở dòng `Đang mở` bên dưới thanh tab.

Tab hội thoại
Mỗi tab là một cuộc trò chuyện riêng, có phiên lưu riêng trong `.sessions/`. Dùng `Ctrl+T` hoặc `/tab new` để mở tab, `Ctrl+←` / `Ctrl+→` hoặc nhấp tên tab để chuyển, nhấp `×` hoặc `/tab delete [n]` để xoá vĩnh viễn cuộc trò chuyện, `/tab close` để đóng tab khỏi phiên hiện tại. Có thể đổi thứ tự bằng `/tab left` và `/tab right`. Khi khởi động lại, OpenHL khôi phục tối đa 8 phiên gần đây thành các tab để bạn tiếp tục.

Sao chép
Mỗi khối code Markdown được bọc bằng dấu ba backtick có nút `[⧉ copy]` riêng ở góc phải trên khối.
Câu trả lời văn bản thông thường không hiện nút copy thừa; dùng `/copy` khi muốn sao chép toàn bộ câu trả lời.
`/copy` chép toàn bộ câu trả lời gần nhất (giữ nguyên Markdown).
`/copy code` chép khối code cuối; `/copy 2` chép khối code số 2.
Có thể bôi đen văn bản để sao chép bằng thao tác chọn của terminal; khi terminal đang bắt sự kiện chuột, giữ `Shift` trong lúc kéo chọn nếu cần.

System Prompt của riêng bạn
Bạn không cần gõ lệnh để sửa prompt. Trong giao diện chính, nhấp nút [⚙ Chỉnh sửa System Prompt] ngay bên dưới tên cuộc trò chuyện; hoặc gõ `/system` để mở cùng một trình soạn thảo nhiều dòng.
Trong màn hình SYSTEM PROMPT, bạn có thể viết vai trò, phong cách, quy tắc, định dạng trả lời và những điều AI cần tránh. Đây là một vùng nhập văn bản riêng chiếm toàn màn hình, không phải hộp chọn lệnh.

| Phím | Thao tác |
| --- | --- |
| Gõ văn bản | Soạn system prompt tự do, nhiều dòng |
| Enter | Xuống dòng |
| Ctrl+S | Lưu prompt vào cấu hình OpenHL |
| Ctrl+R | Xoá nội dung bản nháp đang sửa |
| Esc | Huỷ và đóng mà không lưu |

Prompt được lưu vào `config.json` (`chat.systemPrompt`) và áp dụng cho các lượt chat tiếp theo. Chat mode và agent mode đều được hướng dẫn hỏi lại khi thiếu thông tin quan trọng; các quy tắc do bạn viết sẽ được ghép vào hướng dẫn nền của OpenHL.

Lệnh trong giao diện

| Lệnh | Việc |
| --- | --- |
| /model | chọn model |
| /provider | chọn backend (Gemini, Google AI Studio, Qwen, DeepSeek, ChatGPT) |
| /file [đường-dẫn] | đính kèm tệp; không có đường dẫn thì mở hộp chọn tệp |
| /agent | bật/tắt chế độ agent (mặc định bật) |
| /skill | chọn skill, lưu prompt thành skill, bật/tắt skill |
| /allow | tự đồng ý thao tác trong phiên hiện tại (Guardian vẫn chặn vùng hệ thống) |
| /guard | xem nhật ký Guardian và các thư mục được bảo vệ |
| /thinking [mức\|auto\|ngân-sách-token] | chỉnh Thinking theo khả năng của model; DeepSeek bật/tắt |
| /search | bật/tắt web search (DeepSeek) |
| /copy [code\|n] | sao chép câu trả lời hoặc khối code |
| /system [set\|file\|reset] | xem hoặc sửa system prompt cá nhân |
| /tab [new\|next\|prev\|close\|delete [n]\|left\|right\|n] | quản lý, sắp xếp và xoá tab hội thoại |
| /new | phiên chat mới |
| /clear | xoá nội dung chat hiện tại |
| /help | trợ giúp |
| /exit | thoát |

Gõ `/` để mở gợi ý lệnh. Dùng `↑`/`↓`, `Tab` hoặc `Enter` để chọn.

Cài ChatGPT trực tiếp từ OpenHL
ChatGPT là một provider bên trong OpenHL. OpenHL tự cài ChatGPT-Web2API trong môi trường Python riêng dưới `vendor/chatgpt`; bạn không cần tự clone repo, tự tạo virtualenv hoặc cài package bằng tay.

Yêu cầu: Python 3.11+, Google Chrome và tài khoản ChatGPT Plus (theo yêu cầu hiện tại của dự án ChatGPT-Web2API). Việc cài provider không thay đổi tên ứng dụng hoặc package OpenHL.

```powershell
# 1. Cài ChatGPT-Web2API do OpenHL quản lý
openhl install chatgpt
# 2. Khởi động lần đầu và đăng nhập trong cửa sổ Chrome riêng
openhl login chatgpt
# 3. Mở OpenHL bằng ChatGPT
openhl --provider chatgpt
```

Sau lần đăng nhập đầu, OpenHL lưu phiên chạy của provider tại thư mục dữ liệu riêng do ChatGPT-Web2API quản lý. Khi cần cài lại/cập nhật package, dùng `openhl install chatgpt --force`. Backend mặc định chỉ lắng nghe trên máy local, cổng `8080`; khóa API nội bộ được lưu trong cấu hình OpenHL và gửi tới proxy qua biến môi trường.

Tài liệu dự án gốc: [Octo-Lex/ChatGPT-Web2API](https://github.com/Octo-Lex/ChatGPT-Web2API). Đây là cầu nối không chính thức dùng giao diện web ChatGPT, không phải OpenAI API chính thức; yêu cầu đăng nhập ChatGPT trong Chrome và có thể cần đăng nhập lại khi phiên hết hạn.

Backend mặc định dùng model `auto`. Sau khi cài và đăng nhập một lần, OpenHL tự khởi chạy proxy cùng các backend đang bật. Một Chrome session là tài nguyên dùng chung; tránh gửi nhiều yêu cầu đồng thời. Việc truy cập phụ thuộc phiên đăng nhập, trạng thái dịch vụ và giới hạn của proxy.

## 3. Agent và công cụ

Khi agent bật, model có thể yêu cầu OpenHL thực hiện các thao tác sau trên máy:

| Công cụ | Việc |
| --- | --- |
| read_file | đọc tệp |
| list_dir | liệt kê thư mục |
| search_files | tìm nội dung trong tệp |
| write_file | tạo/ghi tệp |
| append_file | ghi thêm vào tệp |
| replace_in_file | sửa nội dung tệp |
| make_dir | tạo thư mục |
| move_path | di chuyển/đổi tên |
| copy_path | sao chép |
| delete_path | xoá tệp/thư mục |
| run_command | chạy lệnh PowerShell |
| update_plan | lập kế hoạch nhiều bước |
| write_skill | đóng gói quy trình thành skill |

Agent luôn hiển thị tiến trình, kế hoạch và kết quả từng công cụ. Nếu cần quyền, OpenHL hiện hộp thoại:
`y` — cho phép lần này
`a` — cho phép trong phiên hiện tại
`n` / `Esc` — từ chối

Muốn quay lại chế độ chỉ trò chuyện: gõ `/agent` hoặc chạy `openhl --chat`.

## 4. Guardian

Guardian là lớp bảo vệ độc lập, không phụ thuộc vào model:
- Chặn ghi/xoá trong `C:\Windows`, `Program Files`, `ProgramData`, thư mục gốc ổ đĩa, `.ssh`, `.aws`, v.v.
- Chặn lệnh nguy hiểm: `format`, `diskpart`, `bcdedit`, `shutdown`, xoá thư mục hệ thống, PowerShell mã hoá, sửa registry/service…
- Yêu cầu xác nhận khi xoá, ghi ra ngoài thư mục làm việc, di chuyển tệp hoặc chạy lệnh.
- Ghi nhật ký JSONL tại `.runtime/security.log`.

Xem nhanh:
```powershell
openhl guard
```

Guardian giảm rủi ro nhưng không thay thế việc bạn kiểm tra trước khi đồng ý.

## 5. Skill

OpenHL có sẵn các skill: `architect`, `debugger`, `writer`, `researcher`, `file-organizer`, `skill-creator`, `guardian`.

```powershell
openhl skills
openhl skills use debugger
openhl skills off debugger
```

Trong giao diện, `/skill` cho phép:
- chọn/bật/tắt skill
- lưu prompt gần nhất thành skill mới
- dùng `/skill save <tên> | <mô tả>`
- dùng `/skill delete <tên>`

Skill được lưu dưới dạng Markdown trong `skills/` và có thể sửa trực tiếp.

## 6. Tệp đính kèm

- `Ctrl+F` mở hộp chọn tệp.
- `/file C:\đường\dẫn\tệp.txt` đính kèm trực tiếp.
- Kéo–thả tệp vào terminal (Windows Terminal hỗ trợ dán đường dẫn) để đính kèm.
- Tối đa 10 tệp. Ảnh: PNG/JPG/GIF/WEBP/BMP (tối đa 10 MB). Văn bản/code: tối đa 512 KB.
- Tài liệu: `.docx`, `.xlsx`, `.pptx`, `.odt`, `.ods`, `.odp`, `.epub`, `.rtf` và `.pdf` (tối đa 40 MB). OpenHL trích văn bản ngay trên máy, không gửi nguyên tệp nhị phân.
- Tệp văn bản/code UTF-8: nhận cả phần mở rộng phổ biến và phần mở rộng lạ nếu nội dung thực sự là văn bản. Hộp chọn tệp hiển thị `Mọi tệp (*.*)`; chọn được không đồng nghĩa mọi định dạng nhị phân đều giải mã được.
- PDF trích theo cách thử nghiệm (best-effort): PDF scan ảnh hoặc mã hóa phức tạp có thể không đọc được; khi đó OpenHL báo rõ thay vì gửi dữ liệu rỗng.
- Tệp văn bản được gửi làm ngữ cảnh; ảnh gửi dạng data URL nếu backend hỗ trợ.
- Nếu backend từ chối ảnh, OpenHL tự thử lại chỉ với phần văn bản.

## 7. Đăng nhập backend

### Gemini
Không bắt buộc. Guest dùng được nhưng ít model hơn. Muốn dùng tài khoản Google:
```powershell
openhl login gemini
```

### Google AI Studio Playground
Backend là [Mag1cFall/AIStudio2API](https://github.com/Mag1cFall/AIStudio2API) (Go, giấy phép MIT). OpenHL tải bản Windows Release tự động; không cần cài Git, Go hay npm để dùng backend này.

```powershell
openhl login aistudio
```

Lần đầu, OpenHL tải `aistudio2api.exe` vào `vendor\aistudio`. Mặc định OpenHL mở Camoufox (bản Firefox riêng của AIStudio2API) để bạn đăng nhập Google ngay trong cửa sổ đó — không cần đăng nhập sẵn trong Chrome. Tài khoản được lưu trong `vendor\aistudio\auth`; lần sau không cần đăng nhập lại và Camoufox không bị xóa giữa các lần.

```powershell
openhl login aistudio                    # Camoufox (mặc định)
openhl login aistudio --browser chrome   # nhập tài khoản đang có trong Chrome
openhl login aistudio --browser thorium  # Chromium khác: edge|thorium|brave|vivaldi|opera|chromium
openhl login aistudio --browser-path "C:\duong\dan\browser.exe"
openhl login aistudio --browser auto     # thử Chrome trước, không được thì Camoufox
openhl login aistudio --browser camoufox # Camoufox, giữ nguyên bản tải
openhl login aistudio --force            # thêm tài khoản Google khác
openhl login aistudio --fresh            # xóa tài khoản đã lưu rồi đăng nhập lại
openhl doctor aistudio                   # kiểm tra kết nối và model
openhl models                            # xem model hiện có
```

Trình duyệt bạn chọn được ghi vào `config.json` (`providers.aistudio.browser`) nên các lần sau OpenHL dùng đúng lựa chọn đó, không tự ý đổi. OpenHL chỉ ép một trình duyệt khi kỹ thuật bắt buộc — ví dụ Qwen cần trình duyệt Chromium vì luồng đăng nhập dùng CDP, còn Camoufox là Firefox nên không dùng được CDP. Với AI Studio, phần sinh nội dung chạy bằng SpiderMonkey trong tiến trình khi bạn chọn Chromium, và bằng Camoufox khi bạn chọn Camoufox.

Camoufox (mặc định): cửa sổ Firefox riêng của AIStudio2API, tự đăng nhập Google được, tải một lần và dùng lại.
Chrome: đọc profile Chrome đang có trên máy (nhanh nhất nếu bạn đã đăng nhập Google trong Chrome).
Edge/Thorium/Brave/Vivaldi/Opera/Chromium: AIStudio2API không đọc profile các trình duyệt này từ đĩa, nên OpenHL mở chúng với profile riêng tại `vendor\aistudio\runtime\<tên>-profile`, bạn đăng nhập Google một lần, rồi OpenHL nhập tài khoản qua `setup --cdp`. Muốn dùng bản Chromium khác, truyền thẳng file `.exe` bằng `--browser-path`.
auto: thử Chrome trước, không thấy tài khoản thì chuyển sang Camoufox.

Không có thư mục Camoufox nào bị xóa tự động. `--fresh` chỉ xóa tài khoản trong `vendor\aistudio\auth` để bạn chọn tài khoản Google khác.

Backend dùng Playground làm kênh tạo nội dung mặc định. Kênh Build cũ bị tắt mặc định trong upstream vì Google đã ngừng hỗ trợ luồng đó. OpenHL khởi động API ở `http://127.0.0.1:2048/v1` và yêu cầu dịch vụ sinh nội dung phải ở trạng thái `RUNNING`.

Không cần Google Gemini API Key. `openhl-local` là khóa cục bộ giữa OpenHL và backend trên máy của bạn, không phải khóa Google. OpenHL tự đặt khóa này khi khởi động backend.

### Qwen
```powershell
openhl login qwen
```

Lệnh này mở Chrome/Edge/Thorium… có sẵn trên máy (không tải thêm trình duyệt) với profile riêng của OpenHL tại `chat.qwen.ai`. Bạn đăng nhập tài khoản Qwen miễn phí một lần. OpenHL chờ đến khi tài khoản thực sự đăng nhập xong, rồi lưu token + `auth-session` vào `config.json` (`providers.qwen.env.QWEN_TOKEN`, `QWEN_AUTH_COOKIE`) và kiểm tra chat thật trước khi báo thành công. Mật khẩu không được lưu. Sau đó:

Bạn có thể chọn trình duyệt cụ thể cho Qwen:
```powershell
openhl login qwen --browser chrome   # mặc định khi có Chrome
openhl login qwen --browser edge     # dùng Microsoft Edge
openhl login qwen --browser thorium  # Thorium, Brave, Vivaldi, Opera, Chromium…
openhl login qwen --browser "C:\duong\dan\browser.exe"
openhl login qwen --browser auto     # tự chọn
```

Qwen bắt buộc dùng trình duyệt Chromium vì luồng đăng nhập cần Chrome DevTools Protocol; Camoufox dựa trên Firefox nên không hỗ trợ CDP. Đây là trường hợp duy nhất OpenHL ép loại trình duyệt.

```powershell
openhl --provider qwen
```

Lần sau OpenHL dùng lại token — không phải đăng nhập lại. Token Qwen chỉ sống khoảng 15 phút, nhưng OpenHL tự làm mới bằng `auth-session` đã lưu; nếu cookie hết hạn hoàn toàn thì mới cần:
```powershell
openhl login qwen --force
```

Đã có token sẵn (Network → `Authorization: Bearer ...`):
```powershell
openhl login qwen --token "<token>"
```

Lưu ý: guest mode không cần tài khoản của smanx hiện bị Qwen/Aliyun WAF chặn (`RGV587_ERROR`), nên OpenHL dùng chế độ tài khoản. Backend vẫn là smanx/qwen2api chạy Node, cổng 7860.

### DeepSeek
```powershell
openhl login deepseek
openhl --provider deepseek
```

`login` mở Chrome hoặc Edge có sẵn trên máy (không tải thêm trình duyệt) để đăng nhập `chat.deepseek.com` một lần. Session lưu trong `vendor\deepseek\session`.

Sau khi vào giao diện:
- `think:on` → gửi `thinking: true`
- `search:on` → gửi `search: true`

Phần suy luận hiện màu xám dưới nhãn `~ thinking`. Nếu tài khoản bị DeepSeek mute, OpenHL báo rõ thời gian mở lại thay vì trả lời trống.

### Đổi tài khoản
Mỗi backend lưu phiên riêng. Dùng `--fresh` để xóa phiên cũ rồi đăng nhập tài khoản khác; không cần xóa file thủ công.

```powershell
openhl login qwen --fresh
openhl login deepseek --fresh
openhl login aistudio --fresh
openhl login gemini --fresh
```

Qwen: đóng cửa sổ Chrome của OpenHL trước (nếu còn), chạy lệnh trên, rồi đăng nhập tài khoản Qwen mới. `--force` chỉ mở lại Chrome với phiên hiện tại, không đổi tài khoản.

DeepSeek: lệnh sẽ xóa `vendor\deepseek\session` (profile Chrome + token) và mở trang đăng nhập mới.

AI Studio: lệnh xóa `vendor\aistudio\auth`, sau đó chạy lại nhập tài khoản Google từ Chrome hoặc dùng luồng đăng nhập dự phòng.

Gemini: mặc định là guest, không cần tài khoản. `--fresh` xóa phiên Google cũ; nếu backend không hiện bước chọn tài khoản, hãy dùng AI Studio để chat bằng tài khoản Google.

Sau khi đổi, kiểm tra lại:
```powershell
openhl status
openhl --provider qwen
```

## 8. Lệnh terminal

```powershell
openhl                          # mở giao diện agent
openhl --chat                   # mở giao diện chỉ trò chuyện
openhl --once "Xin chào"        # chạy một lượt (agent)
openhl --once --chat "2+2?"     # chạy một lượt, chỉ chat
openhl login <backend>          # đăng nhập
openhl install <backend>        # gemini | aistudio | qwen | deepseek | all
openhl start [backend|all]      # bật backend
openhl stop [backend|all]       # tắt backend
openhl restart [backend|all]
openhl status                   # bảng trạng thái
openhl models                   # model đang có
openhl serve                    # gateway OpenAI-compatible
openhl doctor                   # chẩn đoán môi trường
openhl config get|set|path
openhl sessions
openhl skills [list|use|off]
openhl guard
openhl --provider deepseek --model deepseek-expert
openhl --continue               # tiếp tục phiên gần nhất
openhl --demo                   # in thử giao diện
```

Tùy chọn hữu ích:
```
--provider <name>     backend lúc mở
--model <id>          model lúc mở
--attach <file>       đính kèm tệp (lặp lại được)
--thinking / --no-thinking
--search / --no-search
--reasoning           in phần suy luận với --once
--yes                 tự đồng ý thao tác agent (vẫn qua Guardian)
--allow               cho phép trong phiên
--skill <name>        bật skill (có thể lặp lại)
--max-steps <n>       giới hạn số bước agent
```

## 9. Gateway (tùy chọn)

```powershell
openhl serve
```

Base URL: `http://127.0.0.1:8787/v1`
API key: `openhl-local`
Model: `gemini/<id>`, `aistudio/<id>`, `qwen/<id>`, `deepseek/<id>`

```powershell
$body = '{"model":"gemini/gemini-3.8-flash","messages":[{"role":"user","content":"Hello"}]}'
curl.exe http://127.0.0.1:8787/v1/chat/completions `
  -H "Authorization: Bearer openhl-local" `
  -H "Content-Type: application/json" -d $body
```

Gateway chỉ bind `127.0.0.1`.

## 10. Cấu hình

`config.json`:
```json
{
   "version": 2,
   "brand": "OpenHL",
   "gateway": { "port": 8787, "apiKey": "openhl-local" },
   "chat": {
     "provider": "gemini",
     "model": "",
     "thinking": true,
     "search": true,
     "temperature": null,
     "systemPrompt": ""
   },
   "agent": {
     "enabled": true,
     "maxSteps": 12,
     "allowSession": false,
     "activeSkills": []
   },
   "providers": {
     "gemini": { "kind": "gemini-web2api", "port": 8007 },
     "aistudio": { "kind": "aistudio2api", "port": 2048, "exe": "aistudio2api.exe" },
     "qwen": { "kind": "qwen2api-node", "port": 7860, "env": { "QWEN_TOKEN": "" } },
     "deepseek": { "kind": "deepseek-api", "port": 8000 }
   }
}
```

Sửa nhanh:
```powershell
openhl config path
openhl config set chat.provider deepseek
openhl config set agent.enabled true
openhl config set agent.maxSteps 16
openhl config set chat.thinking true
openhl config set chat.search true
```

Biến môi trường: `OPENHL_HOME` (đổi thư mục dữ liệu), `NO_COLOR=1`, `OPENHL_DEBUG=1`.

## 11. Xử lý sự cố

| Triệu chứng | Cách xử lý |
| --- | --- |
| `openhl` không tìm thấy | chạy `.\install.ps1 -Register`, mở terminal mới |
| PowerShell chặn `.ps1` | dùng `openhl` (shim cmd) hoặc `.\openhl.cmd` |
| Backend chưa sẵn sàng | `openhl status`, xem `.runtime\logs\<backend>.log` |
| DeepSeek báo mute | chờ hết thời gian ghi trong thông báo, dùng tài khoản khác, hoặc chuyển Gemini/AI Studio |
| DeepSeek 503 | `openhl login deepseek` rồi mở lại |
| AI Studio chưa có tài khoản / dịch vụ chưa chạy | `openhl login aistudio`, bấm/khởi động dịch vụ rồi `openhl doctor aistudio` |
| Qwen `RGV587_ERROR` hoặc chưa có token | `openhl login qwen` (đăng nhập Chrome một lần) |
| Qwen token hết hạn | OpenHL tự làm mới khi mở; nếu không được: `openhl login qwen --force` |
| Qwen đã đăng nhập nhưng không trả lời | `openhl doctor qwen` (kiểm tra token, cổng 7860, gửi thử một tin nhắn) |
| Gemini guest không nhận ảnh | đăng nhập Google hoặc gửi tệp văn bản |
| Muốn thoát | `Ctrl+C` (hai lần nếu đang có chữ trong ô nhập) |

## 12. Credits & license

- [Mag1cFall/Gemini-Web2API](https://github.com/Mag1cFall/Gemini-Web2API) — MIT
- [iBUHub/AIStudioToAPI](https://github.com/iBUHub/AIStudioToAPI) — CC BY-NC 4.0
- [smanx/qwen2api](https://github.com/smanx/qwen2api) — MIT
- [sums001/Deepseek-API](https://github.com/sums001/Deepseek-API) — MIT

OpenHL là lớp giao diện/quản lý và agent. Dùng tài khoản của bạn và tuân thủ điều khoản từng dịch vụ. Guardian giảm rủi ro nhưng không thay thế việc bạn kiểm tra trước khi đồng ý cho agent chạy lệnh.

Mã nguồn OpenHL: giấy phép phi thương mại (xem `LICENSE`) — tự do dùng/sửa/chia sẻ phi thương mại, không được bán hoặc dùng cho mục đích thương mại. Watermark/tác giả gốc: Contact me via Discord: doki_doki_fuwa.fuwa.

### Nhập nhiều dòng và sao chép câu trả lời

Nhấn `Ctrl+Enter` để xuống dòng trong ô soạn tin; nhấn `Enter` để gửi.
Nếu terminal không gửi được `Ctrl+Enter`, thử `Alt+Enter`, `Ctrl+J`, hoặc gõ `\` rồi Enter.

Mặc định OpenHL không chiếm chuột của terminal, vì vậy bạn có thể kéo chuột để bôi đen nội dung hội thoại rồi nhấn `Ctrl+Shift+C` (Windows Terminal) để sao chép.

Nếu muốn dùng chuột để bấm các nút/tab trong giao diện, đặt biến môi trường `OPENHL_MOUSE=1` trước khi chạy OpenHL. Chế độ này sẽ bật mouse tracking và có thể khiến việc bôi đen văn bản phụ thuộc vào terminal; hãy bỏ biến này để ưu tiên chọn/sao chép.

### Language / Ngôn ngữ

The interface is English by default. Type `/lang vi` in the app (or run `openhl lang vi`) to switch to Vietnamese, and `/lang en` to switch back. The choice is saved in `config.json` (`ui.lang`); the `OPENHL_LANG` environment variable overrides it.

Giao diện mặc định là tiếng Anh. Gõ `/lang vi` trong ứng dụng (hoặc `openhl lang vi`) để chuyển sang tiếng Việt, `/lang en` để quay lại.

### Chuẩn bị trước khi đưa lên GitHub

Trước khi `git push` lên repo public, kiểm tra:
- [ ] File `.gitignore` đã có trong repo (đi kèm trong bản này) — loại `config.json`, `.runtime/`, `.sessions/`, `vendor/*/auth`, `vendor/*/session`, `node_modules/`, log, `.env`. Đây là nơi lưu token/cookie đăng nhập thật của bạn — không commit các thư mục/tệp này.
- [ ] Chạy `git status` trước khi `git add .` để chắc chắn không có `config.json` hay thư mục `vendor/*/auth|session` nào lọt vào.
- [ ] File `LICENSE` đã có watermark/tên tác giả bạn muốn giữ (xem phần "Giấy phép" ở trên).
- [ ] Không có email, token hoặc API key thật nào còn sót trong `config.example.json` hoặc trong các file test.
- [ ] `package.json` giữ `"private": true` để tránh bị `npm publish` nhầm lên npm registry.
