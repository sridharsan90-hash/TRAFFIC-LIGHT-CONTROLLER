`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV

`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator gen;
  driver driv;
  monitor mon;
  scoreboard scb;
  
  mailbox #(transaction) gen2driv;
  mailbox #(transaction) mon2scb;
  
  virtual traffic_if vif;
  
  function new(virtual traffic_if vif);
    this.vif = vif;
    gen2driv = new();
    mon2scb = new();
    
    gen = new(gen2driv);
    driv = new(vif, gen2driv);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction
  
  task test();
    fork
      gen.main();
      driv.main();
      mon.main();
      scb.main();
    join_any
  endtask
  
  task run();
    $display("=================================================");
    $display("   STARTING CLASS-BASED VERIFICATION ENV         ");
    $display("=================================================");
    test();
    // Run simulation for enough time to see a full cycle
    #500;
    $display("=================================================");
    $display("               SIMULATION FINISHED               ");
    $display("=================================================");
    $finish;
  endtask
endclass

`endif
