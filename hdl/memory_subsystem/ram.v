module ram(
    input clk,          // clock input
    input read,         // read control signal (active high)
    input write,        // write control signal (active high)
    input [31:0] data_in,       // input data
    input [8:0] address_in,     // address input
    output wire [31:0] data_out  // output data
);

reg [31:0] mem [511:0]; // memory array
reg [31:0] tempData;

initial $readmemh("init.mif", mem);

always @(posedge clk) begin
    if (write) begin
        mem[address_in] <= data_in; // write data to memory location
    end
    if (read) begin
        tempData <= mem[address_in]; // read data from memory location
    end
end

assign data_out = tempData;

endmodule
