class alu_vlib_test extends uvm_test;
	`uvm_component_utils(alu_vlib_test)
	alu_env env_h;
	alu_scoreboard sb_h;
	
	alu_env_config m_cfg;
	alu_wr_config w_cfg;
	alu_rd_config r_cfg;
	
	bit has_wagent = 1;
	bit has_ragent = 1;
	bit has_scoreboard = 1;
	bit has_virtual_sequencer = 1;
	
	alu_low_vseq low_vseq;
	alu_mid_vseq mid_vseq;
	alu_mid1_vseq mid1_vseq;
	alu_high_vseq high_vseq;
	//alu_rand_vseq rand_vseq;
	
	function new(string name = "alu_vlib_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		m_cfg = alu_env_config::type_id::create("m_cfg");
		config_alu();
		uvm_config_db #(alu_env_config)::set(this, "*", "alu_env_config", m_cfg);
		super.build_phase(phase);
		env_h = alu_env::type_id::create("alu_env", this);
		if(has_scoreboard)
			sb_h = alu_scoreboard::type_id::create("sb_h", this);
	endfunction
	
	function void config_alu();
		if(has_wagent) begin
			w_cfg = alu_wr_config::type_id::create("w_cfg");
			if(!uvm_config_db #(virtual alu_if)::get(this, "", "in_if", w_cfg.vif))
				`uvm_fatal(get_type_name(), "Error while getting interface");
			m_cfg.w_cfg = w_cfg;
		end
		if(has_ragent) begin
			r_cfg = alu_rd_config::type_id::create("r_cfg");
			if(!uvm_config_db #(virtual alu_if)::get(this, "", "op_if", r_cfg.vif))
				`uvm_fatal(get_type_name(), "Error while getting interface");
			m_cfg.r_cfg = r_cfg;
		end
		m_cfg.has_wagent = has_wagent;
		m_cfg.has_ragent = has_ragent;
		m_cfg.has_scoreboard = has_scoreboard;
		m_cfg.has_virtual_sequencer = has_virtual_sequencer;
	endfunction
	
	function void connect_phase(uvm_phase phase);
		if(m_cfg.has_scoreboard) begin
			if(m_cfg.has_wagent)
				env_h.wr_agt.monh.monitor_port.connect(sb_h.fifo_wrh.analysis_export);
			if(m_cfg.has_ragent)
				env_h.rd_agt.monh.monitor_port.connect(sb_h.fifo_rdh.analysis_export);
		end
	endfunction
	
	function void start_of_simulation_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
	
endclass

class alu_test_low extends alu_vlib_test;
	`uvm_component_utils(alu_test_low)
	
	function new(string name = "alu_test_low", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			
			repeat(100) 
			begin
				low_vseq = alu_low_vseq::type_id::create("low_vseq");
				low_vseq.start(env_h.vseqrh);
			end
			#10;
		phase.drop_objection(this);
	endtask
endclass

class alu_test_mid extends alu_vlib_test;
	`uvm_component_utils(alu_test_mid)
	
	function new(string name = "alu_test_mid", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			
			repeat(100) 
			begin
				mid_vseq = alu_mid_vseq::type_id::create("mid_vseq");
				mid_vseq.start(env_h.vseqrh);
			end
			#10;
		phase.drop_objection(this);
	endtask
endclass

class alu_test_mid1 extends alu_vlib_test;
	`uvm_component_utils(alu_test_mid1)
	
	function new(string name = "alu_test_mid1", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			
			repeat(100) 
			begin
				mid1_vseq = alu_mid1_vseq::type_id::create("mid1_vseq");
				mid1_vseq.start(env_h.vseqrh);
			end
			#10;
		phase.drop_objection(this);
	endtask
endclass

class alu_test_high extends alu_vlib_test;
	`uvm_component_utils(alu_test_high)
	
	function new(string name = "alu_test_high", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			
			repeat(100) 
			begin
				high_vseq = alu_high_vseq::type_id::create("high_vseq");
				high_vseq.start(env_h.vseqrh);
			end
			
		phase.drop_objection(this);
	endtask
endclass


