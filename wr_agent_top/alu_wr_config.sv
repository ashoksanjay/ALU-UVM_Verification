class alu_wr_config extends uvm_object;
	`uvm_object_utils(alu_wr_config)
	
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	virtual alu_if vif;
	
	static int wr_drv_data = 0;
	static int wr_mon_data = 0;
	
	function new(string name = "alu_wr_config");
		super.new(name);
	endfunction
	
endclass