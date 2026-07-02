#########################################################
# Multi-Mode Multi-Corner
#########################################################
create_library_set \
    -name typical \
    -timing $LIB_LIST

create_rc_corner \
    -name rc_typ

create_delay_corner \
    -name dc_typ \
    -library_set typical \
    -rc_corner rc_typ

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
    -delay_corner dc_typ

set_analysis_view \
    -setup setup \
    -hold setup

setDesignMode -process 45

# To enable OCV
#setAnalysisMode -analysisType onChipVariation
