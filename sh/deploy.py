import argparse
import platform
import subprocess

parser = argparse.ArgumentParser(description="Deploy commands to servers.")
parser.add_argument("--command", type=str, help="Command to execute on the servers")
args = parser.parse_args()


def run_script(script_name, command):
    try:
        subprocess.run(script_name + [command], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")


os_name = platform.system()
update_script = (
    ["powershell", "-ExecutionPolicy", "Bypass", "-File", "sh/update.ps1"]
    if os_name == "Windows"
    else ["bash", "./sh/update.sh"]
)

# Pass the command to the script
if args.command:
    run_script(update_script, args.command)
else:
    print("No command provided. Exiting.")
