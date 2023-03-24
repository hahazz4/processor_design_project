module flip_flop(input wire clk, input wire reset, input wire D, output reg Q);
	
	// Logic for Flip Flop Behaviour
	always @(posedge clk or posedge reset) begin
		 if (reset) begin
			  Q <= 1'b0;
		 end else begin
			  Q <= D;
		 end
	end

endmodule
