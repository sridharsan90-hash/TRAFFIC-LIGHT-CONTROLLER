`ifndef TEST_SV
`define TEST_SV
`include "environment.sv"

program test(traffic_if vif);
  environment env;
  
  initial begin
    env = new(vif);
    env.run();
  end
endprogram

`endif
