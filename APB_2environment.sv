 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "APB_2active_agent.sv"
`include "APB_2passive_agent.sv"
`include "APB_2scoreboard.sv"


class APB_2environment extends uvm_env;
  `uvm_component_utils(APB_2environment)
 
  APB_2active_agent active_agent;
  APB_2passive_agent passive_agent;
  APB_2scoreboard scoreboard;
  //APB_2coverage coverage;
 
  function new(string name = "APB_2environment",uvm_component parent);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    active_agent = APB_2active_agent::type_id::create("active_agent", this);
    scoreboard = APB_2scoreboard::type_id::create("scoreboard", this);
    // Create the coverage collector
    //coverage = APB_2coverage::type_id::create("coverage", this);
    // Create the passive agent
    passive_agent = APB_2passive_agent::type_id::create("passive_agent", this);
  endfunction
 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);    
    active_agent.APB_2mon_1.item_collect_port.connect(scoreboard.item_collect1_export);
    //active_agent.APB_2driver.item_collect_port.connect(coverage.cov_in_export);
    passive_agent.APB_2mon_2.item_collect_port2.connect(scoreboard.item_collect2_export);
    //passive_agent.APB_2monitor.item_collect_port.connect(coverage.cov_out_export);
  endfunction
endclass
