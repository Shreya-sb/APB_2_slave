// import uvm_pkg::*;
// `include "uvm_macros.svh"
//`include "APB_2sequence_item.sv"


class APB_2sequence extends uvm_sequence#(APB_2sequence_item);
  `uvm_object_utils(APB_2sequence)
  APB_2sequence_item req;
  
  function new(string name = "APB_2sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    req = APB_2sequence_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
  endtask
  
endclass

//write sequence for slave 0
class APB_2writeSequence_0 extends APB_2sequence;
    `uvm_object_utils(APB_2writeSequence_0)
  
    APB_2sequence_item item;
  
  function new(string name = "APB_2writeSequence_0");
    super.new(name);
  endfunction
  
  virtual task body();
      item = APB_2sequence_item::type_id::create("item");
      `uvm_do_with(item,{transfer==1; READ_WRITE==0; apb_write_paddr[8]==0;}) 
  endtask
endclass:APB_2writeSequence_0

//write sequence for slave 1
class APB_2writeSequence_1 extends APB_2sequence;
    `uvm_object_utils(APB_2writeSequence_1)
  
    APB_2sequence_item item;
  
  function new(string name = "APB_2writeSequence_1");
    super.new(name);
  endfunction
  
  virtual task body();
      item = APB_2sequence_item::type_id::create("item");
      `uvm_do_with(item,{transfer==1;READ_WRITE==0;apb_write_paddr[8]==1;}) 
  endtask
endclass:APB_2writeSequence_1

//read sequence for slave 0
class APB_2readSequence_0 extends APB_2sequence;
  `uvm_object_utils(APB_2readSequence_0)
  
    APB_2sequence_item item;
  
  function new(string name = "APB_2readSequence_0");
    super.new(name);
  endfunction
  
  virtual task body();
      item = APB_2sequence_item::type_id::create("item");
      `uvm_do_with(item,{transfer==1;READ_WRITE==1;apb_write_paddr[8]==0;}) 
  endtask
endclass:APB_2readSequence_0

//read sequence for slave 1
class APB_2readSequence_1 extends APB_2sequence;
  `uvm_object_utils(APB_2readSequence_1)
  
    APB_2sequence_item item;
  
  function new(string name = "APB_2readSequence_1");
    super.new(name);
  endfunction
  
  virtual task body();
      item = APB_2sequence_item::type_id::create("item");
      `uvm_do_with(item,{transfer==1;READ_WRITE==1;apb_write_paddr[8]==0;}) 
  endtask
endclass:APB_2readSequence_1
