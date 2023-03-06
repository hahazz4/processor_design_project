/* Representation of an encoder in Verilog HDL. */
/* Declared 32, 1-bit inputs and 5 output select signals. */
/* Data type of each input/output is a wire. */
module encoder(input encodeIN_r0, input encodeIN_r1, input encodeIN_r2, 
input encodeIN_r3, input encodeIN_r4, input encodeIN_r5, input encodeIN_r6, 
input encodeIN_r7, input encodeIN_r8, input encodeIN_r9, input encodeIN_r10, 
input encodeIN_r11, input encodeIN_r12, input encodeIN_r13, input encodeIN_r14, 
input encodeIN_r15, input encodeIN_HI, input encodeIN_LO, input encodeIN_Z_HI, 
input encodeIN_Z_LO, input encodeIN_PC, input encodeIN_MDR, input encodeIN_InPort, 
input encodeIN_Cout, output reg [4:0] select_signals_OUT);

    /* While loop to update the select_signals_OUT output wire. */
    always @* begin
        if (encodeIN_Cout) select_signals_OUT <= 5'b10111;
        else if (encodeIN_InPort) select_signals_OUT <= 5'b10110;
        else if (encodeIN_MDR) select_signals_OUT <= 5'b10101;
        else if (encodeIN_PC) select_signals_OUT <= 5'b10100;
        else if (encodeIN_Z_LO) select_signals_OUT <= 5'b10011;
        else if (encodeIN_Z_HI) select_signals_OUT <= 5'b10010;
        else if (encodeIN_LO) select_signals_OUT <= 5'b10001;
        else if (encodeIN_HI) select_signals_OUT <= 5'b10000;
        else if (encodeIN_r15) select_signals_OUT <= 5'b01111;
        else if (encodeIN_r14) select_signals_OUT <= 5'b01110;
        else if (encodeIN_r13) select_signals_OUT <= 5'b01101;
        else if (encodeIN_r12) select_signals_OUT <= 5'b01100;
        else if (encodeIN_r11) select_signals_OUT <= 5'b01011;
        else if (encodeIN_r10) select_signals_OUT <= 5'b01010;
        else if (encodeIN_r9) select_signals_OUT <= 5'b01001;
        else if (encodeIN_r8) select_signals_OUT <= 5'b01000;
        else if (encodeIN_r7) select_signals_OUT <= 5'b00111;
        else if (encodeIN_r6) select_signals_OUT <= 5'b00110;
        else if (encodeIN_r5) select_signals_OUT <= 5'b00101;
        else if (encodeIN_r4) select_signals_OUT <= 5'b00100;
        else if (encodeIN_r3) select_signals_OUT <= 5'b00011;
        else if (encodeIN_r2) select_signals_OUT <= 5'b00010;
        else if (encodeIN_r1) select_signals_OUT <= 5'b00001;
        else if (encodeIN_r0) select_signals_OUT <= 5'b00000;
        else select_signals_OUT <= 5'b00000;  // optional, to avoid latch.
    end
endmodule // Encoder end.