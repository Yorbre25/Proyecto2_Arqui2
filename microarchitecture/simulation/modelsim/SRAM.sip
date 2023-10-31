set_global_assignment -entity "SRAM" -library "lib_SRAM" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "SRAM" -library "lib_SRAM" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "SRAM" -library "lib_SRAM" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_SRAM" -name SPD_FILE [file join $::quartus(sip_path) "../SRAM.spd"]
set_global_assignment -library "lib_SRAM" -name MISC_FILE [file join $::quartus(sip_path) "../../SRAM.qsys"]

set_global_assignment -library "lib_SRAM" -name MISC_FILE [file join $::quartus(sip_path) "SRAM.v"]
set_global_assignment -library "lib_SRAM" -name MISC_FILE [file join $::quartus(sip_path) "submodules/SRAM_sram_0.v"]
