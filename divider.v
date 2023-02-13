//Start of code
module multiplier(input reg [15:0] Q, B, A, n, Q0, slres,            //Q is dividend, B is divisor, n is the number of bits for B, and rem_result is the remainder, div_result is final dividend.
                  output [31:0] div_result, rem_result);
    
    always @(negedge clk){
        begin
            n = $size(Q)
            A = (n+1)'b0;                                            //Initializing A as 0000.

            for (i = 0; i < n; i++)                                  //Iterating through n number of loops
            begin
                slres = A << 1;
                if(i < n)                                            //when i is less than the number of bits, n.
                begin
                    if(A == (1)'b0)                                  //If the sign bit of A is 0
                    begin                      
                        A = A - B;
                        Q0 = 'b1;
                        Q = (1)Q0;
                    end
                    
                    else if(A == (1)'b1)                             //If the sign bit of A is 1
                    begin
                        A = A + B;
                        Q0 = 'b0;
                        Q = (1)Q0;
                    end
                end
                
                else                                                 //when i is equal to the number of bits, n.
                begin
                    if(A == (1)'b0)                                  //If the sign bit of A is 0
                    begin                      
                        div_result = Q;
                        rem_result = A;
                    end
                    
                    else if(A == (1)'b1)                             //If the sign bit of A is 1
                    begin
                        A = A + B;
                        div_result = Q;
                        rem_result = A;
                    end
                end

            end
        end
    }    
endmodule
//End of code