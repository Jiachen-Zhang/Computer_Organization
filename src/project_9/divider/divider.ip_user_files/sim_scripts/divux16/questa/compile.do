vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 "+incdir+../../../../divider.srcs/sources_1/bd/divux16/ipshared/4868" "+incdir+../../../../divider.srcs/sources_1/bd/divux16/ipshared/4868" \
"../../../bd/divux16/ipshared/4809/sources_1/new/divu.v" \
"../../../bd/divux16/ip/divux16_divu_0_0_2/sim/divux16_divu_0_0.v" \
"../../../bd/divux16/ip/divux16_clk_wiz_0_0/divux16_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/divux16/ip/divux16_clk_wiz_0_0/divux16_clk_wiz_0_0.v" \
"../../../bd/divux16/sim/divux16.v" \


vlog -work xil_defaultlib \
"glbl.v"

