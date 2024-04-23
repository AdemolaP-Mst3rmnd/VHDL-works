set_global_assignment -entity "kj_clock_generator" -library "lib_kj_clock_generator" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "kj_clock_generator" -library "lib_kj_clock_generator" -name IP_TOOL_VERSION "22.1"
set_global_assignment -entity "kj_clock_generator" -library "lib_kj_clock_generator" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_kj_clock_generator" -name SPD_FILE [file join $::quartus(sip_path) "kj_clock_generator.spd"]

set_global_assignment -library "lib_kj_clock_generator" -name MISC_FILE [file join $::quartus(sip_path) "kj_clock_generator_sim/kj_clock_generator.vho"]
