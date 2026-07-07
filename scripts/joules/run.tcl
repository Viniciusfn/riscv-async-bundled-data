# run.tcl
set_db information_level 7


# ----------------------------------------
# SETUP
# ----------------------------------------

# Defines
source ../scripts/genus/defines.tcl

# Lib
set_db init_lib_search_path $LIB_PATH
set_db library $LIB_LIST

# Workplace
set_db init_hdl_search_path {../rtl/src}

# ----------------------------------------
# READ DESIGN
# ----------------------------------------

read_netlist ../structural/innovus/ariscv_routed.v
read_sdf ../timing/ariscv.sdf
# read_spef ../structural/ariscv.spef

# Constraints
source ../scripts/genus/clocks.tcl
source ../scripts/genus/io_delays.tcl
source ../scripts/genus/timing_exceptions.tcl

check_design -unresolved > ../reports/joules/unresolved_modules.rpt

# ----------------------------------------
# POWER SETUP
# ----------------------------------------

set_db power_method dynamic
set_db power_analysis_mode "time_based"

# Corner de análise
set_db power_corner "typical"

# ----------------------------------------
# ACTIVITY
# ----------------------------------------

# Read VCD
read_activity_file -format vcd ../timing/testbench.vcd \
    -instance $DESIGN -sim_top tb_ariscv_soc_top.dut.uu_core

# ----------------------------------------
# REPORTS
# ----------------------------------------

report_power > reports/power_summary.rpt
report_power -by_hierarchy -levels 3 > reports/power_hier.rpt
report_power -by_leaf > reports/power_leaf.rpt
report_power -format csv > reports/power_summary.csv
