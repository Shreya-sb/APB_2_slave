`include "APB2slave_define.sv"
interface APB_2interface(input bit pclk,presetn);
  logic transfer;
  logic READ_WRITE;
  logic [7:0]apb_write_paddr;
  logic [7:0]apb_write_data;
  logic [7:0]apb_read_paddr;
  logic [7:0]apb_read_data_out;
  
  clocking APB_2driver_cb @(posedge pclk);
    default input #0 output #0;
    output transfer;
    output READ_WRITE;
    output [7:0]apb_write_paddr;
    output [7:0]apb_write_data;
    output [7:0]apb_read_paddr;
    input presetn;
  endclocking
  
  clocking APB_2monitor_cb @(posedge pclk);
    default input #0 output #0;
    input [7:0]apb_read_data_out;
  endclocking
  
  modport APB_2DRV   (clocking APB_2driver_cb);
  modport APB_2MON   (clocking APB_2monitor_cb);

endinterface
    
