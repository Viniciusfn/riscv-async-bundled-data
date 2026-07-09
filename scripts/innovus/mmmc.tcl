#########################################################
# Multi-Mode Multi-Corner
#########################################################
create_library_set \
    -name slow \
    -timing {/Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/gsclib045/timing/slow_vdd1v0_basicCells.lib}

create_library_set \
    -name fast \
    -timing {/Tools/pdks/gpdk045_v_6_0/gsclib045_all_v4_4/gsclib045/timing/fast_vdd1v0_basicCells.lib}

create_rc_corner \
    -name rc_slow

create_rc_corner \
    -name rc_fast

create_delay_corner \
    -name dc_slow \
    -library_set slow \
    -rc_corner rc_slow

create_delay_corner \
    -name dc_fast \
    -library_set fast \
    -rc_corner rc_fast

create_constraint_mode \
    -name func \
    -sdc_files [list \
        ${SCRIPTS_PATH}/genus/defines.tcl \
        ${SCRIPTS_PATH}/genus/clocks.tcl \
        ${SCRIPTS_PATH}/genus/io_delays.tcl \
        ${SCRIPTS_PATH}/innovus/timing_exceptions.tcl \
    ]

create_analysis_view \
    -name setup \
    -constraint_mode func \
    -delay_corner dc_slow

create_analysis_view \
    -name hold \
    -constraint_mode func \
    -delay_corner dc_fast

set_analysis_view \
    -setup setup \
    -hold hold

setDesignMode -process 45

# To enable OCV
setAnalysisMode -analysisType onChipVariation
