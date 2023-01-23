module multiplexer(mux_r0, mux_r1, mux_r2, mux_r3, 
mux_r4, mux_r5, mux_r6, mux_r7, mux_r8, mux_r9, 
mux_r10, mux_r11, mux_r12, mux_r13, mux_r14, mux_r15,
mux_hi, mux_lo, mux_zhi, mux_zlo, mux_pc, mux_MDR, mux_inPort,
);
    input [31:0] D;
    input clk, clr, enable;
    output reg [31:0] Q;

    always @(posedge clk) //posedge -> positive edge trigger, negedge -> negative edge trigger
        if(clr)
            Q <= 0;

        else if(enable)
            Q = D; //Data stored in Q, if the enable is 1.
            
endmodule //Register end.