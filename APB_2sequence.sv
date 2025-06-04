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

//write sequence for slave 1
class APB_2WriteSequence_1 extends APB_2sequence;
  `uvm_object_utils(APB_2WriteSequence_1)
  
    APB_2sequence_item item;
  
  function new(string name = "APB_2WriteSequence_1");
    super.new(name);
  endfunction
  
  virtual task body();
    item = APB_2sequence_item::type_id::create("item");
    repeat(2) begin
    `uvm_do_with(item,{transfer==1; READ_WRITE==0; apb_write_paddr[8]==0;}) 
  //   `uvm_send(item)
   end
  endtask
endclass:APB_2WriteSequence_1

//write sequence for slave 2
class APB_2WriteSequence_2 extends APB_2sequence;
  `uvm_object_utils(APB_2WriteSequence_2)
  
    APB_2sequence_item item;
  
  function new(string name = "APB_2WriteSequence_2");
    super.new(name);
  endfunction
  
  virtual task body();
    item = APB_2sequence_item::type_id::create("item");
    repeat(10) begin
    `uvm_do_with(item,{transfer==1;READ_WRITE==0;apb_write_paddr[8]==1;})
    //`uvm_send(item)
 end
 endtask
endclass:APB_2WriteSequence_2

//read sequence for slave 1
class APB_2ReadSequence_1 extends APB_2sequence;
  `uvm_object_utils(APB_2ReadSequence_1)

    APB_2sequence_item item;
  
  function new(string name = "APB_2ReadSequence_1");
    super.new(name);
  endfunction
  
  virtual task body();
      item = APB_2sequence_item::type_id::create("item");
    repeat(10) begin
    `uvm_do_with(item,{transfer==1;READ_WRITE==1;apb_write_paddr[8]==0;}) 
   // `uvm_send(item)
    end
  endtask
endclass:APB_2ReadSequence_1

//read sequence for slave 2
class APB_2ReadSequence_2 extends APB_2sequence;
  `uvm_object_utils(APB_2ReadSequence_2)
  
    APB_2sequence_item item;
  
  function new(string name = "APB_2ReadSequence_2");
    super.new(name);
  endfunction
  
  virtual task body();
      item = APB_2sequence_item::type_id::create("item");
    repeat(10) begin
      `uvm_do_with(item,{transfer==1;READ_WRITE==1;apb_write_paddr[8]==1;})
     // `uvm_send(item)
    end
  endtask
endclass:APB_2ReadSequence_2


class APB_2WriteReadSequence_1 extends APB_2sequence;
  `uvm_object_utils(APB_2WriteReadSequence_1)
  
    APB_2sequence_item item;
    bit [8:0] w_addr;
  
  function new(string name = "APB_2WriteReadSequence_1");
    super.new(name);
  endfunction
  
  virtual task body();
    item = APB_2sequence_item::type_id::create("item");
    repeat(10)begin
    `uvm_do_with(item, {
        transfer == 1;
        READ_WRITE == 0;
        apb_write_paddr[8] == 0;
    })
      //`uvm_send(item)
      w_addr = item.apb_write_paddr;
      
   
  // Then send read item with the same address
    `uvm_do_with(item, {
        transfer == 1;
        READ_WRITE == 1;
        apb_read_paddr == w_addr;
    })
     //`uvm_send(item)
    end
endtask 
endclass:APB_2WriteReadSequence_1

class APB_2WriteReadSequence_2 extends APB_2sequence;
  `uvm_object_utils(APB_2WriteReadSequence_2)
  
    APB_2sequence_item item;
  bit [8:0] w_addr;
  
  function new(string name = "APB_2WriteReadSequence_2");
    super.new(name);
  endfunction
  
  virtual task body();
    item = APB_2sequence_item::type_id::create("item");
    repeat(10)begin
    // First randomize and send write item
    `uvm_do_with(item, {
        transfer == 1;
        READ_WRITE == 0;
      apb_write_paddr[8] == 1;
    })
      //`uvm_send(item);
      w_addr = item.apb_write_paddr;
      
     //w_item.apb_write_paddr.rand_mode(0); 
   
  // Then send read item with the same address
    `uvm_do_with(item, {
        transfer == 1;
        READ_WRITE == 1;
        apb_read_paddr == w_addr;
    })
      //      `uvm_send(item);
    end
endtask 
endclass:APB_2WriteReadSequence_2

