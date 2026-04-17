# claude-code-shot

Zero-friction macOS screenshot slash commands for [Claude Code](https://claude.com/claude-code). Capture any screen (or region) and attach it to the current session — no clipboard, no paste, no context switch.

Built for multi-monitor setups, but works fine with one.

## Why

Claude Code lets you paste images from the clipboard with `Ctrl+V`, but that's a manual step: take the screenshot, switch to the terminal, paste. These commands collapse all of that into one slash command. The screenshot is saved to disk, and Claude reads it automatically — just like a pasted image, but hands-free.

## Commands

| Command | What it captures | Mouse? |
|---|---|---|
| `/shot` | Interactive drag selection on any display | yes |
| `/shotm` | Main display (the one with the menu bar) | **no** |
| `/shotn <N>` | Display N — e.g. `/shotn 2`. Errors cleanly if N is out of range | **no** |
| `/shota` | All displays stitched into one image | **no** |
| `/shots` | **Lists your current displays** and how to capture each | — |

When in doubt, run `/shots` — it reads live display state, so it stays correct across plug / unplug / rearrangement.

## Install

```sh
git clone https://github.com/shubham030/cc-shot.git ~/.cc-shot
cd ~/.cc-shot && ./install.sh
```

That clones the repo to `~/.cc-shot` and copies the slash commands into `~/.claude/commands/`, making them available in every Claude Code session.

### Update later

```sh
cd ~/.cc-shot && git pull && ./install.sh
```

### Uninstall

```sh
rm ~/.claude/commands/shot*.md
rm -rf ~/.cc-shot
```

### Project-level install (only for one project)

If you'd rather not install globally, copy `.claude/commands/*.md` into your project's own `.claude/commands/` directory.

## First-run setup

macOS requires **Screen Recording** permission for `screencapture` to work when invoked from a terminal.

1. Open **System Settings → Privacy & Security → Screen Recording**
2. Enable your terminal (WezTerm / iTerm / Terminal / Ghostty / whatever)
3. Fully quit and relaunch the terminal

If `/shot` fails with `could not create image from rect`, this is almost always the cause.

## How it works

Each command runs `screencapture` with different flags, writes a PNG to `/tmp/cc-shot.png`, and instructs Claude to `Read` that file. Claude Code's `Read` tool renders images natively, so the screenshot joins the conversation exactly like a pasted image.

```
/shotn 2  →  screencapture -D 2 -x /tmp/cc-shot.png  →  Read /tmp/cc-shot.png
```

`/shotn N` also uses a `&& echo CAPTURED || echo FAILED` guard: if `screencapture` fails (e.g. display `N` doesn't exist), Claude sees `FAILED` in the output and tells you to run `/shots` instead of reading a stale file.

`/shots` runs `system_profiler SPDisplaysDataType` and has Claude parse it into a live table of `# | resolution | main? | command`. It's always accurate, even when you plug or unplug displays.

## Requirements

- macOS (uses built-in `screencapture` and `system_profiler`)
- Claude Code CLI

## Contributing

PRs welcome. I only run macOS, so Linux and Windows ports would need someone who actually uses those day-to-day — see [CONTRIBUTING.md](CONTRIBUTING.md) for ideas.

## License

MIT
