class APB_2test extends uvm_test;
  `uvm_component_utils(APB_2test)
 
//Handle for APB_2environment class
  APB_2environment env;
 
//Constructor
  function new(string name = "APB_2test",uvm_component parent);
    super.new(name,parent);
  endfunction
 
  //Implementing the build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = APB_2environment::type_id::create("env",this);
  endfunction
 
 
//end_of_elaboration phase
  virtual function void end_of_elaboration();
    print();
  endfunction
 
  function void report_phase(uvm_phase phase);
    uvm_report_server svr;
    super.report_phase(phase);
    svr = uvm_report_server::get_server();
    if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0)begin
     `uvm_info(get_type_name(), "------------------", UVM_NONE)
     `uvm_info(get_type_name(), "--   TEST FAIL  --", UVM_NONE)
     `uvm_info(get_type_name(), "------------------", UVM_NONE)
   end
   else begin
     `uvm_info(get_type_name(), "----------------", UVM_NONE)
     `uvm_info(get_type_name(), "--  TEST PASS --", UVM_NONE)
     `uvm_info(get_type_name(), "----------------", UVM_NONE)
   end
endfunction
endclass

class apb_write_seq_test extends APB_2test;

  `uvm_component_utils(apb_write_seq_test)

//Constructor
  function new(string name = "apb_write_seq_test",uvm_component parent);
    super.new(name,parent);
  endfunction

 //end_of_elaboration phase
  virtual function void end_of_elaboration();
    print();
  endfunction
 
 //run phase 
  virtual task run_phase(uvm_phase phase);
    apb_write_seq seq;
    seq = apb_write_seq::type_id::create("seq");
    phase.raise_objection(this);
    seq.start(env.active_agent.APB_2seq);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30); 
  endtask 
endclass
