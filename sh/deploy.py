import platform
import subprocess


def run_script(script_name):
    try:
        subprocess.run(script_name, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")


os_name = platform.system()

update_script = "sh/update.ps1" if os_name == "Windows" else "./sh/update.sh"

if os_name == "Windows":
    run_script(["powershell", "-ExecutionPolicy", "Bypass", "-File", update_script])
else:
    run_script(["bash", update_script])
