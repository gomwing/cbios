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

Data and Variables of Basic
---------------------------

|Address| Name |Length|Description|
|:-----:|:----:|:----:|-----------|
|F6C2h  |VARTAB|2   |Address of the single variables area
|F6C4h  |ARYTAB|2   |Address of the array variables area
|F6C6h  |STREND|2   |Address of the end of the variable area
|F6C8h  |DATPTR|2   |Pointer to next data to read from the instruction DATA. Modified by RESTORE
|F6CAh  |DEFTBL|26  |Declaration table of variables defined by the instructions DEFINT, DEFSTR, DEFSNG and DEFDBL of the Basic for each alphabet letter.  2 = integer, 3 = String, 4 = Simple precision, 8 = Double precision (default)

Displaying
==========

AV Control Port
---------------

|Address| Name |Length|Description|
|:-----:|:----:|:----:|-----------|
FAF7h
AVCSAV
1
Copy of AV control port (#F7) content. (MSX2+\~)

CIRCLE
------
|Address| Name |Length|Description|
|:-----:|:----:|:----:|-----------|
|F3ECh  |MAXUPD |3  |Work area used by the instruction CIRCLE, contains JP 0000h at start
|F3EFh  |MINUPD |3  |Work area used by the instruction CIRCLE, contains JP 0000h at start
|F3F2h  |ATRBYT |1  |Tracing attribute (Plot color for graphic routines)
|F40Bh  |ASPCT1 |2  |256/aspect ratio for Basic instruction CIRCLE
|F40Dh  |ASPCT2 |2  |256\*aspect ratio for Basic instruction CIRCLE
|F931h  |ASPECT |2  |Aspect ratio of the circle; set by <ratio> of CIRCLE
|F933h  |CENCNT |2  |Counter used by CIRCLE
|F935h  |CLINEF |1  |Flag to draw line to centre, Used set by CIRCLE
|F936h  |CNPNTS |2  |Point to be plottted in a 45° segment, Used set by CIRCLE
|F938h  |CPLOTF |1  |Plot polarity flag, Used set by CIRCLE
|F939h  |CPCNT  |2  |Number of points in 1/8 of circle, Used set by CIRCLE
|F93Bh  |CPCNT8 |2  |Number of points in the circle. Used by CIRCLE
|F93Dh  |CRCSUM |2  |Cyclic redundancy check sum of the circle. Used by CIRCLE
|F93Fh  |CSTCNT |2  |Variable to maintain the number of points of the starting angle. Used by the instruction CIRCLE
|F941h  |CSCLXY |1  |Scale of X & Y. Used by the instruction CIRCLE

DRAW
----
|Address| Name |Length|Description|
|:-----:|:----:|:----:|-----------|
|FCBBh  |DRWFLG |1  |Draw flag for the instruction DRAW<pre>Bit 7 = Draw Line 0 = No / 1 = Yes<br>Bit 6 = Move Cursor 0 = Yes / 1 = Yes<br>Bit 5 - 0 Unused</pre>
|FCBCh  |DRWSCL |1  |Current draw scaling parameter for the instruction DRAW
|FCBDh  |DRWANG |1  |Current draw angle parameter for the instruction DRAW<pre>0 = 0° rotation<br>1 = 90° rotation<br>2 = 180° otation<br>
3 = 270° rotation</pre>See also MCLTAB and MCLFLG variables.

PAINT
-----
Instruction PAINT and/or the routine from the BIOS
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F942h  |CSAVEA |2  |Address of the first pixel of different color, Used by PAINT
|F944h  |CSAVEM |1  |Mask of the first pixel of different color, Used by PAINT
|F945h  |CXOFF  |2  |X offset from center, Used by PAINT
|F947h  |CYOFF  |2  |Y offset from center, Used by PAINT
|F949h  |LOHMSK |1  |Leftmost position of an LH excursion, Used by PAINT
|F94Ah  |LOHDIR |1  |New painting direction required by an LH excursion, Used by PAINT
|F94Bh  |LOHADR |2  |Leftmost position of an LH, Used by PAINT
|F94Dh  |LOHCNT |2  |Size of an LH excursion, Used by PAINT
|F94Fh  |SKPCNT |2  |Skip count, Used by PAINT
|F951h  |MOVCNT |2  |Movement count, Used by PAINT
|F953h  |PDIREC |1  |Direction of the paint, Used by PAINT
|F954h  |LFPROG |1  |Set to 1 when moving to the left. Used by PAINT
|F955h  |RTPROG |1  |Set to 1 when moving to the right. Used by PAINT
|FCB2h  |BRDATR |1  |Border color returned by PAINT

Screen Parameters
-----------------
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3E9h  |FORCLR |1  |Foreground colour
|F3EAh  |BAKCLR |1  |Background colour
|F3EBh  |BDRCLR |1  |Border colour
|F3AEh  |LINL40 |1  |Screen width per line in SCREEN 0 (Default 39)
|F3AFh  |LINL32 |1  |Screen width per line in SCREEN 1 (Default 29)
|F3B0h  |LINLEN |1  |Current screen width per line
|F3B1h  |CRTCNT |1  |Number of lines of current screen (default 24)
|F3B2h  |CLMLST |1  |X-location in the case that items are divided by commas in PRINT. (LINLEN-(LINLEN MOD 14)-14)
|F3B3h  |TXTNAM |2  |SCREEN 0 pattern name tabte address
|F3B5h  |TXTCOL |2  |SCREEN 0 color table address
|F3B7h  |TXTCGP |2  |SCREEN 0 Pattern generator table address
|F3B9h  |TXTATR |2  |Unused
|F3BBh  |TXTPAT |2  |Unused
|F3BDh  |T32NAM |2  |SCREEN 1 pattern name table address
|F3BFh  |T32COL |2  |SCREEN 1 color table address
|F3C1h  |T32CGP |2  |SCREEN 1 pattern ganarator table address
|F3C3h  |T32ATR |2  |SCREEN 1 sprite attribute table address
|F3C5h  |T32PAT |2  |SCREEN 1 sprite generator table address
|F3C7h  |GRPNAM |2  |SCREEN 2 pattern name table address
|F3C9h  |GRPCOL |2  |SCREEN 2 color table address
|F3CBh  |GRPCGP |2  |SCREEN 2 pattern generator table address
|F3CDh  |GRPATR |2  |SCREEN 2 sprite attribute table address
|F3CFh  |GRPPAT |2  |SCREEN 2 sprite generator table address
|F3D1h  |MLTNAM |2  |SCREEN 3 pattern name tabte address
|F3D3h  |MLTCOL |2  |SCREEN 3 color table address
|F3D5h  |MLTCGP |2  |SCREEN 3 pattern generator table address
|F3D7h  |MLTATR |2  |SCREEN 3 sprite attribute table address
|F3D9h  |MLTPAT |2  |SCREEN 3 sprite generator table address
|F7C4h  |TRCFLG |1  |Tracing flag. 0 = No tracing; Other = Tracing in progress
|F91Fh  |CGPNT  |2  |Location of the character font used to initialise screen<pre>CGPNT = Slot ID<br>CGPNT+1 = Address</pre>
|F922h  |NAMBAS |2  |Current pattern name table address
|F924h  |CGPBAS |2  |Current pattern generator table address
|F926h  |PATBAS |2  |Current sprite generator table address
|F928h  |ATRBAS |2  |Current sprite attribute table address
|F92Ah  |CLOC   |2  |Graphic cursor location
|F92Ch  |CMASK  |1  |Graphic cursor mask (SCREEN 2 to 4) or ordinate (SCREEN 5 to 12)
|FAF5h  |DPPAGE |1  |Displayed page number. (MSX2\~)  <br>Modified by SETPAGE X
|FAF6h  |ACPAGE |1  |Destination page number. (MSX2\~)  <br>Modified by SETPAGE ,X
|FAFCh  |MODE   |1  |Flag for screen mode
                        bit 7: 1 = conversion to Katakana; 0 = conversion to Hiragana. (MSX2+\~)
                        bit 6: 1 if Kanji ROM level 2. (MSX2+\~)
                        bit 5: 0 = SCREEN10, 1=SCREEN11. Selects when drawing functions will 
                                draw using RGB (SCREEN10) or YJK (SCREEN11) (MSX2+\~)
                        bit 4: 1 to disable the limit of the Y coordinate to 191 on SCREEN 2 & 4 
                                and to 211 on SCREEN 5/higher. (MSX2+\~). 
                                Note: GRPPRT has a bug when printing text beyond line 211. 
                                It will set bogus blitter coordinates.
                        bit 3: 1 to limit VRAM access to 16KB on SCREEN 0\~3
                        bits 1-2: VRAM size
                            00 for 16kB
                            01 for 64kB
                            10 for 128kB
                            11 for 192kB
                        bit 0: 1 if the conversion of Romaji to Kana is possible. (MSX2\~)
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FC18h  |LINWRK |40 |Work area for screen management
|FC40h  |PATWRK |8  |Returned character pattern by the routine GETPAT
|FCA6h  |GRPHED |1  |Heading for the output of graphic characters
|FCAFh  |SCRMOD |1  |Screen mode
|FCB0h  |OLDSCR |1  |Old screen mode
|FAFDh  |NORUSE |1  |Used by KANJI-ROM for rendering KANJI fonts in graphic modes. (MSX2\~)
                        bit 7 Don't return to textmode
                        bit 6 if 1 and F7F4h (DECCNT)=0, read SHIFT status ???
                        bit 5 Disable some functinality
                        bit 4 Not in use	
                        bit 3 color 0 = Transparent
                        bit 0-2: Logical operation on kanji font draw
                            0 for PSET
                            1 for AND
                            2 for OR
                            3 for XOR
                            4 for NOT
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FB02h  |LOGOPR |1  |Logical operation code. (MSX2\~)
|FCB3h  |GXPOS  |2  |X-position of graphic cursor
|FCB5h  |GYPOS  |2  |Y-position of graphic cursor
|FCB7h  |GRPACX |2  |X Graphics Accumulator
|FCB9h  |GRPACY |2  |Y Graphics Accumulator

VDP Registers
-------------
Area to save the last writting value in vdp registers
### MSX1 and newer

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3DFh  |RG0SAV |1  |R#00, Used by VDP(0)
|F3E0h  |RG1SAV |1  |R#01, Used by VDP(1)
|F3E1h  |RG2SAV |1  |R#02, Used by VDP(2)
|F3E2h  |RG3SAV |1  |R#03, Used by VDP(3)
|F3E3h  |RG4SAV |1  |R#04, Used by VDP(4)
|F3E4h  |RG5SAV |1  |R#05, Used by VDP(5)
|F3E5h  |RG6SAV |1  |R#06, Used by VDP(6)
|F3E6h  |RG7SAV |1  |R#07.at start, Used by VDP(7)
|F3E7h  |STATFL |   |status register R#00, Used by VDP(0)

### MSX2 and newer
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FFE7h  |RG08SAV|1  |R#08 here, Used by VDP(9). (MSX2\~)
|FFE8h  |RG09SAV|1  |R#09 here, Used by VDP(10). (MSX2\~)
|FFE9h  |RG10SAV|1  |R#10 here, Used by VDP(11). (MSX2\~)
|FFEAh  |RG11SAV|1  |R#11 here, Used by VDP(12). (MSX2\~)
|FFEBh  |RG12SAV|1  |R#12 here, Used by VDP(13). (MSX2\~)
|FFECh  |RG13SAV|1  |R#13 here, Used by VDP(14). (MSX2\~)
|FFEDh  |RG14SAV|1  |R#14 here, Used by VDP(15). (MSX2\~)
|FFEEh  |RG15SAV|1  |R#15 here, Used by VDP(16). (MSX2\~)
|FFEFh  |RG16SAV|1  |R#16 here, Used by VDP(17). (MSX2\~)
|FFF0h  |RG17SAV|1  |R#17 here, Used by VDP(18). (MSX2\~)
|FFF1h  |RG18SAV|1  |R#18 here, Used by VDP(19). (MSX2\~)
|FFF2h  |RG19SAV|1  |R#19 here, Used by VDP(20). (MSX2\~)
|FFF3h  |RG20SAV|1  |R#20 here, Used by VDP(21). (MSX2\~)
|FFF4h  |RG21SAV|1  |R#21 here, Used by VDP(22). (MSX2\~)
|FFF5h  |RG22SAV|1  |R#22 here, Used by VDP(23). (MSX2\~)
|FFF6h  |RG23SAV|1  |R#23 here, Used by VDP(24). (MSX2\~)
|FFF7h  |MINROM |1  |Slot address of Main-ROM. Use EXPTBL+0 to know [slot ID](/wiki/Slot_ID "Slot ID") of the internal Main-ROM. (MSX2\~)

### MSX2+ and newer
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FFFAh  |RG25SAV|1  |R#25 here, Used by VDP(26). (MSX2+\~)
|FFFBh  |RG26SAV|1  |R#26 here, Used by VDP(27). (MSX2+\~)
|FFFCh  |RG27SAV|1  |R#27 here, Used by VDP(28). (MSX2+\~)

Interruptions
=============
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FC4Ch  |TRPTBL |78 |Tables for each of the following instructions:<pre>TRPTBL (3×10 bytes) => ON KEY GOSUB<br>TRPTBL+30 (3×1 byte) => ON STOP GOSUB<br>TRPTBL+33 (3×1 byte) => ON SPRITE GOSUB<br>TRPTBL+48 (3×5 bytes) => ON GOSUB STRIG<br>TRPTBL+51 (3×1 byte) => ON INTERVAL GOSUB<br>TRPTBL+54 => Reserved</pre>The first octet serves as an flag. 0 = OFF, 1 = ON, 2 = STOP, 3 = Call in progress, 7 = Call waiting. The other 2 bytes contain the address of the line number of the routine to be called by the GOSUB in the Basic program
|FC9Ah  |RTYCNT |1  |Interrupt control
|FC9Bh  |INTFLG |1  |This flag is set if STOP or CTRL+STOP is pressed<pre>0 = Not Pressed<br>3 = CTRL +STOP Pressed<br>4 = STOP Pressed</pre>
|FC9Ch  |PADY   |1  |Y-coordinate of a connected touch pad. (Until MSX2+)
|FC9Dh  |PADX   |1  |X-coordinate of a connected touch pad. (Until MSX2+)
|FC9Eh  |JIFFY  |2  |Contains value of the software clock, each interrupt of the VDP it is increased by 1<br>The contents can be read or changed by the function 'TIME' or instruction 'TIME'
|FCA0h  |INTVAL |2  |Contains length of the interval when the ON INTERVAL routine was established
|FCA2h  |INTCNT |2  |ON INTERVAL counter (counts backwards)
|FCA7h  |ESCCNT |1  |Escape sequence counter

Keyboard and Triggers
=====================

Cursor Parameters
-----------------
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3DCh  |CSRY   |1  |Y-coordinate of text cursor
|F3DDh  |CSRX   |1  |X-coordinate of text cursor
|FBCCh  |CODSAV |1  |ASCII code of character under the cursor
|FCA8h  |INSFLG |1  |Insert mode flag
|FCA9h  |CSRSW  |1  |Cursor display switch<br>Cursor style i.e. Used if INS Key is used. ( 0 = Full Cursor / other = Halve Cursor )

Function keys
-------------
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3DEh  |CNSDFG |1  |Flag to know if the function keys are displayed (255) or not (0)
|F87Fh  |FNKSTR |160|Texts for function keys
|FAF9h  |CHRCNT |1  |Character counter in the buffer, used in KANA-ROM. (MSX2\~)
|FAFAh  |ROMA   |2  |Area to store KANA character (Japanese MSX2\~ only)
|FBCDh  |FNKSWI |1  |Indicate which function keys is displayed
|FBCEh  |FNKFLG |10 |Function key which have subroutine

Keys and Triggers
-----------------
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3DBh  |CLIKSW |1  |Key click switch. (0 = Disabled / 1 = Enabled)
|F3E8h  |TRGFLG |1  |Stores trigger button status of joystick
    Byte Format:
    7 6 5 4 3 2 1 0
    | | | |       +- Space bar on the keyboard (0 when pressed)
    | | | +-------- Trigger 1 on the joystick 1 (0 when pressed)
    | | +--------- Trigger 2 on the joystick 1 (0 when pressed)
    | +---------- Trigger 1 on the joystick 2 (0 when pressed)
    +----------- Trigger 2 on the joystick 2 (0 when pressed)

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3F6h  |SCNCNT |1  |Interval for the key scan. Permanently set by the Basic
|F3F7h  |REPCNT |1  |Delay until the auto-repeat of the key begins. (50 by default)
|F3F8h  |PUTPNT |2  |Address of first free byte in the Keyboard Buffer. (FBF0h by default)
|F3FAh  |GETPNT |2  |Address of the next data from the keyboard (in the Keyboard Buffer)
|FBB1h  |BASROM |1  |<>0 if basic is in rom. (CTRL+STOP disabled)
|FBB2h  |LINTTB |24 |Table of 24 end-of-line flags for each physical line. (used by the Basic interpreter.)<pre>0 = The corresponding line contains a program line that continues on the next physical line,<br>Other value = The corresponding line contains a program line that ends here</pre>
|FBCAh  |FSTPOS |2  |First position for inlin
|FBD8h  |ONGSBF |1  |Global event flag
|FBD9h  |CLIKFL |1  |Flag to know if the key click has already occurred
|FBDAh  |OLDKEY |11 |Previous status of each keyboard matrix row
|FBE5h  |NEWKEY |11 |New status of each keyboard matrix row. The status is updated by the KEYINT interrupt routine
    Bit correspondence for a European Keyboard Layout:
    NEWKEY+0  = 7      6      5      4      3      2      1      0
    NEWKEY+1  = ;      ]      [      \      =      -      9      8
    NEWKEY+2  = B      A    ACCENT   /      .      ,      \`      '
    NEWKEY+3  = J      I      H      G      F      E      D      C
    NEWKEY+4  = R      Q      P      O      N      M      L      K
    NEWKEY+5  = Z      Y      X      W      V      U      T      S
    NEWKEY+6  = F3     F2     F1    CODE   CAPS   GRPH   CTRL  SHIFT
    NEWKEY+7  = RET    SEL    BS    STOP   TAB    ESC    F5     F4
    NEWKEY+8  = RIGHT  DOWN   UP    LEFT   DEL    INS    HOME  SPACE
    NEWKEY+9  = 4      3      2      1      0      /      +      \*
    NEWKEY+10 = .      ,      -      9      8      7      6      5

See [here](/wiki/Keyboard "Keyboard") for other keyboard layouts

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FBF0h  |KEYBUF |40 |Key code buffer
|FCABh  |CAPST  |1  |Capital status. ( 0 = Off / other = On )
|FCACh  |KANAST |1  |Kana mode flags for MSX Japanese, Russian key status ou "Dead Key" status<pre>0 = No Dead Keys<br>1 = Dead Key > Accent Grave<br>2 = SHIFT + Dead Key > Accent Egu<br>3 = CODE + Dead Key > Accent Circumflex<br>4 = SHIFT + CODE + Dead Key > Trema</pre>
|FCADh  |KANAMD |1  |Flag to know if the keyboard type is "KANA" (0) or "JIS" (other value). (Japanese MSX only)

Math-Pack
=========
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F663h  |VALTYP |1  |Contains the code of the type of variable that is currently in DAC<pre>2 = Integer<br>3 = String<br>4 = Single precision<br>8 = Double precision</pre>
|F7C5h  |FBUFFR |43 |Buffer used by mathematical routines
|F7F0h  |DECTMP |2  |Used to transform decimal integer to floating point number
|F7F2h  |DECTM2 |2  |Used by the divisions
|F7F4h  |DECCNT |2  |Used by the divisions
|F7F6h  |DAC    |16 |Decimal accumulator
|F806h  |HOLD8  |48 |Work area for decimal multiplications
|F836h  |HOLD2  |8  |Work area in the execution of numerical operators
|F83Eh  |HOLD   |8  |Work area in the execution of numerical operators
|F847h  |ARG    |16 |Argument. (Value used to be calculate with DAC.)
|F857h  |RNDX   |8  |Last random number generated

Memory
======
Subroutines For Inter-Slot Read/Write/Call
------------------------------------------
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F380h  |RDPRIM |5  |RDSLT (Main-ROM) subroutine which is used to read a byte from memory at the address indicated by HL in the primary Slot specified by register A, then replaces the slots to the state at the time of the call. The byte read is returned to the E register.<br>The D register must contain the current state of the primary Slots to call this routine as well as the A register, except the 2 bits of the Slot to be selected on the range in which the memory byte must be read.
|F385h  |WRPRIM |7  |WRSLT (Main-ROM) subroutine which is used to write a byte in memory at the address indicated by HL in the primary Slot specified by register A, then replaces the slots to the state at the time of the call.<br>The byte to be written must be specified in the E register and the A and D registers must contain the current state of the primary Slots to call this routine, except the 2 bits of the Slot to be selected on the range in which the byte must be written for register A.
|F38Ch  |CLPRIM |14 |CALSLT (Main-ROM) subroutine which is used to call a routine in the primary Slot specified by register A at the address indicated by HL, then replaces the Slot in the state at the time of the call to CLPRIM.<br>As input, register A must contain the current state of the primary Slots except the 2 bits of the Slot to be selected on the range in which the routine to be called is located. The A' register must contain the value of the A register that the routine to be called would need. The byte on top of the stack should contain the was of the current Primary Slots.

Slots and Memory Map
--------------------
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F672h  |MEMSIZ |2  |Highest location in memory used by Basic
|F674h  |STKTOP |2  |Top location to be used for the stack
|FAF8h  |EXBRSA |1  |SUB-ROM [Slot ID](/wiki/Slot_ID "Slot ID"). (MSX2\~)
|FC48h  |BOTTOM |2  |Address of the beginning of the available RAM area
|FC4Ah  |HIMEM  |2  |Address of the end of the available RAM area
|FCC1h  |EXPTBL |4  |Bit 7 of these variables is a flag for each primary slot to indicate if the slot is expanded or not. The other bits are reset. The first variable (also called MNROM) indicates the slot ID of the Main-ROM. This implies that the Main-ROM of an MSX is always in primary slot 0, or secondary slot 0-0<pre>EXPTBL+0 = Flag for slot 0 (also Slot ID of the Main-ROM!)<br>EXPTBL+1 = Flag for slot 1<br>EXPTBL+2 = Flag for slot 2<br>EXPTBL+3 = Flag for slot 3<br>Note: MSX2 upgrade MA-20 for MSX1 moves the Main-ROM to another Slot. It changes the first variable to 0FCC1h (also called MNROM) to indicate the new Slot of the Main-ROM in F000SSPP format. This has the effect that it is no longer possible to determine whether the slot 0 is extended or not. The variable MINROM (0FFF7h) should be able to solve this problem but the extension also modifies MINROM</pre>
|FCC5h  |SLTTBL |4  |Saves the state of the 4 secondary slot registers of each extended Primary Slot<pre>SLTTBL+0 = Value for slot 0<br>SLTTBL+1 = Value for slot 1<br>SLTTBL+2 = Value for slot 2<br>SLTTBL+3 = Value for slot 3<br> Format:<br>  Bits 1-0 = Extended slot on page 0000h\~3FFFh<br>  Bits 3-2 = Extended slot on page 4000h\~7FFFh<br>  Bits 5-4 = Extended slot on page 8000h\~BFFFh<br>  Bits 7-6 = Extended slot on page C000h\~FFFFh</pre>
|FCC9h  |SLTATR |64 |Slot attributes given during MSX boot process<pre>Bit 7 = 1 if Basic program, else 0<br>Bit 6 = 1 if device extension, else 0<br>Bit 5 = 1 if statement extension, else 0<br>Bits 4\~0 = Unused</pre>
|FD09h  |SLTWRK |128|SLTWRK is a 128-byte variable array used to reserve a RAM work area in Main-RAM for ROM applications. This array consists of 8 bytes per slot (2 per memory page). Each of these 2 octets are provided to place an slot ID with flags on a byte (MSB) or an address on two bytes as follows<pre>SLTWRK+0 = Work area for slot 0-0, page 0000h\~3FFFh<br>SLTWRK+2 = Work area for slot 0-0, page 4000h\~7FFFh<br>SLTWRK+4 = Work area for slot 0-0, page 8000h\~BFFFh<br>SLTWRK+6 = Work area for slot 0-0, page C000h\~FFFFh<br>SLTWRK+8 = Work area for slot 0-1, page 0000h\~3FFFh<br>.<br>.<br>SLTWRK+124 = Work area for slot 3-3, page 8000h\~BFFFh<br>SLTWRK+126 = Work area for slot 3-3, page C000h\~FFFFh</pre>The pointer is used to reserve a work area from 8000h or higher to F37Fh.  The slot ID is used to reserve a work area on the pages 0000h\~3FFFh & 4000h\~7FFFh).  Slot ID format used in table SLTWRK:  LSB = F RMD APP RES SS1 SS0 PS1 PS0  <br>MSB = 00h  

    *   PS = Primary slot number
    *   SS = Secondary slot number
    *   RES = Reserved
    *   APP = Set if the RAM used by an application, 0 otherwise
    *   RMD = Set if the RAM is used by instruction CALL MEMINI, 0 otherwise
    *   F = Set if secondary slot, 0 if primary slot

FFFFh
SLTSL
1
Access address to selection register of secondary slots. (Available in extended slots only.)

Format:
 Bits 1-0 = Extended slot on page 0 (0000h\~3FFFh)
 Bits 3-2 = Extended slot on page 1 (4000h\~7FFFh)
 Bits 5-4 = Extended slot on page 2 (8000h\~BFFFh)
 Bits 7-6 = Extended slot on page 3 (C000h\~FFFFh)

Note: Read value has the INVERTED bits of previous written value

Mouse/Trackball/Lightpen
========================
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FAFEh  |XSAVE  |2  |X-coordinate for Mouse/Trackball/Lightpen. (MSX2\~)<pre>XSAVE = X-coordinate<br>XSAVE+1 = P0000000 (bit 7 indicates a request to interrupt the optical pen)</pre>
|FB00h  |YSAVE  |2  |Y-coordinate for Mouse/Trackball/Lightpen. (MSX2\~)<pre>YSAVE = X-coordinate<br>YSAVE+1 = \*0000000 (bit 7 unused)</pre>

PLAY
====
|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3F5h  |FRCNEW |1  |Work area size for PLAY (255 by default)
|FB35h  |PRSCNT |1  |Parse counter<pre>Bits 0-1 = String parse<br>Bit 7 = Pass if set</pre>
|FB36h  |SAVSP  |2  |Stack pointer when instruction PLAY is used
|FB38h  |VOICEN |1  |Number of voice played
|FB39h  |SAVVOL |2  |The volume is saved here when Pause
|FB3Bh  |MCLLEN |1  |Length of the macro being analyzed
|FB3Ch  |MCLPTR |2  |Address of the macro being analyzed
|FB3Fh  |MUSICF |1  |Music interruption flags
|FB40h  |PLYCNT |1  |Number of macro strings in the PLAY queue
|FB41h  |VCBA   |37 |Data for voice A<pre>VCBA	= Duration counter<br>VCBA+2	= String length<br>VCBA+3	= String address<br>VCBA+5	= Stack data address<br>VCBA+7	= Music packet length<br>VCBA+8	= Music packet<br>VCBA+9	= Octave<br>VCBA+10	= Length<br>VCBA+11	= Tempo<br>VCBA+12	= Volume<br>VCBA+13	= Envelope period<br>VCBA+15	= Space for stack data</pre>
|FB66h  |VCBB   |37 |Data for voice B
|FB8Bh  |VCBC   |37 |Data for voice C<br>See also the [Queues](/wiki/System_variables_and_work_area#Queues "System variables and work area") paragraph.

Printer
=======

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F415h  |LPTPOS |1  |Position of printer head
|F416h  |PRTFLG |1  |Flag whether to send to printer. (0 = Print to screen / other = Print to printer)
|F417h  |NTMSXP |1  |0 If MSX printer (This converts Hiragana to Katakana on Japanese MSX)
|F418h  |RAWPRT |1  |0 to convert TAB's and unknown characters to spaces.  Other value to print in 'RAW MODE'

MML Queues
==========

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3F3h  |QUEUES |2  |QUETAB table address (F959h by default), used by PLAY
|F959h  |QUETAB |24 |Queue tables (VOICAQ, VOICBQ, VOICCQ and RS2IQ (RS-232C))
    QUETAB:
    ;Voice A queue
        db 0		;Starting position
        db 0		;Position flag
        db 0		;Replacement flag
        db 7Fh		;size
        dw VOICAQ	;Address
    ;Voice C queue
        db 0		;Starting position
        db 0		;Position flag
        db 0		;Replacement flag
        db 7Fh		;size
        dw VOICBQ	;Address
    ;Voice C queue
        db 0		;Starting position
        db 0		;Position flag
        db 0		;Replacement flag
        db 7Fh		;size
        dw VOICCQ	;Address
    ;RS-232C queue (MSX1 only)
        db 0		;Starting position
        db 0		;Position flag
        db 0		;Replacement flag
        db 0		;size
        dw RS2IQ	;address (0000h by default)

The three music control tables are initialized by the GICINI routine (00090h) and then managed by the interrupt routine and the PUTQ routine (000F9h)

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F971h  |QUEBAK |4  |Replacement characters table of queues<pre>QUEBAK:<br>	db 0	; Replacement characters (voice A)<br>	db 0	; Replacement characters (voice B)<br>	db 0	; Replacement characters (voice C)<br>	db 0	; Replacement characters (RS-232C) (MSX1 only)</pre>
|F975h  |VOICAQ |128|Voice A queue of instruction PLAY. (PSG)  If MSX-Music is present area #F9C0-#F9F8 is used to store copy of YM2413 registers
|F9F5h  |VOICBQ |128|Voice B queue of instruction PLAY. (PSG)
|FA75h  |VOICCQ |128|Voice C queue of instruction PLAY. (PSG)
|FAF5h  |RS2IQ  |64 |RS-232C queue. (MSX1 only)
|FB3Eh  |QUEUEN |1  |Number of the current queue

RS-232C
=======
Data Area Used By RS-232C

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FB03h  |RSTMP  |1  |Temporary data storage for RS232 Driver
|FB03h  |TOCNT  |1  |Counter used by the RS-232C interface
|FB04h  |RSFCB  |2  |FCB ("File Control Block") address of the RS-232C
|FB06h  |RSIQLN |1  |Byte DATA used by the RS-232C interface
|FB07h  |MEXBIh |5  |Hook called by the RS-232C<pre>MEXBIh = RST 30h (0F7h)<br>MEXBIh+1 = Slot ID<br>MEXBIh+2 = Address<br>MEXBIh+4 = RET (0C9h)</pre>
|FB0Ch  |OLDSTT |5  |Hook called by the RS-232C<pre>OLDSTT = RST 30h (0F7h)<br>OLDSTT+1 = Slot ID<br>OLDSTT+2 = Address<br>OLDSTT+4 = RET (0C9h)</pre>
|FB0Ch  |OLDINT |5  |Hook called by the RS-232C<pre>OLDINT = RST 30h (0F7h)<br>OLDINT+1 = Slot ID<br>OLDINT+2 = Address<br>OLDINT+4 = RET (0C9h)</pre>
|FB16h  |DEVNUM |1  |Byte offset. (RS-232C)
|FB17h  |DATCNT |3  |DATA area. (RS-232C)<pre>DATCNT = Slot ID<br>DATCNT+1 = Address</pre>
|FB1Ah  |ERRORS |1  |RS-232C error code
|FB1Bh  |FLAGS  |1  |RS-232C flags
|FB1Ch  |ESTBLS |1  |Bit boolean. (RS-232C)
|FB1Dh  |COMMSK |1  |RS-232C mask
|FB1Eh  |LSTCOM |1  |Byte Data. (RS-232C)
|FB1Fh  |LSTMOD |1  |Byte Data. (RS-232C)

Storage
=======

Cassette Tape
-------------

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F3FCh  |CS120  |5  |Work area of the data recorder. (Until MSX2+)<pre>CS120+0 = LOW signal length of bit 0. (53h by default)<br>CS120+1 = HIGH signal length of bit 0. (5Ch by default)<br>CS120+2 = Length of LOW signal of bit 1. (26h by default)<br>CS120+3 = Length of HIGH signal of bit 1. (2Dh by default)<br>CS120+4 = Length of the header signal calculated by HEADLEN \* 2/256(HEADLEN = 2000)</pre>
|F401h  |CS240  |5  |Work area of the data recorder. (Until MSX2+)<pre>CS240+0 = LOW signal length of bit 0. (25h by default)<br>CS240+1 = HIGH signal length of bit 0. (2Dh by default)<br>CS240+2 = Length of LOW signal of bit 1. (0Eh by default)<br>CS240+3 = Length of HIGH signal of bit 1. (16h by default)<br>CS240+4 = Length of the header signal calculated by HEADLEN \* 2/256(HEADLEN = 2000)</pre>
|F406h  |LOW    |2  |Settings for the tape player. (Until MSX2+)<pre>LOW+0 = LOW signal length which represents bit 0 at the current transmission rate. (53h by default)<br>LOW+1 = HIGH signal length that represents bit 0 at the current transmission rate.(5Ch by default)
</pre>
|F408h  |HIGH   |2  |Settings for the tape player. (Until MSX2+)<pre>HIGH+0 = Length of the LOW signal that represents bit 1 at the current transmission rate. (26h by default)<br>HIGH+1 = Length of the HIGH signal that represents bit 1 at the current transmission rate. (2Dh by default)</pre>
|F40Ah  |HEADER |1  |Settings for the tape player. (Until MSX2+) Length of the current header signal calculated by HEADLEN \* 2/256 or HEADLEN \* 4/256 (HEADLEN = 2000)
|FCA4h  |LOWLIM |1  |Used by the Cassette system (minimal length of startbit)
|FCA5h  |WINWID |1  |Used by the Cassette system (store the difference between a low-and high-cycle)
|FCB1h  |CASPRV |1  |Work area for the cassette (until MSX2+) On MSX turbo R, the system saves the contents of port A7h each time it is written.<pre>*   bit 0 is set when the Pause LED is on;<br>*   bit 1 is set when Z80 is active CPU.<br>*   bit 7 is set when the R800 mode LED is on.</pre>

Disks
-----
This area is not used on system without disk, Data Area used By Disk-Basic / MSX-DOS:

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F348h  |MASTERS|1  |Slot number of the master disk controller
|FB20h  |HOKVLD |1  |Bit 0 of this byte indicates the presence of an extended Bios.<br>0 = No Bios, 1 = There is at least one Bios that can be called at the address 0FFCAh (EXTBIO)
|FB21h  |DRVTBL |8  |[Slot ID](/wiki/Slot_ID "Slot ID") and number of drives connected to disk interfaces, a value of zero for the number of drives marks the end of the table<pre>DRVTBL+0 = Number of drives connected to disk interface 1<br>DRVTBL+1 = Slot ID of disk interface 1<br>DRVTBL+2 = Number of drives connected to disk interface 2<br>DRVTBL+3 = Slot ID of disk interface 2<br>DRVTBL+4 = Number of drives connected to disk interface 3<br>DRVTBL+5 = Slot ID of disk interface 3<br>DRVTBL+6 = Number of drives connected to disk interface 4<br>DRVTBL+7 = Slot ID of disk interface 4</pre>
|FB29h  |HOKSAV |12 |[Slot ID](/wiki/Slot_ID "Slot ID") and address of the timer interrupt handler for each disk interface, each entry corresponds to the equivalent entry in DRVTBL<pre>HOKSAV+0 = Slot ID of previous/current interrupt handler of interface 1<br>HOKSAV+1 = Address of previous/current interrupt handler of interface 1<br>HOKSAV+3 = Slot ID of previous/current interrupt handler of interface 2<br>HOKSAV+4 = Address of previous/current interrupt handler of interface 2<br>HOKSAV+6 = Slot ID of previous/current interrupt handler of interface 3<br>HOKSAV+7 = Address of previous/current interrupt handler of interface 3<br>HOKSAV+9 = Slot ID of previous/current interrupt handler of interface 4<br>HOKSAV+10 = Address of previous/current interrupt handler of interface 4</pre>
|FD99h  |DEVICE |1  |This byte increases to 255 when SHIFT key was pressed at startup to prevent the installation of disks. Otherwise, this byte remains reseted. (Disk-Basic)

**Note about how HOKSAV is filled an used**

The values of the HOKSAV table have different meanings in MSX-DOS 1 and MSX-DOS 2.

**In MSX-DOS 1** disk drivers that have a timer interrupt service routine invoke a routine named SETINT provided by the MSX-DOS kernel they are attached to, this routine fills the HOKSAV entry corresponding to the driver with the slot number and address that are held in H.TIMI (which is assumed to contain a RST 30h instruction), then sets H.TIMI with the address of the interrupt routine of the driver itself (this address is passed to SETINT).

Thus each entry in HOKSAV holds the slot number and address of the **previous** timer interrupt handler for each driver (the value that was in H.TIMI when the driver invoked SETINT). At the end of the boot procedure H.TIMI is pointing to the interrupt routine of the last disk driver that has been set up.

When the interrupt handler of the driver finishes doing its work it invokes a routine named PRVINT provided as well by the MSX-DOS kernel they are attached to, which executes the previous interrupt routine as defined by slot ID + address in the appropriate HOKSAV entry. This causes all the interrupt routines to be executed in succession, starting with the one for the last disk driver.

**In MSX-DOS 2** things are a little bit different. The SETINT and PRVINT routines are still available for the disk drivers, but the former will fill the corresponding HOKSAV entry with the slot ID and address of the interrupt routine for the driver that makes the call (instead of the current value of H.TIMI), and the later does nothing (but is still provided for compatibility).

Thus this time each entry in HOKSAV holds the slot number and address of the **current** timer interrupt handler for each driver (the slot ID of the driver and the address that was passed to SETINT).

In the case of MSX-DOS 2 H.TIMI ends up pointing to an internal routine in the DOS kernel code itself. This routine does some internal processing, then scans the HOKSAV table and "manually" invokes the interrupt routine for each entry, then jumps to the previous value of H.TIMI (the value that the hook had before the master disk controller was initialized).

This is not the end of the story, though. Since disk drivers invoke SETINT and PRVINT _in their own kernels_ (not in the master controller), HOKSAV will end up having a mix of DOS 1 style entries ("previous hook") and DOS 2 entries ("current hook"). For this reason, what MSX-DOS 2 actually does when processing HOKSAV is to check the slot number in each entry against the slot number of the corresponding entry in DRVTBL, and only when both match is the interrupt routine invoked (if slot numbers are different it's a "previous hook" entry set by a driver on a DOS 1 kernel). The "previous hook" entries end up being invoked as well when the master DOS 2 kernel jumps to the previous value of H.TIMI.

A last note: SETINT and PRVINT are provided as external symbols and resolved when the DOS kernel and the disk driver are linked to compose a full disk ROM, therefore they don't have a fixed address.

Files Management
----------------

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|F85Fh  |MAXFIL |1  |High legal file number
|F860h  |FILTAB |2  |Starting address of of file data area
|F862h  |NULBUF |2  |Points to file 0 buffer ( used in SAVE & LOAD st.)
|F864h  |PTRFIL |2  |Points to file data of currently accessing file
|FCBEh  |RUNBNF |1  |Flag for the BLOAD instruction. Set to 52 when a binary file has been executed. Set to 53 while loading VRAM data
|F866h  |RUNFLG |1  |Non-zero when Basic program run after load
|F866h  |FILNAM |11 |File name from Disk-Basic instruction used
|F871h  |FILNM2 |11 |Second file name from Disk-Basic instruction used. (NAME, COPY, MOVE, etc)
|F87Ch  |NLONLY |1  |When loading program. (0 = NON Basic / other = Basic)
|F87Dh  |SAVEND |2  |End address specified in BSAVE
|FCBFh  |SAVENT |1  |Start address for BSAVE / BLOAD operations

Reserved areas
--------------

|Address| Name  |Length|Description|
|:-----:|:-----:|:-----:|----------|
|FFF8h  |       |2      |Reserved
|FFFDh  |       |2      |Reserved
