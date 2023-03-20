/* This module determines whether the correct condition has been met to cause branching to take place in a conditional branch instruction. */
module CON_FF(
    input [31:0] bus_in, ir, 
    input con_in_signal,
    output con_out
);                                                

    wire [3:0] decoder_out;
    wire eq, not_eq, pos, neg, branch_flag;
    
    always @(*)
    begin
        case((ir[1:0]))                                                 //2 to 4 decoder
            2'b00 : begin
                decoder_out = 4'b0001;
            end

            2'b01 : begin
                decoder_out = 4'b0010;
            end

            2'b10 : begin
                decoder_out = 4'b0100;
            end

            2'b11 : begin
                decoder_out = 4'b1000;
            end
        endcase
    end
    
    assign eq = (bus_in == 32'd0) ? 1'b1 : 1'b0;
    assign not_eq = (bus_in != 32'd0) ? 1'b1 : 1'b0;
    assign pos = (bus_in[31] == 0) ? 1'b1 : 1'b0;
    assign neg = (bus_in[31] == 1) ? 1'b1 : 1'b0;
    
    assign branch_flag = (decoder_out[0] and eq or decoder_out[1] and not_eq or decoder_out[2] and pos or decoder_out[3] and neg);                                             //Assigning the value of con_D to the output wire con_out.
    flip_flop_logic ffl(.clk(con_in_signal), .d(branch_flag), .q(con_out));
endmodule
