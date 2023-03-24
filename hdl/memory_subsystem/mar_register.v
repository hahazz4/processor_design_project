module mar_register(input clk, input clr, input MAR_enable, input [31:0] bus_Data, output reg [8:0] ram_address);

    always @(posedge clk) 
    begin
        if (clr) begin
            ram_address <= 9'b0;
        end else if (MAR_enable) begin
            ram_address <= bus_Data;
        end
    end

endmodule