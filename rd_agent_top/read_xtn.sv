class read_xtn extends uvm_sequence_item;
	`uvm_object_utils(read_xtn)
	
	logic [31:0] ALUResult_o;
	logic Zero_o;
	
	function new(string name = "read_xtn");
		super.new(name);
	endfunction
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("Result", this.ALUResult_o, 32, UVM_DEC);
		printer.print_field("Zero_flag", this.Zero_o, '1, UVM_BIN);
	endfunction
	
endclass