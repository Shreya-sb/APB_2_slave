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
  endtask
 
endclass
