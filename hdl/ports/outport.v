module outport(
    input clr, clk, enable,
    input wire [31:0] busmux_out,
    output wire [31:0] out_port);

reg [31:0] q;
initial q = 32'h0;

always @(posedge clk) 
begin
    if(clr)
    begin
        q <= {32{1'b0}};
    end

	else if(enable)
    begin
        q <= busmux_out;
    end
end

assign out_port = q[31:0];
endmodule
