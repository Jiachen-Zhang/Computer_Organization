# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: new/addsub����8bit.xdc

# Block Designs: bd/addsub8/addsub8.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==addsub8 || ORIG_REF_NAME==addsub8} -quiet] -quiet

# IP: bd/addsub8/ip/addsub8_addsub_0_0/addsub8_addsub_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==addsub8_addsub_0_0 || ORIG_REF_NAME==addsub8_addsub_0_0} -quiet] -quiet

# XDC: bd/addsub8/ip/addsub8_addsub_0_0/constrs_1/new/addsub����8bit.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==addsub8_addsub_0_0 || ORIG_REF_NAME==addsub8_addsub_0_0} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: bd/addsub8/addsub8_ooc.xdc
