MSX 1 BIOS Entries
==================

RST-and other routines
----------------------

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0000   |CHKRAM<br>STARTUP<br>RESET<br>BOOT |Tests RAM and sets RAM slot for the system. After this, a jump must be made to INIT, for further initialisation. Remark   : After this, a jump must be made to INIT, for further initialisation.

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0008   |SYNCHR | Tests whether the character of (HL) is the specified character.<br>if not, it generates SYNTAX ERROR, otherwise it goes to [CHRGTR](#CHRGTR) (#0010)
    Input    : Set the character to be tested in (HL) and the character to be
            compared next to RST instruction which calls this routine (inline parameter)
    Output   : HL is increased by one and A receives (HL), When the tested character is
            numerical, the carry flag is set the end of the statement (00h or 3Ah) causes
            the zero flag to be set
    Registers: AF, HL

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|000C   |RDSLT  |Reads the value of an address in another slot
    Input    : A  - ExxxSSPP  Slot-ID
                    │   ││└┴─ Primary slot number (00-11)
                    │   └┴─── Secondary slot number (00-11)
                    └──────── Expanded slot (0 = no, 1 = yes)
                    HL - Address to read
    Output   : A  - Contains the value of the read address
    Registers: AF, C, DE
    Remark   : This routine turns off the interupt, but won't turn it on again

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0010   |CHRGTR |Gets the next character (or token) of the Basic text
    Input    : HL - Address last character
    Output   : HL - Points to the next character
                A  - Contains the character
                Carry flag set if it's a number
                Zero flag set if it's the end of the statement
    Registers: AF, HL

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0014   |WRSLT  |Writes a value to an address in another slot.
    Input    : A  - Slot ID, see [RDSLT](#RDSLT)
               HL - Address
               E  - Value
    Registers: AF, BC, D
    Remark   : See [RDSLT](#RDSLT)

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0018   |OUTDO  |Output to current output channel (printer, file, etc.)
    Input    : A  - PRTFIL, PRTFLG
    Remark   : Used in basic, in ML it's pretty difficult

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|001C   |CALSLT |Executes inter-slot call.
    Input    : IY - High byte with slot ID, see [RDSLT](#RDSLT)
            IX - The address that will be called
    Remark   : Variables can never be given in alternative registers or IX and IY

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0020   |DCOMPR |Compares HL with DE, Zero flag set if HL and DE are equal. Carry flag set if HL is less than DE.Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0024   |ENASLT |Switches indicated slot at indicated page on perpetually
    Input    : A - Slot ID, see [RDSLT](#RDSLT)
            H - Bit 6 and 7 must contain the page number (00-11)

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0028   |GETYPR |Returns Type of DAC
    Input    : DAC
    Output   : S,Z,P/V, CY
    Registers: AF
    Remark   : Not a very clear routine to me, please mail us if you know more about it.

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0030   |CALLF  |Executes an interslot call, Remark   : The following is the calling sequence:
    RST #30
    DB destination slot ID, see [RDSLT](#RDSLT)
    DW destination address

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0038   |KEYINT |Executes the timer interrupt process routine
|003B   |INITIO |Initialises the device
|003E   |INIFNK |Initialises the contents of the function keys

VDP routines
------------
|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0041   |DISSCR |Inhibits the screen display, Registers: AF, BC
|0044   |ENASCR |Displays the screen, Registers: AF, BC

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0047   |WRTVDP |Write data in the VDP-register
    Input   :   B  - Data to write
                C  - Number of the register
    Registers:  AF, BC

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|004A   |RDVRM  |Reads the content of VRAM
    Input    : HL - Address read
    Output   : A  - Value which was read
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|004D   |WRTVRM | Writes data in VRAM
    Input   :   HL - Address write
                A  - Value write
    Registers:  AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0050   |SETRD  |Enable VDP to read
|0053   |SETWRT |Enable VDP to write
    Input    : HL - For VRAM-address
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0056   |FILVRM |Fill VRAM with value
    Input    : A  - Data byte
            BC - Length of the area to be written
            HL - Start address
    Registers: AF, BC


|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0059   |LDIRMV |Block transfer to memory from VRAM
    Input   :   BC - Block length
                DE - Start address of memory
                HL - Start address of VRAM
    Registers:  All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|005C   |LDIRVM |Block transfer to VRAM from memory
    Input    : BC - Block length
            DE - Start address of VRAM
            HL - Start address of memory
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|005F   |CHGMOD |Switches to given screen mode
    Input    : A  - Screen mode
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0062   |CHGCLR |Changes the screen colors
    Input    : Foreground color in FORCLR
            Background color in BAKCLR
            Border color in BDRCLR
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0066   |NMI    | Executes non-maskable interupt handling routine

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0069   |CLRSPR |Initialises all sprites
    Input    : SCRMOD
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|006C   |INITXT |Switches to SCREEN 0 (text screen with 40×24 characters)
    Input    : TXTNAM, TXTCGP
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|006F   |INIT32 | Switches to SCREEN 1 (text screen with 32×24 characters)
    Input    : T32NAM, T32CGP, T32COL, T32ATR, T32PAT
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0072   |INIGRP | Switches to SCREEN 2 (high resolution screen with 256×192 pixels)
    Input    : GRPNAM, GRPCGP, GRPCOL, GRPATR, GRPPAT
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0075   |INIMLT | Switches to SCREEN 3 (multi-color screen with 64×48 pixels)
    Input    : MLTNAM, MLTCGP, MLTCOL, MLTATR, MLTPAT
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0078   |SETTXT |Switches VDP to SCREEN 0 mode, See [INITXT](#INITXT)
|007B   |SETT32 |Switches VDP to SCREEN 1 mode, See [INIT32](#INIT32)
|007E   |SETGRP |Switches VDP to SCREEN 2 mode, See [INIGRP](#INIGRP)
|0081   |SETMLT |Switches VDP to SCREEN 3 mode, See [INIMLT](#INIMLT)

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0084   |CALPAT | Returns the address of the sprite pattern table
    Input    : A  - Sprite ID
    Output   : HL - For the address
    Registers: AF, DE, HL

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0087   |CALATR |Returns the address of the sprite attribute table
    Input    : A  - Sprite number
    Output   : HL - For the address
    Registers: AF, DE, HL

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|008A   |GSPSIZ |Returns current sprite size
    Output  :   A  - Sprite size in bytes
                Carry flag set when size is 16×16 sprites otherwise Carry flag is reset
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|008D   |GRPPRT |Displays a character on the graphic screen
    Input    : A  - ASCII value of the character to print

PSG routines
------------
|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0090   |GICINI |Initialises PSG and sets initial value for the PLAY statement
|0093   |WRTPSG |Writes data to PSG register
    Input   :   A  - PSG register number
                E  - Data write

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0096   |RDPSG  |Reads value from PSG register
    Input    : A  - PSG register read
    Output   : A  - Value read

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0099   |STRTMS |Tests whether the PLAY statement is being executed as a background task. If not, begins to execute the PLAY statement

Console routines
----------------

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|009C   |CHSNS  |Tests the status of the keyboard buffer
    Output   : Zero flag set if buffer is empty, otherwise not set
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|009F   |CHGET  | One character input (waiting)
    Output   : A  - ASCII code of the input character
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00A2   |CHPUT  | Displays one character
    Input    : A  - ASCII code of character to display

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00A5   |LPTOUT | Sends one character to printer
    Input    : A  - ASCII code of character to send
    Output   : Carry flag set if failed
    Registers: F

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00A8   |LPTSTT |Tests printer status
    Output  :   A  - #FF and zero flag reset if printer is ready
                     #00 and zero flag set if not ready
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00AB   |CNVCHR |Tests for the graphic header and transforms the code
    Output   : The carry flag is reset to not the graphic reader
            The carry flag and zero flag are set to the transformed code is set in A
            The carry flag is set and zero flag is reset to the untransformed code is set in A
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00AE   |PINLIN |Stores in the specified buffer the character codes input until the return key or STOP key is pressed
    Output   : HL - For the starting address of the buffer -1
            Carry flag set when it ends with the STOP key
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00B1   |INLIN  |Same as [PINLIN](#PINLIN) except that AUGFLG (#F6AA) is set
    Output   : HL - For the starting address of the buffer -1
            Carry flag set when it ends with the STOP key
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00B4   |QINLIN |Prints a question mark and one space
    Output   : HL - For the starting address of the buffer -1
            Carry flag set when it ends with the STOP key
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00B7   |BREAKX |Tests status of CTRL-STOP
    Output   : Carry flag set when pressed
    Registers: AF
    Remark   : In this routine, interrupts are inhibited

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00BA   |ISCNTC |Tests status of SHIFT-STOP
|00BD   |CKCNTC |Same as [ISCNTC](#ISCNTC). used in Basic
|00C0   |BEEP   |Generates beep, Registers: All
|00C3   |CLS    |Clears the screen
    Registers: AF, BC, DE
    Remark   : Zero flag must be set to be able to run this routine
            XOR A will do fine most of the time

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00C6   |POSIT  | Moves cursor to the specified position
    Input    : H  - Y coordinate of cursor
            L  - X coordinate of cursor
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00C9   |FNKSB  |Tests whether the function key display is active (FNKFLG),  If so, displays them, otherwise erase them
    Input    : FNKFLG (#FBCE)
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00CC   |ERAFNK |Erase functionkey display, Registers: All
|00CF   |DSPFNK |Displays the function keys, Registers: All
|00D2   |TOTEXT |Forces the screen to be in the text mode

Controller routines
-------------------
|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00D5   |GTSTCK |Returns the joystick status
    Input    : A  - Joystick number to test (0 = cursors, 1 = port 1, 2 = port 2)
    Output   : A  - Direction
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00D8   |GTTRIG | Returns current trigger status
    Input   :   A  - Trigger button to test
                0 = space bar
                1 = port 1, button A
                2 = port 2, button A
                3 = port 1, button B
                4 = port 2, button B
    Output  :   A  -    #00 trigger button not pressed
                        #FF trigger button pressed
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00DB   |GTPAD  | Returns current touch pad status
    Input    : A  - Function call number. Fetch device data first, then read.

            \[ 0\]   Fetch touch pad data from port 1 (#FF if available)
            \[ 1\]   Read X-position
            \[ 2\]   Read Y-position
            \[ 3\]   Read touchpad status from port 1 (#FF if pressed)

            \[ 4\]   Fetch touch pad data from port 2 (#FF if available)
            \[ 5\]   Read X-position
            \[ 6\]   Read Y-position
            \[ 7\]   Read touchpad status from port 2 (#FF if pressed)

    Output   : A  - Value
    Registers: All

Remark   : On MSX2, function call numbers 8-23 are forwarded to
           [NEWPAD](subrom.php#NEWPAD) in the SubROM.

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00DE   |GTPDL  |Returns current value of paddle
    Input    : A  - Paddle number
    Output   : A  - Value
    Registers: All

Tape device routines
--------------------

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00E1   |TAPION |Reads the header block after turning the cassette motor on
    Output   : Carry flag set if failed
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00E4   |TAPIN  | Read data from the tape
    Output  :   A  - Read value
                Carry flag set if failed
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00E7   |TAPIOF |Stops reading from the tape

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00EA   |TAPOON |Turns on the cassette motor and writes the header
    Input    : A  - #00 short header
                not #00 long header
    Output   : Carry flag set if failed
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00ED   |TAPOUT |Writes data on the tape
    Input    : A  - Data to write
    Output   : Carry flag set if failed
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00F0   |TAPOOF |Stops writing on the tape

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00F3   |STMOTR |Sets the cassette motor action
    Input    : A  - #00 stop motor
                    #01 start motor
                    #FF reverse the current action
    Registers: AF

Queue routines
--------------

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00F6   |LFTQ   |Gives number of bytes in queue
|00F9   |PUTQ   |Put byte in queue. Remark   : Internal use
Output   : A  - Length of queue in bytes
Remark   : Internal use

Graphic routines
----------------
|Address| Name  |Description|
|:-----:|:-----:|-----------|
|00FC   |RIGHTC |Shifts screen pixel to the right, Registers: AF
|00FF   |LEFTC  |Shifts screen pixel to the left, Registers: AF
|0102   |UPC    |Shifts screen pixel up, Registers: AF
|0105   |TUPC   |Tests whether [UPC](#UPC) is possible, if possible, execute [UPC](#UPC), Carry flag set if operation would end outside the screen, Registers: AF
|0108   |DOWNC  |Shifts screen pixel down, Registers: AF
|010B   |TDOWNC |Tests whether [DOWNC](#DOWNC) is possible, if possible, execute [DOWNC](#DOWNC), Carry flag set if operation would end outside the screen, Registers: AF
|010E   |SCALXY |Scales X and Y coordinates
|0111   |MAPXY  |Places cursor at current cursor address
|0114   |FETCHC |Gets current cursor addresses mask pattern <pre>Input    : HL - Cursor address<br>A  - Mask pattern</pre>
|0117   |STOREC |Record current cursor addresses mask pattern <pre>Input    : HL - Cursor address<br>A  - Mask pattern</pre>
|011A   |SETATR |Set attribute byte
|011D   |READC  |Reads attribute byte of current screen pixel
|0120   |SETC   |Returns current screen pixel of specified attribute byte
|0123   |NSETCX |Set horizontal screen pixels
|0126   |GTASPC |Gets screen relations, Output   : DE, HL, Registers: DE, HL
|0129   |PNTINI |Initalises the PAINT instruction
|012C   |SCANR  |Scans screen pixels to the right
|012F   |SCANL  |Scans screen pixels to the left

Misc routines
-------------

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0132   |CHGCAP |Alternates the CAPS lamp status
    Input    : A  - #00 is lamp on
                not #00 is lamp off
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0135   |CHGSND |Alternates the 1-bit sound port status
    Input    : A  - #00 to turn off
                not #00 to turn on
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0138   |RSLREG |Reads the primary slot register
|013B   |WSLREG |Writes value to the primary slot register
    Output   : A  - For the value which was read(RSLREG), write(WSLREG)
            33221100
            ││││││└┴─ Page 0 (#0000-#3FFF)
            ││││└┴─── Page 1 (#4000-#7FFF)
            ││└┴───── Page 2 (#8000-#BFFF)
            └┴─────── Page 3 (#C000-#FFFF)
    Registers: A

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|013E   |RDVDP  |Reads VDP status register, A  - Value which was read

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0141   |SNSMAT |Returns the value of the specified line from the keyboard matrix
    Input    : A  - For the specified line
    Output   : A  - For data (the bit corresponding to the pressed key will be 0)
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0144   |PHYDIO |Executes I/O for mass-storage media like disks
    Input   :   F  - Set carry to write, reset carry to read
                A  - Drive number (0 = A:, 1 = B:, etc.)
                B  - Number of sectors
                C  - Media ID of the disk
                DE - Begin sector
                HL - Begin address in memory
    Output  :   F  - Carry set on error
                A  - Error code (only if carry set)
                    0 = Write protected
                    2 = Not ready
                    4 = Data error
                    6 = Seek error
                    8 = Record not found
                    10 = Write error
                    12 = Bad parameter
                    14 = Out of memory
                    16 = Other error
                B  - Number of sectors actually written or read
    Registers: All
    Remark   : Interrupts may be disabled afterwards. On some hard disk interfaces,
            when bit 7 of register C is set, a 23-bit addressing scheme is used
            and bits 0-6 of register C contain bits 23-16 of the sector number.

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0147   |FORMAT |Initialises mass-storage media like formatting of disks, Remark:In minimum configuration only a HOOK is available

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|014A   |ISFLIO |Tests if I/O to device is taking place
    Output   : A  - #00 if not taking place
                not #00 if taking place
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|014D   |OUTDLP |Printer output
    Input    : A  - Code to print
    Registers: F
    Remark   : Differences with [LPTOUT](#LPTOUT):
             1. TAB is expanded to spaces
             2. For non-MSX printers, Hiragana is transformed to katakana
                and graphic characters are transformed to 1-byte characters
             3. If failed, device I/O error occurs

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0150   |GETVCP |Returns pointer to play queue
    Input    : A  - Channel number
    Output   : HL - Pointer
    Registers: AF
    Remark   : Only used to play music in background

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0153   |GETVC2 |Returns pointer to variable in queue number VOICEN (byte at #FB38)
    Input    : L  - Pointer in play buffer
    Output   : HL - Pointer
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0156   |KILBUF |Clear keyboard buffer, Registers using HL
    Registers: HL

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0159   |CALBAS |Executes inter-slot call to the routine in BASIC interpreter
    Input    : IX - For the calling address
    Output   : Depends on the called routine
    Registers: Depends on the called routine

MSX 2 BIOS Entries
==================
|Address| Name  |Description|
|:-----:|:-----:|-----------|
|015C   |SUBROM |Calls a routine in SUB-ROM
    Input    : IX - Address of routine in SUB-ROM
    Output   : Depends on the routine
    Registers: Alternative registers, IY

Remark   : Use of [EXTROM](#EXTROM) or [CALSLT](#CALSLT) is more convenient.
        In IX an extra value to the routine can be given by first
        pushing it to the stack.

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|015F   |<a name="EXTROM">EXTROM</a> |Calls a routine in SUB-ROM. Most common way
    Input    : IX - Address of routine in SUB-ROM
    Output   : Depends on the routine
    Registers: Alternative registers, IY
    Remark   : Use: LD IX,address
                    CALL EXTROM

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0162   |CHKSLZ |Search slots for SUB-ROM
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0165   |CHKNEW |Tests screen mode
    Output   : Carry flag set if screenmode = 5, 6, 7 or 8 
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0168   |EOL    |Deletes to the end of the line
    Input   :   H  - X coordinate of cursor
                L  - Y coordinate of cursor
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|016B   |BIGFIL |Same function as [FILVRM](#FILVRM) (with 16-bit VRAM-address)
    Input   :   HL - Address
                BC - Length
                A  - Data
    Registers:  AF,BC

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|016E   |NSETRD |Same function as [SETRD](#SETRD) (with 16-bit VRAM-address).
    Input    : HL - VRAM address
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0171   |NSTWRT | Same function as [SETWRT](#SETWRT) (with 16-bit VRAM-address).
    Input    : HL - VRAM address
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0174   |NRDVRM |Reads VRAM like in [RDVRM](#RDVRM) (with 16-bit VRAM-address).
    Input    : HL - VRAM address
    Output   : A  - Read value
    Registers: F

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0177   |NWRVRM |Writes to VRAM like in [WRTVRM](#WRTVRM) (with 16-bit VRAM-address).
    Input   :   HL - VRAM address
                A  - Value to write
    Registers:  AF

MSX 2+ BIOS Entries
===================

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|017A   |RDRES  |Read value of I/O port #F4
    Input    : None
    Output   : A = value read
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|017D   |WRRES  |Write value to I/O port #F4
    Input    : A = value to write
            When bit 7 is reset it shows the MSX 2+ startup screen on boot,
            and counts and initialises the RAM.
    Output   : None
    Registers: None

MSX turbo R BIOS Entries
========================

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0180   |CHGCPU |Changes CPU mode
    Input    : A = LED 0 0 0 0 0 x x
                    │            0 0 = Z80 (ROM) mode
                    │            0 1 = R800 ROM  mode
                    │            1 0 = R800 DRAM mode
                LED indicates whether the Turbo LED is switched with the CPU
    Output   : None
    Registers: None

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0183   |GETCPU |Returns current CPU mode
    Input    : None
    Output   : A = 0 0 0 0 0 0 x x
                            0 0 = Z80 (ROM) mode
                            0 1 = R800 ROM  mode
                            1 0 = R800 DRAM mode
    Registers: AF

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0186   |PCMPLY | Plays specified memory area through the PCM chip
    Input    : A = v 0 0 0 0 0 x x
                │           │ │
                │           └─┴── Quality parameter (Speed: 0 = Fast)
                └──────────────── VRAM usage flag
            HL= Start address in RAM or VRAM
            BC= Length of area to play
            D = Bit 0 = Bit 17 of area length when using VRAM
            E = Bit 0 = Bit 17 os start address when using VRAM
    Output   : Carry flag set when aborted with CTRL-STOP
    Registers: All

|Address| Name  |Description|
|:-----:|:-----:|-----------|
|0189    |PCMREC |Records audio using the PCM chip into the specified memory area
    Input    : A = v t t t t c x x
                │ │ │ │ │ │ │ │
                │ │ │ │ │ │ └─┴── Quality parameter (Speed: 0 = Fast)
                │ │ │ │ │ └────── Zero-data compression
                │ └─┴─┴─┴──────── Treshold
                └──────────────── VRAM usage flag
            HL= Start address in RAM or VRAM
            BC= Length of area to play
            D = Bit 0 = Bit 17 of area length when using VRAM
            E = Bit 0 = Bit 17 os start address when using VRAM
    Output   : Carry flag set when aborted with CTRL-STOP
    Registers: All

<hr>

WorkArea
========

Basic Interpreter
-----------------

|Address| Name |Length|Description|
|:-----:|:----:|:----:|--------------------------|
| F39Ah |USRTAB|20    | Table that contains addresses of routine in machine language specified with the instruction DEFUSRX=.(Contains the error routine address of the Basic by default.)
||||<pre>USRTAB+0 = Address specified with DEFUSR0=<br>USRTAB+2 = Address specified with DEFUSR1=<br>USRTAB+4 = Address specified with DEFUSR2=<br>USRTAB+6 = Address specified with DEFUSR3=<br>USRTAB+8 = Address specified with DEFUSR4=<br>USRTAB+10 = Address specified with DEFUSR5=<br>USRTAB+12 = Address specified with DEFUSR6=<br>USRTAB+14 = Address specified with DEFUSR7=<br>USRTAB+16 = Address specified with DEFUSR8=<br>USRTAB+18 = Address specified with DEFUSR9=</pre>
| F40Fh   | ENDPRG| 5      | Dummy program end for instructions RESUME ... NEXT. (contains DB ":",0,0,0,0 by default)|
| F414h   | ERRFLG| 1      | Number of the last error occurred
| F419h   | VLZADR| 2      | Address of character replaced by VAL
| F41Bh   | VLZDAT| 1      | Character replaced with 0 by VAL
| F41Ch   | CURLIN| 2      | Current execution line number of Basic
| F41Eh   | KBFMIN| 1      | Used if direct statement error occures
| F41Fh   | KBUF  | 318    | Crunch buffer; translated into intermediate language from BUF
| F55Dh   | BUFMIN| 1      | Used by INPUT routine
| F55Eh   | BUF   | 258    | Buffer to store characters displayed to screen under Basic in direct mode.Used also by some Basic interpreter processes.For example the COPY instruction of Basic stores values as below
||||<pre>BUF   = SX (VDP R#32 &amp; VDP R#33)<br>BUF+2 = SY (VDP R#34 &amp; VDP R#35)<br>BUF+4 = DX (VDP R#36 &amp; VDP R#37)<br>BUF+6 = DY (VDP R#38 &amp; VDP R#39)<br>BUF+8 = NX (VDP R#40 &amp; VDP R#41)<br>BUF+10 = NY (VDP R#42 &amp; VDP R#43)<br>BUF+12 = CDUMMY (VDP R#44)<br>BUF+13 = ARG (VDP R#45)<br>BUF+14 = L_OP (VDP R#46)<br><br>The VDP is also able to communicate with the DISKROM to save or load images from or to VRAM<br>A 2Byte filename pointer is expected in SX for loading and DX for writing operation<br>i.e. FNAAM: DEFB 34,"d:filename.ext",34,0<br>See [http://map.grauw.nl/resources/subrom.php SUB-ROM / EXT-ROM]<br>(BIT-BLIT routines)<br><br>L_OP has 10 different operators:<br>  0 - PSET      1 - AND<br>  2 - OR        3 - XOR<br>  4 - PRESET    8 - TPSET<br>  9 - TAND     10 - TOR<br> 11 - TXOR     12 - TPRESET</pre>
| F660h   | ENDBUF | 1      | Flag to prevent overflow of BUF
| F661h   | TTYPOS | 1      | Virtual cursor location internally retained by the BASIC
| F662h   | DIMFLG | 1      | DIM instruction flag to distinguishing between array and simple variables
| F664h   | DORES  | 1      | Tempory flag for the BASIC interpreter that indicates if stored keyword can be tokenized or not
| F664h   | OPRTYP | 1      | When an operator used with an instruction, its type is stored momentarily here
| F665h   | DONUM  | 1      | Flag for the number encoding (IEEE 754-1985)
| F666h   | CONTXT | 2      | Temporary save of the text pointer
| F668h   | CONSAV | 1      | Store token of constant after calling CHRGTR (00010h en Main-ROM)
| F669h   | CONTYP | 1      | Type of stored constant, used by CHRGTR (00010h en Main-ROM)
| F66Ah   | CONLO  | 8      | Value of stored constant
| F676h   | TXTTAB | 2      | Start address of the Basic program to load.Initially contains the address to BOTTOM+1 (0FC48h+1)
| F678h   | TEMPPT | 2      | Starting address of unused area of temporary descriptor
| F67Ah   | TEMPST | 30     | Temporary descriptors
| F698h   | DSCTMP | 3      | Contains the length and position of the "Ok" message of the BASIC. SET PROMPT modifies it
||||<pre> DSCTMP = Number of characters<br> DSCTMP+1 = Pointer to the string (Variable also called "DSCPTR")</pre>
| F69Bh   | FRETOP | 2      | Starting address of unused area of string area
| F69Dh   | TEMP3  | 2      | Used for garbage collection or by USR function
| F69Fh   | TEMP8  | 2      | Used for garbage collection
| F6A1h   | ENDFOR | 2      | Next address of the instruction FOR, used by NEXT
| F6A3h   | DATLIN | 2      | Line number of the instruction DATA read by READ
| F6A5h   | SUBFLG | 1      | Flag for array for USR fun
| F6A6h   | FLGINP | 1      | Flag for the instruction INPUT or READ
| F6A7h   | TEMP   | 2      | Location for temporary reservation for st.code
| F6A9h   | PTRFLG | 1      | Pointer line number conversion flag for the Basic interpreter.0 = Do not convert; other = Convert
| F6AAh   | AUTFLG | 1      | Auto mode flag (0 = Yes / other = No)
| F6ABh   | AUTLIN | 2      | Current line number for auto
| F6ADh   | AUTINC | 2      | Increment for auto
| F6AFh   | SAVTXT | 2      | Text pointer for resume
| F6B1h   | SAVSTK | 2      | Save stack when an error occurs
| F6B3h   | ERRLIN | 2      | Line number where last error
| F6B5h   | DOT    | 2      | Current line number displayed by LIST
| F6B7h   | ERRTXT | 2      | Pointer to the error message
| F6B9h   | ONELIN | 2      | Line number to go when error, Used by ON ERROR GOTO
| F6BBh   | ONEFLG | 1      | Error flag for the instruction ON ERROR GOTO.1 if an error processing is in progress, otherwise 0
| F6BCh   | TEMP2  | 2      | Work area for the formula evaluation routine
| F6BEh   | OLDLIN | 2      | Line number stored after the execution of the instruction STOP or END, or by pressing CTRL+STOP
| F6C0h   | OLDTXT | 2      | Old text pointer. The pointer is directed to the instruction following the one where the stop occurred
| F6E4h   | PRMSTK | 2      | Previous definition block on the stack. (To clean the waste.)
| F6E6h   | PRMLEN | 2      | Number of bytes used in PARM1
| F6E8h   | PARM1  | 100    | Area 1 for parameters block storage
| F74Ch   | PRMPRV | 2      | Pointer to previous parameter block in PARM1
| F74Eh   | PRMLN2 | 2      | Number of bytes used in PARM2
| F750h   | PARM2  | 100    | Area 2 for to store the blocks being created
| F7B4h   | PRMFLG | 1      | Flag to indicate whether PARM1 was searching
| F7B5h   | ARYTA2 | 2      | End point of search
| F7B7h   | NOFUNS | 1      | 0 if no function active
| F7B8h   | TEMP9  | 2      | Location of temporary storage for garbage collection
| F7BAh   | FUNACT | 1      | Count of active functions
| F7BCh   | SWPTMP | 8      | Value of first variable in instruction SWAP
| F92Dh   | MINDEL | 2      | Used internally by graphic routines
| F92Fh   | MAXDEL | 2      | Used internally by graphic routines
| F956h   | MCLTAB | 2      | Table address of current macro used by the DRAW &amp; PLAY instructions
| F958h   | MCLFLG | 1      | Flag for the instructions DRAW &amp; PLAY
| FBB0h   | ENSTOP | 1      | &lt;&gt;0 when it is possible to resume execution of a BASIC program (CTRL+SHIFT+GRPH+KANA/CODE to resume)
| FCAEh   | FLBMEM | 1      | 0 if loading basic program
| FD89h   | PROCNM | 16     | Work aera of the instructions CALL and OPEN. Contents the instruction name or device name
