import argparse
import subprocess
import time
import logging
import platform
from concurrent.futures import ThreadPoolExecutor, as_completed
from tqdm import tqdm

# Initialize logging
logging.basicConfig(
    filename="sh/deploy.log",
    level=logging.INFO,
    format="%(asctime)s - %(message)s",
)


def run_ssh_command(server, command, ssh_options):
    start_time = time.time()
    try:
        # Depending on the platform, choose PowerShell or Bash
        if platform.system() == "Windows":
            full_command = [
                "powershell",
                "-ExecutionPolicy",
                "Bypass",
                "-Command",
                f'ssh {ssh_options} eriim@{server} "{command}"',
            ]
        else:
            full_command = ["ssh", ssh_options, f"eriim@{server}", command]

        output = subprocess.check_output(full_command, universal_newlines=True)
        duration = time.time() - start_time
        logging.info(
            f"Successfully executed '{command}' on {server} in {duration:.2f} seconds."
        )
        return server, output, None
    except subprocess.CalledProcessError as e:
        duration = time.time() - start_time
        logging.error(
            f"Failed executing '{command}' on {server} in {duration:.2f} seconds. Error: {e}"
        )
        return server, None, e


# Argument Parsing
parser = argparse.ArgumentParser(description="Deploy commands to servers")
parser.add_argument("--command", type=str, help="Command to execute on the servers")
args = parser.parse_args()

# Server IPs and SSH options
servers = ["192.168.2.195", "192.168.2.196", "192.168.2.197"]
ssh_options = "-p 2973"

tasks = {server: args.command for server in servers}

# Using ThreadPoolExecutor to run commands concurrently
results = []
with ThreadPoolExecutor(max_workers=len(servers)) as executor:
    # Initialize tqdm progress bar
    with tqdm(total=len(tasks), desc="Executing Commands", unit="server") as progress:
        futures = {
            executor.submit(run_ssh_command, server, command, ssh_options): server
            for server, command in tasks.items()
        }
        for future in as_completed(futures):
            server = futures[future]
            try:
                (
                    server,
                    output,
                    error,
                ) = (
                    future.result()
                )  # Ensure this matches the return values of run_ssh_command
                results.append((server, output, error))
            except Exception as exc:
                logging.error(f"{server} generated an exception: {exc}")
                results.append((server, None, exc))
            finally:
                progress.update(1)

# Sort results based on the order of servers and print/output them
results.sort(key=lambda x: servers.index(x[0]))
for server, output, error in results:
    if output:
        print(f"Output from {server}:\n{output}")
    if error:
        print(f"Error from {server}: {error}")

print("Execution completed on all servers.")
