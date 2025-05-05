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
    `uvm_do_with(item,{transfer==0; READ_WRITE==0; apb_write_paddr[8]==0;}) 
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
    `uvm_do_with(item,{transfer==0;READ_WRITE==0;apb_write_paddr[8]==1;}) 
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
    `uvm_do_with(item,{transfer==0;READ_WRITE==1;apb_write_paddr[8]==0;}) 
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
    `uvm_do_with(item,{transfer==0;READ_WRITE==1;apb_write_paddr[8]==0;}) 
  endtask
endclass:APB_2readSequence_1



class APB_2writereadSequence_0 extends APB_2sequence;
  `uvm_object_utils(APB_2writereadSequence_0)
  
    APB_2sequence_item w_item;
    APB_2sequence_item r_item;

  function new(string name = "APB_2writereadSequence_0");
    super.new(name);
  endfunction
  
  virtual task body();
    w_item = APB_2sequence_item::type_id::create("w_item");
    r_item = APB_2sequence_item::type_id::create("r_item");
    
    // First randomize and send write item
    `uvm_do_with(w_item, {
        transfer == 0;
        READ_WRITE == 0;
        apb_write_paddr[8] == 0;
    })
     w_item.apb_write_paddr.rand_mode(0); 
   
  // Then send read item with the same address
    `uvm_do_with(r_item, {
        transfer == 0;
        READ_WRITE == 1;
        apb_read_paddr == w_item.apb_write_paddr;
    })
endtask 
endclass:APB_2writereadSequence_0

class APB_2writereadSequence_1 extends APB_2sequence;
  `uvm_object_utils(APB_2writereadSequence_1)
  
    APB_2sequence_item w_item;
    APB_2sequence_item r_item;

  function new(string name = "APB_2writereadSequence_1");
    super.new(name);
  endfunction
  
  virtual task body();
    w_item = APB_2sequence_item::type_id::create("w_item");
    r_item = APB_2sequence_item::type_id::create("r_item");
    
    // First randomize and send write item
    `uvm_do_with(w_item, {
        transfer == 0;
        READ_WRITE == 0;
        apb_write_paddr[8] == 1;
    })
     w_item.apb_write_paddr.rand_mode(0); 
   
  // Then send read item with the same address
    `uvm_do_with(r_item, {
        transfer == 0;
        READ_WRITE == 1;
        apb_read_paddr == w_item.apb_write_paddr;
    })
endtask 
  endclass:APB_2writereadSequence_1

/*class APB_2writereadSequence_1 extends APB_2sequence;
  `uvm_object_utils(APB_2writereadSequence_1)
  
    APB_2sequence_item w_item;
    APB_2sequence_item r_item;

  
  function new(string name = "APB_2writereadSequence_1");
    super.new(name);
  endfunction
  
  virtual task body();
    w_item = APB_2sequence_item::type_id::create("w_item");
    r_item = APB_2sequence_item::type_id::create("r_item");
    `uvm_do_with(w_item,{transfer==1;READ_WRITE==0;apb_write_paddr[8]==1;}) 
   // w_item.apb_write_paddr.rand_mode(0);
   // `uvm_do_with(r_item,{transfer==1;READ_WRITE==1;apb_read_paddr == w_item.apb_write_paddr;}) 
     r_item.transfer = 1;
    r_item.READ_WRITE = 1;
    r_item.apb_read_paddr = w_item.apb_write_paddr;
    r_item.apb_read_paddr.rand_mode(0); // Lock it from being randomized accidentally

    start_item(r_item);
    finish_item(r_item);
  endtask
endclass:APB_2writereadSequence_1

/*class APB_2writereadSequence_1 extends APB_2sequence;
    `uvm_object_utils(APB_2writereadSequence_1)

    APB_2sequence_item w_item;
    APB_2sequence_item r_item;
    bit [31:0] saved_addr; // To store the write address

    function new(string name = "APB_2writereadSequence_1");
        super.new(name);
    endfunction

    virtual task body();
        w_item = APB_2sequence_item::type_id::create("w_item");
        r_item = APB_2sequence_item::type_id::create("r_item");
        
        // First randomize and send write item
        `uvm_do_with(w_item, {
            transfer == 1;
            READ_WRITE == 0;
            apb_write_paddr[8] == 1;
        })
        
        // Save the write address
        saved_addr = w_item.apb_write_paddr;
        
        // Then send read item with the same address
        `uvm_do_with(r_item, {
            transfer == 1;
            READ_WRITE == 1;
            apb_read_paddr == saved_addr;
        })
    endtask
endclass: APB_2writereadSequence_1*/
