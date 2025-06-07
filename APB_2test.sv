class APB_2test extends uvm_test;
  `uvm_component_utils(APB_2test)
 
  APB_2environment env;
  APB_2sequence seq;
 
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
 
  task run_phase (uvm_phase phase);
    phase.raise_objection (this);
    seq = APB_2sequence::type_id::create("seq");
    phase.drop_objection (this);
  endtask: run_phase
endclass

class APB_2WriteSlave1_test extends APB_2test;
  `uvm_component_utils(APB_2WriteSlave1_test)
  function new(string name = "APB_2WriteSlave1_test",uvm_component parent);
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
    APB_2WriteSequence_1 seq;
    phase.raise_objection(this);
    seq = APB_2WriteSequence_1::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass

class APB_2WriteSlave2_test extends APB_2test;

  `uvm_component_utils(APB_2WriteSlave2_test)
    APB_2WriteSequence_2 seq;

//Constructor
  function new(string name = "APB_2WriteSlave2_test",uvm_component parent);
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
    phase.raise_objection(this);
    seq = APB_2WriteSequence_2::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass

class APB_2ReadSlave1_test extends APB_2test;

  `uvm_component_utils(APB_2ReadSlave1_test)
    APB_2ReadSequence_1 seq;
  function new(string name = "APB_2ReadSlave1_test",uvm_component parent);
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
    phase.raise_objection(this);
    seq = APB_2ReadSequence_1::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass

class APB_2ReadSlave2_test extends APB_2test;
  `uvm_component_utils(APB_2ReadSlave2_test)
      APB_2ReadSequence_2 seq;
  function new(string name = "APB_2ReadSlave2_test",uvm_component parent);
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
    phase.raise_objection(this);
    seq = APB_2ReadSequence_2::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass


class APB_2WriteReadSlave1_test extends APB_2test;
  `uvm_component_utils(APB_2WriteReadSlave1_test)
  APB_2WriteReadSequence_1 seq;
  function new(string name = "APB_2WriteReadSlave1_test",uvm_component parent);
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
    phase.raise_objection(this);
    seq = APB_2WriteReadSequence_1::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass

class APB_2WriteReadSlave2_test extends APB_2test;
  `uvm_component_utils(APB_2WriteReadSlave2_test)
  APB_2WriteReadSequence_2 seq;
  function new(string name = "APB_2WriteReadSlave2_test",uvm_component parent);
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
    phase.raise_objection(this);
    seq = APB_2WriteReadSequence_2::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass

class APB_2ContinuousWRSlave1_test extends APB_2test;
  `uvm_component_utils(APB_2ContinuousWRSlave1_test)
  APB_2ContinuousWRSequence_1 seq;
  function new(string name = "APB_2ContinuousWRSlave1_test",uvm_component parent);
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
    phase.raise_objection(this);
    seq = APB_2ContinuousWRSequence_1::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass

class APB_2ContinuousWRSlave2_test extends APB_2test;
  `uvm_component_utils(APB_2ContinuousWRSlave2_test)
  APB_2ContinuousWRSequence_2 seq;
  function new(string name = "APB_2ContinuousWRSlave2_test",uvm_component parent);
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
    phase.raise_objection(this);
    seq = APB_2ContinuousWRSequence_2::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass

class APB_2TransferValidityTest  extends APB_2test;
  `uvm_component_utils(APB_2TransferValidityTest)
  APB_2TransferValiditySequence  seq;
  function new(string name = "APB_2TransferValidityTest",uvm_component parent);
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
    phase.raise_objection(this);
    seq = APB_2TransferValiditySequence::type_id::create("seq");
    seq.start(env.active_agent.APB_2seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100); 
  endtask 
endclass
