module ff_logic(input wire clk, input wire d, output reg q, output reg not_q);
    initial begin
	    q <= 0;
	    not_q <= 1;
	end
	always@(clk) 
	begin
	    q <= d;
	    not_q <= !d;
	end
endmodule
