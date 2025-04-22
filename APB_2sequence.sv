class APB_2sequence extends uvm_sequence#(APB_2sequence_item);
  `uvm_object_utils(APB_2sequence)
  
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

//rest of the test sequences
