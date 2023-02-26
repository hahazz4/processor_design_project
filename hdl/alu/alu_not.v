module not_op(input [31:0] A, 
              output [31:0] not_result);
   
    wire [31:0] i;
    for(i = 0; i < 32; i = i + 1)
        not_result[i] = !A[i];
endmodule