
`timescale 1ns/10ps
module load_tb;
	// CPU signals
	reg clk;
	
	// Register write/enable signals 
	wire [15:0] r1_enable;
	reg PC_enable, PC_increment_enable, IR_enable; 
	reg Y_enable, Z_enable; 
	reg MAR_enable, MDR_enable;
	reg r_enable;

	// Memory Data Multiplexer Read/Select Signal
	reg read;
	
	// Select and Encode Input Signals
	reg Gra, Grb, BAout;

	// Encoder Output Select Signals 
	reg PC_select;
	reg Z_LO_select;
	reg MDR_select;
	reg c_select;
	
	wire [4:0] encode_sel_signal;
	
	// ALU Opcode
	reg [4:0] alu_instruction;

	// Output Data Signals
	wire [31:0] bus_Data; // Data currently in the bus
	wire [63:0] aluResult;
	
	wire [31:0] R1_Data;

	wire [31:0] PC_Data, IR_Data;
	wire [31:0] Y_Data;
	wire [31:0] Z_HI_Data, Z_LO_Data;
	wire [31:0] MAR_Data, MDR_Data;

	// Time Signals and Load Registers
	parameter Default = 4'b0000, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
 
	reg [3:0] Present_state = Default;

	datapath datapathInstance(	// CPU signals
	.clk(clk), 
	
	// Register write/enable signals
	.register_enable(r1_enable),
	.PC_enable(PC_enable), .PC_increment_enable(PC_increment_enable), .IR_enable(IR_enable), 
	.Y_enable(Y_enable), .Z_enable(Z_enable), 
	.MAR_enable(MAR_enable), .MDR_enable(MDR_enable), .r_enable(r_enable),

	// Memory Data Multiplexer Read/Select Signal
	.read(read),

	// Select and Encode Input Signals
	.Gra(Gra), .Grb(Grb), .BAout(BAout),

	// Encoder Output Select Signals
	.PC_select(PC_select),
	.Z_LO_select(Z_LO_select), 
	.MDR_select(MDR_select),
	.c_select(c_select),

	.encode_sel_signal(encode_sel_signal),
	
	// ALU Opcode
	.alu_instruction(alu_instruction),

	// Output Data Signals
	.bus_Data(bus_Data), // Data currently in the bus
	.aluResult(aluResult),
	
	.R1_Data(R1_Data),

	.PC_Data(PC_Data), .IR_Data(IR_Data),
	.Y_Data(Y_Data),
	.Z_HI_Data(Z_HI_Data), .Z_LO_Data(Z_LO_Data),
	.MAR_Data(MAR_Data), .MDR_Data(MDR_Data));
	
initial begin clk = 0; Present_state = Default; end
always #10 clk = ~clk;

	always @(posedge clk) // finite state machine; if clk rising-edge
		begin
			case (Present_state)
				Default: #40 Present_state = T0;
				T0 : #40 Present_state = T1;
				T1 : #40 Present_state = T2;
				T2 : #40 Present_state = T3;
				T3 : #40 Present_state = T4;
				T4 : #40 Present_state = T5;
            	T5 : #40 Present_state = T6;
            	T6 : #40 Present_state = T7;
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
					r_enable <= 0;

					// Select Signals
					PC_select <= 0;
					MDR_select <= 0;
					Z_LO_select <= 0; read <= 0;
					c_select <= 0;

					// Select and Encode Signals
					Gra <= 0; Grb <= 0; BAout <= 0;	
					
					// Register Contents
					alu_instruction <= 0;
				end
			
				T0: begin // see if you need to de-assert these signals
					#10 PC_select <= 1; MAR_enable <= 1; PC_increment_enable <= 1;
			        #15 PC_select <= 0; MAR_enable <= 0; PC_increment_enable <= 0;
				end
				
				T1: begin
					#10 PC_enable <= 1; read <= 1; MDR_enable <= 1;
			        #15 PC_enable <= 0; read <= 0; MDR_enable <= 0;
				end
				
				T2: begin
					#10 MDR_select <= 1; IR_enable <= 1;
					#15 MDR_select <= 0; IR_enable <= 0;
				end
				
				T3: begin
					#10 Grb <= 1; BAout <= 1; Y_enable <= 1;
			        #15 Grb <= 0; BAout <= 0; Y_enable <= 0;
				end
				
				T4: begin
					#10 c_select <= 1; alu_instruction <= 5'b00000; Z_enable <= 1;
					#15 c_select <= 0; alu_instruction <= 0; Z_enable <= 0;
				end
				
				T5: begin
					#10 Z_LO_select <= 1; MAR_enable <= 1;
			        #15 Z_LO_select <= 0; MAR_enable <= 0;
				end

                T6: begin
					#10 read <= 1; MDR_enable <= 1;
			        #15 read <= 0; MDR_enable <= 0;
				end

                T7: begin
					#10 MDR_select <= 1; Gra <= 1; r_enable <= 1;
			        #15 MDR_select <= 0; Gra <= 0; r_enable <= 0;
				end
			endcase
		end
endmodule
