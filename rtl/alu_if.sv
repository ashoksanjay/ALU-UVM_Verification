interface alu_if(input bit clock);
	logic rst_i;
	logic [31:0] dataA_i;
	logic [31:0] dataB_i;
	logic [2:0] ALUCtrl_i;
	logic [31:0] ALUResult_o;
	logic Zero_o;
	
	clocking wr_drv_cb @(posedge clock);
		default input #1 output #1;
		output rst_i;
		output dataA_i;
		output dataB_i;
		output ALUCtrl_i;
	endclocking
	
	clocking wr_mon_cb @(posedge clock);
		default input #1 output #1;
		input rst_i;
		input dataA_i;
		input dataB_i;
		input ALUCtrl_i;
	endclocking
	
	clocking rd_mon_cb @(posedge clock);
		default input #1 output #1;
		input rst_i;
		input ALUResult_o;
		input Zero_o;
	endclocking
	
	modport WR_DRV_MP(clocking wr_drv_cb);
	modport WR_MON_MP(clocking wr_mon_cb);
	modport RD_MON_MP(clocking rd_mon_cb);
	
	
	
endinterface