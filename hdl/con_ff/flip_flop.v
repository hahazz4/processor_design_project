module flip_flop(input wire clk, input wire D, output reg Q, output reg notQ);
    
	// Initial Flip Flop States
	initial 
	begin
	    Q <= 0;
	    notQ <= 1;
	end
	
	// Logic for Flip Flop Behaviour
	always @(clk) 
	begin
	    Q <= D;
	    notQ <= !D;
	end

endmodule
