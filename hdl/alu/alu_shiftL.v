module shift_left(input [31:0] A, s_num,
                  output [31:0] shiftL_result);

    assign shiftL_result[31:0] = shiftL_result << s_num;         //shifts left n amount of times
endmodule