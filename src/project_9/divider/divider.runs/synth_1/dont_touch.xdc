# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: new/divux16_.xdc

# Block Designs: bd/divux16/divux16.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==divux16 || ORIG_REF_NAME==divux16} -quiet] -quiet

# IP: bd/divux16/ip/divux16_divu_0_0_2/divux16_divu_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==divux16_divu_0_0 || ORIG_REF_NAME==divux16_divu_0_0} -quiet] -quiet

# IP: bd/divux16/ip/divux16_clk_wiz_0_0/divux16_clk_wiz_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==divux16_clk_wiz_0_0 || ORIG_REF_NAME==divux16_clk_wiz_0_0} -quiet] -quiet

# XDC: bd/divux16/ip/divux16_divu_0_0_2/constrs_1/new/divux16_.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==divux16_divu_0_0 || ORIG_REF_NAME==divux16_divu_0_0} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: bd/divux16/ip/divux16_clk_wiz_0_0/divux16_clk_wiz_0_0_board.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==divux16_clk_wiz_0_0 || ORIG_REF_NAME==divux16_clk_wiz_0_0} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: bd/divux16/ip/divux16_clk_wiz_0_0/divux16_clk_wiz_0_0.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==divux16_clk_wiz_0_0 || ORIG_REF_NAME==divux16_clk_wiz_0_0} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: bd/divux16/ip/divux16_clk_wiz_0_0/divux16_clk_wiz_0_0_ooc.xdc

# XDC: bd/divux16/divux16_ooc.xdc