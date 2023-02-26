module shift_left(input [31:0] a, s_num,
                  output wire [31:0] shiftL_result);

    assign shiftL_result = a << s_num;         //shifts left n amount of times
endmodule
