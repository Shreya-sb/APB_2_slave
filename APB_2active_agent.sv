class APB_2active_agent extends uvm_agent;
 
  `uvm_component_utils(APB_2active_agent)
  APB_2sequencer APB_2seq;
  APB_2driver APB_2dri;
 
  function new(string name = "APB_2active_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     APB_2seq = APB_2sequencer::type_id::create("APB_2seq", this);
    APB_2dri = APB_2driver::type_id::create("APB_2dri", this);
  endfunction
 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     APB_2dri.seq_item_port.connect(APB_2seq.seq_item_export);
  endfunction
 
endclass
