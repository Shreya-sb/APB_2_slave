`include "uvm_macros.svh"
import uvm_pkg::*;
`include "APB_2package.sv" 

module top;
  bit pclk;
  bit presetn;
 
  always #5 pclk = ~ pclk;
 
  APB_2interface intf(.pclk(pclk),.presetn(presetn));
 
  initial begin
    presetn = 0;
    #10 presetn = 1;
    #15 presetn = 0;
  end
  
  //apb_slave dut();
 
  initial begin
    uvm_config_db#(virtual APB_2interface)::set(uvm_root::get(),"*","vif",intf);
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
  initial begin
    run_test("APB_2write_test");
  end
 
endmodule
