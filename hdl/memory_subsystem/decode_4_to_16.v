/* This module is a 4 to 16 decoder, which takes 4 bits input and produces a 16 bits output. */
module decode_4_to_16(
    input [3:0] decoder_in, 
    output [15:0] decoder_out);
    
    case(decoder_in)
            4'b0000 : begin
                decoder_out = 16'b0000000000000001;
            end
            
            4'b0001 : begin
                decoder_out = 16'b0000000000000010;
            end

            4'b0010 : begin
                decoder_out = 16'b0000000000000100;
            end

            4'b0011 : begin
                decoder_out = 16'b0000000000001000;
            end

            4'b0100 : begin
                decoder_out = 16'b0000000000010000;
            end

            4'b0101 : begin
                decoder_out = 16'b0000000000100000;
            end

            4'b0110 : begin
                decoder_out = 16'b0000000001000000;
            end

            4'b0111 : begin
                decoder_out = 16'b0000000010000000;
            end

            4'b1000 : begin
                decoder_out = 16'b0000000100000000;
            end

            4'b1001 : begin
                decoder_out = 16'b0000001001000000;
            end

            4'b1010 : begin
                decoder_out = 16'b0000010000000000;
            end

            4'b1011 : begin
                decoder_out = 16'b0000100000000000;
            end

            4'b1100 : begin
                decoder_out = 16'b0001000000000000;
            end

            4'b1101 : begin
                decoder_out = 16'b0010000000000000;
            end

            4'b1110 : begin
                decoder_out = 16'b0100000000000000;
            end

            4'b1111 : begin
                decoder_out = 16'b1000000000000000;
            end

            default : begin
                decoder_out = 16'b0000000000000000;
            end
        endcase
endmodule
