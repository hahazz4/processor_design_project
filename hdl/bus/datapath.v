/* Representation of the datapath in Verilog HDL. */
/* Connected outputs of encoder to select signals in multiplexer. */
module datapath(
	// CPU signals
	input wire clk, 
	input wire clr, 
	
	// Register write/enable signals
	input wire PC_enable, PC_increment_enable, IR_enable,
	input wire con_enable, 
	input wire Y_enable, Z_enable, 
	input wire MAR_enable, MDR_enable, 
	input wire HI_enable, LO_enable,

	// Memory Data Multiplexer Read/Select Signal
	input wire read, write,

	// Select and Encode Logic Inputs
	input wire Gra, Grb, Grc, r_enable, r_select, BAout,

	// CON FF Module
	input wire con_output,

	// Encoder Output Select Signals
	input wire PC_select,
	input wire HI_select, LO_select, 
	input wire Z_HI_select, Z_LO_select, 
	input wire MDR_select,
	input wire InPort_select,
	input wire c_select,
	output wire [4:0] encode_sel_signal,
	
	// ALU Opcode
	input wire [4:0] alu_instruction,

	// Output Data Signals
	output wire [15:0] register_enable,
	output wire [31:0] bus_Data, // Data currently in the bus
	output wire [63:0] aluResult,
	
	output wire [31:0] R0_Data, R1_Data, R2_Data, R3_Data,
	output wire [31:0] R4_Data, R5_Data, R6_Data, R7_Data,
	output wire [31:0] R8_Data, R9_Data, R10_Data, R11_Data,
	output wire [31:0] R12_Data, R13_Data, R14_Data, R15_Data,

	output wire [31:0] PC_Data, IR_Data,
	output wire [31:0] Y_Data,
	output wire [31:0] Z_HI_Data, Z_LO_Data,
	output wire [8:0] MAR_Data,
	output wire [31:0] MDR_Data,
	output wire [31:0] HI_Data, LO_Data,
	output wire [31:0] InPort_Data,
	output wire [31:0] C_sign_ext_Data);

	wire [31:0] MDataIN;
	//wire [15:0] register_enable, 
	wire [15:0] register_select;

	// General purpose registers r0-r15
	R0_revised r0 (.clk(clk), .clr(clr), .enable(register_enable[0]), .BAout(BAout), .bus_Data(bus_Data), .R0_Data(R0_Data)); 
	register r1 (.clk(clk), .clr(clr), .enable(register_enable[1]), .D(bus_Data), .Q(R1_Data)); 
	register r2 (.clk(clk), .clr(clr), .enable(register_enable[2]), .D(bus_Data), .Q(R2_Data));
	register r3 (.clk(clk), .clr(clr), .enable(register_enable[3]), .D(bus_Data), .Q(R3_Data));
	register r4 (.clk(clk), .clr(clr), .enable(register_enable[4]), .D(bus_Data), .Q(R4_Data));
	register r5 (.clk(clk), .clr(clr), .enable(register_enable[5]), .D(bus_Data), .Q(R5_Data));
	register r6 (.clk(clk), .clr(clr), .enable(register_enable[6]), .D(bus_Data), .Q(R6_Data));
	register r7 (.clk(clk), .clr(clr), .enable(register_enable[7]), .D(bus_Data), .Q(R7_Data));
	register r8 (.clk(clk), .clr(clr), .enable(register_enable[8]), .D(bus_Data), .Q(R8_Data));
	register r9 (.clk(clk), .clr(clr), .enable(register_enable[9]), .D(bus_Data), .Q(R9_Data));
	register r10 (.clk(clk), .clr(clr), .enable(register_enable[10]), .D(bus_Data), .Q(R10_Data));
	register r11 (.clk(clk), .clr(clr), .enable(register_enable[11]), .D(bus_Data), .Q(R11_Data));
	register r12 (.clk(clk), .clr(clr), .enable(register_enable[12]), .D(bus_Data), .Q(R12_Data));
	register r13 (.clk(clk), .clr(clr), .enable(register_enable[13]), .D(bus_Data), .Q(R13_Data));
	register r14 (.clk(clk), .clr(clr), .enable(register_enable[14]), .D(bus_Data), .Q(R14_Data));
	register r15 (.clk(clk), .clr(clr), .enable(register_enable[15]), .D(bus_Data), .Q(R15_Data));

	// C Output Registers
	register HI (.clk(clk), .clr(clr), .enable(HI_enable), .D(bus_Data), .Q(HI_Data));
	register LO (.clk(clk), .clr(clr), .enable(LO_enable), .D(bus_Data), .Q(LO_Data));
	register Z_HI (.clk(clk), .clr(clr), .enable(Z_enable), .D(aluResult[63:32]), .Q(Z_HI_Data));
	register Z_LO (.clk(clk), .clr(clr), .enable(Z_enable), .D(aluResult[31:0]), .Q(Z_LO_Data));
	register Y (.clk(clk), .clr(clr), .enable(Y_enable), .D(bus_Data), .Q(Y_Data));

	// PC and IR Registers
	program_counter PC (.clk(clk), .clr(clr), .enable(PC_enable), .incPC(PC_increment_enable), .PC_Input(bus_Data), .PC_Output(PC_Data));
	register IR (.clk(clk), .clr(clr), .enable(IR_enable), .D(bus_Data), .Q(IR_Data));

	// Memory Registers	
	register MAR (.clk(clk), .clr(clr), .enable(MAR_enable), .D(bus_Data[8:0]), .Q(MAR_Data[8:0]));
	md_register MDR (.clk(clk), .clr(clr), .enable(MDR_enable), .read(read), .MDataIN(MDataIN), .bus_Data(bus_Data), .Q(MDR_Data));

	// Encoder Instance
    encoder encoder_instance(.encodeIN_r0(register_select[0]), .encodeIN_r1(register_select[1]), .encodeIN_r2(register_select[2]), 
    .encodeIN_r3(register_select[3]), .encodeIN_r4(register_select[4]), .encodeIN_r5(register_select[5]), .encodeIN_r6(register_select[6]), 
    .encodeIN_r7(register_select[7]), .encodeIN_r8(register_select[8]), .encodeIN_r9(register_select[9]), .encodeIN_r10(register_select[10]), 
    .encodeIN_r11(register_select[11]), .encodeIN_r12(register_select[12]), .encodeIN_r13(register_select[13]), .encodeIN_r14(register_select[14]), 
    .encodeIN_r15(register_select[15]), .encodeIN_HI(HI_select), .encodeIN_LO(LO_select), .encodeIN_Z_HI(Z_HI_select), 
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

	ram ramInstance(.clk(clk), .read(read), .write(write), .data_in(MDR_Data), .address_in(MAR_Data), .data_out(MDataIN));

	select_encode_logic selInstance(.instruction(IR_Data), .Gra(Gra), .Grb(Grb), .Grc(Grc), .r_enable(r_enable), .r_select(r_select), 
	.BAout(BAout), .register_enable(register_enable), .register_select(register_select), .C_sign_ext_Data(C_sign_ext_Data));

	con_ff conInstance(.bus_Data(bus_Data), .instruction(IR_Data), .con_enable(con_enable), .con_output(con_output));
	
endmodule // Datapath end.