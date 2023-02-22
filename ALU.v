module ALU(input [31:0] A, B, 
           input [3:0] opcode, 
           output [31:0] result, 
           output carry_out, 
           output overflow);
   
   // Simple operations
   wire and_result = A & B;
   wire or_result = A | B;
   wire xor_result = A ^ B;
   
   // Addition and subtraction
   wire [31:0] add_result, sub_result;
   adder add_unit(.a(A), .b(B), .sum(add_result), .carry_out(carry_out));              //gonna test soon
   // subtractor sub_unit(.a(A), .b(B), .diff(sub_result), .carry_out(carry_out));
   
   // // Multiplication
   // wire [63:0] mul_result;
   // multiplier mul_unit(.a(A), .b(B), .product(mul_result));
   
   // // Division
   // wire [31:0] div_result, rem_result;
   // divider div_unit(.a(A), .b(B), .quotient(div_result), .remainder(rem_result));
   
   // // Shift and rotate operations
   // wire [31:0] shift_left_result, shift_right_result;
   // wire [31:0] rotate_left_result, rotate_right_result;
   // shiftL shift_unit(.a(A), .result(shift_left_result), .dir(1'b0));
   // shiftR shift_unit(.a(A), .result(shift_right_result), .dir(1'b1));
   // rotate_unit(.a(A), .result(rotate_left_result), .dir(1'b0));
   // rotate_unit(.a(A), .result(rotate_right_result), .dir(1'b1));
   
   // Select operation
   always @(*) begin
      case(opcode)
         4'b0000: result = and_result;
         4'b0001: result = or_result;
         4'b0010: result = xor_result;
         4'b0011: result = add_result;
         // 4'b0100: result = sub_result;
         // 4'b0101: result = mul_result;
         // 4'b0110: result = div_result;
         // 4'b0111: result = rem_result;
         // 4'b1000: result = shift_left_result;
         // 4'b1001: result = shift_right_result;
         // 4'b1010: result = rotate_left_result;
         // 4'b1011: result = rotate_right_result;
         default: result = 32'b0;
      endcase
   end
endmodule
