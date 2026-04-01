`timescale 1ns/1ps

`include "interface.sv"
`include "test.sv"

module testbench;
  
  // Clock generation
  bit clk;
  always #5 clk = ~clk;
  
  // Interface instance
  traffic_if t_if(clk);
  
  // DUT instance (Assuming design.sv is compiled in the same project)
  traffic_light_controller dut (
    .clk(t_if.clk),
    .rst_n(t_if.rst_n),
    .light_main(t_if.light_main),
    .light_side(t_if.light_side)
  );
  
  // Test program instance
  test t1(t_if);
  
  // Waveform dump for EDA playground
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule
