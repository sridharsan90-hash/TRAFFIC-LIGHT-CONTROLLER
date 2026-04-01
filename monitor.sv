`ifndef MONITOR_SV
`define MONITOR_SV

class monitor;
  virtual traffic_if vif;
  mailbox #(transaction) mon2scb;
  
  function new(virtual traffic_if vif, mailbox #(transaction) mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task main();
    transaction trans;
    forever begin
      @(posedge vif.clk);
      trans = new();
      trans.rst_n = vif.rst_n;
      trans.light_main = vif.light_main;
      trans.light_side = vif.light_side;
      mon2scb.put(trans);
    end
  endtask
endclass

`endif
