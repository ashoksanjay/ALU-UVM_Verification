class alu_wr_sequencer extends uvm_sequencer #(write_xtn);
	`uvm_component_utils(alu_wr_sequencer)
	
	function new(string name = "alu_wr_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
endclass