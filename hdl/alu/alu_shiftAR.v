module shift_arithmetic_right(input signed [31:0] A,
                   input [31:0] s_num,
                   output [31:0] shiftAR_result);

    assign shiftAR_result[31:0] = shiftAR_result >>> s_num;         //shifts right n amount of times
endmodule