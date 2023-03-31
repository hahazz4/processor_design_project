`timescale 1ns/10ps

module mfhi_tb;
	// CPU signals
	reg clk;
	
	// Register write/enable signals
	reg PC_enable, PC_increment_enable, IR_enable;
	reg Y_enable, Z_enable;
	reg MAR_enable, MDR_enable;
	reg r_enable;
	reg con_enable;
	reg manual_R15_enable;
	reg HI_enable;

	// Memory Data Multiplexer Read/Select Signal
	reg read, write;
	
	// Select and Encode Input Signals
	reg Gra, Grb, ba_select;

	// Encoder Output Select Signals
	reg PC_select;
	reg Z_LO_select;
	reg MDR_select;
	reg c_select;
	reg r_select;
	reg HI_select;
	
	wire [4:0] bus_select;
	wire [15:0] register_select;

	// ALU Opcode
	reg [4:0] alu_instruction;

	// Output Data Signals
	wire [31:0] bus_Data; // Data currently in the bus
	// wire [63:0] aluResult;
	
    wire con_output;

	wire [31:0] R4_Data, HI_Data;

	wire [31:0] PC_Data, IR_Data;
	wire [31:0] Y_Data;
	wire [31:0] Z_HI_Data, Z_LO_Data;
	wire [31:0] MAR_Data, MDR_Data, MDataIN;

	datapath datapathInstance(	// CPU signals
	.clk(clk),
	
	// Register write/enable signals
	.PC_enable(PC_enable), .PC_increment_enable(PC_increment_enable), .IR_enable(IR_enable), 
	.Y_enable(Y_enable), .Z_enable(Z_enable), .con_enable(con_enable),
	.MAR_enable(MAR_enable), .MDR_enable(MDR_enable), .r_enable(r_enable),
	.manual_R15_enable(manual_R15_enable), .HI_enable(HI_enable),

	// Memory Data Multiplexer Read/Select Signal
	.read(read), .write(write),

	// Select and Encode Input Signals
	.Gra(Gra), .Grb(Grb), .ba_select(ba_select),

	// Encoder Output Select Signals
	.PC_select(PC_select),
	.Z_LO_select(Z_LO_select), 
	.MDR_select(MDR_select),
	.c_select(c_select),
	.r_select(r_select),
	.HI_select(HI_select),

	.bus_select(bus_select), .register_select(register_select),
	
	// ALU Opcode
	.alu_instruction(alu_instruction),

	// Output Data Signals
	.bus_Data(bus_Data), // Data currently in the bus
	// .aluResult(aluResult),
	
	.R4_Data(R4_Data), .con_output(con_output),

	.PC_Data(PC_Data), .IR_Data(IR_Data),
	.Y_Data(Y_Data), .HI_Data(HI_Data),
	.Z_HI_Data(Z_HI_Data), .Z_LO_Data(Z_LO_Data),
	.MAR_Data(MAR_Data), .MDR_Data(MDR_Data), .MDataIN(MDataIN));
	
	// Time Signals and Load Registers
	parameter Default = 0, loadi_T0 = 1, loadi_T1 = 2, loadi_T2 = 3, loadi_T3 = 4, 
	loadi_T4 = 5, loadi_T5 = 6, mfhi_T0 = 7, mfhi_T1 = 8, mfhi_T2 = 9, mfhi_T3 = 10;

	reg [4:0] Present_state = Default;

	initial begin clk = 0; Present_state = Default; end
	always #10 clk = ~clk;

	always @(posedge clk) // finite state machine; if clk rising-edge
		begin
			case (Present_state)
				Default: #100 Present_state = loadi_T0;
				loadi_T0 : #100 Present_state = loadi_T1;
				loadi_T1 : #100 Present_state = loadi_T2;
				loadi_T2 : #100 Present_state = loadi_T3;
				loadi_T3 : #100 Present_state = loadi_T4;
				loadi_T4 : #100 Present_state = loadi_T5;
				
				loadi_T5 : #100 Present_state = mfhi_T0;
				mfhi_T0 : #100 Present_state = mfhi_T1;
				mfhi_T1 : #100 Present_state = mfhi_T2;
				mfhi_T2 : #100 Present_state = mfhi_T3;

			endcase
		end
	
	always @(Present_state) // do the required job in each state
		begin
			case (Present_state) // assert the required signals in each clk cycle
				Default: begin
					// Enable Signals
					MDR_enable <= 0; MAR_enable <= 0;
					IR_enable <= 0;
					Y_enable <= 0; Z_enable <= 0;
					PC_enable <= 0; PC_increment_enable <= 0;
					r_enable <= 0; con_enable <= 0; manual_R15_enable <= 0;
					HI_enable <= 0;

					// Select Signals
					PC_select <= 0;
					MDR_select <= 0;
					Z_LO_select <= 0; read <= 0;
					write <= 0; c_select <= 0;
					r_select <= 0;

					// Select and Encode Signals
					Gra <= 0; Grb <= 0; ba_select <= 0;	
					
					// Register Contents
					alu_instruction <= 0;
				end
				
				loadi_T0: begin // see if you need to de-assert these signals
					#10 PC_select <= 1; MAR_enable <= 1; 
			        #75 PC_select <= 0; MAR_enable <= 0; 
				end
				
				loadi_T1: begin
					#10 PC_increment_enable <= 1; read <= 1; MDR_enable <= 1;
			        #75 PC_increment_enable <= 0; read <= 0; MDR_enable <= 0;
				end
				
				loadi_T2: begin
					#10 MDR_select <= 1; IR_enable <= 1;
					#75 MDR_select <= 0; IR_enable <= 0;
				end
				
				loadi_T3: begin
					#10 Grb <= 1; ba_select <= 1; Y_enable <= 1;
			        #75 Grb <= 0; ba_select <= 0; Y_enable <= 0;
				end
				
				loadi_T4: begin
					#10 c_select <= 1; alu_instruction <= 5'b00001; Z_enable <= 1;
					#75 c_select <= 0; alu_instruction <= 0; Z_enable <= 0;
				end
				
				loadi_T5: begin
					#10 Z_LO_select <= 1; HI_enable <= 1;
			        #75 Z_LO_select <= 0; HI_enable <= 0;
				end

				// mfhi Instruction
				mfhi_T0: begin
					#10 PC_select <= 1; MAR_enable <= 1;
					#75 PC_select <= 0; MAR_enable <= 0;
				end

				mfhi_T1: begin
					#10 PC_increment_enable <= 1; read <= 1; MDR_enable <= 1;
					#75 PC_increment_enable <= 0; read <= 0; MDR_enable <= 0;
				end

				mfhi_T2: begin
					#10 MDR_select <= 1; IR_enable <= 1;
					#75 MDR_select <= 0; IR_enable <= 0;
				end

				mfhi_T3: begin
					#10 Gra <= 1; r_enable <= 1; HI_select <= 1;
					#75 Gra <= 0; r_enable <= 0; HI_select <= 0;
				end

			endcase
		end
endmodule
