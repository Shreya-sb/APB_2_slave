class APB_2passive_agent extends uvm_agent;
 
  `uvm_component_utils(APB_2passive_agent)
  APB_2monitor APB_2mon;
 
  function new(string name = "APB_2passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    APB_2mon = APB_2monitor::type_id::create("APB_2mon", this);
  endfunction
 
endclass
