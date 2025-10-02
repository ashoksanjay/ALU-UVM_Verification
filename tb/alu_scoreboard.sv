class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)

  uvm_tlm_analysis_fifo #(write_xtn) fifo_wrh;
  uvm_tlm_analysis_fifo #(read_xtn)  fifo_rdh;

  write_xtn wr_data;
  read_xtn  rd_data;
  
  write_xtn write_cov;

  int xtns_compared, xtns_dropped;
  
  
  covergroup alu_cg;
		option.per_instance = 1;
		option.comment = "ALU functional coverage";

	  DATA_A: coverpoint write_cov.dataA_i {
		bins low  = {[32'h0000_0000 : 32'h3FFF_FFFF]};
	    bins mid  = {[32'h4000_0000 : 32'h7FFF_FFFF]};
	    bins mid1 = {[32'h8000_0000 : 32'hBFFF_FFFF]};
	    bins high = {[32'hC000_0000 : 32'hFFFF_FFFF]};
	  }

	  DATA_B: coverpoint write_cov.dataB_i {
		bins low  = {[32'h0000_0000 : 32'h3FFF_FFFF]};
        bins mid  = {[32'h4000_0000 : 32'h7FFF_FFFF]};
        bins mid1 = {[32'h8000_0000 : 32'hBFFF_FFFF]};
        bins high = {[32'hC000_0000 : 32'hFFFF_FFFF]};
	  }

	  ADDR: coverpoint write_cov.ALUCtrl_i {
		bins ADD = {3'b010};
		bins SUB = {3'b110};
		bins AND = {3'b000};
		bins OR  = {3'b001};
		bins XOR = {3'b011};
		bins NOR = {3'b100};
		bins others = default;
	  }

	  CROSS_inputs: cross ADDR, DATA_A, DATA_B;

	endgroup

  function new(string name = "alu_scoreboard", uvm_component parent);
    super.new(name, parent);
    fifo_wrh = new("fifo_wrh", this);
    fifo_rdh = new("fifo_rdh", this);
	alu_cg = new();
  endfunction
  
  task run_phase(uvm_phase phase);
	forever
		begin
			fork
				fifo_wrh.get(wr_data);
				fifo_rdh.get(rd_data);
			join
			
			write_cov = wr_data;
			alu_cg.sample();

			//`uvm_info(get_type_name(), $sformatf("Write Monitor packet\n %s", wr_data.sprint()), UVM_LOW);
			//`uvm_info(get_type_name(), $sformatf("Read Monitor packet\n %s", rd_data.sprint()), UVM_LOW);
			do_check(wr_data, rd_data);
		end
  endtask
  
  task do_check(write_xtn wdata, read_xtn rdata);
	read_xtn exp_data;
	exp_data = ref_mod(wdata);
	if(compare(exp_data, rd_data)) begin
		xtns_compared++;
		`uvm_info(get_type_name(), $sformatf("Data Matched packet\n %s %s",wdata.sprint(), rd_data.sprint()), UVM_LOW);
	end
	else begin
		xtns_dropped++;
		`uvm_info(get_type_name(), $sformatf("Data Mismatched packet\n %s %s",wdata.sprint(), rd_data.sprint()), UVM_LOW);
	end
  endtask
  
  function read_xtn ref_mod(write_xtn xtn);
    read_xtn out_data = read_xtn::type_id::create("out_data");
    if (xtn.rst_i) begin
      out_data.ALUResult_o = 0;
      out_data.Zero_o      = 1;
    end
    else begin
      case (xtn.ALUCtrl_i)
        3'b010: out_data.ALUResult_o = xtn.dataA_i + xtn.dataB_i;
        3'b110: out_data.ALUResult_o = xtn.dataA_i - xtn.dataB_i;
        3'b000: out_data.ALUResult_o = xtn.dataA_i & xtn.dataB_i;
        3'b001: out_data.ALUResult_o = xtn.dataA_i | xtn.dataB_i;
        3'b011: out_data.ALUResult_o = xtn.dataA_i ^ xtn.dataB_i;
        3'b100: out_data.ALUResult_o = ~(xtn.dataA_i | xtn.dataB_i);
        default: out_data.ALUResult_o = '0;
      endcase
      out_data.Zero_o = (out_data.ALUResult_o == 0);
    end
    return out_data;
  endfunction
  
  function bit compare(read_xtn exp, read_xtn act);
	if(exp.ALUResult_o !== act.ALUResult_o)
		return 0;
	else if(exp.Zero_o !== act.Zero_o)
		return 0;
	else
		return 1;
  endfunction
  
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(),$sformatf("Packets matched: %0d, dropped: %0d",xtns_compared, xtns_dropped), UVM_LOW)
  endfunction
  
endclass
