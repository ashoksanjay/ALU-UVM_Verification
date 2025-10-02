class alu_rd_agent extends uvm_agent;
	`uvm_component_utils(alu_rd_agent)
	
	alu_rd_monitor monh;
	alu_rd_config m_cfg;
	
	function new(string name = "alu_rd_agent", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(alu_rd_config)::get(this, "", "alu_rd_config", m_cfg))
			`uvm_fatal(get_type_name(), "Error while getting config");
		monh = alu_rd_monitor::type_id::create("monh", this);
	endfunction
	
	
endclass