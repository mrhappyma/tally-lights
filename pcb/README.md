### Welcome to the PCB design files!

This was my first time ever designing a PCB so there are a couple things that could have been made better. Here you will find two files, `Sketch.json` is the EasyEDA file with the main sketch in it, by importing it into EasyEDA you can extract files that can be opened in KiCad, etc...

`Routes.json` is an EasyEDA file with all the routing for the PCB, this was all done using the autorouter, I'm sure it could have been better.

Fun details about the design of this board: 
- You will notice that the battery holder is on a little board off to the side of the main board... this is because JLCPCB charges an astronomical amount for double sided board assembly. To combat this, the battery holder was put on the same side as the other components, but on a little board off to the side. You desolder the battery holder from its board, use a dremel to cut off the little board, and then solder the battery holder on the bottom!

Mistakes on this design of the PCB:
1. The blue color in the RGB LED closest to the USB-C port does not function as GPIO9 on the ESP8266 is reserved for something else, if you try to use it, it probably will not work in your favor :)
2. You need a 1K pulldown resistor between TX and GND as the serial converter pulls it up, causing boot to fail.
3. You need a large-ish capacitor between 3.3V and GND on the ESP8266 as the device would bootloop when the WiFi hardware was utilized. I used a 33uF cap and that seems to fix it right up!
4. You need a .1uF cap between 3.3V and GND on the CH340 USB to serial converter chip or else it will not work!

Good Luck!!