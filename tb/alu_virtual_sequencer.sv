class alu_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
	`uvm_component_utils(alu_virtual_sequencer)
	
	alu_wr_sequencer wr_seqrh;
	
	function new(string name = "alu_virtual_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction
endclass
