/* Representation of a memory data register with 2 to 1 multiplexer in Verilog */
module memory_data_register(input clk, input clr, input enable, input [31:0] D1, input [31:0] D2, input sel, output reg [31:0] Q);

    /* While loop that iterates every positive clock edge. */
    always @(posedge clk) 
    begin
        
        /* If clear signal is high, set Q output to 0. */
        if(clr)
            Q <= 0;

        /* If enable signal is high, set Q output to follow (or equal to) D input. */
        else if(enable)
            Q <= sel ? D1 : D2;        
    end
endmodule // memory_data_register end.
