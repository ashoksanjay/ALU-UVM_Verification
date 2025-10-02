class write_xtn extends uvm_sequence_item;
	`uvm_object_utils(write_xtn)
	
	bit rst_i;
	rand logic [31:0] dataA_i;
	rand logic [31:0] dataB_i;
	rand logic [2:0] ALUCtrl_i;
	
	constraint c1{ALUCtrl_i inside {[0:6]};
					ALUCtrl_i != 5;}
					
	//constraint c2{dataA_i inside {[0:32]}; dataB_i inside {[0:32]};}
	
	function new(string name = "write_xtn");
		super.new(name);
	endfunction
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("Reset", this.rst_i, '1, UVM_BIN);
		printer.print_field("Data_A", this.dataA_i, 32, UVM_DEC);
		printer.print_field("Data_B", this.dataB_i, 32, UVM_DEC);
		printer.print_field("ALU_Ctrl", this.ALUCtrl_i, 3, UVM_DEC);
	endfunction
	
endclass