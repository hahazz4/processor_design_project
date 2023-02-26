/* Representation of the datapath in Verilog HDL. */
/* Connected outputs of encoder to select signals in multiplexer. */
module datapath(
	// CPU signals
	input clk, 
	input clr, 
	
	// Register enable signals
	input wire r0_enable, r1_enable, r2_enable, r3_enable, 
	input wire r4_enable, r5_enable, r6_enable, r7_enable, 
	input wire r8_enable, r9_enable, r10_enable, r11_enable, 
	input wire r12_enable, r13_enable, r14_enable, r15_enable, 
	input wire PC_enable, IR_enable, 
	input wire Y_enable, 
	input wire Z_enable, 
	input wire MAR_enable, MDR_enable, 
	input wire HI_enable, LO_enable,

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
	input wire c_select
	output wire [4:0] encode_sel_signal;
	
	// ALU Opcode
	input wire [4:0] alu_instruction;

	// Data Signals
	output wire [31:0] bus_Data, //Data current in the bus
	output wire [31:0] alu_HI_Data, alu_LO_Data, // Output of the ALU that feeds into Z_HI and Z_LO registers
	
	output wire [31:0] R0_busMuxIN, R1_busMuxIN, R2_busMuxIN, R3_busMuxIN,
	output wire [31:0] R4_busMuxIN, R5_busMuxIN, R6_busMuxIN, R7_busMuxIN,
	output wire [31:0] R8_busMuxIN, R9_busMuxIN, R10_busMuxIN, R11_busMuxIN,
	output wire [31:0] R12_busMuxIN, R13_busMuxIN, R14_busMuxIN, R15_busMuxIN,

	output wire [31:0] PC_Data, IR_Data,
	output wire [31:0] Y_Data,
	output wire [31:0] Z_HI_Data, Z_LO_Data,
	output wire [31:0] MAR_Data, MDR_Data,
	output wire [31:0] HI_Data, LO_Data,
	output wire [31:0] InPort_Data,
	output wire [31:0] C_sign_ext_Data
	input wire [31:0] MDataIN
);

	// General purpose registers r0-r15
	register r0 (.clk(clk), .clr(clr), .enable(r0_enable), .D(bus_Data), .Q(R0_busMuxIN)); 
	register r1 (.clk(clk), .clr(clr), .enable(r1_enable), .D(bus_Data), .Q(R1_busMuxIN)); 
	register r2 (.clk(clk), .clr(clr), .enable(r2_enable), .D(bus_Data), .Q(R2_busMuxIN));
	register r3 (.clk(clk), .clr(clr), .enable(r3_enable), .D(bus_Data), .Q(R3_busMuxIN));
	register r4 (.clk(clk), .clr(clr), .enable(r4_enable), .D(bus_Data), .Q(R4_busMuxIN));
	register r5 (.clk(clk), .clr(clr), .enable(r5_enable), .D(bus_Data), .Q(R5_busMuxIN));
	register r6 (.clk(clk), .clr(clr), .enable(r6_enable), .D(bus_Data), .Q(R6_busMuxIN));
	register r7 (.clk(clk), .clr(clr), .enable(r7_enable), .D(bus_Data), .Q(R7_busMuxIN));
	register r8 (.clk(clk), .clr(clr), .enable(r8_enable), .D(bus_Data), .Q(R8_busMuxIN));
	register r9 (.clk(clk), .clr(clr), .enable(r9_enable), .D(bus_Data), .Q(R9_busMuxIN));
	register r10 (.clk(clk), .clr(clr), .enable(r10_enable), .D(bus_Data), .Q(R10_busMuxIN));
	register r11 (.clk(clk), .clr(clr), .enable(r11_enable), .D(bus_Data), .Q(R11_busMuxIN));
	register r12 (.clk(clk), .clr(clr), .enable(r12_enable), .D(bus_Data), .Q(R12_busMuxIN));
	register r13 (.clk(clk), .clr(clr), .enable(r13_enable), .D(bus_Data), .Q(R13_busMuxIN));
	register r14 (.clk(clk), .clr(clr), .enable(r14_enable), .D(bus_Data), .Q(R14_busMuxIN));
	register r15 (.clk(clk), .clr(clr), .enable(r15_enable), .D(bus_Data), .Q(R15_busMuxIN));

	// C Output Registers
	register HI (.clk(clk), .clr(clr), .enable(HI_enable), .D(bus_Data), .Q(HI_busMuxIN));
	register LO (.clk(clk), .clr(clr), .enable(LO_enable), .D(bus_Data), .Q(LO_busMuxIN));
	register Z_HI (.clk(clk), .clr(clr), .enable(Z_enable), .D(C_out_HI), .Q(Z_HI_busMuxIN));
	register Z_LO (.clk(clk), .clr(clr), .enable(Z_enable), .D(C_out_LO), .Q(Z_LO_busMuxIN));
	register Y (.clk(clk), .clr(clr), .enable(Y_enable), .D(bus_Data), .Q(Y_busMuxIN));

	// PC and IR Registers
	register PC (.clk(clk), .clr(clr), .enable(PC_enable), .D(bus_Data), .Q(PC_busMuxIN));
	register IR (.clk(clk), .clr(clr), .enable(IR_enable), .D(bus_Data), .Q(IR_busMuxIN));

	memory_data_register MDR (.clk(clk), .clr(clr), .enable(MDR_enable), .D1(bus_Data), .D2(MDataIN), .sel(MDR_select), .Q(MDR_busMuxIN));

	// Encoder Instance
    encoder encoder_instance(.encodeIN_r0(r0_select), .encodeIN_r1(r1_select), .encodeIN_r2(r2_select), 
    .encodeIN_r3(r3_select), .encodeIN_r4(r4_select), .encodeIN_r5(r5_select), .encodeIN_r6(r6_select), 
    .encodeIN_r7(r7_select), .encodeIN_r8(r8_select), .encodeIN_r9(r9_select), .encodeIN_r10(r10_select), 
    .encodeIN_r11(r11_select), .encodeIN_r12(r12_select), .encodeIN_r13(r13_select), .encodeIN_r14(r14_select), 
    .encodeIN_r15(r15_select), .encodeIN_HI(HI_select), .encodeIN_LO(LO_select), .encodeIN_Z_HI(Z_HI_select), 
    .encodeIN_Z_LO(Z_LO_select), .encodeIN_PC(PC_select), .encodeIN_MDR(MDR_select), .encodeIN_InPort(InPort_select), 
    .encodeIN_Cout(c_select), .select_signals_OUT(encode_sel_signal));

	// Output from the register is the input to the MUX
    multiplexer multiplexer_instance(.select_signals_IN(encode_sel_signal), .muxIN_r0(R0_busMuxIN), 
    .muxIN_r1(R1_busMuxIN), .muxIN_r2(R2_busMuxIN), .muxIN_r3(R3_busMuxIN), .muxIN_r4(R4_busMuxIN),
    .muxIN_r5(R5_busMuxIN), .muxIN_r6(R6_busMuxIN), .muxIN_r7(R7_busMuxIN), .muxIN_r8(R8_busMuxIN),
    .muxIN_r9(R9_busMuxIN), .muxIN_r10(R10_busMuxIN), .muxIN_r11(R11_busMuxIN), .muxIN_r12(R12_busMuxIN),
    .muxIN_r13(R13_busMuxIN), .muxIN_r14(R14_busMuxIN), .muxIN_r15(R15_busMuxIN), .muxIN_HI(HI_busMuxIN),
    .muxIN_LO(LO_busMuxIN), .muxIN_Z_HI(Z_HI_busMuxIN), .muxIN_Z_LO(Z_LO_busMuxIN), .muxIN_PC(PC_busMuxIN), 
    .muxIN_MDR(MDR_busMuxIN), .muxIN_InPort(InPort_Data), .muxIN_C_sign_ext(C_sign_ext_Data), .muxOut(bus_Data));
    
endmodule //Datapath end.