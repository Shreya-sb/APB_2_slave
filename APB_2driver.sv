 //import uvm_pkg::*;
 //`include "uvm_macros.svh"
//`include "APB_2sequence_item.sv"

class APB_2driver extends uvm_driver#(APB_2sequence_item);

  virtual APB_2interface.APB_DRV vif;
  `uvm_component_utils(APB_2driver)

 
  function new(string name = "APB_2driver", uvm_component parent);
    super.new(name,parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual APB_2interface) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "not set");
  endfunction
 
  //Run phase
  task run_phase(uvm_phase phase);
   repeat(2) @(vif.APB_2driver_cb);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask
  
  //Drive task to drive all the signals into the DUT
  task drive();
    //drive data
 @(vif.APB_2driver_cb)
    begin
      vif.APB_2driver_cb.transfer <= req.transfer;
      vif.APB_2driver_cb.READ_WRITE <= req.READ_WRITE;
     if(req.transfer)
      begin
      if(req.READ_WRITE)
       vif.APB_2driver_cb.apb_read_paddr <= req.apb_read_paddr;
      else
       begin
        vif.APB_2driver_cb.apb_write_paddr <= req.apb_write_paddr;
        vif.APB_2driver_cb.apb_write_data <= req.apb_write_data;
       end
     end
      `uvm_info("driver", $sformatf("----Start of Driver----"), UVM_LOW);
      req.print();
      `uvm_info("driver", $sformatf("----End of Driver----"), UVM_LOW); 
 end
  endtask
endclass
