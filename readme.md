# Just another candle simulation

I made this little code in 2015, when I had a demand for a LED
based candle, and everything I found was either ugly
or just did not look "natural". The ugly ones are those
you get for almost no money, consisting of a battery pack
and a flicker LED, which switches brightness in a few
steps in fast random times.

So I made this one, based on a Attiny85 which replays
short sequences of brightness variations which I captured
from a real candle. I captured the brightness at a rate
of 10 samples/sec, and the code plays 30 samples/sec,
calculating the interim steps between each captured 
value. 
The repository contains a few captured data sets. Each
data set contains 16 sequences of different length, which
are replayed in random order.

Besides that, the code has two additional functions:

- It checks the voltage of the battery, which in my
case is a Li-Ion type. Below ~2.8 the controller 
gets into sleep mode. That saves the battery from 
damage. The sleep current is below 1 µA.
- You can connect a LDR to check for the environmental
brightness. If connected, the candle will pause e.g.
during the day, saving battery power. At daytime, the
sun is much brighter that the LED.

I use it with a 700mAh rechargeable battery. At an
average current of 7mA, it lasts net for 100 hours, or
about a week, when it is off at daytime.

There are two PCB layouts included, which fit nicely 
on a CR123 battery holder. They use different form
factors of the Attiny85, DIL or SOIC. For the DIL, I
bend the pins sideways and then solder it to the surface 
of the PCB. That way, the PCB sits flat beneath the
battery holder. The circuit is protected against
inserting the battery in the wrong orientation.

For use, I take a sufficiently large candle, diameter >65mm,
let it burn down such that is has a nice shape, with a cavity
of ~2cm at the top. Then I make a hole in the bottom for the
battery holder with the PCB, connect the LED and the LDR, 
and then I'm done. The only problem with that approach is,
that wax melts in the sun. So do not expose it to direct 
sunlight. Otherwise you get candles in Salvador Dali style.
Even then, I have to replace the wax part sometimes. It gets
dirty after a while at the graveyard.

Note: If you ask, what the relation to Micropython is:
I used a PyBoard 1.0 and a LDR to capture the brightness 
pattern of a real candle, and a Python script for normalizing
the data and cutting it into appropriate segments.
