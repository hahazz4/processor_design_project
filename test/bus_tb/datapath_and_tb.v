
`timescale 1ns/10ps
module datapath_and_tb;
	// Clock Signal
	reg Clock;

	// Input Signals
	reg [31:0] MDataIN;

	// Output Signals
	reg PC_Data, Z_LO_Data, MDR_Data, R2_Data, R3_Data;
	
	// Register Enable Signals
	reg r1_enable, r2_enable, r3_enable;
	reg MAR_enable, MDR_enable;
	reg IR_enable, PC_enable, PC_Increment_enable;
	reg Y_enable, Z_enable;
	
	// Memory Data Multiplexer Select Signal
	reg MDR_select;

	// Opcode Instruction
	wire [4:0] alu_instruction;

	// Time Signals and Load Registers
	parameter Default = 4'b0000, 
	Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
	Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, 
	T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, 
	T5 = 4'b1100;
 
	reg [3:0] Present_state = Default;

	datapath datapathAND();
	
	// add test logic here
	initial
		begin
			Clock = 0;
			forever #10 Clock = ~ Clock;
	end

	always @(posedge Clock) // finite state machine; if clock rising-edge
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
			case (Present_state) // assert the required signals in each clock cycle
				Default: begin
					PC_Data <= 0; Z_LO_Data <= 0; MDR_Data <= 0; // initialize the signals
					R2_Data <= 0; R3_Data <= 0; MAR_enable <= 0; Z_enable <= 0;
					PC_enable <=0; MDR_enable <= 0; IR_enable <= 0; Y_enable <= 0;
					PC_Increment_enable <= 0; MDR_select <= 0; alu_instruction <= 0;
					r1_enable <= 0; r2_enable <= 0; r3_enable <= 0; MDataIN <= 32'h00000000;
				end
			
			Reg_load1a: begin
				MDataIN <= 32'h00000012;
				MDR_select = 0; MDR_enable = 0; // the first zero is there for completeness
				#10 MDR_select <= 1; MDR_enable <= 1;
				#15 MDR_select <= 0; MDR_enable <= 0;
			end
 
			Reg_load1b: begin
				#10 MDR_Data <= 1; r2_enable <= 1;
				#15 MDR_Data <= 0; r2_enable <= 0; // initialize R2 with the value $12
			end
		 
			Reg_load2a: begin
				MDataIN <= 32'h00000014;
				#10 MDR_select <= 1; MDR_enable <= 1;
				#15 MDR_select <= 0; MDR_enable <= 0;
			end
			
			 Reg_load2b: begin
				#10 MDR_Data <= 1; r3_enable <= 1;
				#15 MDR_Data <= 0; r3_enable <= 0; // initialize R3 with the value $14
			end
			
			Reg_load3a: begin
				MDataIN <= 32'h00000018;
				#10 MDR_select <= 1; MDR_enable <= 1;
				#15 MDR_select <= 0; MDR_enable <= 0;
			end
			
			 Reg_load3b: begin
				#10 MDR_Data <= 1; r1_enable <= 1;
				#15 MDR_Data <= 0; r1_enable <= 0; // initialize R1 with the value $18
			end
			
			T0: begin // see if you need to de-assert these signals
				#10 PC_Data <= 1; MAR_enable <= 1; PC_Increment_enable <= 1; Z_enable <= 1;
				#15 PC_Data <= 0; MAR_enable <= 0; PC_Increment_enable <= 0; Z_enable <= 0;
			end
			
			T1: begin
				#10 Z_LO_Data <= 1; PC_enable <= 1; MDR_select <= 1; MDR_enable <= 1;
					 MDataIN <= 32'h28918000; // opcode for “alu_instruction R1, R2, R3”
				#15 Z_LO_Data <= 0; PC_enable <= 0; MDR_select <= 0; MDR_enable <= 0;			 
			end
			
			T2: begin
				MDR_Data <= 1; IR_enable <= 1;
			end
			
			T3: begin
				R2_Data <= 1; Y_enable <= 1;
			end
			
			T4: begin
				R3_Data <= 1; alu_instruction <= 1; Z_enable <= 1;
			end
			
			T5: begin
				Z_LO_Data <= 1; r1_enable <= 1;
			end
			
			T6: begin
				Zhighout <= 1; r1_enable <= 1;
			end
			
		endcase
	end
endmodule
