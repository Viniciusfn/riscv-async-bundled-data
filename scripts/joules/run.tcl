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
# read_sdf ../timing/ariscv_routed.sdf 
read_spef ../structural/innovus/ariscv.spef

# Constraints
source ../scripts/genus/clocks.tcl
source ../scripts/genus/io_delays.tcl
source ../scripts/genus/timing_exceptions.tcl

# ----------------------------------------
# POWER SETUP
# ----------------------------------------

# set_db lp_dynamic_analysis_scope true

# ----------------------------------------
# ACTIVITY
# ----------------------------------------

# Read VCD
read_stimulus -format vcd wave_trace.vcd \
                -dut_instance tb_ariscv_soc_top.dut.uu_core

compute_power

# ----------------------------------------
# REPORTS
# ----------------------------------------

report_power > ../reports/joules/power_summary.rpt
report_power -by_hierarchy -levels 3 > ../reports/joules/power_hier.rpt
report_power -by_leaf > ../reports/joules/power_leaf.rpt
# report_power -format csv > ../reports/joules/power_summary.csv
