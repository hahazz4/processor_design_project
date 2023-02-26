module shift_right(input [31:0] a, s_num,
                  output wire [31:0] shiftR_result);

    assign shiftR_result = a >> s_num;         //shifts left n amount of times
endmodule
