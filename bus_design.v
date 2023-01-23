module bus_design(clk, clr, enable, D, Q);
    input [31:0] D;
    input clk, clr, enable;
    output reg [31:0] Q;

    always @(posedge clk) //posedge -> positive edge trigger, negedge -> negative edge trigger
        if(clr)
            Q <= 0;

        else if(enable)
            Q = D; //Data stored in Q, if the enable is 1.
            
endmodule //Register end.