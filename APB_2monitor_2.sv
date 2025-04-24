 //import uvm_pkg::*;
//`include "uvm_macros.svh"
//`include "APB_2sequence_item.sv"

class APB_2monitor_2 extends uvm_monitor;
  `uvm_component_utils(APB_2monitor_2)
 
  // Virtual interface for connecting to the DUT
  virtual APB_2interface.APB_2MON vif;
 
  // Analysis port for broadcasting transactions
  uvm_analysis_port #(APB_2sequence_item) item_collect_port2;
 
  // Handle for the sequence item
  APB_2sequence_item APB_2mon_item;
 
  // Constructor
  function new(string name = "APB_2monitor_2", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collect_port2 = new("item_collect_port2", this);
    if (!uvm_config_db#(virtual APB_2interface)::get(this, "", "vif", vif))
      `uvm_fatal("APB_2monitor_2", "Virtual interface not set for APB_2monitor_2");
  endfunction
 
  // Run phase
  task run_phase(uvm_phase phase);
    //Define a task for run phase 
     repeat(1)@(vif.APB_2monitor_cb);
    forever begin
      @(vif.APB_2monitor_cb)
      
      // Sample DUT information and populate the transaction
      APB_2mon_item = APB_2sequence_item::type_id::create("APB_2mon_item", this);
      APB_2mon_item.transfer         = vif.APB_2monitor_cb.transfer;
      APB_2mon_item.READ_WRITE       = vif.APB_2monitor_cb.READ_WRITE;
      APB_2mon_item.apb_write_paddr  = vif.APB_2monitor_cb.apb_write_paddr;
      APB_2mon_item.apb_write_data   = vif.APB_2monitor_cb.apb_write_data;
      APB_2mon_item.apb_read_paddr   = vif.APB_2monitor_cb.apb_read_paddr;
      APB_2mon_item.apb_read_data_out= vif.APB_2monitor_cb.apb_read_data_out;

      
      // Broadcast the transaction using the analysis port
      item_collect_port2.write(APB_2mon_item);
      
      `uvm_info("MONITOR_1",$sformatf("transfer=%0d READ_WRITE=%0d apb_write_paddr=%0d,apb_write_data=%0d,apb_read_paddr=%0d,apb_read_data_out=%0d",APB_2mon_item.transfer,APB_2mon_item.READ_WRITE,APB_2mon_item.apb_write_paddr,APB_2mon_item.apb_write_data,APB_2mon_item.apb_read_paddr,APB_2mon_item.apb_read_data_out),UVM_LOW)
	  repeat(2)@(vif.APB_2monitor_cb); 
    end
  endtask
 
endclass
