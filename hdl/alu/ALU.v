module ALU(input [31:0] A, B, 
           input [3:0] opcode, 
           output [31:0] result, 
           output carry_out, 
           output overflow);
   
   // Simple operations
   wire [31:0] and_result, or_result, xor_result, not_result;
   and_op and_unit(.a(A), .b(B), .and_result(and_result));
   or_op or_unit(.a(A), .b(B), .or_result(or_result));
   xor_op xor_unit(.a(A), .b(B), .xor_result(xor_result));
   not_op not_unit(.a(A), .not_result(not_result));
   
   // Addition and subtraction
   wire [31:0] add_result, sub_result;
   carryRippleAdder32 add_unit(.a(A), .b(B), .sum(add_result), .co(carry_out));
   full_subtractor32 sub_unit(.a(A), .b(B), .diff(sub_result), .co(carry_out));
   
   // Multiplication
   wire [63:0] mul_result;
   multiplier mul_unit(.a(A), .b(B), .mul_result(mul_result));
   
   // Division
   wire [31:0] div_result, rem_result;
   divider div_unit(.a(A), .b(B), .div_result(div_result), .rem_result(rem_result));
   
   // Shift and rotate operations
   wire [31:0] shiftL_result, shiftR_result, shiftAR_result;
   wire [31:0] rotateL_result, rotateR_result;
   integer num;
   shift_left shiftL_unit(.a(A), .s_num(num), .shiftL_result(shiftL_result));
   shift_right shiftR_unit(.a(A), .s_num(num), .shiftR_result(shiftR_result));
   shiftAR shiftAR_unit(.a(A), .s_num(num), .shiftAR_result(shiftAR_result));
   rotateL rotateL_unit(.a(A), .r_num(num), .rotateL_result(rotateL_result));
   rotateR rotateR_unit(.a(A), .r_num(num), .rotateR_result(rotateR_result));
   
   // Select operation
   always @(*) begin
      case(opcode)
         4'b0000: result = and_result;
         4'b0001: result = or_result;
         4'b0010: result = xor_result;
         4'b0011: result = not_result;
         4'b0100: result = add_result;
         4'b0101: result = sub_result;
         4'b0110: result = mul_result;
         4'b0111: result = div_result;
         4'b1000: result = rem_result;
         4'b1001: result = shiftL_result;
         4'b1010: result = shiftR_result;
         4'b1011: result = shiftAR_result;
         4'b1100: result = rotateL_result;
         4'b1101: result = rotateR_result;
         default: result = 32'b0;
      endcase
   end
endmodule
