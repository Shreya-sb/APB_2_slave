 import uvm_pkg::*;
 `include "uvm_macros.svh"
//`include "APB_2sequence_item.sv"

class APB_2driver extends uvm_driver#(APB_2sequence_item);

  virtual APB_2interface.APB_DRV vif;
  `uvm_component_utils(APB_2driver)

  uvm_analysis_port #(APB_2sequence_item) item_collect_port;
 
  function new(string name = "APB_2driver", uvm_component parent);
    super.new(name,parent);
	item_collect_port = new("item_collect_port",this);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual APB_2interface) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "not set");
  endfunction
 
  //Run phase
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask
  
  //Drive task to drive all the signals into the DUT
  task drive();
    //drive data
  endtask
endclass
