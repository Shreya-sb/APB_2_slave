// import uvm_pkg::*;
// `include "uvm_macros.svh"
//`include "APB_2monitor_2.sv"

class APB_2passive_agent extends uvm_agent;
 
  `uvm_component_utils(APB_2passive_agent)
  APB_2monitor_2 APB_2mon_2;
 
  function new(string name = "APB_2passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    APB_2mon_2 = APB_2monitor_2::type_id::create("APB_2mon_2", this);
  endfunction
 
endclass
