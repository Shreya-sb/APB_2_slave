// import uvm_pkg::*;
//`include "uvm_macros.svh"
//`include "APB_2sequence_item.sv"
//`include "APB_2driver.sv"
//`include "APB_2sequencer.sv"
//`include "APB_2monitor_1.sv"

class APB_2active_agent extends uvm_agent;
 
  `uvm_component_utils(APB_2active_agent)
  APB_2sequencer APB_2seqr;
  APB_2driver APB_2dri;
  APB_2monitor_1 APB_2mon_1;
 
  function new(string name = "APB_2active_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    APB_2seqr = APB_2sequencer::type_id::create("APB_2seqr", this);
    APB_2dri = APB_2driver::type_id::create("APB_2dri", this);
    APB_2mon_1 = APB_2monitor_1::type_id::create("APB_2mon_1", this);  
  endfunction
 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     APB_2dri.seq_item_port.connect(APB_2seqr.seq_item_export);
  endfunction
 
endclass
