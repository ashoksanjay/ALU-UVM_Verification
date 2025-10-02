class alu_wr_monitor extends uvm_monitor;
	`uvm_component_utils(alu_wr_monitor)
	
	virtual alu_if.WR_MON_MP vif;
	alu_wr_config m_cfg;
	
	uvm_analysis_port #(write_xtn) monitor_port;
	
	function new(string name = "alu_wr_monitor", uvm_component parent);
		super.new(name, parent);
		monitor_port = new("monitor_port", this);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(alu_wr_config)::get(this, "", "alu_wr_config", m_cfg))
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
		write_xtn mon_data;
		begin
			mon_data = write_xtn::type_id::create("mon_data");
			@(vif.wr_mon_cb)
			mon_data.dataA_i = vif.wr_mon_cb.dataA_i;
			mon_data.dataB_i = vif.wr_mon_cb.dataB_i;
			mon_data.ALUCtrl_i = vif.wr_mon_cb.ALUCtrl_i;
			
			@(vif.wr_mon_cb)
			`uvm_info(get_full_name(), $sformatf("Monitor_packet\n %s", mon_data.sprint()), UVM_LOW);
			m_cfg.wr_mon_data++;
			monitor_port.write(mon_data);
		end
	endtask
	
	function void report_phase(uvm_phase phase);
		`uvm_info(get_type_name(), $sformatf("No of Packets received in wr monitor : %0d", m_cfg.wr_mon_data), UVM_LOW);
	endfunction
	
endclass