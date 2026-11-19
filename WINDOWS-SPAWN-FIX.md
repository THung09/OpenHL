# OpenHL v2.6.0 — Windows npm spawn fix

This patch fixes the AI Studio install failure `spawn EINVAL` on Windows.

Cause: the installer was passing `npm.cmd` directly to `child_process.spawn()`. Windows command scripts need to be invoked through `cmd.exe` (or a shell).

Change: `src/providers.js` now runs `npm install` via `%ComSpec%` / `cmd.exe` on Windows, and continues to invoke npm directly on POSIX systems.

Replace the matching OpenHL source folder with this archive, or replace only `src/providers.js` with the file from this archive.
