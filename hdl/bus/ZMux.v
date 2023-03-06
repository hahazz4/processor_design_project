module ZMux(
    // ZMux Inputs
	input wire [63:0] aluOutput,
	input wire ZSelect,
	input wire ZMuxEnable,

    // ZMux Output
	output wire [31:0] bus_Data
);

// Temp variable to pass the output to 'bus_Data'
reg [31:0] Zout;

always @ (ZMuxEnable) begin
	if (ZSelect) begin
		Zout = aluOutput[63:32];
	end
	else begin
		Zout = aluOutput[31:0];
	end
end
assign bus_Data = Zout;
endmodule