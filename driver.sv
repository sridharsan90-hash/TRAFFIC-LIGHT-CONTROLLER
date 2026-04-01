`ifndef DRIVER_SV
`define DRIVER_SV

class driver;
  virtual traffic_if vif;
  mailbox #(transaction) gen2driv;
  
  function new(virtual traffic_if vif, mailbox #(transaction) gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task main();
    transaction trans;
    forever begin
      gen2driv.get(trans);
      vif.rst_n <= trans.rst_n;
    end
  endtask
endclass

`endif
