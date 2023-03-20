module in_port(
    input clr, clk,
    input wire [31:0] input_data,
    output wire [31:0] busmux_in);

reg [31:0] q;
initial q = 32'h0;

always @(posedge clk) 
begin
    if (clr)
    begin
        q <= {32{1'b0}};
    end

	else
    begin
        q <= input_data;
    end
end

assign busmux_in = q[31:0];
endmodule
