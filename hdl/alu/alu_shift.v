module shift_left_or_right(input [31:0] A
                           input reset_n, clk, l_enable, shift_l_r,
                           output [31:0] shift_result);

always(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            shift_result <= 32'b0;
        
        else if (l_enable == 1'b0)                                  //the load reg
            shift_result <= A;
        
        else begin                                                        //commencing the shift reg
            if(shift_l_r == 1'b0)
                shift_result <= {shift_result[30:0], 1'b0};         //shift left
            else
                shift_result <= {1'b0, shift_result[31:1]};         //shift right
        end
    end
endmodule