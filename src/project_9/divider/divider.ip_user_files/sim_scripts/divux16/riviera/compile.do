vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../divider.srcs/sources_1/bd/divux16/ipshared/4868" "+incdir+../../../../divider.srcs/sources_1/bd/divux16/ipshared/4868" \
"../../../bd/divux16/ipshared/be3a/sources_1/new/divu.v" \
"../../../bd/divux16/ip/divux16_divu_0_0_2/sim/divux16_divu_0_0.v" \
"../../../bd/divux16/ip/divux16_clk_wiz_0_0/divux16_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/divux16/ip/divux16_clk_wiz_0_0/divux16_clk_wiz_0_0.v" \
"../../../bd/divux16/sim/divux16.v" \


vlog -work xil_defaultlib \
"glbl.v"

