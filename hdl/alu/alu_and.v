module and_op(input [31:0] A, B, 
              output [31:0] and_result);
   
    wire [31:0] i;
    for(i = 0; i < 32; i = i + 1)
        and_result[i] = A[i] & B[i];
endmodule