`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

class scoreboard;
  mailbox #(transaction) mon2scb;
  
  function new(mailbox #(transaction) mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main();
    transaction trans;
    forever begin
      mon2scb.get(trans);
      // Basic check: Both lights should never be green at the same time
      // 3'b001 is GREEN in our encoding (Red=bit 2, Yellow=bit 1, Green=bit 0)
      if(trans.light_main == 3'b001 && trans.light_side == 3'b001)
        $display("[SCOREBOARD] ERROR! Both lights are GREEN! SAFETY VIOLATION!");
      else begin
        // Only display if out of reset and there's an active main light
        if (trans.rst_n == 1'b1)
          trans.display("SCOREBOARD");
      end
    end
  endtask
endclass

`endif
