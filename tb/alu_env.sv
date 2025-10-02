class alu_env extends uvm_env;
	`uvm_component_utils(alu_env)
	
	alu_wr_agent wr_agt;
	alu_rd_agent rd_agt;
	alu_env_config m_cfg;
	
	alu_virtual_sequencer vseqrh;
	
	function new(string name = "alu_env", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(alu_env_config)::get(this, "", "alu_env_config", m_cfg))
			`uvm_fatal(get_type_name(), "Error while getting config");
		if(m_cfg.has_wagent) begin
			uvm_config_db #(alu_wr_config)::set(this, "wr_agt*", "alu_wr_config", m_cfg.w_cfg);
			wr_agt = alu_wr_agent::type_id::create("wr_agt", this);
		end
		
		if(m_cfg.has_ragent) begin
			uvm_config_db #(alu_rd_config)::set(this, "rd_agt*", "alu_rd_config", m_cfg.r_cfg);
			rd_agt = alu_rd_agent::type_id::create("rd_agt", this);
		end
		
		if(m_cfg.has_virtual_sequencer) begin
			vseqrh = alu_virtual_sequencer::type_id::create("vseqrh", this);
		end
	endfunction
	
	function void connect_phase(uvm_phase phase);
		if(m_cfg.has_virtual_sequencer) begin
			if(m_cfg.has_wagent)
				vseqrh.wr_seqrh = wr_agt.seqrh;
		end
		
		
			
	endfunction
	
endclass