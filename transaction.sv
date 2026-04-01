`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;
  bit rst_n;
  bit [2:0] light_main;
  bit [2:0] light_side;
  
  function void display(string name);
    $display("[%s] Time=%0t | rst_n=%0b | main=%0b | side=%0b", name, $time, rst_n, light_main, light_side);
  endfunction
endclass

`endif
