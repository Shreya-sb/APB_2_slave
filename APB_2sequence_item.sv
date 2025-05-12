//import uvm_pkg::*;
//`include "uvm_macros.svh"

class APB_2sequence_item extends uvm_sequence_item;
  
  rand bit transfer;
  rand bit READ_WRITE;
  rand bit [8:0]apb_write_paddr;
  rand bit [7:0]apb_write_data;
  rand bit [8:0]apb_read_paddr;
  logic  [7:0]apb_read_data_out;  
  
  `uvm_object_utils_begin(APB_2sequence_item)
  `uvm_field_int(transfer,UVM_ALL_ON)
  `uvm_field_int(READ_WRITE,UVM_ALL_ON)
  `uvm_field_int(apb_write_paddr,UVM_ALL_ON)
  `uvm_field_int(apb_write_data,UVM_ALL_ON)
  `uvm_field_int(apb_read_paddr,UVM_ALL_ON)
  `uvm_field_int(apb_read_data_out,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "APB_2sequence_item");
    super.new(name);
  endfunction
  
 /* constraint c1 { if(transfer ==0)
                 {READ_WRITE==0;
                 apb_write_paddr==0;
                 apb_write_data==0;
                 apb_read_paddr==0;
                 apb_read_data_out==0;
                }}
*/
//  constraint c2 {  apb_write_paddr[8] dist {0:=1,1:=1}; }
  constraint c3 {
    if (transfer==1 && READ_WRITE == 0) 
  {
    apb_write_paddr inside {[0:10]}; 
    apb_write_data inside {[0:255]};
  }
}
    constraint c4 {
      if (transfer== 1 && READ_WRITE == 1) {
    apb_read_paddr inside {[0:10]}; 
  }
}

endclass
