module shift_right(input [31:0] A, s_num,
                  output [31:0] shiftR_result);

    assign shiftR_result[31:0] = shiftR_result >> s_num;         //shifts right n amount of times
endmodule