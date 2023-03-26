module ram(
    input ram_enable,          // RAM enable control signal (active high)
    input read,                // Read control signal (active high)
    input write,               // Write control signal (active high)
    input [31:0] data_in,      // Input data
    input [8:0] address_in,    // Address input
    output wire [31:0] data_out, // Output data
    output [31:0] debug_port
);

reg [31:0] mem [511:0]; // Memory array
reg [31:0] tempData;    // Temporary data storage

initial begin 
    $readmemh("store.mif", mem);
end

always @(posedge ram_enable) begin
    if (write) begin
        mem[address_in] <= data_in; // Write data to memory location   
    end
    if (read) begin
        tempData <= mem[address_in]; // Read data from memory location
    end
end

assign data_out = tempData;
assign debug_port = mem [145];

endmodule
