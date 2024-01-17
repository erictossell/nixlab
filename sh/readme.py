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


def generate_readme(username, repo_name, path):
    """Generate README.md content."""
    flake_show_output = run_command(f"nix flake show github:{username}/{repo_name}")
    dir_tree = directory_tree(path)

    readme_content = f"""###nix-pi-lab

A basic configuration for 3 different raspberry-pi devices running NixOS.

    - A live image for flashing SSH access

    - Wireless network configuration with Agenix encrypted secrets

    - Docker Swarm Cluster, managed by terraform


    `nix flake show`
    ```nix
    {flake_show_output}
    ```
    `tree`
    ```bash
    {dir_tree}
    ```
    """
    return readme_content


with open("README.md", "w") as f:
    f.write(generate_readme("erictossell", "nix-pi-lab", "."))
