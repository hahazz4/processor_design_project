//Start of code
//Non-Restoring Division Algorithm
module divider(reg [31:0] Q, B,              				//Q is dividend, B is divisor, n is the number of bits for B, and rem_result is the remainder, div_result is final dividend.
               output [31:0] div_result, rem_result);
    
	 reg [31:0] A, Q0, slres, tc;
	 reg n, clk;
	 
    always @(negedge clk)
        begin
            n = 31;
            if(Q < 0)
            begin
                tc = ~Q + 'b1;
                Q = tc;
            end

            else if(B < 0)
            begin
                tc = ~B + 'b1;
                B = tc;
            end

            else if(Q < 0 && B < 0)
            begin
                tc = ~Q + 'b1;
                Q = tc;
                tc = ~B + 'b1;
                B = tc;
            end

            A = 32'b0;                                            //Initializing A as 0000.

            for (i = 0; i < n; i = i + 1)                                  //Iterating through n number of loops
            begin
                slres = A << 1;
                if(A[31] == 'b0)                                 //If the less significant bit of A is 0
                begin                      
                    A = A - B;
                    Q[31] = 'b1;                                  //Q0 = 1
                    // Q = (1)Q0;
                end
                
                else if(A[31] == 'b1)                             //If the less significant bit of A is 1
                begin
                    A = A + B;
                    Q[31] = 'b0;                                  //Q0 = 0
                    // Q = (1)Q0;
                end
            
                if(i == n)                                        //when i is equal to the number of bits, n.
                begin
                    if(A[31] == 'b0)                                  //If the less significant bit of A is 0
                    begin                      
                        div_result = Q;
                        rem_result = A;
                    end
                    
                    else if(A[31] == 'b1)                             //If the less significant bit of A is 1
                    begin
                        A = A + B;
                        div_result = Q;
                        rem_result = A;
                    end
                end

            end
        end   
endmodule
//End of code