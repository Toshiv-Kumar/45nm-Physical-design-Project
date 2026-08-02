
#### Template Script for RTL->Gate-Level Flow (generated from GENUS 17.10-p007_1) 

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################


set DESIGN dtmf_recvr_core
set GEN_EFF medium
set MAP_OPT_EFF high
set DATE [clock format [clock seconds] -format "%b%d-%T"] 
set _OUTPUTS_PATH outputs_${DATE}
set _REPORTS_PATH reports_${DATE}
set _LOG_PATH logs_${DATE}
##set ET_WORKDIR <ET work directory>
set_db / .init_lib_search_path  {/home/server2/design_kits/cadence_dft/Genus_CUI_RAK/LI
B}
##set_db / .script_search_path {. <path>} 
set_db / .init_hdl_search_path  {/home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RT
L}
##Uncomment and specify machine names to enable super-threading./home/server2/design_ki
ts/cadence_dft/Genus_CUI_RAK/LIB}
##set_db / .super_thread_servers {<machine names>} 
##For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 
to 32 CPUs
##set_db / .max_cpus_per_server 8

##Default undriven/unconnected setting is 'none'.  
##set_db / .hdl_unconnected_input_port_value 0 | 1 | x | none 
##set_db / .hdl_undriven_output_port_value   0 | 1 | x | none

##set_db / .hdl_undriven_signal_value        0 | 1 | x | none 


##set_db / .wireload_mode <value> 
set_db / .information_level 7 

###############################################################
## Library setup
###############################################################


set_db / .library { /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/LIB/slow.lib /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/LIB/pll.lib  /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/LIB/CDK_S128x16.lib  /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/LIB/CDK_S256x16.lib  /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/LIB/CDK_R512x16.lib}
## PLE(Physical layout estimation. All net connection will have 60 degree orientation. Aftet PLE full flow is like a legal placement and spatial:implementation part and how you want to place) We use lef files for physical synthesis. WE are not doing that now
## set_db / .lef_library  { ../LEF/gsclib045_tech.lef ../LEF/gsclib045_macro.lef ../LEF/pll.lef   ../LEF/CDK_S128x16.lef  ../LEF/CDK_S256x16.lef  ../LEF/CDK_R512x16.lef   }
## Provide either cap_table_file or the qrc_tech_file
##set_db / .cap_table_file <file> 
#set_db / .qrc_tech_file <file>

##set_db / .lp_insert_clock_gating true 

####################################################################
## Load Design
####################################################################


read_hdl { /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/pllclk.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/accum_stat.v /home/server2/design_kits/cadence_dft/Genus_C
UI_RAK/RTL/alu_32.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/arb.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/data_bus_mach.v /home/server2/design_kits/cadence_df
t/Genus_CUI_RAK/RTL/data_sample_mux.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/decode_i.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/decoder.v /home/server2/desig
n_kits/cadence_dft/Genus_CUI_RAK/RTL/digit_reg.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/conv_subreg.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/dma.v /home/ser
ver2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/dtmf_recvr_core.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/execute_i.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/m
16x16.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/mult_32_dp.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/port_bus_mach.v /home/server2/design_kits/cadence_dft/Gen
us_CUI_RAK/RTL/prog_bus_mach.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/ram_128x16_test.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/ram_256x16_test.v /home/serve
r2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/results_conv.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/spi.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/tdsp_core_gl
ue.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/tdsp_core_mach.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/tdsp_core.v /home/server2/design_kits/cadence_dft/Genus_
CUI_RAK/RTL/tdsp_data_mux.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/tdsp_ds_cs.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/test_control.v /home/server2/design_k
its/cadence_dft/Genus_CUI_RAK/RTL/ulaw_lin_conv.v /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/RTL/power_manager.v }
elaborate $DESIGN
puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration


check_design
check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

read_sdc /home/server2/design_kits/cadence_dft/Genus_CUI_RAK/constraints/dtmf_recvr_core_gate.sdc
puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"

#set_db "design:$DESIGN" .force_wireload <wireload name> 

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}


if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}


#### To turn off sequential merging on the design 
#### uncomment & use the following attributes.
##set_db / .optimize_merge_flops false 
##set_db / .optimize_merge_latches false 
#### For a particular instance use attribute 'optimize_merge_seqs' to turn off sequential merging. 



####################################################################################################
## Synthesizing to generic 
####################################################################################################

set_db / .syn_generic_effort $GEN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH





####################################################################################################
## Synthesizing to gates
####################################################################################################


set_db / .syn_map_effort $MAP_OPT_EFF
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -directory $_REPORTS_PATH
report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt



write_do_lec -revised_design fv_map -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do

## ungroup -threshold <value>

#######################################################################################################
## Optimize Netlist
#######################################################################################################
## Uncomment to remove assigns & insert tiehilo cells during Incremental synthesis
##set_db / .remove_assigns true 
##set_remove_assign_options -buffer_or_inverter <libcell> -design <design|subdesign> 
##set_db / .use_tiehilo_for_const <none|duplicate|unique> 
set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after 'syn_opt'"
time_info OPT




write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -directory $_REPORTS_PATH
 write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_m.v
 write_script > ${_OUTPUTS_PATH}/${DESIGN}_m.script
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_m.sdc


#################################
### write_do_lec
#################################


#write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do
##Uncomment if the RTL is to be compared with the final netlist..
##write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do


puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

#file copy [get_db / .stdout_log] ${_LOG_PATH}

##quit
