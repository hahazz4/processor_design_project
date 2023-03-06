// and datapath_tb.v file: <This is the filename>
`timescale 1ns/10ps
module datapath_tb;
 reg PCout, ZLOout, MDRout,R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out;
 reg MARin, PCin, MDRin, IRin, Yin;
 reg IncPC, Read, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in;
 reg clock;
 reg ALUIn, ZMuxEnable, ZSelect, ZMuxOut;
 reg [31:0] Mdatain;
 wire [31:0] out;
 reg [4:0] alucontrol;
 
parameter Default =  0 ,
Reg_load1a =  1 ,
Reg_load1b =  2 ,
Reg_load2a =  3 ,
Reg_load2b =  4 ,
Reg_load3a =  5 ,
Reg_load3b =  6 ,
Reg_load4a =  7 ,
Reg_load4b =  8 ,
Reg_load5a =  9 ,
Reg_load5b =  10 ,
Reg_load6a =  11 ,
Reg_load6b =  12 ,
Reg_load7a =  13 ,
Reg_load7b =  14 ,
ANDT0 =  15 ,
ANDT1 =  16 ,
ANDT2 =  17 ,
ANDT3 =  18 ,
ANDT4 =  19 ,
ANDT5 =  20 ,
ADDT0 =  21 ,
ADDT1 =  22 ,
ADDT2 =  23 ,
ADDT3 =  24 ,
ADDT4 =  25 ,
ADDT5 =  26 ,
SUBT0 =  27 ,
SUBT1 =  28 ,
SUBT2 =  29 ,
SUBT3 =  30 ,
SUBT4 =  31 ,
SUBT5 =  32 ,
MULT0 =  33 ,
MULT1 =  34 ,
MULT2 =  35 ,
MULT3 =  36 ,
MULT4 =  37 ,
MULT5 =  38 ,
MULT6 =  39 ,
DIVT0 =  40 ,
DIVT1 =  41 ,
DIVT2 =  42 ,
DIVT3 =  43 ,
DIVT4 =  44 ,
DIVT5 =  45 ,
DIVT6 =  46 ,
SHRT0 =  47 ,
SHRT1 =  48 ,
SHRT2 =  49 ,
SHRT3 =  50 ,
SHRT4 =  51 ,
SHRT5 =  52 ,
SHRAT0 =  53 ,
SHRAT1 =  54 ,
SHRAT2 =  55 ,
SHRAT3 =  56 ,
SHRAT4 =  57 ,
SHRAT5 =  58 ,
SHLT0 =  59 ,
SHLT1 =  60 ,
SHLT2 =  61 ,
SHLT3 =  62 ,
SHLT4 =  63 ,
SHLT5 =  64 ,
RORT0 =  65 ,
RORT1 =  66 ,
RORT2 =  67 ,
RORT3 =  68 ,
RORT4 =  69 ,
RORT5 =  70 ,
ROLT0 =  71 ,
ROLT1 =  72 ,
ROLT2 =  73 ,
ROLT3 =  74 ,
ROLT4 =  75 ,
ROLT5 =  76 ,
NEGT0 =  77 ,
NEGT1 =  78 ,
NEGT2 =  79 ,
NEGT3 =  80 ,
NEGT4 =  81 ,
NEGT5 =  82 ,
NOTT0 =  83 ,
NOTT1 =  84 ,
NOTT2 =  85 ,
NOTT3 =  86 ,
NOTT4 =  87,
NOTT5 =  88;
reg [8:0] Present_state = Default;
 
DataPath DUT(PCout, ZLOout, MDRout,R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, MARin, PCin, MDRin, IRin, Yin, IncPC, Read, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, clock, ALUIn, ZMuxEnable, ZSelect, ZMuxOut, Mdatain, alucontrol, out);

// add test logic here
always #10 clock = ~clock;

initial begin
  clock = 0;
end
always @(posedge clock) // finite state machine; if clock rising-edge
 begin
 case (Present_state)
Default : #40 Present_state = Reg_load1a;
Reg_load1a : #40 Present_state = Reg_load1b;
Reg_load1b : #40 Present_state = Reg_load2a;
Reg_load2a : #40 Present_state = Reg_load2b;
Reg_load2b : #40 Present_state = Reg_load3a;
Reg_load3a : #40 Present_state = Reg_load3b;

Reg_load3b : #40 Present_state = Reg_load4a;
Reg_load4a : #40 Present_state = Reg_load4b;
Reg_load4b : #40 Present_state = Reg_load5a;

Reg_load5a : #40 Present_state = Reg_load5b;
Reg_load5b : #40 Present_state = Reg_load6a;
Reg_load6a : #40 Present_state = Reg_load6b;

Reg_load6b : #40 Present_state = Reg_load7a;
Reg_load7a : #40 Present_state = Reg_load7b;

Reg_load7b : #40 Present_state = ANDT0;
ANDT0 : #40 Present_state = ANDT1;
ANDT1 : #40 Present_state = ANDT2;
ANDT2 : #40 Present_state = ANDT3;
ANDT3 : #40 Present_state = ANDT4;
ANDT4 : #40 Present_state = ANDT5;

ANDT5 : #40 Present_state = ADDT0;
ADDT0 : #40 Present_state = ADDT1;
ADDT1 : #40 Present_state = ADDT2;
ADDT2 : #40 Present_state = ADDT3;
ADDT3 : #40 Present_state = ADDT4;
ADDT4 : #40 Present_state = ADDT5;

ADDT5 : #40 Present_state = SUBT0;
SUBT0 : #40 Present_state = SUBT1;
SUBT1 : #40 Present_state = SUBT2;
SUBT2 : #40 Present_state = SUBT3;
SUBT3 : #40 Present_state = SUBT4;
SUBT4 : #40 Present_state = SUBT5;

SUBT5 : #40 Present_state = MULT0;
MULT0 : #40 Present_state = MULT1;
MULT1 : #40 Present_state = MULT2;
MULT2 : #40 Present_state = MULT3;
MULT3 : #40 Present_state = MULT4;
MULT4 : #40 Present_state = MULT5;
MULT5 : #40 Present_state = MULT6;

MULT6 : #40 Present_state = DIVT0;
DIVT0 : #40 Present_state = DIVT1;
DIVT1 : #40 Present_state = DIVT2;
DIVT2 : #40 Present_state = DIVT3;
DIVT3 : #40 Present_state = DIVT4;
DIVT4 : #40 Present_state = DIVT5;
DIVT5 : #40 Present_state = DIVT6;

DIVT6 : #40 Present_state = SHRT0;
SHRT0 : #40 Present_state = SHRT1;
SHRT1 : #40 Present_state = SHRT2;
SHRT2 : #40 Present_state = SHRT3;
SHRT3 : #40 Present_state = SHRT4;
SHRT4 : #40 Present_state = SHRT5;

SHRT5 : #40 Present_state = SHRAT0;
SHRAT0 : #40 Present_state = SHRAT1;
SHRAT1 : #40 Present_state = SHRAT2;
SHRAT2 : #40 Present_state = SHRAT3;
SHRAT3 : #40 Present_state = SHRAT4;
SHRAT4 : #40 Present_state = SHRAT5;

SHRAT5 : #40 Present_state = SHLT0;
SHLT0 : #40 Present_state = SHLT1;
SHLT1 : #40 Present_state = SHLT2;
SHLT2 : #40 Present_state = SHLT3;
SHLT3 : #40 Present_state = SHLT4;
SHLT4 : #40 Present_state = SHLT5;

SHLT5 : #40 Present_state = RORT0;
RORT0 : #40 Present_state = RORT1;
RORT1 : #40 Present_state = RORT2;
RORT2 : #40 Present_state = RORT3;
RORT3 : #40 Present_state = RORT4;
RORT4 : #40 Present_state = RORT5;

RORT5 : #40 Present_state = ROLT0;
ROLT0 : #40 Present_state = ROLT1;
ROLT1 : #40 Present_state = ROLT2;
ROLT2 : #40 Present_state = ROLT3;
ROLT3 : #40 Present_state = ROLT4;
ROLT4 : #40 Present_state = ROLT5;

ROLT5 : #40 Present_state = NEGT0;
NEGT0 : #40 Present_state = NEGT1;
NEGT1 : #40 Present_state = NEGT2;
NEGT2 : #40 Present_state = NEGT3;
NEGT3 : #40 Present_state = NEGT4;
NEGT4 : #40 Present_state = NEGT5;

NEGT5 : #40 Present_state = NOTT0;
NOTT0 : #40 Present_state = NOTT1;
NOTT1 : #40 Present_state = NOTT2;
NOTT2 : #40 Present_state = NOTT3;
NOTT3 : #40 Present_state = NOTT4;
NOTT4 : #40 Present_state = NOTT5;
 endcase
 end

always @(Present_state) // do the required job in each state
 begin
 case (Present_state) // assert the required signals in each clock cycle
Default: begin
PCout <= 0; ZLOout <= 0; MDRout <= 0; // initialize the signals
 R2out <= 0; R3out <= 0; MARin <= 0;
 R1out <= 0; R0out <= 0; R1in <= 0; R0in <= 0;
 R4out <=0; R5out <=0; R6out<=0; R7out <=0;
 R4in <=0; R5in <=0; R6in<=0; R7in <=0;
 PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
 IncPC <= 0; Read <= 0; ALUIn <= 0; ZMuxEnable <= 0; ZSelect <= 0; ZMuxOut <= 0;
 R1in <= 0; R2in <= 0; R3in <= 0; Mdatain <= 32'h00000000; alucontrol <= 32'h00000000;
end
Reg_load1a: begin
Mdatain <= 32'h00000005;
Read = 0; MDRin = 0; // the first zero is there for completeness
#10 Read <= 1; MDRin <= 1;
#15 Read <= 0; MDRin <= 0;
end
 Reg_load1b: begin
 #10 MDRout <= 1; R2in <= 1;
 #15 MDRout <= 0; R2in <= 0; // initialize R2 with the value
end
Reg_load2a: begin
Mdatain <= 32'h00000002;
#10 Read <= 1; MDRin <= 1;
#15 Read <= 0; MDRin <= 0;
end
 Reg_load2b: begin
 #10 MDRout <= 1; R3in <= 1;
 #15 MDRout <= 0; R3in <= 0; // initialize R3 with the value
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

Reg_load4a: begin
Mdatain <= 32'h00000018;
#10 Read <= 1; MDRin <= 1;
#15 Read <= 0; MDRin <= 0;
end
 Reg_load4b: begin
 #10 MDRout <= 1; R4in <= 1;
 #15 MDRout <= 0; R4in <= 0; // initialize R4 with the value $18
end

Reg_load5a: begin
Mdatain <= 32'h00000001;
#10 Read <= 1; MDRin <= 1;
#15 Read <= 0; MDRin <= 0;
end
 Reg_load5b: begin
 #10 MDRout <= 1; R5in <= 1;
 #15 MDRout <= 0; R5in <= 0; // initialize R1 with the value $18
end

Reg_load6a: begin
Mdatain <= 32'h00000005;
#10 Read <= 1; MDRin <= 1;
#15 Read <= 0; MDRin <= 0;
end
 Reg_load6b: begin
 #10 MDRout <= 1; R6in <= 1;
 #15 MDRout <= 0; R6in <= 0; // initialize R1 with the value $18
end

Reg_load7a: begin
Mdatain <= 32'h00000002;
#10 Read <= 1; MDRin <= 1;
#15 Read <= 0; MDRin <= 0;
end
 Reg_load7b: begin
 #10 MDRout <= 1; R7in <= 1;
 #15 MDRout <= 0; R7in <= 0; // initialize R1 with the value $18
end




ANDT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
ANDT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
ANDT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
ANDT3: begin
#10 R2out <= 1; alucontrol <= 5'b00101; Yin <= 1;
#15 R2out <= 0; Yin <= 0;
end
ANDT4: begin
#10 R3out <= 1;
#1 ALUIn <= 1;
#15 R3out <= 0; ALUIn = 0;
end
ANDT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25 ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end


ADDT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
ADDT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
ADDT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
ADDT3: begin
#10 R4out <= 1; alucontrol <= 5'b00011; Yin <= 1;
#15 R4out <= 0; Yin <= 0;
end
ADDT4: begin
#10 R5out <= 1;
#1 ALUIn <= 1;
#15 R5out <= 0; ALUIn = 0;
end
ADDT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25 ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end



SUBT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
SUBT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
SUBT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
SUBT3: begin
#10 R4out <= 1; alucontrol <= 5'b00100; Yin <= 1;
#15 R4out <= 0; Yin <= 0;
end
SUBT4: begin
#10 R5out <= 1;
#1 ALUIn <= 1;
#15 R5out <= 0; ALUIn = 0;
end
SUBT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end


MULT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
MULT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
MULT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
MULT3: begin
#10 R6out <= 1; alucontrol <= 5'b01111; Yin <= 1;
#15 R6out <= 0; Yin <= 0;
end
MULT4: begin
#10 R7out <= 1;
#1 ALUIn <= 1;
#15 R7out <= 0; ALUIn = 0;
end
MULT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end
MULT6: begin
ZSelect <= 1; ZMuxEnable <= 1;
ZMuxOut <= 1; R2in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R2in <= 0;
end



DIVT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
DIVT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
DIVT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
DIVT3: begin
#10 R6out <= 1; alucontrol <= 5'b10000; Yin <= 1;
#15 R6out <= 0; Yin <= 0;
end
DIVT4: begin
#10 R7out <= 1;
#1 ALUIn <= 1;
#15 R7out <= 0; ALUIn = 0;
end
DIVT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end
DIVT6: begin
ZSelect <= 1; ZMuxEnable <= 1;
ZMuxOut <= 1; R7in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R7in <= 0;
end



SHRT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
SHRT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
SHRT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
SHRT3: begin
#10 R3out <= 1; alucontrol <= 5'b00111; Yin <= 1;
#15 R3out <= 0; Yin <= 0;
end
SHRT4: begin
#10 R5out <= 1;
#1 ALUIn <= 1;
#15 R5out <= 0; ALUIn = 0;
end
SHRT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25 ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end



SHRAT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
SHRAT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
SHRAT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
SHRAT3: begin
#10 R3out <= 1; alucontrol <= 5'b01000; Yin <= 1;
#15 R3out <= 0; Yin <= 0;
end
SHRAT4: begin
#10 R5out <= 1;
#1 ALUIn <= 1;
#15 R5out <= 0; ALUIn = 0;
end
SHRAT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end



SHLT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
SHLT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
SHLT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
SHLT3: begin
#10 R3out <= 1; alucontrol <= 5'b01001; Yin <= 1;
#15 R3out <= 0; Yin <= 0;
end
SHLT4: begin
#10 R5out <= 1;
#1 ALUIn <= 1;
#15 R5out <= 0; ALUIn = 0;
end
SHLT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end



RORT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
RORT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
RORT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
RORT3: begin
#10 R6out <= 1; alucontrol <= 5'b01010; Yin <= 1;
#15 R6out <= 0; Yin <= 0;
end
RORT4: begin
#10 R6out <= 1;
#1 ALUIn <= 1;
#15 R6out <= 0; ALUIn = 0;
end
RORT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R6in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R6in <= 0;
end



ROLT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
ROLT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
ROLT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
ROLT3: begin
#10 R6out <= 1; alucontrol <= 5'b01011; Yin <= 1;
#15 R6out <= 0; Yin <= 0;
end
ROLT4: begin
#10 R4out <= 1;
#1 ALUIn <= 1;
#15 R4out <= 0; ALUIn = 0;
end
ROLT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R1in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R1in <= 0;
end


NEGT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
NEGT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
NEGT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
NEGT3: begin
#10 R1out <= 1; alucontrol <= 5'b10001; Yin <= 1;
#15 R1out <= 0; Yin <= 0;
end
NEGT4: begin
#10 R1out <= 1;
#1 ALUIn <= 1;
#15 R1out <= 0; ALUIn = 0;
end
NEGT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R0in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R0in <= 0;
end


NOTT0: begin // see if you need to de-assert these signals
#10 PCout <= 1; MARin <= 1; IncPC <= 1;
#15 PCout <= 0; MARin <= 0; IncPC <= 0;
end
NOTT1: begin
#10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
#15 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
end
NOTT2: begin
#10 MDRout <= 1; IRin <= 1;
#15 MDRout <= 0; IRin <= 0;
end
NOTT3: begin
#10 R1out <= 1; alucontrol <= 5'b10010; Yin <= 1;
#15 R1out <= 0; Yin <= 0;
end
NOTT4: begin
#10 R1out <= 1;
#1 ALUIn <= 1;
#15 R1out <= 0; ALUIn = 0;
end
NOTT5: begin
ZSelect <= 0; ZMuxEnable <= 1;
ZMuxOut <= 1; R0in <= 1;
#25  ZMuxEnable <= 0; ZMuxOut <= 0; R0in <= 0;
end

 endcase
 end
endmodule