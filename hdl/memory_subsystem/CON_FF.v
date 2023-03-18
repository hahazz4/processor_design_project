/* This module determines whether the correct condtion has been met to cause branching to take place in a conditional branch instruction. */
module CON_FF(
    input [31:0] bus_in, ir, 
    input con_in_signal,
    output con_out);                           //c2 is located at bits 22:19 of the ir register
    
    reg [3:0] decoder_out;
    reg con_D, reg_1, reg_2, reg_3, reg_4, reg_5; 
    
    always @(*)
    begin
        case(ir[1:0])
            2'b00 : begin
                decoder_out = 4'b0001;
            end

            2'b01 : begin
                decoder_out = 4'b0010;
            end

            2'b10 : begin
                decoder_out = 4'b0100;
            end

            2'b11 : begin
                decoder_out = 4'b1000;
            end
        endcase
    end
    
    always @(con_in_signal && bus_in)
    begin
        if((decoder_out[0] and bus_in) == 0)        //If the decoder_out[0] AND bus_in is equal to 0, then D = 1;
        begin
            res_1 = 1;  
        end

        else if((decoder_out[1] and bus_in) != 0)   //If the decoder_out[1] AND bus_in is not equal to 0, then D = 1;
        begin
            res_2 = 1;  
        end

        else if((decoder_out[2] and bus_in) >= 0)   //If the decoder_out[2] AND bus_in greater than equal to 0, then D = 1;
        begin
            res_3 = 1;  
        end

        else if((decoder_out[3] and bus_in[31]))    //If the decoder_out[3] AND bus_in is equal to 1, then D = 1;
        begin
            res_4 = 1;  
        end

        else                                        //If the decoder_out AND bus_in is less than equal to 0, then D = 0;
        begin
            res_5 = 0;  
        end
    end
    
    con_D = (res_1 or res_2 or res_3 or res_4);     //Or all the and results obtained.

    assign con_out = con_D;                         //Assigning the value of con_D to the output wire con_out.

endmodule
