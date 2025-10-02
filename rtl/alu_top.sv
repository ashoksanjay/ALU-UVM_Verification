module alu_top(clk_i, rst_i, dataA_i, dataB_i, ALUCtrl_i, ALUResult_o, Zero_o);
	input clk_i;
	input rst_i;
	input [31:0] dataA_i;
	input [31:0] dataB_i;
	input [2:0] ALUCtrl_i;
	output reg [31:0] ALUResult_o;
	output reg Zero_o;
	
	reg [31:0] temp_result;
	reg temp_zero;
	
	always @(*) begin
		if(rst_i) begin
			temp_result = 0;
			temp_zero = 1;
		end
		else begin
			case(ALUCtrl_i)
				3'b010 : begin  //ADD
					temp_result = dataA_i + dataB_i;
				end
				3'b110: begin //SUB
					temp_result = dataA_i - dataB_i;
				end
				3'b000: begin //AND
					temp_result = dataA_i & dataB_i;
				end
				3'b001: begin //OR
					temp_result = dataA_i | dataB_i;
				end
				3'b011: begin //XOR
					temp_result = dataA_i ^ dataB_i;
				end
				3'b100: begin //NOR
					temp_result = ~(dataA_i | dataB_i);
				end
				default: begin
					temp_result = 0;
					temp_zero = 0;
				end
			endcase
			if(temp_result == 0) begin
				temp_zero = 1;
			end
			else begin
				temp_zero = 0;
			end
		end
	end
	
	always @(posedge clk_i or posedge rst_i) begin
		if(rst_i) begin
			ALUResult_o <= 0;
			Zero_o <= 1;
		end
		else begin
			ALUResult_o <= temp_result;
			Zero_o <= temp_zero;
		end
	end
	
	
endmodule