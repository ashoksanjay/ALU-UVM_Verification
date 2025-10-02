class alu_rd_config extends uvm_object;
	`uvm_object_utils(alu_rd_config)
	
	virtual alu_if vif;
	uvm_active_passive_enum is_active = UVM_PASSIVE;
	
	static int rd_mon_data = 0;
	
	function new(string name = "alu_rd_config");
		super.new(name);
	endfunction
endclass