module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
   wire [31:0] add_result, sub_result;
   wire add_overflow, sub_overflow, add_cout, sub_cout;
   wire [31:0] sll_result, sra_result;
   wire [31:0] and_result, or_result;
	
	add_op ao(data_operandA,data_operandB,add_cout,add_result,add_overflow);
	sub_op so(data_operandA,data_operandB,sub_cout,sub_result,sub_overflow);
	
   a_lessthan_b lt(sub_result[31],sub_overflow,isLessThan);
   a_isnotequal_b ine(sub_result,isNotEqual);
	
   and_op ado(data_operandA,data_operandB,and_result);
   or_op oro(data_operandA,data_operandB,or_result);
	
   sll sl(data_operandA,ctrl_shiftamt,sll_result);
   sra sr(data_operandA,ctrl_shiftamt,sra_result);
	
   assign data_result = ctrl_ALUopcode[2]?(ctrl_ALUopcode[0]? sra_result:sll_result):(ctrl_ALUopcode[1]?(ctrl_ALUopcode[0]?or_result:and_result):(ctrl_ALUopcode[0]?sub_result:add_result));
   assign overflow = ctrl_ALUopcode[0]? sub_overflow:add_overflow;
	
endmodule
