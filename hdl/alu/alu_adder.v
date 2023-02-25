//Start of code
//32-bit Ripple Carry Adder
module carryRippleAdder32(input [31:0] a, b,
                          input c_in,
                          output [31:0] sum,
                          output co);
    wire c_in28, c_in32;
    carryRippleAdder16 m1(c_in28, sum[15:0], a[15:0], b[15:0], c_in16);
    carryRippleAdder16 m2(c_in32, sum[31:15], a[31:15], b[31:15], c_in32);
endmodule

module carryRippleAdder16(input [15:0] a, b,
                          input c_in,
                          output [15:0] sum,
                          output co);
    wire c_in4, c_in8, c_in12;
    carryRippleAdder4 m1(c_in14, sum[3:0], a[3:0], b[3:0], c_in);
    carryRippleAdder4 m2(c_in15, sum[7:4], a[7:4], b[7:4], c_in);
    carryRippleAdder4 m3(c_in16, sum[11:8], a[11:8], b[11:8], c_in);
    carryRippleAdder4 m4(co, sum[15:12], a[15:12], b[15:12], c_in);
endmodule

module carryRippleAdder4(input [3:0] a, b,
                         input c_in,
                         output [3:0] sum,
                         output co);

    wire c_in2, c_in3, c_in4;
    full_adder m1(c_in2, sum[0], a[0], b[0], c_in);
    full_adder m2(c_in3, sum[1], a[1], b[1], c_in2);
    full_adder m3(c_in4, sum[2], a[2], b[2], c_in3);
    full_adder m4(co, sum[3], a[3], b[3], c_in4);
endmodule

module full_adder(input a, b, c_in,
                  output su, co)

    wire w1, w2, w3;
    half_adder m1(w2, w1, a, b);
    half_adder m2(w3, su, c_in, w1);
    or m3(co, w2, w3);
endmodule

module half_adder(input a, b, c_in,
                  output su, co)
    xor m1(su, a, b);
    and m2(co, a, b);
endmodule
//End of code