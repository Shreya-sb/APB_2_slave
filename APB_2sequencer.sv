// import uvm_pkg::*;
// `include "uvm_macros.svh"
//`include "APB_2sequence_item.sv"
class APB_2sequencer extends uvm_sequencer #(APB_2sequence_item);
  `uvm_component_utils(APB_2sequencer)
  function new (string name="APB_2sequencer", uvm_component parent);
    super.new(name, parent); 
  endfunction
 
endclass
