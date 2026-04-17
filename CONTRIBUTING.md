# Contributing

Thanks for your interest! This project is small by design, but contributions are welcome.

## Ground rules

- **Keep it tiny.** Each slash command should stay simple enough to fit on a screen. If a command needs shell logic, prefer splitting into multiple command files over adding complexity.
- **No shell expansion in `!` blocks.** Claude Code's permission checker rejects `${VAR}`, `"$X"`, `case`, `$(...)`, and similar in inline bash. That's why commands are one-per-mode instead of argument-dispatched.
- **No external dependencies.** Everything should work with tools that ship with macOS (`screencapture`, `system_profiler`, `osascript`).
- **Test on a real machine.** Screen Recording permission, multi-monitor layouts, and display numbering quirks can only be verified live.

## Good first contributions

- **Linux port** — Swap `screencapture` for `grim` (Wayland), `scrot`, `gnome-screenshot`, or `maim`. Use an OS detection gate in the install script. *(I don't have a Linux machine to test on, so if you do — this would be a big help.)*
- **Windows port** — Likely via PowerShell's `Add-Type` with `System.Windows.Forms`, or a tool like `nircmd` / Snipping Tool CLI. *(Same story — no Windows box here, so contributions very welcome.)*
- **`/shotd N`** — Delayed capture. Use `screencapture -T $ARGUMENTS` with the same `CAPTURED`/`FAILED` guard pattern as `/shotn`.
- **`/shotw`** — `screencapture -w` window picker (click-to-select a window on any display).
- **`/shotc`** — Capture the frontmost window automatically using AppleScript + window ID.

## Proposing a change

1. Open an issue first for anything bigger than a typo fix so we can talk scope.
2. Fork, branch, open a PR against `main`.
3. Conventional commit style: `feat:`, `fix:`, `docs:`, `chore:`, etc.
4. Update the README's command table if you add or change commands.
5. Keep PRs focused — one feature or fix per PR.

## Testing manually

After editing a command:

```fish
cp .claude/commands/*.md ~/.claude/commands/
```

Open a fresh Claude Code session and run the command. If you changed `/shots`, confirm its table matches `system_profiler SPDisplaysDataType` reality.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
