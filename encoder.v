module encoder(r0_out, r1_out, r2_out, r3_out, 
r4_out, r5_out, r6_out, r7_out, r8_out, r9_out, 
r10_out, r11_out, r12_out, r13_out, r14_out, r15_out,
HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out,
in_port_out, C_out);
    
    input HI_out, LO_out, Z_high_out, Z_low_out, PC_out, MDR_out, in_port_out, C_out;
    input reg [31:0] r0_out; input reg [31:0] r1_out; input reg [31:0] r2_out;
    input reg [31:0] r3_out; input reg [31:0] r4_out; input reg [31:0] r5_out;
    input reg [31:0] r6_out; input reg [31:0] r7_out; input reg [31:0] r8_out;
    input reg [31:0] r9_out; input reg [31:0] r10_out; input reg [31:0] r11_out;
    input reg [31:0] r12_out; input reg [31:0] r13_out; input reg [31:0] r14_out;
    input reg [31:0] r15_out;

    always @(posedge clk) //posedge -> positive edge trigger, negedge -> negative edge trigger
        if(clr)
            Q <= 0;

        else if(enable)
            Q = D; //Data stored in Q, if the enable is 1.
            
endmodule //Register end