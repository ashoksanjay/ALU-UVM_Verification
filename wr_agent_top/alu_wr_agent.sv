class alu_wr_agent extends uvm_agent;
	`uvm_component_utils(alu_wr_agent)
	
	alu_wr_sequencer seqrh;
	alu_wr_driver drvh;
	alu_wr_monitor monh;
	
	alu_wr_config m_cfg;
	
	function new(string name = "alu_wr_agent", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(alu_wr_config)::get(this, "", "alu_wr_config", m_cfg))
			`uvm_fatal(get_type_name(), "Error while getting config");
		monh = alu_wr_monitor::type_id::create("monh", this);
		if(m_cfg.is_active == UVM_ACTIVE) begin
			seqrh = alu_wr_sequencer::type_id::create("seqrh", this);
			drvh = alu_wr_driver::type_id::create("drvh", this);
		end
	endfunction	
	
	function void connect_phase(uvm_phase phase);
		drvh.seq_item_port.connect(seqrh.seq_item_export);
	endfunction
endclass