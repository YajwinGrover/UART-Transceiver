import serial
import time

PORT = 'COM9'
BAUD = 115_200

ser = serial.Serial(PORT, BAUD, timeout=1)

while (True):
    chunk = ser.read(1)
    if not chunk:
        continue
    #print(chunk.decode('ascii', errors='replace'), end='\n', flush=True)
    print(chunk)

    for i in range(int.from_bytes(chunk, byteorder='big')+1):
        ser.write(i.to_bytes(1, byteorder='big'))
        time.sleep(0.5)
        