import argparse
import subprocess
import time
import logging
import platform

# Initialize logging
logging.basicConfig(
    filename="sh/deploy.log",
    level=logging.INFO,
    format="%(asctime)s - %(message)s",
)


def run_script(script_name, command):
    start_time = time.time()
    try:
        os_name = platform.system()
        if os_name == "Windows":
            # PowerShell execution
            ps_command = [
                "powershell",
                "-ExecutionPolicy",
                "Bypass",
                "-File",
                script_name,
                command,
            ]
            subprocess.run(ps_command, check=True)
        else:
            # Bash execution
            bash_command = ["bash", script_name, command]
            subprocess.run(bash_command, check=True)

        duration = time.time() - start_time
        logging.info(f"Successfully executed '{command}' in {duration:.2f} seconds.")
    except subprocess.CalledProcessError as e:
        duration = time.time() - start_time
        logging.error(
            f"Failed executing '{command}' in {duration:.2f} seconds. Error: {e}"
        )


# Argument Parsing
parser = argparse.ArgumentParser(description="Deploy commands to servers")
parser.add_argument("--command", type=str, help="Command to execute on the servers")
args = parser.parse_args()

# Determine the appropriate script based on OS
update_script = (
    "sh/ssh_command.ps1" if platform.system() == "Windows" else "./sh/ssh_command.sh"
)

# Execute the script with the provided command
if args.command:
    run_script(update_script, args.command)
else:
    print("No command provided. Exiting.")
