`timescale 1ns/1ps

// Include register module definition
`include "hdl/general_reg/register.v"

module register_tb;

  // Declare register module instance
  reg clk, clr, enable;
  reg [31:0] D;
  wire [31:0] Q;

  register reg_instance(
    .clk(clk),
    .clr(clr),
    .enable(enable),
    .D(D),
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
    D = $random;
    enable = 1;
    #1000;
    enable = 0;
  end

  // Monitor for Q output
  initial begin
    $dumpfile("register_tb.vcd");
    $dumpvars(0, register_tb);
  end

endmodule