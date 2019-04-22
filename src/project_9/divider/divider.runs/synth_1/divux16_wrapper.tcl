# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_msg_config -id {HDL-1065} -limit 10000
create_project -in_memory -part xc7a100tfgg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir F:/Github/Computer_Organization/src/project_9/divider/divider.cache/wt [current_project]
set_property parent.project_path F:/Github/Computer_Organization/src/project_9/divider/divider.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths f:/github/computer_organization/src/project_9/divider/divider.srcs [current_project]
set_property ip_output_repo f:/Github/Computer_Organization/src/project_9/divider/divider.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib F:/Github/Computer_Organization/src/project_9/divider/divider.srcs/sources_1/bd/divux16/hdl/divux16_wrapper.v
add_files F:/Github/Computer_Organization/src/project_9/divider/divider.srcs/sources_1/bd/divux16/divux16.bd
set_property used_in_implementation false [get_files -all f:/Github/Computer_Organization/src/project_9/divider/divider.srcs/sources_1/bd/divux16/ip/divux16_clk_wiz_0_1/divux16_clk_wiz_0_1_board.xdc]
set_property used_in_implementation false [get_files -all f:/Github/Computer_Organization/src/project_9/divider/divider.srcs/sources_1/bd/divux16/ip/divux16_clk_wiz_0_1/divux16_clk_wiz_0_1.xdc]
set_property used_in_implementation false [get_files -all f:/Github/Computer_Organization/src/project_9/divider/divider.srcs/sources_1/bd/divux16/ip/divux16_clk_wiz_0_1/divux16_clk_wiz_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all F:/Github/Computer_Organization/src/project_9/divider/divider.srcs/sources_1/bd/divux16/divux16_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top divux16_wrapper -part xc7a100tfgg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef divux16_wrapper.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file divux16_wrapper_utilization_synth.rpt -pb divux16_wrapper_utilization_synth.pb"
