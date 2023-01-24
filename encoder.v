/* Representation of an encoder in Verilog HDL. */
/* Declared 32, 1-bit inputs and 5 output select signals. */
/* Data type of each input/output is a wire. */
module encoder (input encode_IN_r0, input encode_IN_r1, input encode_IN_r2, 
input encode_IN_r3, input encode_IN_r4, input encode_IN_r5, input encode_IN_r6, 
input encode_IN_r7, input encode_IN_r8, input encode_IN_r9, input encode_IN_r10, 
input encode_IN_r11, input encode_IN_r12, input encode_IN_r13, input encode_IN_r14, 
input encode_IN_r15, input encode_IN_HI, input encode_IN_LO, input encode_IN_Z_HI, 
input encode_IN_Z_LO, input encode_IN_PC, input encode_IN_MDR, input encode_IN_inPort, 
input encode_IN_Cout, input encode_IN_24, input encode_IN_25, input encode_IN_26, 
input encode_IN_27, input encode_IN_28, input encode_IN_29, input encode_IN_30, 
input encode_IN_31, output [4:0] select_signals);

    /* While loop to update the select_signals output wire. */
    always @* begin
        if (encode_IN_31) select_signals = 5'b11111;
        else if (encode_IN_30) select_signals = 5'b11110;
        else if (encode_IN_29) select_signals = 5'b11101;
        else if (encode_IN_28) select_signals = 5'b11100;
        else if (encode_IN_27) select_signals = 5'b11011;
        else if (encode_IN_26) select_signals = 5'b11010;
        else if (encode_IN_25) select_signals = 5'b11001;
        else if (encode_IN_24) select_signals = 5'b11000;
        else if (encode_IN_Cout) select_signals = 5'b10111;
        else if (encode_IN_inPort) select_signals = 5'b10110;
        else if (encode_IN_MDR) select_signals = 5'b10101;
        else if (encode_IN_PC) select_signals = 5'b10100;
        else if (encode_IN_Z_LO) select_signals = 5'b10011;
        else if (encode_IN_Z_HI) select_signals = 5'b10010;
        else if (encode_IN_LO) select_signals = 5'b10001;
        else if (encode_IN_HI) select_signals = 5'b10000;
        else if (encode_IN_r15) select_signals = 5'b01111;
        else if (encode_IN_r14) select_signals = 5'b01110;
        else if (encode_IN_r13) select_signals = 5'b01101;
        else if (encode_IN_r12) select_signals = 5'b01100;
        else if (encode_IN_r11) select_signals = 5'b01011;
        else if (encode_IN_r10) select_signals = 5'b01010;
        else if (encode_IN_r9) select_signals = 5'b01001;
        else if (encode_IN_r8) select_signals = 5'b01000;
        else if (encode_IN_r7) select_signals = 5'b00111;
        else if (encode_IN_r6) select_signals = 5'b00110;
        else if (encode_IN_r5) select_signals = 5'b00101;
        else if (encode_IN_r4) select_signals = 5'b00100;
        else if (encode_IN_r3) select_signals = 5'b00011;
        else if (encode_IN_r2) select_signals = 5'b00010;
        else if (encode_IN_r1) select_signals = 5'b00001;
        else if (encode_IN_r0) select_signals = 5'b00000;
        else select_signals = 5'b00000;  // optional, to avoid latch.
    end
endmodule // Encoder end.