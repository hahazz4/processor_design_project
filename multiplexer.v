/* Representation of a multiplexer in Verilog HDL */
/* Declared 32, 32-bit inputs, 5 select signals, and  1, 32-bit output */
/* Data type of each input/select signal is a wire and output is a reg */

module multiplexer(input wire [4:0] select_signals, input wire [31:0] muxIN_r0; 
input wire [31:0] muxIN_r1; input wire [31:0] muxIN_r2; input wire [31:0] muxIN_r3; 
input wire [31:0] muxIN_r4; input wire [31:0] muxIN_r5; input wire [31:0] muxIN_r6; 
input wire [31:0] muxIN_r7; input wire [31:0] muxIN_r8; input wire [31:0] muxIN_r9; 
input wire [31:0] muxIN_r10; input wire [31:0] muxIN_r11; input wire [31:0] muxIN_r12; 
input wire [31:0] muxIN_r13; input wire [31:0] muxIN_r14; input wire [31:0] muxIN_r15; 
input wire [31:0] muxIN_HI; input wire [31:0] muxIN_LO; input wire [31:0] muxIN_Z_HI;
input wire [31:0] muxIN_Z_LO; input wire [31:0] muxIN_PC; input wire [31:0] muxIN_MDR; 
input wire [31:0] muxIN_inPort; input wire [31:0] C_sign_extended; input wire [31:0] in_24;
input wire [31:0] in_25; input wire [31:0] in_26; input wire [31:0] in_27; input wire [31:0] in_28; 
input wire [31:0] in_29; input wire [31:0] in_30; input wire [31:0] in_31; output reg [31:0] muxOut;);

always @* begin
        case (select_signals)
            5'b00000: muxOut = muxIN_r0;
            5'b00001: muxOut = muxIN_r1;
            5'b00010: muxOut = muxIN_r2;
            5'b00011: muxOut = muxIN_r3;
            5'b00100: muxOut = muxIN_r4;
            5'b00101: muxOut = muxIN_r5;
            5'b00110: muxOut = muxIN_r6;
            5'b00111: muxOut = muxIN_r7;
            5'b01000: muxOut = muxIN_r8;
            5'b01001: muxOut = muxIN_r9;
            5'b01010: muxOut = muxIN_r10;
            5'b01011: muxOut = muxIN_r11;
            5'b01100: muxOut = muxIN_r12;
            5'b01101: muxOut = muxIN_r13;
            5'b01110: muxOut = muxIN_r14;
            5'b01111: muxOut = muxIN_r15;
            5'b10000: muxOut = muxIN_HI;
            5'b10001: muxOut = muxIN_LO;
            5'b10010: muxOut = muxIN_Z_HI;
            5'b10011: muxOut = muxIN_Z_LO;
            5'b10100: muxOut = muxIN_PC;
            5'b10101: muxOut = muxIN_MDR;
            5'b10110: muxOut = muxIN_inPort;
            5'b10111: muxOut = C_sign_extended;
            5'b11000: muxOut = in_24;
            5'b11001: muxOut = in_25;
            5'b11010: muxOut = in_26;
            5'b11011: muxOut = in_27;
            5'b11100: muxOut = in_28;
            5'b11101: muxOut = in_29;
            5'b11110: muxOut = in_30;
            5'b11111: muxOut = in_31;
        endcase
    end
            
endmodule // Multiplexer end.

