module xor_op(input [31:0] A, B, 
              output [31:0] xor_result);
   
    wire [31:0] i;
    for(i = 0; i < 32; i = i + 1)
        xor_result[i] = A[i] ^ B[i];
endmodule