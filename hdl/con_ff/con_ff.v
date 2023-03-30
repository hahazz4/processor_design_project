/* This module determines whether the correct condition has been met to cause branching to take place in a conditional branch instruction. */
module con_ff(
    // Bus Input
    input [31:0] bus_Data,

    // Instruction Register Input
    input [31:0] instruction,

    // Enable Signal for the CON Flip Flop
    input con_enable,

    // Q Output Signal from the CON Flip Flop
    output con_output);                                                

    // Branch Conditions
    wire equal, notEqual, positive, negative;
    
    // Flip Flop D Input
    wire branchFlag;
	 
	// Flip Flop Reset Signal
	wire FFreset;

    // 2-to-4 Decoder Output
    wire [3:0] decoder_out;
    
    // Branch Condition Logic
    assign equal = (bus_Data == 32'd0) ? 1'b1 : 1'b0;
    assign notEqual = (bus_Data != 32'd0) ? 1'b1 : 1'b0;
    assign positive = (bus_Data[31] == 0) ? 1'b1 : 1'b0;
    assign negative = (bus_Data[31] == 1) ? 1'b1 : 1'b0;
    
    // 2-to-4 CON FF Decoder
    con_decoder conDecoder(.decoder_input(instruction[20:19]), .decoder_output(decoder_out));

    // Branch Flag and Flip Flip
    assign branchFlag = ((decoder_out[0] & equal) | (decoder_out[1] & notEqual) | (decoder_out[2] & positive) | (decoder_out[3] & negative));                                             //Assigning the value of con_D to the output wire con_out.
    flip_flop flipFlopInstance(.clk(con_enable), .reset(FFreset), .D(branchFlag), .Q(con_output));

endmodule