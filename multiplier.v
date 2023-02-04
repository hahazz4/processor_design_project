module multiplier(input reg [31:0] a, b, 
                  input start, clk, reset,
                  output [61:0] mul_result, ans,
                  integer i, l_tbl, op);
    always @(negedge clk){
        begin
            ans = 64'b0;
            mul_result = 64'b0;              //2(n) is the product bits, thus 2(32) = 64 bits
            
            for(i=1; i<=31; i=i+2)
            begin
                if(i == 1)
                    l_tbl = 0;
                else
                    l_tbl = b[i-2];



                if(l_tbl == 0 || l_tbl == 7)   //the first and last row of the lookup table
                    op = 0;
                else if(l_tbl == 1 || l_tbl == 2 || l_tbl == 5 || l_tbl == 6)
                    op = 1;
                else   //the 4th and 5th row of the lookup table
                    op = 2;

                if(b[i] == 1)
                    op = -1 * op;        

                case(op) //switch cases for each op
                1:
                    begin
                        
                    end
                -1:
                    begin
                        
                    end
                2:
                    begin
                        
                    end
                -2:
                    begin
                        
                    end
            end
        end
    }    
endmodule