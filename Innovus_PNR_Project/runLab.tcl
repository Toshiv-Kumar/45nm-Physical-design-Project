source /home/vfirstcad56/Toshiv_Kumar/Pnr_Projects/leon.globals
init_design
loadFPlan /home/server2/design_kits/pd/innovus/innovus_designs/BlockImplementation231/RAK_23.10_blockImplementation/DATA/leon.power.fp
win

verifyConnectivity
checkPlace
checkPinAssignment
reportCongestion -overflow

setDesignMode -process 45
setMultiCpuUsage -localCpu 2

setAnalysisMode -analysisType onChipVariation -cppr both

setDontUse *XL true
setDontUse *X1 true
timeDesign -prePlace
setPlaceMode -place_global_place_io_pins true

place_design
reportCongestion -overflow
# fix by opt_design if thereis more than summed 0.01% H+V overflow.
reportCongestion -hotSpot
# Fix the overlaps found in checkPlace either by opt_design or manually shifting std cells by shift+R to vacant spaces found in the design.
checkPlace leon.checkPlace
checkPinAssignment
legalizePin
timeDesign -preCtS
# if there is a negative slack in wns or tns, then run opt design to fix that
place_opt_design

saveDesign placement.enc
report_timing
# time_design givves time analysis of entire design. Whats the diff b/w both?
# if slack is not met(negative), then run diff types of opt_design again and then move to next part. see the cell having high or low delay. Change size by selecting X2,X3 or X4 size.
#

extractRC
rcOut -spef leon.spef -rc_corner rc_worst
# This creates a leon.spef file that lays out rc values of each net in design. We choose rc_corner as the worst case
#

# cts starts now
add_ndr -width {Metal1 0.12 Metal2 0.14 Metal3 0.14 Metal4 0.14 Metal5 0.14 Metal6 0.14 Metal7 0.14 Metal8 0.14 Metal9 0.14 } -spacing {Metal1 0.12 Metal2 0.14 Metal3 0.14 Metal4 0.14 Metal5 0.14 Metal6 0.14 Metal7 0.14 Metal8 0.14 Metal9 0.14 } -name 2w2s
#2s helps crosstalk prevention
#2w helps electromigration
# check lef file in LIBS/ folder, the first lef file. Its specifies vial, metal width, spacing default values. In the above add_ndr, we multiplied by 2 each and every value manually. M1 was 0.6 but now it is .12
#

create_route_type -name clkroute -non_default_rule 2w2s -bottom_preferred_layer Metal5 -top_preferred_layer Metal6
# bottom vs top? We specify the range of layers allowed for clock route.
# The route properties and name is specified. We are creating clock tree.

set_ccopt_property route_type clkroute -net_type trunk
# trunk is the source net driving the clock tree

set_ccopt_property route_type clkroute -net_type leaf 
set_ccopt_property buffer_cells {CLKBUFX8 CLKBUFX12}
set_ccopt_property inverter_cells {CLKINVX8 CLKINVX12}
set_ccopt_property clock_gating_cells TLATNTSCA*
create_ccopt_clock_tree_spec -file ccopt.spec
# the above commands of setting property are saved in the spec file. We source that file into our tool to run it or enable our tool to have their access.

source ccopt.spec

clock_opt_design -cts
# We don't need to -cts, it is required to inform the tool about the current stage
# analyze the log file to understand what happenned in cts. How the nets were modified or designed for efficient clock tree generation. Legalization happens first, optimzation starts after legalized placement of clock nets.
#
saveDesign initial_cts.enc

timeDesign -postCTS
# I want to see the timing it has met with.
#  slack is 0.001 slack +ve setup. Hold is not shown in default give -hold (attach this switch). We are getting a hold -ve slack(AT - RT).
#  We will need to optimize our design to fix -ve slack.


optDesign -postCTS -hold -setup
# this tries to fix both setup and hold violations.
report_ccopt_skew_groups
report_ccopt_clock_tree_structure
report_ccopt_clock_trees
saveDesign postcts_optimized.enc

# Need to set some constraints on the design before routing.
setAnalysisMode -analysisType onChipVariation -cppr both

routeDesign
saveDesign after_route_save_state.enc
verifyConnectivity
verify_antenna
verify_drc
# the above one is not the official drc check performed by PV team. It is basic check, if issue is present, then either we can re route/optDesign the design.
# Or we can manually fix simple issues like metal spacing error, if it is something difficult like short, then we should go back to one of the previous steps.



setExtractRCMode -engine postRoute
setExtractRCMode -effortLevel medium
timeDesign -postRoute
timeDesign -postRoute -hold

optDesign -postRoute -setup -hold
saveDesign DBS/postroute.enc
