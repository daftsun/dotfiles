"""
Config Placer - A utility to manage dotfiles by copying them from a source directory to the home directory.

This script helps maintain dotfiles by:
1. Finding configuration files in the dotfiles repository
2. Linking them to appropriate locations in the home directory
3. Preserving directory structures and file metadata
"""

import os
from collections.abc import Generator
from pathlib import Path

# Constants
IGNORED_PATHS: frozenset[str] = frozenset({".git", "config_placer.py", ".gitignore", "installer.sh", "readme.md"})

IGNORED_CONFIGS = frozenset({".zshrc", "alacritty", "hypr", "waybar", "wofi"})


def find_config_files() -> Generator[Path, None, None]:
    """Find all configuration files and directories in the dotfiles repository."""
    dotfiles_path = Path(__file__).parent
    for item_path in dotfiles_path.iterdir():
        if item_path.name.lower() not in IGNORED_PATHS:
            yield item_path


def link_config_item(source: Path, destination: Path) -> None:
    """Link a configuration file or directory to its destination."""
    target_path = destination.joinpath(source.name)
    if source.name in IGNORED_CONFIGS:
        return
    if source.name in ".config":
        for glob in source.glob("*"):
            link_config_item(glob, target_path)
        return

    target_path.symlink_to(source, target_is_directory=source.is_dir())
    print(f"Linked {source.name} to {target_path}")


def main() -> None:
    """Main function to initiate the configuration placement process."""
    home_dir = Path.home()

    print("Starting config placement...")
    for config_item in find_config_files():
        link_config_item(config_item, home_dir)
    print("Config placement complete!")


if __name__ == "__main__":
    main()
