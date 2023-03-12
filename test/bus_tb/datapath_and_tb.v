
`timescale 1ns/10ps
module datapath_and_tb;
	// CPU signals
	reg clk; 
	reg clr; 
	
	// Register write/enable signals
	reg r0_enable, r1_enable, r2_enable, r3_enable; 
	reg r4_enable, r5_enable, r6_enable, r7_enable; 
	reg r8_enable, r9_enable, r10_enable, r11_enable; 
	reg r12_enable, r13_enable, r14_enable, r15_enable; 
	reg PC_enable, PC_increment_enable, IR_enable; 
	reg Y_enable, Z_enable; 
	reg MAR_enable, MDR_enable; 
	reg HI_enable, LO_enable;

	// Memory Data Multiplexer Read/Select Signal
	reg read;

	// Encoder Output Select Signals
	reg r0_select, r1_select, r2_select, r3_select; 
	reg r4_select, r5_select, r6_select, r7_select; 
	reg r8_select, r9_select, r10_select, r11_select;
	reg r12_select, r13_select, r14_select, r15_select;
	reg PC_select;
	reg HI_select, LO_select; 
	reg Z_HI_select, Z_LO_select;
	reg MDR_select;
	reg InPort_select;
	reg c_select;
	wire [4:0] encode_sel_signal;
	
	// ALU Opcode
	reg [4:0] alu_instruction;

	// Input Data Signals
	reg [31:0] MDataIN;

	// Output Data Signals
	wire [31:0] bus_Data; // Data currently in the bus
	wire [63:0] aluResult;
	
	wire [31:0] R0_Data, R1_Data, R2_Data, R3_Data;
	wire [31:0] R4_Data, R5_Data, R6_Data, R7_Data;
	wire [31:0] R8_Data, R9_Data, R10_Data, R11_Data;
	wire [31:0] R12_Data, R13_Data, R14_Data, R15_Data;

	wire [31:0] PC_Data, IR_Data, PC_IncData, tempPC;
	wire [31:0] Y_Data;
	wire [31:0] Z_HI_Data, Z_LO_Data;
	wire [31:0] MAR_Data, MDR_Data;
	wire [31:0] HI_Data, LO_Data;
	wire [31:0] InPort_Data;
	wire [31:0] C_sign_ext_Data;

	// Time Signals and Load Registers
	parameter Default = 4'b0000, 
	Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, 
	Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, 
	Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, 
	T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, 
	T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
 
	reg [3:0] Present_state = Default;

	datapath datapathAND(	// CPU signals
	.clk(clk), 
	.clr(clr), 
	
	// Register write/enable signals
	.r0_enable(r0_enable), .r1_enable(r1_enable), .r2_enable(r2_enable), .r3_enable(r3_enable), 
	.r4_enable(r4_enable), .r5_enable(r5_enable), .r6_enable(r6_enable), .r7_enable(r7_enable), 
	.r8_enable(r8_enable), .r9_enable(r9_enable), .r10_enable(r10_enable), .r11_enable(r11_enable), 
	.r12_enable(r12_enable), .r13_enable(r13_enable), .r14_enable(r14_enable), .r15_enable(r15_enable), 
	.PC_enable(PC_enable), .PC_increment_enable(PC_increment_enable), .IR_enable(IR_enable), 
	.Y_enable(Y_enable), .Z_enable(Z_enable), 
	.MAR_enable(MAR_enable), .MDR_enable(MDR_enable), 
	.HI_enable(HI_enable), .LO_enable(LO_enable),

	// Memory Data Multiplexer Read/Select Signal
	.read(read),

	// Encoder Output Select Signals
	.r0_select(r0_select), .r1_select(r1_select), .r2_select(r2_select), .r3_select(r3_select), 
	.r4_select(r4_select), .r5_select(r5_select), .r6_select(r6_select), .r7_select(r7_select), 
	.r8_select(r8_select), .r9_select(r9_select), .r10_select(r10_select), .r11_select(r11_select), 
	.r12_select(r12_select), .r13_select(r13_select), .r14_select(r14_select), .r15_select(r15_select), 
	.PC_select(PC_select),
	.HI_select(HI_select), .LO_select(LO_select), 
	.Z_HI_select(Z_HI_select), .Z_LO_select(Z_LO_select), 
	.MDR_select(MDR_select),
	.InPort_select(InPort_select),
	.c_select(c_select),
	.encode_sel_signal(encode_sel_signal),
	
	// ALU Opcode
	.alu_instruction(alu_instruction),

	// Input Data Signals
	.MDataIN(MDataIN),

	// Output Data Signals
	.bus_Data(bus_Data), // Data currently in the bus
	.aluResult(aluResult),
	
	.R0_Data(R0_Data), .R1_Data(R1_Data), .R2_Data(R2_Data), .R3_Data(R3_Data),
	.R4_Data(R4_Data), .R5_Data(R5_Data), .R6_Data(R6_Data), .R7_Data(R7_Data),
	.R8_Data(R8_Data), .R9_Data(R9_Data), .R10_Data(R10_Data), .R11_Data(R11_Data),
	.R12_Data(R12_Data), .R13_Data(R13_Data), .R14_Data(R14_Data), .R15_Data(R15_Data),

	.PC_Data(PC_Data), .IR_Data(IR_Data), .PC_IncData(PC_IncData), .tempPC(tempPC),
	.Y_Data(Y_Data),
	.Z_HI_Data(Z_HI_Data), .Z_LO_Data(Z_LO_Data),
	.MAR_Data(MAR_Data), .MDR_Data(MDR_Data),
	.HI_Data(HI_Data), .LO_Data(LO_Data),
	.InPort_Data(InPort_Data),
	.C_sign_ext_Data(C_sign_ext_Data));
	
	// add test logic here
	initial
		begin
			clk = 0;
			forever #10 clk = ~ clk;
	end

	always @(posedge clk) // finite state machine; if clk rising-edge
		begin
			case (Present_state)
				Default : Present_state = Reg_load1a;
				Reg_load1a : Present_state = Reg_load1b;
				Reg_load1b : Present_state = Reg_load2a;
				Reg_load2a : Present_state = Reg_load2b;
				Reg_load2b : Present_state = Reg_load3a;
				Reg_load3a : Present_state = Reg_load3b;
				Reg_load3b : Present_state = T0;
				T0 : Present_state = T1;
				T1 : Present_state = T2;
				T2 : Present_state = T3;
				T3 : Present_state = T4;
				T4 : Present_state = T5;
			endcase
		end
	
	always @(Present_state) // do the required job in each state
		begin
			case (Present_state) // assert the required signals in each clk cycle
				Default: begin
				 	PC_select <= 0; Z_LO_select <= 0; MDR_select <= 0; // initialize the signals
					r2_select <= 0; r3_select <= 0; MAR_enable <= 0; Z_enable <= 0;
					PC_enable <=0; MDR_enable <= 0; IR_enable <= 0; Y_enable <= 0;
					PC_increment_enable <= 0; read <= 0; alu_instruction <= 0;
					r1_enable <= 0; r2_enable <= 0; r3_enable <= 0; MDataIN <= 32'h00000000;
				end
			
			Reg_load1a: begin
				MDataIN <= 32'h00000012;
				read = 0; MDR_enable = 0; // the first zero is there for completeness
				#10 read <= 1; MDR_enable <= 1;
				#15 read <= 0; MDR_enable <= 0;
			end
 
			Reg_load1b: begin
				#10 MDR_select <= 1; r2_enable <= 1;
				#15 MDR_select <= 0; r2_enable <= 0; // initialize R2 with the value $12
			end
		 
			Reg_load2a: begin
				MDataIN <= 32'h00000014;
				#10 read <= 1; MDR_enable <= 1;
				#15 read <= 0; MDR_enable <= 0;
			end
			
			 Reg_load2b: begin
				#10 MDR_select <= 1; r3_enable <= 1;
				#15 MDR_select <= 0; r3_enable <= 0; // initialize R3 with the value $14
			end
			
			Reg_load3a: begin
				MDataIN <= 32'h00000018;
				#10 read <= 1; MDR_enable <= 1;
				#15 read <= 0; MDR_enable <= 0;
			end
			
			 Reg_load3b: begin
				#10 MDR_select <= 1; r1_enable <= 1;
				#15 MDR_select <= 0; r1_enable <= 0; // initialize R1 with the value $18
			end
			
			T0: begin // see if you need to de-assert these signals
				#10 PC_select <= 1; MAR_enable <= 1; PC_increment_enable <= 1; Z_enable <= 1;
				#15 PC_select <= 0; MAR_enable <= 0; PC_increment_enable <= 0; Z_enable <= 0;
			end
			
			T1: begin
				#10 Z_LO_select <= 1; PC_enable <= 1; read <= 1; MDR_enable <= 1;
					MDataIN <= 32'h28918000; // opcode for Ã¢â‚¬Å“alu_instruction R1, R2, R3Ã¢â‚¬Â
				#15 Z_LO_select <= 0; PC_enable <= 0; read <= 0; MDR_enable <= 0;			 
			end
			
			T2: begin
				#10 MDR_select <= 1; IR_enable <= 1;
				#15 MDR_select <= 0; IR_enable <= 0;
			end
			
			T3: begin
				#10 r2_select <= 1; Y_enable <= 1;
				#15 r2_select <= 0; Y_enable <= 0;
			end
			
			T4: begin
				#10 r3_select <= 1; alu_instruction <= 1; Z_enable <= 1;
				#15 r3_select <= 0; alu_instruction <= 0; Z_enable <= 0;
			end
			
			T5: begin
				#10 Z_LO_select <= 1; r1_enable <= 1;
				#15 Z_LO_select <= 0; r1_enable <= 0;
			end
		endcase
	end
endmodule
