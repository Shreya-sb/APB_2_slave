`include "uvm_macros.svh"
import uvm_pkg::*;
`include "APB_2package.sv" 
`include "apbtop.v"

module top;
  bit pclk;
  bit presetn;
 
  always #5 pclk = ~ pclk;
 
  APB_2interface intf(.pclk(pclk),.presetn(presetn));
  
APB_Protocol dut (.PCLK(pclk),.PRESETn(presetn),
  .transfer(intf.transfer),
  .READ_WRITE(intf.READ_WRITE ),
  .apb_write_paddr(intf.apb_write_paddr),
  .apb_write_data(intf.apb_write_data),
  .apb_read_paddr(intf.apb_read_paddr ),
  .apb_read_data_out (intf.apb_read_data_out)
//  .PSLVERR          () // connect to a signal if you need to use PSLVERR
);

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
    run_test("APB_2writereadSlave0_test");
  end
 
endmodule
