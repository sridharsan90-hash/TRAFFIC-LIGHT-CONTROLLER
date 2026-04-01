`ifndef INTERFACE_SV
`define INTERFACE_SV

interface traffic_if(input logic clk);
  logic rst_n;
  logic [2:0] light_main;
  logic [2:0] light_side;
endinterface

`endif
