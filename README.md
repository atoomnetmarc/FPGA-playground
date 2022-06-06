# Why?

This repository contains random collection of FPGA related stuff as a result of trying to lean Verilog.

Hardware: [Olimex iCE40HX8K-EVB](https://www.olimex.com/Products/FPGA/iCE40/iCE40HX8K-EVB/open-source-hardware) board.

Toolchain: [APIO](https://github.com/FPGAwars/apio).

Programmer: customized FT2232H board.

I programmed the bitstream using a FT2232H board with wiring instructions from [Davide Berardi](https://cs.unibo.it/~davide.berardi6/post/20200604-1.html). To make my experience somewhat easier and let APIO recognize the serial chip I reprogrammed the FT2332 using [FT_PROG](https://ftdichip.com/utilities/#ft_prog) with the EEPROM contents from the [iCEstick](https://hedmen.org/icestorm-doc/icestorm.html#USB-communication).\
Choose `iCE40-HX8K` as the board in APIO.

# Links

Dutch book [Programmeerbare logica van 0 en 1 tot FPGA](http://www.siliconvalleygarage.com/published-works/programmeerbare-logica.html) by [Vincent Himpe](http://www.siliconvalleygarage.com/about-me.html).\
Book [Microprocessor Design Using Verilog HDL](https://www.elektor.com/microprocessor-design-using-verilog-hdl-e-book) by [Monty Dalrymple](https://www.linkedin.com/in/monte-dalrymple-04237013).\
[Shawn Hymel](https://shawnhymel.com/)'s [introduction to FPGA](https://www.youtube.com/playlist?list=PLEBQazB0HUyT1WmMONxRZn9NmQ_9CIKhb) on YouTube.\
Stacey's [FPGAs For Beginners](https://www.youtube.com/c/FPGAsforBeginners/) on YouTube.\
HDLBits [Verlilog Practice](https://hdlbits.01xz.net).

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
