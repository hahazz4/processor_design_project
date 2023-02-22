//Start of code
//32-bit full_subtractor
module full_subtractor32(input [31:0] a, b,
                          input c_in,
                          output [31:0] diff,
                          output co);
    wire c_in28, c_in32;
    full_subtractor16 m1(c_in28, diff[15:0], a[15:0], b[15:0], c_in16);
    full_subtractor16 m2(c_in32, diff[31:15], a[31:15], b[31:15], c_in32);
endmodule

module full_subtractor16(input [15:0] a, b,
                          input c_in,
                          output [15:0] diff,
                          output co);
    wire c_in4, c_in8, c_in12;
    full_subtractor4 m1(c_in14, diff[3:0], a[3:0], b[3:0], c_in);
    full_subtractor4 m2(c_in15, diff[7:4], a[7:4], b[7:4], c_in);
    full_subtractor4 m3(c_in16, diff[11:8], a[11:8], b[11:8], c_in);
    full_subtractor4 m4(co, diff[15:12], a[15:12], b[15:12], c_in);
endmodule

module full_subtractor4(input [3:0] a, b,
                         input c_in,
                         output [3:0] diff,
                         output co);

    wire c_in2, c_in3, c_in4;
    full_subtractor m1(c_in2, diff[0], a[0], b[0], c_in);
    full_subtractor m2(c_in3, diff[1], a[1], b[1], c_in2);
    full_subtractor m3(c_in4, diff[2], a[2], b[2], c_in3);
    full_subtractor m4(co, diff[3], a[3], b[3], c_in4);
endmodule

module full_subtractor(input a, b, c_in,
                  output diff, co)

    wire w1, w2, w3;
    half_subtractor m1(w2, w1, a, b);
    half_subtractor m2(w3, diff, c_in, w1);
    or m3(co, w2, w3);
endmodule

module half_subtractor(input a, b, c_in,
                  output diff, co)
    xor m1(diff, a, b);
    and m2(co, ~a, b);
endmodule
//End of code