module select_encode_logic(
    input [31:0] ir,
    input Gra, Grb, Grc, r_enable, r_out, ba_out,   //External inputs
    output [31:0] c_sign);

    reg [3:0] ra, rb, rc, opcode;
    reg [15:0] decoder_in_a, decoder_in_b, decoder_in_c, decoder_in, decoder_out;
    reg [31:0] c_sign_ext;

    assign opcode = ir[31:27];     //bit 31 -> 27 of the instruction register is the opcode.
    assign ra = ir[26:23];         //bit 26 -> 23 of the instruction register is register a.
    assign rb = ir[22:19];         //bit 22 -> 19 of the instruction register is register b.
    assign rc = ir[18:15];         //bit 18 -> 15 of the instruction register is register c.

    if(Gra)                 //if the General register a control signal is 1, then decoder input would be register a AND Gra.
    begin
        decoder_in_a = (ra & {4{Gra}});
    end

    else if(Grb)            //if the General register b control signal is 1, then decoder input would be register b AND Grb.
    begin
        decoder_in_b = (rb & {4{Grb}});
    end

    else if(Grc)            //if the General register c control signal is 1, then decoder input would be register c AND Grc.
    begin
        decoder_in_c = (rc & {4{Grc}});
    end

    assign decoder_in = (decoder_in_a | decoder_in_b | decoder_in_c);     //Or's all the decoder_inputs for register a, b, c and stores the result in decoder_in.

    decoder decoderInstance(decoder_in, decoder_out);                       //Calling the 4-to-16 decoder and passing in the parameters, decoder_in and decoder_out.

    assign r_enable = {16{r_enable}} & decoder_out;
    assign r_out = ({16{ba_out[15:0]}} | {16{r_out}}) & decoder_out;
endmodule

