module multiplexer(muxIN_r0, muxIN_r1, muxIN_r2, muxIN_r3, 
muxIN_r4, muxIN_r5, muxIN_r6, muxIN_r7, muxIN_r8, muxIN_r9, 
muxIN_r10, muxIN_r11, muxIN_r12, muxIN_r13, muxIN_r14, muxIN_r15,
muxIN_HI, muxIN_LO, muxIN_Z_HI, muxIN_Z_LO, muxIN_PC, muxIN_MDR, 
muxIN_inPort, C_sign_extended);
    
    input [31:0] D;
    input clk, clr, enable;
    output reg [31:0] Q;

    always @(posedge clk) //posedge -> positive edge trigger, negedge -> negative edge trigger
        if(clr)
            Q <= 0;

        else if(enable)
            Q = D; //Data stored in Q, if the enable is 1.
            
endmodule //Register end.