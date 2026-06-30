#########################################################
# DEFINITIONS
#########################################################

# PARAMETERS/MACROS -----------------------------
set DESIGN ariscv

set NETLIST_PATH  ../structural
set SCRIPTS_PATH  ../scripts
set REPORT_PATH  ../reports/innovus
set RESULTS_PATH  ../structural/innovus

# LEFS and LIBS ---------------------------------
set LEF_LIST {/Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/gsclib045/lef/gsclib045_tech.lef \
              /Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/gsclib045/lef/gsclib045_macro.lef \
              /Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/gsclib045_hvt/lef/gsclib045_hvt_macro.lef \
              /Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/gsclib045_lvt/lef/gsclib045_lvt_macro.lef \
              /Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/gsclib045/lef/gsclib045_multibitsDFF.lef \
            }

set LIB_PATH {/Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/ }

set LIB_LIST {/Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/gsclib045/timing/slow_vdd1v0_basicCells.lib}

# Other Definitions -----------------------------
setMultiCpuUsage -localCpu 4

#########################################################
# LOAD DESIGN
#########################################################

set init_verilog "${NETLIST_PATH}/${DESIGN}_netlist.v"

set init_lef_file $LEF_LIST

set init_lib_search_path $LIB_PATH

set init_lib_file $LIB_LIST

set init_top_cell $DESIGN

set init_mmmc_file "${SCRIPTS_PATH}/innovus/mmmc.tcl"

set init_pwr_net VDD
set init_gnd_net VSS

init_design

#########################################################
# RUN P&R
#########################################################

source ${SCRIPTS_PATH}/innovus/run.tcl
