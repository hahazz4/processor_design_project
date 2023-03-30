`timescale 1ns/10ps

module in_tb;
	// CPU signals
	reg clk;
	
	// Register write/enable signals
	reg PC_enable, PC_increment_enable, IR_enable;
	reg Y_enable, Z_enable;
	reg MAR_enable, MDR_enable;
	reg r_enable;
	reg con_enable;
	reg manual_R15_enable;
	reg outport_enable;

	// Memory Data Multiplexer Read/Select Signal
	reg read, write;
	
	// Select and Encode Input Signals
	reg Gra, Grb, BAout;

	// Encoder Output Select Signals
	reg PC_select;
	reg Z_LO_select;
	reg MDR_select;
	reg c_select;
	reg r_select;
	reg inport_select;
	
	wire [4:0] bus_select;
	wire [15:0] register_select;

	// ALU Opcode
	reg [4:0] alu_instruction;

	// Output Data Signals
	wire [31:0] bus_Data; // Data currently in the bus
	// wire [63:0] aluResult;
	
    wire con_output;

	wire [31:0] R3_Data, outport_Data;

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
	.manual_R15_enable(manual_R15_enable), .HI_enable(HI_enable), .outport_enable(outport_enable)

	// Memory Data Multiplexer Read/Select Signal
	.read(read), .write(write),

	// Select and Encode Input Signals
	.Gra(Gra), .Grb(Grb), .BAout(BAout),

	// Encoder Output Select Signals
	.PC_select(PC_select),
	.Z_LO_select(Z_LO_select), 
	.MDR_select(MDR_select),
	.c_select(c_select),
	.r_select(r_select),
	.inport_select(inport_select),

	.bus_select(bus_select), .register_select(register_select),
	
	// ALU Opcode
	.alu_instruction(alu_instruction),

	// Output Data Signals
	.bus_Data(bus_Data), // Data currently in the bus
	// .aluResult(aluResult),
	
	.R3_Data(R3_Data), .con_output(con_output), .outport_Data(outport_Data),

	.PC_Data(PC_Data), .IR_Data(IR_Data),
	.Y_Data(Y_Data),
	.Z_HI_Data(Z_HI_Data), .Z_LO_Data(Z_LO_Data),
	.MAR_Data(MAR_Data), .MDR_Data(MDR_Data), .MDataIN(MDataIN));
	
	// Time Signals and Load Registers
	parameter Default = 0, in_T0 = 1, in_T1 = 2, in_T2 = 3, in_T3 = 4;

	reg [4:0] Present_state = Default;

	initial begin clk = 0; Present_state = Default; end
	always #10 clk = ~clk;

	always @(posedge clk) // finite state machine; if clk rising-edge
		begin
			case (Present_state)
				loadi_T5 : #100 Present_state = in_T0;
				in_T0 : #100 Present_state = in_T1;
				in_T1 : #100 Present_state = in_T2;
				in_T2 : #100 Present_state = in_T3;
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
					HI_enable <= 0; outport_enable <= 0;

					// Select Signals
					PC_select <= 0;
					MDR_select <= 0;
					Z_LO_select <= 0; read <= 0;
					write <= 0; c_select <= 0;
					r_select <= 0; inport_select <= 0;

					// Select and Encode Signals
					Gra <= 0; Grb <= 0; BAout <= 0;	
					
					// Register Contents
					alu_instruction <= 0;

					con_output <= 0;
				end

				// in Instruction
				in_T0: begin
					#10 PC_select <= 1; MAR_enable <= 1;
					#75 PC_select <= 0; MAR_enable <= 0;
				end

				in_T1: begin
					#10 PC_increment_enable <= 1; read <= 1; MDR_enable <= 1;
					#75 PC_increment_enable <= 0; read <= 0; MDR_enable <= 0;
				end

				in_T2: begin
					#10 MDR_select <= 1; IR_enable <= 1;
					#75 MDR_select <= 0; IR_enable <= 0;
				end

				in_T3: begin
					#10 Gra <= 1; r_enable <= 1; inport_select <= 1;
					#75 Gra <= 0; r_enable <= 0; inport_select <= 0;
				end

			endcase
		end
endmodule
