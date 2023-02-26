module shift_arithmetic_right(input [31:0] a, s_num,
                  output wire [31:0] shiftAR_result);

    assign shiftAR_result = a >>> s_num;         //shifts left n amount of times
endmodule
