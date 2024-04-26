import subprocess
import os
import re


def strip_ansi_sequences(text):
    """Remove ANSI escape sequences from a string."""
    ansi_escape = re.compile(r"\x1B[@-_][0-?]*[ -/]*[@-~]")
    return ansi_escape.sub("", text)


def run_command(command):
    """Run a shell command and return its output."""
    result = subprocess.run(command, shell=True, text=True, capture_output=True)
    return strip_ansi_sequences(result.stdout)


def directory_tree(path):
    """Generate a directory tree structure, ignoring hidden folders and listing only folder names."""
    tree = []
    for root, dirs, files in os.walk(path):
        # Skip hidden directories
        dirs[:] = sorted([d for d in dirs if not d.startswith(".")])
        level = root.replace(path, "").count(os.sep)
        if level == 0 or not root.split(os.sep)[-1].startswith("."):
            indent = " " * 4 * level
            tree.append(f"{indent}{os.path.basename(root)}/")
    return "\n".join(tree)


def generate_readme(
    username, repo_name, path, markdown_prefix_file="docs/readme-header.md"
):
    """Generate README.md content."""
    existing_content = ""
    try:
        with open(markdown_prefix_file, "r") as f:
            existing_content = f.read()
    except FileNotFoundError:
        print("%s not found, creating new file.", markdown_prefix_file)

    flake_show_output = run_command(f"nix flake show . --all-systems")
    dir_tree = directory_tree(path)

    readme_content = (
        existing_content
        + f"""

`nix flake show`

```nix
{flake_show_output}
```

`Directory Tree`

```bash
{dir_tree}
```

"""
    )

    return readme_content


with open("README.md", "w") as f:
    f.write(generate_readme("erictossell", "nix-pi-lab", "."))
