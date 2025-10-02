module top;
	import uvm_pkg::*;
	import alu_pkg::*;
	
	`include "uvm_macros.svh"
	
	bit clock;
	always #5 clock = ~clock;
	
	alu_if in_if(clock);
	alu_if op_if(clock);
	
	alu_top DUT(.clk_i(clock), .rst_i(in_if.rst_i), 
					.dataA_i(in_if.dataA_i), .dataB_i(in_if.dataB_i), .ALUCtrl_i(in_if.ALUCtrl_i), 
						.ALUResult_o(op_if.ALUResult_o), .Zero_o(op_if.Zero_o));
	
	initial begin
		uvm_config_db #(virtual alu_if)::set(null, "*", "in_if", in_if);
		uvm_config_db #(virtual alu_if)::set(null, "*", "op_if", op_if);
		run_test();
	end
	
	property reset_prpty;
		@(posedge clock or posedge in_if.rst_i)
		in_if.rst_i |-> (op_if.ALUResult_o == 32'h0 && op_if.Zero_o == 1'b1);
	endproperty

	property add_prpty;
		@(posedge clock) disable iff(in_if.rst_i)
		(in_if.ALUCtrl_i == 3'b010) |=> (op_if.ALUResult_o == $past(in_if.dataA_i + in_if.dataB_i));
	endproperty

	property sub_prpty;
		@(posedge clock) disable iff(in_if.rst_i)
		(in_if.ALUCtrl_i == 3'b110) |=> (op_if.ALUResult_o == $past(in_if.dataA_i - in_if.dataB_i));
	endproperty

	property and_prpty;
		@(posedge clock) disable iff(in_if.rst_i)
		(in_if.ALUCtrl_i == 3'b000) |=> (op_if.ALUResult_o == $past(in_if.dataA_i & in_if.dataB_i));
	endproperty

	property or_prpty;
		@(posedge clock) disable iff(in_if.rst_i)
		(in_if.ALUCtrl_i == 3'b001) |=> (op_if.ALUResult_o == $past(in_if.dataA_i | in_if.dataB_i));
	endproperty

	property xor_prpty;
		@(posedge clock) disable iff(in_if.rst_i)
		(in_if.ALUCtrl_i == 3'b011) |=> (op_if.ALUResult_o == $past(in_if.dataA_i ^ in_if.dataB_i));
	endproperty

	property nor_prpty;
		@(posedge clock) disable iff(in_if.rst_i)
		(in_if.ALUCtrl_i == 3'b100) |=> (op_if.ALUResult_o == $past(~(in_if.dataA_i | in_if.dataB_i)));
	endproperty

	property zero_prpty;
		@(posedge clock) disable iff(in_if.rst_i)
		(op_if.ALUResult_o == 32'h0) |-> (op_if.Zero_o == 1'b1);
	endproperty
  
    RESET: assert property(reset_prpty);
	ADD: assert property(add_prpty);
	SUB: assert property(sub_prpty);
	AND: assert property(and_prpty);
	OR: assert property(or_prpty);
	XOR: assert property(xor_prpty);
	NOR: assert property(nor_prpty);
	ZERO: assert property(zero_prpty);

	RESET_C: cover property(reset_prpty);
	ADD_C: cover property(add_prpty);
	SUB_C: cover property(sub_prpty);
	AND_C: cover property(and_prpty);
	OR_C: cover property(or_prpty);
	XOR_C: cover property(xor_prpty);
	NOR_C: cover property(nor_prpty);
	ZERO_C: cover property(zero_prpty);

	
endmodule
