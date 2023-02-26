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

    wire [31:0] R0_busin, R1_busin, R2_busin, R3_busin, R4_busin, R5_busin, R6_busin, R7_busin, 
                R8_busin, R9_busin, R10_busin, R11_busin, R12_busin, R13_busin, R14_busin, R15_busin, 
                MDR_busin;
    
    wire [4:0] select_signals_OUT;

	// General purpose registers r0-r15
	register r0 (clk, clr, enableReg[0], muxBusOut, R0_busIN); 
	register r1 (clk, clr, enableReg[1], muxBusOut, R1_busIN); 
	register r2 (clk, clr, enableReg[2], muxBusOut, R2_busIN);
	register r3 (clk, clr, enableReg[3], muxBusOut, R3_busIN);
	register r4 (clk, clr, enableReg[4], muxBusOut, R4_busIN);
	register r5 (clk, clr, enableReg[5], muxBusOut, R5_busIN);
	register r6 (clk, clr, enableReg[6], muxBusOut, R6_busIN);
	register r7 (clk, clr, enableReg[7], muxBusOut, R7_busIN);
	register r8 (clk, clr, enableReg[8], muxBusOut, R8_busIN);
	register r9 (clk, clr, enableReg[9], muxBusOut, R9_busIN);
	register r10 (clk, clr, enableReg[10], muxBusOut, R10_busIN);
	register r11 (clk, clr, enableReg[11], muxBusOut, R11_busIN);
	register r12 (clk, clr, enableReg[12], muxBusOut, R12_busIN);
	register r13 (clk, clr, enableReg[13], muxBusOut, R13_busIN);
	register r14 (clk, clr, enableReg[14], muxBusOut, R14_busIN);
	register r15 (clk, clr, enableReg[15], muxBusOut, R15_busIN);

	// Other
	register HI (clk, clr, HIin, muxBusOut, HI_busIN);
	register LO (clk, clr, LOin, muxBusOut, LO_busIN);
	register Z_HI (clk, clr, Zhighin, C_out_HI, Z_HI_busIN);
	register Z_LO (clk, clr, Zlowin, C_out_LO, Z_LO_busIN);
	register PC (clk, clr, PCin, muxBusOut, PC_busIN);
	register Y (clk, clr, Yin, muxBusOut, Y_busIN);


	// IR will be used for select and encode logic in phase 2
	//register IR (clk, clr, IRin, muxBusOut, IR_busIN);
	memory_data_register MDR (clk, clr, MDRin, Read, MDatain, muxBusOut, MDR_busIN);

    encoder encoder_instance(encodeIN_r0, encodeIN_r1, encodeIN_r2, 
    encodeIN_r3, encodeIN_r4, encodeIN_r5, encodeIN_r6, 
    encodeIN_r7, encodeIN_r8, encodeIN_r9, encodeIN_r10, 
    encodeIN_r11, encodeIN_r12, encodeIN_r13, encodeIN_r14, 
    encodeIN_r15, encodeIN_HI, encodeIN_LO, encodeIN_Z_HI, 
    encodeIN_Z_LO, encodeIN_PC, encodeIN_MDR, encodeIN_inPort, 
    encodeIN_Cout, encodeIN_24, encodeIN_25, encodeIN_26, 
    encodeIN_27, encodeIN_28, encodeIN_29, encodeIN_30, 
    encodeIN_31, select_signals_OUT);

    multiplexer multiplexer_instance(.select_signals_IN(select_signals_OUT), .muxIN_r0(muxIN_r0), 
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