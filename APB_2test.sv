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

   //int mismatch_count = APB_2scoreboard.mismatch_count; // Replace with actual path

 
 /* function void report_phase(uvm_phase phase);
    uvm_report_server svr;
    super.report_phase(phase);
    svr = uvm_report_server::get_server();
    
  //
    if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0 +  svr.get_id_count("[Mismatch]") > 0)begin
     `uvm_info(get_type_name(), "------------------", UVM_NONE)
     `uvm_info(get_type_name(), "--   TEST FAIL  --", UVM_NONE)
     `uvm_info(get_type_name(), "------------------", UVM_NONE)
   end
   else begin
     `uvm_info(get_type_name(), "----------------", UVM_NONE)
     `uvm_info(get_type_name(), "--  TEST PASS --", UVM_NONE)
     `uvm_info(get_type_name(), "----------------", UVM_NONE)
   end
endfunction*/
endclass

class APB_2writeSlave0_test extends APB_2test;

  `uvm_component_utils(APB_2writeSlave0_test)

//Constructor
  function new(string name = "APB_2writeSlave0_test",uvm_component parent);
    super.new(name,parent);
  endfunction

 //connect phase 
 virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
 endfunction

 //end_of_elaboration phase
  virtual function void end_of_elaboration();
    print();
  endfunction
 
 //run phase 
  virtual task run_phase(uvm_phase phase);
    APB_2writeSequence_0 seq;
    phase.raise_objection(this);
    seq = APB_2writeSequence_0::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30); 
  endtask 
endclass

class APB_2writeSlave1_test extends APB_2test;

  `uvm_component_utils(APB_2writeSlave1_test)

//Constructor
  function new(string name = "APB_2writeSlave1_test",uvm_component parent);
    super.new(name,parent);
  endfunction

 //connect phase 
 virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
 endfunction

 //end_of_elaboration phase
  virtual function void end_of_elaboration();
    print();
  endfunction
 
 //run phase 
  virtual task run_phase(uvm_phase phase);
    APB_2writeSequence_1 seq;
    phase.raise_objection(this);
    seq = APB_2writeSequence_1::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30); 
  endtask 
endclass

class APB_2readSlave0_test extends APB_2test;

  `uvm_component_utils(APB_2readSlave0_test)

//Constructor
  function new(string name = "APB_2readSlave0_test",uvm_component parent);
    super.new(name,parent);
  endfunction

 //connect phase 
 virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
 endfunction

 //end_of_elaboration phase
  virtual function void end_of_elaboration();
    print();
  endfunction
 
 //run phase 
  virtual task run_phase(uvm_phase phase);
    APB_2readSequence_0 seq;
    phase.raise_objection(this);
    seq = APB_2readSequence_0::type_id::create("seq");
   // repeat(50)begin
    seq.start(env.active_agent.APB_2seqr);
   // end
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30); 
  endtask 
endclass

class APB_2readSlave1_test extends APB_2test;

  `uvm_component_utils(APB_2readSlave1_test)

//Constructor
  function new(string name = "APB_2readSlave1_test",uvm_component parent);
    super.new(name,parent);
  endfunction

 //connect phase 
 virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
 endfunction

 //end_of_elaboration phase
  virtual function void end_of_elaboration();
    print();
  endfunction
 
 //run phase 
  virtual task run_phase(uvm_phase phase);
    APB_2readSequence_1 seq;
    phase.raise_objection(this);
    seq = APB_2readSequence_1::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30); 
  endtask 
endclass


class APB_2writereadSlave0_test extends APB_2test;

  `uvm_component_utils(APB_2writereadSlave0_test)

//Constructor
  function new(string name = "APB_2writereadSlave0_test",uvm_component parent);
    super.new(name,parent);
  endfunction

 //connect phase 
 virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
 endfunction

 //end_of_elaboration phase
  virtual function void end_of_elaboration();
    print();
  endfunction
 
 //run phase 
  virtual task run_phase(uvm_phase phase);
    APB_2writereadSequence_0 seq;
    phase.raise_objection(this);
    seq = APB_2writereadSequence_0::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30); 
  endtask 
endclass

class APB_2writereadSlave1_test extends APB_2test;

  `uvm_component_utils(APB_2writereadSlave1_test)

//Constructor
  function new(string name = "APB_2writereadSlave1_test",uvm_component parent);
    super.new(name,parent);
  endfunction

 //connect phase 
 virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
 endfunction

 //end_of_elaboration phase
  virtual function void end_of_elaboration();
    print();
  endfunction
 
 //run phase 
  virtual task run_phase(uvm_phase phase);
    APB_2writereadSequence_1 seq;
    phase.raise_objection(this);
    seq = APB_2writereadSequence_1::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,30); 
  endtask 
endclass
