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
create_project -in_memory -part xc7a100tfgg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir F:/Github/Computer_Organization/src/project_9/ALU/ALU.cache/wt [current_project]
set_property parent.project_path F:/Github/Computer_Organization/src/project_9/ALU/ALU.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths {
  f:/Github/Computer_Organization/src/IP_Core/CSE_CSE_xorgate_1.0
  f:/Github/Computer_Organization/src/IP_Core/CSE_CSE_orgate_1.0
  f:/Github/Computer_Organization/src/IP_Core/CSE_CSE_notgate_1.0
  f:/Github/Computer_Organization/src/IP_Core/CSE_CSE_addsub_1.0
  f:/Github/Computer_Organization/src/IP_Core/CSE_CSE_andgate_1.0
} [current_project]
set_property ip_output_repo f:/Github/Computer_Organization/src/project_9/ALU/ALU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/addsubx8/hdl/addsubx8_wrapper.v
  F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/andgatex8/hdl/andgatex8_wrapper.v
  F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/notgatex8/hdl/notgatex8_wrapper.v
  F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/orgatex8/hdl/orgatex8_wrapper.v
  F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/xorgatex8/hdl/xorgatex8_wrapper.v
  F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/new/ALUx8.v
}
add_files F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/notgatex8/notgatex8.bd
set_property used_in_implementation false [get_files -all F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/notgatex8/notgatex8_ooc.xdc]

add_files F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/xorgatex8/xorgatex8.bd
set_property used_in_implementation false [get_files -all F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/xorgatex8/xorgatex8_ooc.xdc]

add_files F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/andgatex8/andgatex8.bd
set_property used_in_implementation false [get_files -all F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/andgatex8/andgatex8_ooc.xdc]

add_files F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/orgatex8/orgatex8.bd
set_property used_in_implementation false [get_files -all F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/orgatex8/orgatex8_ooc.xdc]

add_files F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/addsubx8/addsubx8.bd
set_property used_in_implementation false [get_files -all f:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/addsubx8/ip/addsubx8_addsub_0_0/constrs_1/new/addsub����8bit.xdc]
set_property used_in_implementation false [get_files -all F:/Github/Computer_Organization/src/project_9/ALU/ALU.srcs/sources_1/bd/addsubx8/addsubx8_ooc.xdc]

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

synth_design -top ALUx8 -part xc7a100tfgg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef ALUx8.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file ALUx8_utilization_synth.rpt -pb ALUx8_utilization_synth.pb"