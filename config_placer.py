"""
Config Placer - A utility to manage dotfiles by copying them from a source directory to the home directory.

This script helps maintain dotfiles by:
1. Finding configuration files in the dotfiles repository
2. Copying them to appropriate locations in the home directory
3. Preserving directory structures and file metadata
"""

import shutil
from collections.abc import Generator
from pathlib import Path

# Constants
IGNORED_PATHS: frozenset[str] = frozenset(
    {".git", "config_placer.py", ".gitignore", ".ruff_cache", "installer.sh", "README.MD"}
)


def find_config_files() -> Generator[Path, None, None]:
    """Find all configuration files and directories in the dotfiles repository."""
    dotfiles_path = Path(__file__).parent
    for item_path in dotfiles_path.iterdir():
        if item_path.name not in IGNORED_PATHS:
            yield item_path


def copy_config_item(source: Path, destination: Path) -> None:
    """Copy a configuration file or directory to its destination."""
    if source.name in IGNORED_PATHS:
        print(f"Skipping ignored item: {source.name}")
        return

    target_path = destination.joinpath(source.name)
    try:
        if source.is_dir():
            target_path.mkdir(parents=True, exist_ok=True)
            for item in source.iterdir():
                copy_config_item(item, target_path)
        else:
            shutil.copy2(src=source, dst=target_path)
            print(f"{source.name.upper():<20} {'->':<5} {destination}")

    except shutil.Error as err:
        print(f"Failed to copy {source.name}: {err}")
    except Exception as err:
        print(f"Unexpected error while copying {source.name}: {err}")


def main() -> None:
    """Main function to initiate the configuration placement process."""
    home_dir = Path.home()

    print("Starting config placement...")
    for config_item in find_config_files():
        copy_config_item(config_item, home_dir)
    print("Config placement complete!")


if __name__ == "__main__":
    main()
