module program_counter(
    input wire clk, clr, enable, incPC,
    input wire [31:0] PC_Input,
    output wire [31:0] PC_Output
);

reg [31:0] Q;    

initial Q <= 0;

always @ (posedge clk)
		begin 
			if (clr)
				Q <= 0;
			else if (enable)
				Q <= PC_Input;
			else if (incPC)
				Q <= Q + 1;
		end

assign PC_Output = Q;

endmodule
