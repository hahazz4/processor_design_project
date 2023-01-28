/* Representation of the datapath in Verilog HDL. */
/* Connected outputs of encoder to select signals in multiplexer. */
module datapath(input [31:0] muxIN_r0, 
input [31:0] muxIN_r1, input [31:0] muxIN_r2, input [31:0] muxIN_r3, 
input [31:0] muxIN_r4, input [31:0] muxIN_r5, input [31:0] muxIN_r6, 
input [31:0] muxIN_r7, input [31:0] muxIN_r8, input [31:0] muxIN_r9, 
input [31:0] muxIN_r10, input [31:0] muxIN_r11, input [31:0] muxIN_r12, 
input [31:0] muxIN_r13, input [31:0] muxIN_r14, input [31:0] muxIN_r15, 
input [31:0] muxIN_HI, input [31:0] muxIN_LO, input [31:0] muxIN_Z_HI,
input [31:0] muxIN_Z_LO, input [31:0] muxIN_PC, input [31:0] muxIN_MDR, 
input [31:0] muxIN_inPort, input [31:0] muxIN_C_sign_ext, input [31:0] muxIN_24,
input [31:0] muxIN_25, input [31:0] muxIN_26, input [31:0] muxIN_27, input [31:0] muxIN_28, 
input [31:0] muxIN_29, input [31:0] muxIN_30, input [31:0] muxIN_31, output reg [31:0] muxOut);

    wire [4:0] select_signals_OUT;

    //register regis()
    //eventually we can do this instead of the large input list at the top
    //creates an instance of the register module

    encoder ecode(encodeIN_r0, encodeIN_r1, encodeIN_r2, 
    encodeIN_r3, encodeIN_r4, encodeIN_r5, encodeIN_r6, 
    encodeIN_r7, encodeIN_r8, encodeIN_r9, encodeIN_r10, 
    encodeIN_r11, encodeIN_r12, encodeIN_r13, encodeIN_r14, 
    encodeIN_r15, encodeIN_HI, encodeIN_LO, encodeIN_Z_HI, 
    encodeIN_Z_LO, encodeIN_PC, encodeIN_MDR, encodeIN_inPort, 
    encodeIN_Cout, encodeIN_24, encodeIN_25, encodeIN_26, 
    encodeIN_27, encodeIN_28, encodeIN_29, encodeIN_30, 
    encodeIN_31, select_signals_OUT);

    multiplexer mux(.select_signals_IN(select_signals_OUT), .muxIN_r0(muxIN_r0), 
    .muxIN_r1(muxIN_r1), .muxIN_r2(muxIN_r2), .muxIN_r3(muxIN_r3), .muxIN_r4(muxIN_r4),
    .muxIN_r5(muxIN_r5), .muxIN_r6(muxIN_r6), .muxIN_r7(muxIN_r7), .muxIN_r8(muxIN_r8),
    .muxIN_r9(muxIN_r9), .muxIN_r10(muxIN_r10), .muxIN_r11(muxIN_r11), .muxIN_r12(muxIN_r12),
    .muxIN_r13(muxIN_r13), .muxIN_r14(muxIN_r14), .muxIN_r15(muxIN_r15), .muxIN_HI(muxIN_HI),
    .muxIN_LO(muxIN_LO), .muxIN_Z_HI(muxIN_Z_HI), .muxIN_Z_LO(muxIN_Z_LO), .muxIN_PC(muxIN_PC), 
    .muxIN_MDR(muxIN_MDR), .muxIN_inPort(muxIN_inPort), .muxIN_C_sign_ext(muxIN_C_sign_ext), 
    .muxIN_24(muxIN_24), .muxIN_25(muxIN_25), .muxIN_26(muxIN_26), .muxIN_27(muxIN_27), 
    .muxIN_28(muxIN_28), .muxIN_29(muxIN_29), .muxIN_30(muxIN_30), .muxIN_31(muxIN_31), 
    .muxOut(muxOut));
    
endmodule //Datapath end.