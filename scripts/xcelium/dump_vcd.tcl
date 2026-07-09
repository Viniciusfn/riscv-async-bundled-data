# dump_vcd.tcl
database -create waves -vcd -into wave_trace.vcd

probe -database waves -create /tb_ariscv_soc_top/dut/uu_core -depth all -all

run
exit