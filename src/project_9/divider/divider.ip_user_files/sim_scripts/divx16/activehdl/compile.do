vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../divider.srcs/sources_1/bd/divx16/ipshared/4868" "+incdir+../../../../divider.srcs/sources_1/bd/divx16/ipshared/4868" \
"../../../bd/divx16/ip/divx16_clk_wiz_0/divx16_clk_wiz_0_clk_wiz.v" \
"../../../bd/divx16/ip/divx16_clk_wiz_0/divx16_clk_wiz_0.v" \
"../../../bd/divx16/ipshared/ec77/sources_1/new/div.v" \
"../../../bd/divx16/ip/divx16_div_0_3/sim/divx16_div_0_3.v" \
"../../../bd/divx16/sim/divx16.v" \


vlog -work xil_defaultlib \
"glbl.v"

