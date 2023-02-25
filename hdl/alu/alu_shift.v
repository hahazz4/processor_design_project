module shift_left_or_right(input [31:0] A
                           input reset_n, clk, l_enable, shift_l_r,
                           output [31:0] shift_result);

always(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            q <= 32'b0;
        else if (l_enable == 1'b0)
                   
    end
endmodule