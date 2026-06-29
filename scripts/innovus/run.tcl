#########################################################
# Floorplan
#########################################################

floorPlan \
    -site CoreSite \
    -su 1.0 0.60 20 20 20 20

globalNetConnect VDD -type pgpin -pin VDD -all
globalNetConnect VSS -type pgpin -pin VSS -all

#########################################################
# Placement
#########################################################

place_design
suspend
#########################################################
# CTS
#########################################################

ccopt_design

#########################################################
# Route
#########################################################

route_opt_design

#########################################################
# Optimization
#########################################################

optDesign -postRoute

#########################################################
# Reports
#########################################################

report_area         > "$REPORTS_PATH/area.rpt"
report_power        > "$REPORTS_PATH/power.rpt"
report_timing       > "$REPORTS_PATH/timing.rpt"
report_utilization  > "$REPORTS_PATH/utilization.rpt"
report_congestion   > "$REPORTS_PATH/congestion.rpt"

#########################################################
# Results
#########################################################

saveDesign ${RESULTS_PATH}/${DESIGN}.enc        ;# DEF
defOut ${RESULTS_PATH}/${DESIGN}.def            ;# Export DEF
saveNetlist ${RESULTS_PATH}/${DESIGN}_routed.v  ;# Routed Verilog
rcOut -spef ${RESULTS_PATH}/top.spef            ;# SPEF
streamOut ${RESULTS_PATH}/top.gds               ;# GDS
