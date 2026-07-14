#########################################################
# Pre P&R
#########################################################

set dt_insts [dbGet top.insts.name *_DONT_TOUCH]

foreach inst $dt_insts {
    set_dont_touch $inst true
}

#########################################################
# Floorplan
#########################################################

floorPlan \
    -site CoreSite \
    -su 1.0 0.60 5 5 5 5

createPinGroup INST_IF \
    -pin {i_inst[*] o_pc[*]} \
    -optimizeOrder

createPinGroup DATA_OUT_IF \
    -pin {
        o_writeData[*]
        o_writeAddr[*]
        o_memWrite
        o_writeWidth[*]
        o_mem_clk
    } \
    -optimizeOrder

createPinGroup DATA_IN_IF \
    -pin {i_readData[*]} \
    -optimizeOrder

createPinGroup CLK_RST \
    -pin {clk rst_async_n} \
    -optimizeOrder

assignIoPins \
    -align \
    -autoBusGroup

setPinAssignMode -pinEditInBatch true

editPin \
    -pin {i_inst[*] o_pc[*]} \
    -side TOP \
    -spreadType SIDE \
    -layer 2

editPin \
    -pin {
        i_readData[*]
        o_writeData[*]
        o_writeAddr[*]
        o_memWrite
        o_writeWidth[*]
        o_mem_clk
    } \
    -side RIGHT \
    -spreadType SIDE \
    -layer 2

editPin \
    -pin {clk rst_async_n} \
    -side LEFT \
    -spreadType SIDE \
    -layer 2

setPinAssignMode -pinEditInBatch false

globalNetConnect VDD -type pgpin -pin VDD -all
globalNetConnect VSS -type pgpin -pin VSS -all

#########################################################
# Placement
#########################################################

place_design

#########################################################
# CTS
#########################################################

ccopt_design

#########################################################
# Route
#########################################################

routeDesign

#########################################################
# Post-Route
#########################################################

route_opt_design ;# Requires OCV enabled

#########################################################
# Reports
#########################################################

report_area -out_file "$REPORT_PATH/area.rpt"
report_power -hierarchy all -outfile "$REPORT_PATH/power.rpt"
report_timing -max_paths 50 -path_type full_clock -view "setup" -late -retime path_slew_propagation -analysis_summary_file "${REPORT_PATH}/timing_summary_setup.rpt" > $REPORT_PATH/timing_setup.rpt
report_timing -max_paths 50 -path_type full_clock -view "hold"  -early  -retime path_slew_propagation -analysis_summary_file "${REPORT_PATH}/timing_summary_hold.rpt"  > $REPORT_PATH/timing_hold.rpt
report_constraint -all_violators > $REPORT_PATH/all_viol.rpt
report_clocks > $REPORT_PATH/clocks.rpt
report_clocks -source_insertion -delay_adjustment_table > $REPORT_PATH/clocks_delay_adjustment.rpt
verifyConnectivity > $REPORT_PATH/connectivity.rpt
checkFPlan -outFile "$REPORT_PATH/checkFPlan.rpt"
checkPlace > $REPORT_PATH/checkPlace.rpt
reportRoute > $REPORT_PATH/route.rpt
checkDesign -all -noHtml -outFile "$REPORT_PATH/checkDesign.rpt"

#########################################################
# Results
#########################################################

saveDesign ${DATABASE_PATH}/${DESIGN}.enc       ;# DEF
saveNetlist ${RESULTS_PATH}/${DESIGN}_routed.v  ;# Routed Verilog
write_sdf ${TIMING_PATH}/${DESIGN}_routed.sdf   ;# SDF
rcOut -spef ${RESULTS_PATH}/${DESIGN}.spef      ;# SPEF
#defOut ${RESULTS_PATH}/${DESIGN}.def           ;# Export DEF
#streamOut ${RESULTS_PATH}/${DESIGN}.gds        ;# GDS
