// and datapath_tb.v file: <This is the filename>
`timescale 1ns/10ps
module datapath_tb;
	reg PCout, Zlowout, MDRout, R2out, R3out; // add any other signals to see in your simulation
	reg MARin, Zin, PCin, MDRin, IRin, Yin;
	reg IncPC, Read, AND, R1in, R2in, R3in;
	reg Clock;
	reg [31:0] Mdatain;
	reg opcode[4:0];

	// Time Signals and Load Registers
	parameter Default = 4'b0000, 
	Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
	Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, 
	T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, 
	T5 = 4'b1100;
	
	// Opcodes
	parameter and_op = 5'b00101, or_op = 5'b00110, addition_op = 5'b00011, 
   subtraction_op = 5'b00100, multiplication_op = 5'b01111, division_op = 5'b10000, 
   left_shift_op = 5'b01001, right_shift_op = 5'b00111, arith_shift_right_op = 5'b01000, 
   left_rotate_op = 5'b01011, right_rotate_op = 5'b01010, negate_op = 5'b10001, not_op = 5'b10010;
 
	reg [3:0] Present_state = Default;
	//zin is just the enable signal which is our ZHI or ZLO enable, pc increment select signal, make a dedicated pc increment counter module, finish datapath tbs
	datapath datapathInstance(.PC_Data(PCout), .Z_LO_Data(Zlowout), .MDR_Data(MDRout), .R2_Data(R2out), .R3_Data(R3out), .bus_Data(MARin), .(Zin), .bus_Data(PCin), .MDR_enable(MDRin), .bus_Data(IRin), .bus_Data(Yin), .(IncPC), .MDR_select(Read), .alu_instruction(opcode), .bus_Data(R1in), .bus_Data(R2in), .bus_Data(R3in), .clk(Clock), .MDataIN(Mdatain));
	
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
					PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
					R2out <= 0; R3out <= 0; MARin <= 0; Zin <= 0;
					PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
					IncPC <= 0; Read <= 0; AND <= 0;
					R1in <= 0; R2in <= 0; R3in <= 0; Mdatain <= 32'h00000000;
				end
			
			Reg_load1a: begin
				Mdatain <= 32'h00000012;
				Read = 0; MDRin = 0; // the first zero is there for completeness
				#10 Read <= 1; MDRin <= 1;
				#15 Read <= 0; MDRin <= 0;
			end
 
			Reg_load1b: begin
				#10 MDRout <= 1; R2in <= 1;
				#15 MDRout <= 0; R2in <= 0; // initialize R2 with the value $12
			end
		 
			Reg_load2a: begin
				Mdatain <= 32'h00000014;
				#10 Read <= 1; MDRin <= 1;
				#15 Read <= 0; MDRin <= 0;
			end
			
			 Reg_load2b: begin
				#10 MDRout <= 1; R3in <= 1;
				#15 MDRout <= 0; R3in <= 0; // initialize R3 with the value $14
			end
			
			Reg_load3a: begin
				Mdatain <= 32'h00000018;
				#10 Read <= 1; MDRin <= 1;
				#15 Read <= 0; MDRin <= 0;
			end
			
			 Reg_load3b: begin
				#10 MDRout <= 1; R1in <= 1;
				#15 MDRout <= 0; R1in <= 0; // initialize R1 with the value $18
			end
			
			T0: begin // see if you need to de-assert these signals
				#10 PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
				#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
			end
			
			T1: begin
				#10 Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
					 Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
				#15 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;			 
			end
			
			T2: begin
				MDRout <= 1; IRin <= 1;
			end
			
			T3: begin
				R2out <= 1; Yin <= 1;
			end
			
			T4: begin
				R3out <= 1; AND <= 1; Zin <= 1;
			end
			
			T5: begin
				Zlowout <= 1; R1in <= 1;
			end
			
			T6: begin
				Zhighout <= 1; R1in <= 1;
			end
			
		endcase
	end
endmodule
