package alu_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	`include "write_xtn.sv"
	`include "read_xtn.sv"
	
	`include "alu_wr_config.sv"
	`include "alu_rd_config.sv"
	`include "alu_env_config.sv"
	
	`include "alu_wr_seq.sv"
	`include "alu_wr_sequencer.sv"
	`include "alu_wr_driver.sv"
	`include "alu_wr_monitor.sv"
	`include "alu_wr_agent.sv"
	
	`include "alu_rd_monitor.sv"
	`include "alu_rd_agent.sv"
	
	`include "alu_virtual_sequencer.sv"
	`include "alu_virtual_seq.sv"
	
	`include "alu_env.sv"
	`include "alu_scoreboard.sv"
	`include "alu_vlib_test.sv"
	
endpackage