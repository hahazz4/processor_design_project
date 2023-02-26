module rotate_right(input [31:0] A, r_num,
                           output [31:0] rotateR_result);

    wire[31:0] t0, t1;
    alu_shiftL sl(A, (32 - r_num), t0);     //Shifts left 32 - r_num number of times
    alu_shiftL sl2(A, r_num, t1);           //Shifts right r_num number of times
    or (t1, t0, rotateL_result);            //Performs the OR operation and produces the final result
endmodule