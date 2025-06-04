//`include "APB2slave_define.sv"
//import uvm_pkg::*;
//`include "uvm_macros.svh"

interface APB_2interface(input bit pclk,presetn);
  logic transfer;
  logic READ_WRITE;
  logic [8:0]apb_write_paddr;
  logic [7:0]apb_write_data;
  logic [8:0]apb_read_paddr;
  logic [7:0]apb_read_data_out;
  
  clocking APB_2driver_cb @(posedge pclk);
    default input #0 output #0;
    output transfer;
    output READ_WRITE;
    output apb_write_paddr;
    output apb_write_data;
    output apb_read_paddr;
  endclocking
  
  clocking APB_2monitor_cb @(posedge pclk);
    default input #0 output #0;
    input apb_read_data_out;
    input transfer;
    input READ_WRITE;
    input apb_write_paddr;
    input apb_write_data;
    input apb_read_paddr;
  endclocking
  
  modport APB_2DRV   (clocking APB_2driver_cb);
  modport APB_2MON   (clocking APB_2monitor_cb);

endinterface
    
