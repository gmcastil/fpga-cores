# Signal Timing

The HSYNC and VSYNC pulses (can be active low or high) determine the start of a
new line or a new frame (respectively).  Each HSYNC pulse is preceded and
followed by a short blanking period in the video signals that are referred as
back and front porches.

There are horizontal and vertical back porches, which are blank periods that
occur on each RGB video signal after and before (respectively) the sync pulse
which indiciates the start of a new line.

## Horizontal Timings
SO the HSYNC pulse duration is set to 8% of the total horizontal time, rounded
down to the nearest cell width.

## Coordinated Video Timing Standard
The CVT defines how timings are calculated for all analog video modes.  It
references a legacy method for performing calculations called generalized timing
formulas (GTF) and there even turns out to be a utility that ships with `xorg`
for convenience.  See `man gtf` for more details.  An additional tool `cvt`
ships to calculate CVT timings (probably preferable).

Note that the standard CRT-based timing formulas was removed from the VESA CVT
standard in revision 2.0.

## Sources
[Analog video timing specifications](http://javiervalcarce.eu/html/vga-signal-format-timming-specs-en.html)
[MIT VGA analog basics](https://faculty-web.msoe.edu/johnsontimoj/EE3921/files3921/vga_basics.pdf)

