# OpenHL 2.6.2 — AI Studio Playground migration

This update replaces the retired iBUHub/AIStudioToAPI Build-only provider with Mag1cFall/AIStudio2API.

- Default AI Studio backend: `Mag1cFall/AIStudio2API`
- Default generation channel: Google AI Studio Playground
- Local API endpoint: `http://127.0.0.1:2048/v1`
- Windows release asset: `aistudio2api-v*-windows-amd64.zip`
- Google Gemini API key: not required; a Google AI Studio account is required.
- `openhl-local` is only the local proxy credential shared between OpenHL and the backend.

The existing `aistudio2api.exe` login, startup, and service-control branch was aligned to the current upstream repository. OpenHL explicitly pins `UPSTREAM_CHANNELS=playground`. Account login first tries Chrome import, then uses the upstream-native `setup --login` flow so current authentication renewal material is retained. The old Node/npm installation path is no longer the default. Existing `aistudio-node` config is migrated to the new backend while retaining the locally configured proxy key. A partial old Node checkout is moved aside as a backup before the Go executable is installed.

To use the AI Studio backend:

```powershell
openhl login aistudio
openhl doctor aistudio
openhl models
openhl --provider aistudio
```

The upstream's current Playground implementation is documented at https://github.com/Mag1cFall/AIStudio2API. Google account access and usage limits continue to apply.


## Windows launcher fix (2.6.2)

- Run the local `openhl.cmd` in the extracted folder for the first test (`.\openhl.cmd --version`) so an older globally registered `openhl` command cannot launch a stale copy.
- The Windows account-setup command now uses `cmd /d /c start \"\" /wait ...` without `/s`, avoiding an extra quote-stripping layer when the executable path contains spaces.
