/* Representation of the datapath in Verilog HDL. */
/* Connected outputs of encoder to select signals in multiplexer. */

module datapath(
	// CPU signals
	input wire clk, 
	input wire clr, 
	
	// Register write/enable signals
	input wire r0_enable, r1_enable, r2_enable, r3_enable, 
	input wire r4_enable, r5_enable, r6_enable, r7_enable, 
	input wire r8_enable, r9_enable, r10_enable, r11_enable, 
	input wire r12_enable, r13_enable, r14_enable, r15_enable, 
	input wire PC_enable, PC_increment_enable, IR_enable, 
	input wire Y_enable, Z_enable, 
	input wire MAR_enable, MDR_enable, 
	input wire HI_enable, LO_enable,

	// Memory Data Multiplexer Read/Select Signal
	input wire read,

	// Encoder Output Select Signals
	input wire r0_select, r1_select, r2_select, r3_select, 
	input wire r4_select, r5_select, r6_select, r7_select, 
	input wire r8_select, r9_select, r10_select, r11_select, 
	input wire r12_select, r13_select, r14_select, r15_select, 
	input wire PC_select,
	input wire HI_select, LO_select, 
	input wire Z_HI_select, Z_LO_select, 
	input wire MDR_select,
	input wire InPort_select,
	input wire c_select,
	output wire [4:0] encode_sel_signal,
	
	// ALU Opcode
	input wire [4:0] alu_instruction,

	// Input Data Signals
	input wire [31:0] MDataIN,

	// Output Data Signals
	output wire [31:0] bus_Data, // Data currently in the bus
	output wire [63:0] aluResult,
	
	output wire [31:0] R0_Data, R1_Data, R2_Data, R3_Data,
	output wire [31:0] R4_Data, R5_Data, R6_Data, R7_Data,
	output wire [31:0] R8_Data, R9_Data, R10_Data, R11_Data,
	output wire [31:0] R12_Data, R13_Data, R14_Data, R15_Data,

	output wire [31:0] PC_Data, IR_Data, PC_IncData, tempPC,
	output wire [31:0] Y_Data,
	output wire [31:0] Z_HI_Data, Z_LO_Data,
	output wire [31:0] MAR_Data, MDR_Data,
	output wire [31:0] HI_Data, LO_Data,
	output wire [31:0] InPort_Data,
	output wire [31:0] C_sign_ext_Data
);

	// General purpose registers r0-r15
	register r0 (.clk(clk), .clr(clr), .enable(r0_enable), .D(bus_Data), .Q(R0_Data)); 
	register r1 (.clk(clk), .clr(clr), .enable(r1_enable), .D(bus_Data), .Q(R1_Data)); 
	register r2 (.clk(clk), .clr(clr), .enable(r2_enable), .D(bus_Data), .Q(R2_Data));
	register r3 (.clk(clk), .clr(clr), .enable(r3_enable), .D(bus_Data), .Q(R3_Data));
	register r4 (.clk(clk), .clr(clr), .enable(r4_enable), .D(bus_Data), .Q(R4_Data));
	register r5 (.clk(clk), .clr(clr), .enable(r5_enable), .D(bus_Data), .Q(R5_Data));
	register r6 (.clk(clk), .clr(clr), .enable(r6_enable), .D(bus_Data), .Q(R6_Data));
	register r7 (.clk(clk), .clr(clr), .enable(r7_enable), .D(bus_Data), .Q(R7_Data));
	register r8 (.clk(clk), .clr(clr), .enable(r8_enable), .D(bus_Data), .Q(R8_Data));
	register r9 (.clk(clk), .clr(clr), .enable(r9_enable), .D(bus_Data), .Q(R9_Data));
	register r10 (.clk(clk), .clr(clr), .enable(r10_enable), .D(bus_Data), .Q(R10_Data));
	register r11 (.clk(clk), .clr(clr), .enable(r11_enable), .D(bus_Data), .Q(R11_Data));
	register r12 (.clk(clk), .clr(clr), .enable(r12_enable), .D(bus_Data), .Q(R12_Data));
	register r13 (.clk(clk), .clr(clr), .enable(r13_enable), .D(bus_Data), .Q(R13_Data));
	register r14 (.clk(clk), .clr(clr), .enable(r14_enable), .D(bus_Data), .Q(R14_Data));
	register r15 (.clk(clk), .clr(clr), .enable(r15_enable), .D(bus_Data), .Q(R15_Data));

	// C Output Registers
	register HI (.clk(clk), .clr(clr), .enable(HI_enable), .D(bus_Data), .Q(HI_Data));
	register LO (.clk(clk), .clr(clr), .enable(LO_enable), .D(bus_Data), .Q(LO_Data));
	register Z_HI (.clk(clk), .clr(clr), .enable(Z_enable), .D(aluResult[63:32]), .Q(Z_HI_Data));
	register Z_LO (.clk(clk), .clr(clr), .enable(Z_enable), .D(aluResult[31:0]), .Q(Z_LO_Data));
	register Y (.clk(clk), .clr(clr), .enable(Y_enable), .D(bus_Data), .Q(Y_Data));

	// PC and IR Registers
	register PC (.clk(clk), .clr(clr), .enable(PC_enable), .D(tempPC), .Q(PC_Data));
	
	pc_increment PC_Inc (.PC_Data_IN(PC_Data), .PC_Data_OUT(PC_IncData));
	
	assign tempPC = (PC_increment_enable == 1)? PC_IncData : bus_Data;
	
	register IR (.clk(clk), .clr(clr), .enable(IR_enable), .D(bus_Data), .Q(IR_Data));

	register MAR (.clk(clk), .clr(clr), .enable(MAR_enable), .D(bus_Data), .Q(MAR_Data));
	md_register MDR (.clk(clk), .clr(clr), .enable(MDR_enable), .select(read), .D1(bus_Data), .D2(MDataIN), .Q(MDR_Data));

	// Encoder Instance
    encoder encoder_instance(.encodeIN_r0(r0_select), .encodeIN_r1(r1_select), .encodeIN_r2(r2_select), 
    .encodeIN_r3(r3_select), .encodeIN_r4(r4_select), .encodeIN_r5(r5_select), .encodeIN_r6(r6_select), 
    .encodeIN_r7(r7_select), .encodeIN_r8(r8_select), .encodeIN_r9(r9_select), .encodeIN_r10(r10_select), 
    .encodeIN_r11(r11_select), .encodeIN_r12(r12_select), .encodeIN_r13(r13_select), .encodeIN_r14(r14_select), 
    .encodeIN_r15(r15_select), .encodeIN_HI(HI_select), .encodeIN_LO(LO_select), .encodeIN_Z_HI(Z_HI_select), 
    .encodeIN_Z_LO(Z_LO_select), .encodeIN_PC(PC_select), .encodeIN_MDR(MDR_select), .encodeIN_InPort(InPort_select), 
    .encodeIN_Cout(c_select), .select_signals_OUT(encode_sel_signal));

	// Output from the register is the input to the MUX
    multiplexer multiplexer_instance(.select_signals_IN(encode_sel_signal), .muxIN_r0(R0_Data), 
    .muxIN_r1(R1_Data), .muxIN_r2(R2_Data), .muxIN_r3(R3_Data), .muxIN_r4(R4_Data),
    .muxIN_r5(R5_Data), .muxIN_r6(R6_Data), .muxIN_r7(R7_Data), .muxIN_r8(R8_Data),
    .muxIN_r9(R9_Data), .muxIN_r10(R10_Data), .muxIN_r11(R11_Data), .muxIN_r12(R12_Data),
    .muxIN_r13(R13_Data), .muxIN_r14(R14_Data), .muxIN_r15(R15_Data), .muxIN_HI(HI_Data),
    .muxIN_LO(LO_Data), .muxIN_Z_HI(Z_HI_Data), .muxIN_Z_LO(Z_LO_Data), .muxIN_PC(PC_Data), 
    .muxIN_MDR(MDR_Data), .muxIN_InPort(InPort_Data), .muxIN_C_sign_ext(C_sign_ext_Data), .muxOut(bus_Data));
	 
	 alu alu_instance(.A(Y_Data), .B(bus_Data), .opcode(alu_instruction), .result(aluResult));

endmodule // Datapath end.