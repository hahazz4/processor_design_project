module memory_datapath(
    input clk, clr,
    input MAR_enable, MDR_enable, 
    input read, write, 
    input [31:0] MDataIN, bus_Data,
    
    output reg [8:0] MAR_Data,
    output reg [31:0] MDR_Data);

    reg [31:0] mdrOut;
    reg [8:0] marOut;

    md_register mdr(clk, clr, MDR_enable, read, MDataIN, bus_Data, mdrOut);
    mar_register mar(clk, clr, MAR_enable, bus_Data, marOut);

    ram ramInstance(clk, read, write, mdrOut, marOut, MDataIN);

    assign MAR_Data = marOut;

    always @(posedge clk) 
    begin
        if (read) begin
            assign MDR_Data = mdrOut;
        end
    end

endmodule