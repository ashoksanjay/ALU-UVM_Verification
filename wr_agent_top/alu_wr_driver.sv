class alu_wr_driver extends uvm_driver #(write_xtn);
	`uvm_component_utils(alu_wr_driver)
	
	virtual alu_if.WR_DRV_MP vif;
	alu_wr_config m_cfg;
	
	function new(string name  = "alu_wr_driver", uvm_component parent);
		super.new(name, parent);
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
		@(vif.wr_drv_cb)
			vif.wr_drv_cb.rst_i <= 1;
		@(vif.wr_drv_cb)
			vif.wr_drv_cb.rst_i <= 0;
		forever begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
	endtask
	
	task send_to_dut(write_xtn xtn);
		`uvm_info(get_type_name(), $sformatf("Driver Packet \n %s", xtn.sprint()), UVM_LOW);
		@(vif.wr_drv_cb)
		vif.wr_drv_cb.dataA_i <= xtn.dataA_i;
		vif.wr_drv_cb.dataB_i <= xtn.dataB_i;
		vif.wr_drv_cb.ALUCtrl_i <= xtn.ALUCtrl_i;
		
		@(vif.wr_drv_cb)
		m_cfg.wr_drv_data++;
	endtask
	
	function void report_phase(uvm_phase phase);
		`uvm_info(get_type_name(), $sformatf("No of Packets driven in wr driver : %0d", m_cfg.wr_drv_data), UVM_LOW);
	endfunction
	
endclass