# ================================
# Makefile for ALU UVM Testbench
# Supports: Questa (Mentor), VCS (Synopsys)
# ================================

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS
SIMULATOR = Questa

# Paths
FSDB_PATH = /home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

# Files & Libraries
RTL   = ../rtl/*
work  = work
SVTB1 = ../tb/top.sv
SVTB2 = ../test/alu_test_pkg.sv
INC   = +incdir+../tb +incdir+../test +incdir+../wr_agent_top +incdir+../rd_agent_top

# Options
COVOP     = -coverage +cover=bcft
VSIMOPT   = -vopt -voptargs=+acc
VSIMCOV   = $(COVOP)
VSIMBATCH  = -c -do "log -r /* ; coverage save -onexit alu_cov0; run -all; exit"
VSIMBATCH1 = -c -do "log -r /* ; coverage save -onexit alu_cov1; run -all; exit"
VSIMBATCH2 = -c -do "log -r /* ; coverage save -onexit alu_cov2; run -all; exit"
VSIMBATCH3 = -c -do "log -r /* ; coverage save -onexit alu_cov3; run -all; exit"

COV_OPTS = +cover=sva+fsm+tgl+branch+cond+assert+coverpoints+cross

# ================================
# Help
# ================================
help:
	@echo "=============================================================="
	@echo "! clean        => Clean earlier log and intermediate files.   !"
	@echo "! sv_cmp       => Create library and compile the code.        !"
	@echo "! run_test     => Run alu_test in batch mode.                 !"
	@echo "! TC1          => Run alu_test_low                            !"
	@echo "! TC2          => Run alu_test_mid                            !"
	@echo "! TC3          => Run alu_test_mid1                           !"
	@echo "! TC4          => Run alu_test_high                           !"
	@echo "! view_wave1   => View alu_test_low waveform                  !"
	@echo "! view_wave2   => View alu_test_mid waveform                  !"
	@echo "! view_wave3   => View alu_test_mid1 waveform                 !"
	@echo "! view_wave4   => View alu_test_high waveform                 !"
	@echo "! regress_12   => Run low-mid alu testcases sequentially.     !"
	@echo "! regress_123  => Run low-mid-mid1 alu testcases sequentially !"
	@echo "! regress_1234 => Run low-mid-mid1-high testcases sequentially!"
	@echo "! report_12    => Generate coverage for low-mid               !"
	@echo "! report_123   => Generate coverage for low-mid-mid1          !"
	@echo "! report_1234  => Generate coverage for low-mid-mid1-high     !"
	@echo "! cov          => To view the coverage report                 !"
	@echo "=============================================================="


# ================================
# Generic targets
# ================================
clean       : clean_$(SIMULATOR)
sv_cmp      : sv_cmp_$(SIMULATOR)
run_test    : run_test_$(SIMULATOR)
TC1         : TC1_$(SIMULATOR)
TC2         : TC2_$(SIMULATOR)
TC3         : TC3_$(SIMULATOR)
TC4         : TC4_$(SIMULATOR)
view_wave1  : view_wave1_$(SIMULATOR)
view_wave2  : view_wave2_$(SIMULATOR)
view_wave3  : view_wave3_$(SIMULATOR)
view_wave4  : view_wave4_$(SIMULATOR)
regress     : regress_$(SIMULATOR)
regress_12  : regress_12_$(SIMULATOR)
regress_123 : regress_123_$(SIMULATOR)
regress_1234 : regress_1234_$(SIMULATOR)
report_12   : report_12_$(SIMULATOR)
report_123  : report_123_$(SIMULATOR)
report_1234  : report_1234_$(SIMULATOR)
cov         : cov_$(SIMULATOR)

# ================================
# Questa Targets
# ================================
sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test_Questa: sv_cmp_Questa
	vsim $(VSIMOPT) $(VSIMBATCH) -l test1.log -sv_seed random work.top

TC1_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH)  -wlf alu_rand1.wlf -l rand1.log -sv_seed 71462645 work.top +UVM_TESTNAME=alu_test_low
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html alu_cov0
 
TC2_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1) -wlf alu_rand2.wlf -l rand2.log -sv_seed 3716333793 work.top +UVM_TESTNAME=alu_test_mid
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html alu_cov1
 
TC3_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2) -wlf alu_rand3.wlf -l rand3.log -sv_seed 753057089 work.top +UVM_TESTNAME=alu_test_mid1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html alu_cov2
 
TC4_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3) -wlf alu_rand4.wlf -l rand4.log -sv_seed 3997417034 work.top +UVM_TESTNAME=alu_test_high
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html alu_cov3

report_12_Questa:
	vcover merge -out alu_cov alu_cov0 alu_cov1
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html alu_cov

regress_12_Questa: clean_Questa sv_cmp_Questa TC1_Questa TC2_Questa report_12_Questa

report_123_Questa:
	vcover merge -out alu_cov alu_cov0 alu_cov1 alu_cov2
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html alu_cov

regress_123_Questa: clean_Questa sv_cmp_Questa TC1_Questa TC2_Questa TC3_Questa report_123_Questa

report_1234_Questa:
	vcover merge -out alu_cov alu_cov0 alu_cov1 alu_cov2 alu_cov3
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html alu_cov

regress_1234_Questa: clean_Questa sv_cmp_Questa TC1_Questa TC2_Questa TC3_Questa TC4_Questa report_1234_Questa

view_wave1_Questa:
	vsim -view alu_rand1.wlf
 
view_wave2_Questa:
	vsim -view alu_rand2.wlf
 
view_wave3_Questa:
	vsim -view alu_rand3.wlf
 
view_wave4_Questa:
	vsim -view alu_rand4.wlf

regress_Questa: TC1_Questa

clean_Questa:
	rm -rf transcript* *log* fcover* vsim.wlf *.wlf covhtml* alu_cov* modelsim.ini work
	clear

cov_Questa:
	firefox covhtmlreport/index.html&
