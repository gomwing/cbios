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
