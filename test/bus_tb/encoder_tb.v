`timescale 1ns / 1ps

// Include encoder module definition
`include "hdl\bus\bus_encoder.v"

module encoder_tb;

    // Inputs
    reg encodeIN_r0, encodeIN_r1, encodeIN_r2, encodeIN_r3, encodeIN_r4, 
        encodeIN_r5, encodeIN_r6, encodeIN_r7, encodeIN_r8, encodeIN_r9, 
        encodeIN_r10, encodeIN_r11, encodeIN_r12, encodeIN_r13, encodeIN_r14, 
        encodeIN_r15, encodeIN_HI, encodeIN_LO, encodeIN_Z_HI, encodeIN_Z_LO, 
        encodeIN_PC, encodeIN_MDR, encodeIN_inPort, encodeIN_Cout, encodeIN_24, 
        encodeIN_25, encodeIN_26, encodeIN_27, encodeIN_28, encodeIN_29, 
        encodeIN_30, encodeIN_31;

    // Outputs
    wire [4:0] select_signals_OUT;

    // Instantiate the encoder module
    encoder encoder_inst (
        .encodeIN_r0(encodeIN_r0),
        .encodeIN_r1(encodeIN_r1),
        .encodeIN_r2(encodeIN_r2),
        .encodeIN_r3(encodeIN_r3),
        .encodeIN_r4(encodeIN_r4),
        .encodeIN_r5(encodeIN_r5),
        .encodeIN_r6(encodeIN_r6),
        .encodeIN_r7(encodeIN_r7),
        .encodeIN_r8(encodeIN_r8),
        .encodeIN_r9(encodeIN_r9),
        .encodeIN_r10(encodeIN_r10),
        .encodeIN_r11(encodeIN_r11),
        .encodeIN_r12(encodeIN_r12),
        .encodeIN_r13(encodeIN_r13),
        .encodeIN_r14(encodeIN_r14),
        .encodeIN_r15(encodeIN_r15),
        .encodeIN_HI(encodeIN_HI),
        .encodeIN_LO(encodeIN_LO),
        .encodeIN_Z_HI(encodeIN_Z_HI),
        .encodeIN_Z_LO(encodeIN_Z_LO),
        .encodeIN_PC(encodeIN_PC),
        .encodeIN_MDR(encodeIN_MDR),
        .encodeIN_inPort(encodeIN_inPort),
        .encodeIN_Cout(encodeIN_Cout),
        .encodeIN_24(encodeIN_24),
        .encodeIN_25(encodeIN_25),
        .encodeIN_26(encodeIN_26),
        .encodeIN_27(encodeIN_27),
        .encodeIN_28(encodeIN_28),
        .encodeIN_29(encodeIN_29),
        .encodeIN_30(encodeIN_30),
        .encodeIN_31(encodeIN_31),
        .select_signals_OUT(select_signals_OUT)
    );

    // Clock
    reg clk;
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Clear
    reg clr;
    initial clr = 1;
    
    // Enable
    reg enable;
    initial enable = 1;
    
    // Test all input combinations
    integer i;
    initial begin
        for (i = 0; i < 32'hFFFFFFFF; i = i + 1) begin
            encodeIN = i;
            #10;
        end
        $finish;
    end
  
endmodule