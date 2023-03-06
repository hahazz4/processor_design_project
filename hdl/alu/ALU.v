module alu (
	// ALU Inputs
	input wire [31:0] A, B, 
   input wire [4:0] opcode,

	// ALU Output
	output reg [63:0] result); 
   
   parameter and_op = 5'b00101, or_op = 5'b00110, addition_op = 5'b00011, 
   subtraction_op = 5'b00100, multiplication_op = 5'b01111, division_op = 5'b10000, 
   left_shift_op = 5'b01001, right_shift_op = 5'b00111, arith_shift_right_op = 5'b01000, 
   left_rotate_op = 5'b01011, right_rotate_op = 5'b01010, negate_op = 5'b10001, not_op = 5'b10010

	// And Operation
   wire [31:0] and_result;
	and andInstance(A, B, and_result);
	
	// Or Operation
   wire [31:0] or_result;
	or orInstance(A, B, or_result);
	
	// Add Operation
   wire [31:0] sum_result; 
   wire carryOut;
	adder adderInstance(A, B, sum_result, carryOut);
	
	// Subtractor Operation
   wire [31:0] difference_result;
   wire borrowOut;
	subtractor subtractorInstance(A, B, difference_result, borrowOut);
   
   // Multiplication Operation
   wire [63:0] product_result;
   multiplier multiplierInstance(A, B, product_result);

	// Division Operation
   wire [31:0] quotient_result, remainder_result;
	divider dividerInstance(A, B, quotient_result, remainder_result);
   
   // Left Shift Operation
   wire [31:0] leftShift_result;
   shift_left leftShiftInstance(A, B, leftShift_result);
   
   // Right Shift Operation
   wire [31:0] rightShift_result;
   shift_right rightShiftInstance(A, B, rightShift_result);

   // Arithmetic Right Shift Operation
   wire [31:0] arithShiftRight_result;
   arithmetic_shift_right arithShiftRightInstance(A, B, arithShiftRight_result);

   // Left Rotate Operation
   wire [31:0] leftRotate_result;
   rotate_left leftRotateInstance(A, B, leftRotate_result);

   // Right Rotate Operation
   wire [31:0] rightRotate_result;
   rotate_right rightRotateInstance(A, B, rightRotate_result);

   // Negate Operation
   wire [31:0] negate_result;
   negate negateInstance(A, negate_result);

   // Not Operation
   wire [31:0] not_result;
   not notInstance(A, not_result);

   // Select operation
   always @(*) begin
      case(opcode)
         // And Operation
         and_op : begin
            result[31:0] <= and_result[31:0];
            result[63:32] <= 32'd0;
         
         // Or Operation
         or_op	: begin
            result[31:0] <= or_result[31:0];
            result[63:32] <= 32'd0;

         // Add Operation
         addition_op	: begin
            result[31:0] <= sum_result[31:0];
            result[63:32] <= 32'd0;

         // Subtract Operation
         subtraction_op	: begin
            result[31:0] <= difference_result[31:0];
            result[63:32] <= 32'd0;
         
         // Multiply Operation
         multiplication_op	: begin
            result[63:0] <= product_result[63:0];

         // Divide Operation
         division_op	: begin
            result[31:0] <= quotient_result[31:0];
            result[63:0] <= remainder_result[63:0];

         // Left Shift Operation
         left_shift_op : begin
            result[31:0] <= leftShift_result[31:0];
            result[63:32] <= 32'd0;

         // Right Shift Operation
         right_shift_op	: begin
            result[31:0] <= rightShift_result[31:0];
            result[63:32] <= 32'd0;

         // Arithmetic Right Shift Operation
         arith_shift_right_op	: begin
            result[31:0] <= arithShiftRight_result[31:0];
            result[63:32] <= 32'd0;

         // Left Rotate Operation
         left_rotate_op	: begin
            result[31:0] <= leftRotate_result[31:0];
            result[63:32] <= 32'd0;

         // Right Rotate Operation
         right_rotate_op : begin
            result[31:0] <= rightRotate_result[31:0];
            result[63:32] <= 32'd0;

         // Negate Operation
         negate_op : begin
            result[31:0] <= negate_result[31:0];
            result[63:32] <= 32'd0;

         // Not Operation
         not_op : begin
            result[31:0] <= not_result[31:0];
            result[63:32] <= 32'd0;

         // Default Case
         default: result = 32'b0;
      endcase
   end
endmodule