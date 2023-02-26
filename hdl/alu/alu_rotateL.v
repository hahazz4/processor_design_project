module rotate_left(input [31:0] a, r_num,
                   output [31:0] rotateL_result);

    wire[31:0] t0, t1;
    shift_left sl(a, r_num, t0);            //Shifts left r_num number of times
    shift_left sl2(a, (32 - r_num), t1);    //Shifts right 32 - r_num number of times
    or_op (t1, t0, rotateL_result);         //Performs the OR operation and produces the final result
endmodule
