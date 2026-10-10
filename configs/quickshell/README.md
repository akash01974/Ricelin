# Ricelin Quickshell

Ricelin's custom Quickshell interface for Hyprland. The configuration is split
into three independent shells: the everyday pill, a standalone app launcher,
and a PAM-backed session lock screen.

## Shells

| Config | Entry point | Purpose |
|---|---|---|
| `pill/` | `pill/shell.qml` | Multi-monitor top bar that expands into interactive surfaces. |
| `launcher/` | `launcher/shell.qml` | Standalone fuzzy app launcher with usage-based ranking. |
| `lock/` | `lock/shell.qml` | Animated Wayland session lock screen with PAM authentication. |

The pill includes workspaces and window controls, media, calendar, clipboard,
wallpaper, audio and brightness controls, Wi-Fi and Bluetooth, battery and
peripheral status, notifications, system monitoring, settings, and recording.
Its surfaces share state and services through `pill/Singletons/`.

## Layout

- `pill/`, `launcher/`, and `lock/` each contain a `shell.qml` Quickshell entry
  point and their QML components.
- `pill/Singletons/` owns shared services and application state.
- `pill/lib/` and `launcher/lib/` contain JavaScript helpers and focused tests.
- `lock/Singletons/` contains lock-screen-specific shared services.
- `lock/shaders/` contains the lock screen's shader sources and compiled Qt
  shader assets.

## Running

With the config installed under `~/.config/quickshell`, start an individual
shell in the background with Quickshell's `qs` command:

```sh
qs -c pill -d
qs -c launcher -d
qs -c lock -d
```

In a normal Ricelin install, the Hyprland keybinds and watchdog scripts manage
the pill and lock screen. The `ricelin` helper can start, stop, restart, inspect,
or follow logs for those services:

```sh
ricelin status
ricelin restart pill
ricelin log pill
```

The pill and launcher expose IPC for keybinds and scripts. For example:

```sh
qs -c pill ipc call pill calendar ""
qs -c pill ipc call pill hide
qs -c launcher ipc call launcher show DP-1
```

The monitor argument is the Hyprland monitor name. Ricelin's standard keybinds
include `Super+Space` for the launcher, `Super+V` for clipboard, `Super+C` for
wallpapers, `Super+L` to lock, and `Super+D` for the recording chooser.

## Requirements

- Quickshell with the QML modules used by the configuration.
- Hyprland on Wayland; monitor, workspace, and window integration uses
  Quickshell's Hyprland API.
- Qt Multimedia's QML module for video wallpapers.
- A working system PAM `login` configuration for lock-screen authentication.
- Ricelin's supporting desktop services for the related controls, such as
  PipeWire/WirePlumber, NetworkManager, BlueZ, and the wallpaper tools.

The Ricelin installer resolves packages for supported distributions. See the
[main project README](https://github.com/akash01974/Ricelin/blob/main/README.md)
and `installer/packages.json` for setup details.

## Tests

Run the included JavaScript tests from this directory with Node.js:

```sh
node --test launcher/lib/fuzzy.test.mjs pill/lib/monitors.test.mjs
```

The launcher stores ranking history in
`${XDG_STATE_HOME:-~/.local/state}/ricelin/launcher-usage.json`.
