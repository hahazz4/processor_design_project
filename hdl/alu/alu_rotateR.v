module rotate_right(input [31:0] a, r_num,
                    output [31:0] rotateR_result);

    wire[31:0] t0, t1;
    shift_right sl(a, (32 - r_num), t0);     //Shifts left 32 - r_num number of times
    shift_right sl2(a, r_num, t1);           //Shifts right r_num number of times
    or_op r1(t1, t0, rotateR_result);       //Performs the OR operation and produces the final result
endmodule
