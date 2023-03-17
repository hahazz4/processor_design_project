module select_encode(
    input [31:0] ir,
    input Gra, Grb, Grc, r_enable, r_out, ba_out,   //External inputs
    output [31:0] c_sign);
    // output r0_select, r1_select, r2_select, r3_select, r4_select, r5_select,         //gotta check in with Nick about this...
    // r6_select, r7_select, r8_select, r9_select, r10_select, r11_select, 
    // r12_select, r13_select, r14_select, r15_select, r0_out, r1_out, r2_out, 
    // r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out, r10_out, r11_out, 
    // r12_out, r13_out, r14_out, r15_out);

    reg [3:0] ra, rb, rc, opcode;
    reg [15:0] decoder_in, decoder_out, in, out;
    reg [31:0] c_sign_ext;

    always @(*)
    begin
        opcode = ir[31:27];     //bit 31 -> 27 of the instruction register is the opcode.
        ra = ir[26:23];         //bit 26 -> 23 of the instruction register is register a.
        rb = ir[22:19];         //bit 22 -> 19 of the instruction register is register b.
        rc = ir[18:15];         //bit 18 -> 15 of the instruction register is register c.

        if(Gra)         //if the Ga control signal is 1, then decoder input would be register a.
        begin
            decoder_in = ra;
        end

        else if(Grb)    //if the Ga control signal is 1, then decoder input would be register b.
        begin
            decoder_in = rb;
        end

        else if(Grc)    //if the Ga control signal is 1, then decoder input would be register c.
        begin
            decoder_in = rc;
        end

        else            //Otherwise, let input, output = 0.
        begin
            in, out = 0;
        end

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

        if(r_enable)                //if the enable signal is 1, then input is the decoder output, and the output would be 0.
        begin
            in = decoder_out;
            out = 0;
        end
                
        else if(ba_out | r_out)     //if the result of the (base address output signal AND register output signal) = 1, then the output = decoder output, and the input would be 0.
        begin
            out = decoder_out;
            in = 0;
        end
    end
endmodule
