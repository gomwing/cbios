#!/bin/bash

# Concatenates the C-BIOS ROMs so it can be used on a Sony MSX2+

# Create padding file
dd if=/dev/zero of=16K_zero.tmp bs=1 count=0x4000 >/dev/null 2>&1

#MainROM and SubROM
cat derived/bin/cbios_main_msx2+_jp.rom derived/bin/cbios_sub.rom >derived/bin/sony2+_cbios.rom

#DiskBIOS
#cat derived/bin/cbios_disk.rom >>derived/bin/sony2+_cbios.rom
#cat 16K_zero.tmp >>derived/bin/sony2+_cbios.rom
cat /Applications/Emulators/MSX/systemroms/Sony_HB-F1XDJ_disk.rom >>derived/bin/sony2+_cbios.rom

#Logo in the slot where the Kanji driver originally was
cat 16K_zero.tmp derived/bin/cbios_logo_msx2+.rom >>derived/bin/sony2+_cbios.rom

#MSX-Music
cat derived/bin/cbios_music.rom >>derived/bin/sony2+_cbios.rom

#Last unused block
cat 16K_zero.tmp >>derived/bin/sony2+_cbios.rom

rm 16K_zero.tmp


