/*  
    Booth's Multiplication Algorithm
    
    a = Variable which stores the accumulator of the partial product multiplication
    Q-1 = Variable which stores the value of Q0 after every arithmetic shift right operation. (Intial value is set to 0)
    M = Multiplicand
    Q = Multiplier
    n = The number of times the loop of the algorithm will run, it is equal to the number of bits of the multiplier.
        (ex. if Q = 1001, then n = 4)
*/

/*  
    WORK IN PROGRESS! IDEA: WE CHECK HOW MUCH BITS M and Q has, IF <5 BITS THEN WE CAN RUN THE NORMAL MULTIPLICATION METHOD, 
    OTHERWISE BOOTH'S ALGO 32x32 BIT WISE PAIR.
*/

module multiplier(a, M, Q, n, mul_result);
    input reg [31:0] M, Q;
    input reg [31:0] Q;
    output [31:0] mul_result;
    

    always @() begin

    end
endmodule
