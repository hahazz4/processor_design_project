module ALU(input [31:0] a, b, num, 
           input wire [4:0] opcode, 
			  output reg[31:0] result,
           output reg[31:0] carry_out);
           //output overflow);
   
   // Simple operations
   wire [31:0] and_result, or_result, xor_result, not_result;
	and_op and_unit(a, b, and_result);
   or_op or_unit(a, b, or_result);
	xor_op xor_unit(a, b, xor_result);
   not_op not_unit(a, not_result);
   
   // Addition and subtraction
//   wire [31:0] add_result;
//   carryRippleAdder32 add_unit(a, b, add_result, carry_out);
//   full_subtractor32 sub_unit(.a(A), .b(B), .diff(sub_result), .co(carry_out));
//   
//   // Multiplication
//   wire [63:0] mul_result;
//   multiplier mul_unit(.a(A), .b(B), .mul_result(mul_result));
//   
//   // Division
//   wire [31:0] div_result, rem_result;
//   divider div_unit(.a(A), .b(B), .div_result(div_result), .rem_result(rem_result));
//   
   // Shift and rotate operations
   wire [31:0] shiftL_result, shiftR_result, shiftAR_result;
   wire [31:0] rotateL_result, rotateR_result;
   shift_left shiftL_unit(a, num, shiftL_result);
   shift_right shiftR_unit(a, num, shiftR_result);
	shift_arithmetic_right shiftAR_unit(a, num, shiftAR_result);
	rotate_left rotateL_unit(a, num, rotateL_result);
//   rotateR rotateR_unit(.a(A), .r_num(num), .rotateR_result(rotateR_result));
   
   // Select operation
   always @(*) begin
      case(opcode)
         0	:	result = and_result;
         1	: 	result = or_result;
         2	: 	result = xor_result;
         3	:	result = not_result;
//         4	: 	result = add_result;
//         4'b0101: result = sub_result;
//         4'b0110: result = mul_result;
//         4'b0111: result = div_result;
         8	:	result = shiftL_result;
         9	:	result = shiftR_result;
			10	:	result = shiftAR_result;
			11	:	result = rotateL_result;
//         4'b1101: result = rotateR_result;
         default: result = 32'b0;
      endcase
   end
endmodule
