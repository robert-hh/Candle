##
from array import *
import pyb

# Read analog values.
def analogread(size = 100, run = 1):

    fname = "data_%d" % run
    buffer = array("h", [0 for i in range(size)])
    adc = pyb.ADC(pyb.Pin.board.X19)

    no = adc.read_timed(buffer, 10) # read 10000 values = 1000 Seconds

    maxval = 0
    minval = 4096
    for i in range(size): # find min and max
        maxval = max(maxval, buffer[i])
        minval = min(minval, buffer[i])

    print("Min = %d, Max = %d (Raw)" % (minval, maxval))
# normalize

    with open(fname, "w") as f:
        for i in buffer:
            f.write("%d\n" % i)

