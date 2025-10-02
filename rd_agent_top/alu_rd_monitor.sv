class alu_rd_monitor extends uvm_monitor;
	`uvm_component_utils(alu_rd_monitor)
	
	virtual alu_if.RD_MON_MP vif;
	alu_rd_config m_cfg;
	uvm_analysis_port #(read_xtn) monitor_port;
	bit flag;
	
	function new(string name = "alu_rd_monitor", uvm_component parent);
		super.new(name, parent);
		monitor_port = new("monitor_port", this);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(alu_rd_config)::get(this, "", "alu_rd_config", m_cfg))
			`uvm_fatal(get_type_name(), "Error while getting config");
	endfunction
	
	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction
	
	task run_phase(uvm_phase phase);
		forever
			collect_data();
	endtask
	
	task collect_data();
		read_xtn mon_data;
		begin
			mon_data = read_xtn::type_id::create("mon_data");
			@(vif.rd_mon_cb)
			mon_data.ALUResult_o = vif.rd_mon_cb.ALUResult_o;
			mon_data.Zero_o = vif.rd_mon_cb.Zero_o;
			//`uvm_info(get_full_name(), $sformatf("Read Monitor packet\n %s", mon_data.sprint()), UVM_LOW);
			@(vif.rd_mon_cb)
			m_cfg.rd_mon_data++;
			monitor_port.write(mon_data);
		end
	endtask
	
	function void report_phase(uvm_phase phase);
		`uvm_info(get_type_name(), $sformatf("No of Packets received in rd monitor : %0d", m_cfg.rd_mon_data), UVM_LOW);
	endfunction
	
endclass
