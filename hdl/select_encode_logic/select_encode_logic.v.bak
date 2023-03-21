module select_encode_logic(
    // Instruction Register Data
    input [31:0] instruction,
    
    // Select and Encode Logic Control Signals
    input Gra, Grb, Grc, r_enable, r_select, BAout,

    // Array of Enable and Select Output Signals
    output [15:0] register_enable, register_select,
    
    // Sign Extension of Constant C
    output [31:0] C_sign_ext_Data);

    // Instruction Register Content Variables
    reg [4:0] opcode;
    reg [3:0] Ra, Rb, Rc;

    // 4 to 16 Decoder Input/Output Variable
    reg [3:0] decoder_input;
    reg [15:0] decoder_out;

    // Assigning Values to Instruction Register Content Variables
    assign opcode = instruction [31:27];    // Bits 27 -> 31 of the instruction register is the opcode
    assign Ra = instruction [26:23];        // Bit 23 -> 26 of the instruction register is register a    
    assign Rb = instruction [22:19];        // Bit 19 -> 22 of the instruction register is register b
    assign Rc = instruction [18:15];        // Bit 15 -> 18 of the instruction register is register c

    // Input to the 4-to-16 Decoder
    assign decoder_input = (instruction[26:23] & {4{Gra}}) | (instruction[22:19] & {4{Grb}}) | (instruction[18:15] & {4{Grc}});

    // Calling the 4-to-16 decoder and passing in the parameters: decoder_in, decoder_out
    SE_decoder decoderInstance(decoder_input, decoder_out);

    // Assigning Values to the Outputs
    assign r_enable = {16{r_enable}} & decoder_out;
    assign r_select = ({16{BAout[15:0]}} | {16{r_select}}) & decoder_out;
    assign C_sign_ext_Data = {{13{instruction[18]}}, instruction[18:0]};

endmodule

