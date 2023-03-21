module con_decoder(
	// Instruction Bits 19 -> 20
	input wire [1:0] decoder_input, 
	
	// Decoder Output 
	output reg [3:0] decoder_output);

	// Always Block Changes 'decoder_output' based on 'decoder_input'
	always @(*) 
	begin
		case(decoder_input)
         		4'b00 : decoder_output <= 4'b0001;    
       		 	4'b01 : decoder_output <= 4'b0010;    
         		4'b10 : decoder_output <= 4'b0100;    
         		4'b11 : decoder_output <= 4'b1000;    
      	endcase
   	end

endmodule