import sys
import subprocess

def kill_process(program_name):
    try:
        command = f"pgrep -af {program_name}"
        result = subprocess.run(command, shell=True, capture_output=True, text=True)

        processes = result.stdout.strip().split('\n')

        if processes:
            for process in processes:
                parts = process.split()
                pid = parts[0]  # PID is the first element
                process_name = " ".join(parts[1:])
                if program_name in process_name:
                    kill_command = f"kill -9 {pid}"
                    subprocess.run(kill_command, shell=True)
                    print(f"Process {pid} ({process_name}) has been killed.")
        else:
            print(f"No processes found for {program_name}.")

    except Exception as e:
        print(f"Error: {e}")

def main():
    if len(sys.argv) != 2:
        print("Usage: kill_process.py \"program_name\"")
        sys.exit(1)

    program_name = sys.argv[1]
    kill_process(program_name)

if __name__ == "__main__":
    main()
