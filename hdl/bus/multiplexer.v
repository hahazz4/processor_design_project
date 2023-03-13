/* Representation of a multiplexer in Verilog HDL. */
/* Declared 32, 32-bit inputs, 5 select signals, and  1, 32-bit output. */
/* Data type of each input/select signal is a wire and output is a reg. */

module multiplexer(input [4:0] select_signals_IN, input [31:0] muxIN_r0, 
input [31:0] muxIN_r1, input [31:0] muxIN_r2, input [31:0] muxIN_r3, 
input [31:0] muxIN_r4, input [31:0] muxIN_r5, input [31:0] muxIN_r6, 
input [31:0] muxIN_r7, input [31:0] muxIN_r8, input [31:0] muxIN_r9, 
input [31:0] muxIN_r10, input [31:0] muxIN_r11, input [31:0] muxIN_r12, 
input [31:0] muxIN_r13, input [31:0] muxIN_r14, input [31:0] muxIN_r15, 
input [31:0] muxIN_HI, input [31:0] muxIN_LO, input [31:0] muxIN_Z_HI,
input [31:0] muxIN_Z_LO, input [31:0] muxIN_PC, input [31:0] muxIN_MDR, 
input [31:0] muxIN_InPort, input [31:0] muxIN_C_sign_ext, output reg [31:0] muxOut);

    /* While loop to check for updates in the select signals, which updates the mux output. */
    always @(*) begin
            case (select_signals_IN)
                5'b00000: muxOut <= muxIN_r0[31:0];
                5'b00001: muxOut <= muxIN_r1[31:0];
                5'b00010: muxOut <= muxIN_r2[31:0];
                5'b00011: muxOut <= muxIN_r3[31:0];
                5'b00100: muxOut <= muxIN_r4[31:0];
                5'b00101: muxOut <= muxIN_r5[31:0];
                5'b00110: muxOut <= muxIN_r6[31:0];
                5'b00111: muxOut <= muxIN_r7[31:0];
                5'b01000: muxOut <= muxIN_r8[31:0];
                5'b01001: muxOut <= muxIN_r9[31:0];
                5'b01010: muxOut <= muxIN_r10[31:0];
                5'b01011: muxOut <= muxIN_r11[31:0];
                5'b01100: muxOut <= muxIN_r12[31:0];
                5'b01101: muxOut <= muxIN_r13[31:0];
                5'b01110: muxOut <= muxIN_r14[31:0];
                5'b01111: muxOut <= muxIN_r15[31:0];
                5'b10000: muxOut <= muxIN_HI[31:0];
                5'b10001: muxOut <= muxIN_LO[31:0];
                5'b10010: muxOut <= muxIN_Z_HI[31:0];
                5'b10011: muxOut <= muxIN_Z_LO[31:0];
                5'b10100: muxOut <= muxIN_PC[31:0];
                5'b10101: muxOut <= muxIN_MDR[31:0];
                5'b10110: muxOut <= muxIN_InPort[31:0];
                5'b10111: muxOut <= muxIN_C_sign_ext[31:0];
                default: muxOut <= 32'd0;
            endcase
        end
endmodule // Multiplexer end.

