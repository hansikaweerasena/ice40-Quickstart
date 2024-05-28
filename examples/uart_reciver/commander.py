import serial
import time

def send_command(command):
    with serial.Serial('/dev/tty.usbserial-FT4MG9OV1', 9600, timeout=1) as ser:
        # Send the command followed by a newline character
        ser.write((command + '\n').encode())
        time.sleep(0.1)  # Give the FPGA some time to process the command

if __name__ == "__main__":

    send_command("ON")
    print("LED turned ON")
    time.sleep(10) 

    send_command("OFF")
    print("LED turned OFF")
