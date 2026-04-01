`ifndef GENERATOR_SV
`define GENERATOR_SV

class generator;
  transaction trans;
  mailbox #(transaction) gen2driv;
  
  function new(mailbox #(transaction) gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  task main();
    // Assert reset
    trans = new();
    trans.rst_n = 0; 
    gen2driv.put(trans);
    
    #20; // Wait 20 time units
    
    // Release reset
    trans = new();
    trans.rst_n = 1; 
    gen2driv.put(trans);
  endtask
endclass

`endif
