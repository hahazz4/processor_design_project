`timescale 1ns/1ps

// Include the md_register module definition
`include "hdl/md_reg/md_register.v"

module md_register_tb;

  // Declare the md_register module instance
  reg clk, clr, enable, sel;
  reg [31:0] D1, D2;
  wire [31:0] Q;

  md_register md_register_instance(
    .clk(clk),
    .clr(clr),
    .enable(enable),
    .D1(D1),
    .D2(D2),
    .sel(sel),
    .Q(Q)
  );

  // Clock signal generator
  always #10 clk = ~clk;

  // Reset generator
  initial begin
    clr = 1;
    #100;
    clr = 0;
  end

  // Data generator
  initial begin
    D1 = $random;
    D2 = $random;
    sel = 1'b0; // Set to D2
    enable = 1;
    #1000;
    enable = 0;
  end

  // Monitor for Q output
  initial begin
    $dumpfile("md_register_tb.vcd");
    $dumpvars(0, md_register_tb);
  end

endmodule
