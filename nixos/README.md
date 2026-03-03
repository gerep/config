# NixOS Configuration

Flake-based NixOS configuration for a Samsung Galaxy Book with Intel CPU and NVIDIA GPU, running the Niri Wayland compositor.

## Structure

```
nixos/
├── flake.nix                  # Flake entry point, declares inputs
├── flake.lock                 # Pinned package versions (auto-generated)
├── configuration.nix          # Main system configuration
├── hardware-configuration.nix # Auto-generated hardware config
```

## Quick Reference

### Rebuild after editing `configuration.nix`

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### Test changes without making them permanent

```bash
sudo nixos-rebuild test --flake .#nixos
# Reboot to go back to the previous generation if something breaks
```

### Update packages

```bash
# Update nixpkgs to latest
nix flake update

# Rebuild to apply
sudo nixos-rebuild switch --flake .#nixos
```

### Rollback

```bash
# Revert to previous lockfile
git checkout flake.lock
sudo nixos-rebuild switch --flake .#nixos

# Or select a previous generation from the boot menu
```

## System Overview

| Component       | Choice                  |
| --------------- | ----------------------- |
| OS              | NixOS 25.11 (unstable)  |
| Kernel          | Linux 6.18              |
| GPU             | NVIDIA (proprietary)    |
| Compositor      | Niri (Wayland)          |
| Display Manager | SDDM                   |
| Terminal        | Ghostty                 |
| Shell           | Zsh (Oh My Zsh)         |
| Audio           | PipeWire                |
| Editor          | Neovim                  |
| Browser         | Brave                   |
| Fonts           | FiraCode Nerd Font      |
