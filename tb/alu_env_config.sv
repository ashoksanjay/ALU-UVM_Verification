class alu_env_config extends uvm_object;
	`uvm_object_utils(alu_env_config)
	alu_wr_config w_cfg;
	alu_rd_config r_cfg;
	
	bit has_wagent;
	bit has_ragent;
	bit has_scoreboard;
	bit has_virtual_sequencer;
	
	function new(string name = "alu_env_config");
		super.new(name);
	endfunction
	
endclass