# ----------------------------------------
# Timing Exception
# ----------------------------------------

set_false_path -from [get_ports rst_async_n]

if { ${SYNC_VERSION} == 0 } {
    # Setting hold false path to/from capture clocks 
    set_false_path       -from  [get_clocks CAPTURE*]
    set_false_path -hold -to    [get_clocks CAPTURE*]
    # Setting setup false path to/from launch clocks
    set_false_path -setup -from [get_clocks LAUNCH*]
    set_false_path        -to   [get_clocks LAUNCH*]

    # Settting 0-cycle path from all clocks to all clocks
    set_multicycle_path 0  -setup -from [get_clocks {ACLK_*}] -to [get_clocks {CAPTURE_*}]
    set_multicycle_path 0  -hold  -from [get_clocks {LAUNCH_*}] -to [get_clocks {ACLK_*}]

    # Setting false path to/from all dummy/epc clocks
    set_false_path -from [get_clocks {DUMMY_LOOP* EPC_*}]
    set_false_path -to   [get_clocks {DUMMY_LOOP* EPC_*}]

    # Disabling checks to control path
    # set_false_path -to [get_pins uu_ctrlpath/uu_*/uu_c_element*/*]

    # Max delays between pipeline stages
    set_clock_latency -source $DELAY_PC_FD [get_clocks CAPTURE_PC_FD]
    set_clock_latency -source $DELAY_FD_DE [get_clocks CAPTURE_FD_DE]
    set_clock_latency -source $DELAY_DE_EM [get_clocks CAPTURE_DE_EM]
    set_clock_latency -source $DELAY_DE_PC [get_clocks CAPTURE_DE_PC]
    set_clock_latency -source $DELAY_EM_MW [get_clocks CAPTURE_EM_MW]
    set_clock_latency -source $DELAY_MW_REG [get_clocks CAPTURE_MW_REG]
    set_clock_latency -source $DELAY_REG_DE [get_clocks CAPTURE_REG_DE]

    set_propagated_clock [get_clocks {CAPTURE_* EPC_* LAUNCH_*}]

    set_min_delay 0.400 -from [get_clocks {CAPTURE_EM_MW}] -to [get_ports {o_mem_clk}] -ignore_clock_latency

    # Hold constraints
    set_clock_latency -source 0.250 [get_clocks LAUNCH_*]

    #Disabling timing in muller gates to avoid combinational loop breaking
    if { ${PROTO_LC} == 1 } {
        set_disable_timing [get_pins uu_ctrlpath/*/uu_c_element*/OR2_2_DONT_TOUCH/B] ; #c_element_asym specific
    }
    set_disable_timing [get_pins uu_ctrlpath/*/uu_c_element*/*DRV_DONT_TOUCH/Y]
}
