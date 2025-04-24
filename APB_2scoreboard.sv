// import uvm_pkg::*;
// `include "uvm_macros.svh"
//`include "APB_2sequence_item.sv"

`uvm_analysis_imp_decl(_monitor1port)
`uvm_analysis_imp_decl(_monitor2port)


class APB_2scoreboard extends uvm_scoreboard;
  
  //declare anslysis imports
    uvm_analysis_imp_monitor1port #(APB_2sequence_item, APB_2scoreboard) item_collect1_export;
    uvm_analysis_imp_monitor2port #(APB_2sequence_item, APB_2scoreboard) item_collect2_export;
  
// Declare a virtual interface handle to APB_2interface
  virtual APB_2interface vif;
  //Register the scoreboard with the UVM factory
  `uvm_component_utils(APB_2scoreboard)
  
  //Two queues to store incoming transactions temporarily
  APB_2sequence_item input_queue[$];
  APB_2sequence_item output_queue[$];
  
  //2 Sequence item handle to store transaction
  APB_2sequence_item monitor1_trans;
  APB_2sequence_item monitor2_trans;
  
    bit [7:0] mem_model[0:255];
  
  //Define a new constructor method
  function new(string name = "APB_2scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  //Define build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     item_collect1_export = new("item_collect1_export", this);
    item_collect2_export = new("item_collect2_export", this);

    if (!uvm_config_db#(virtual APB_2interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal("APB_SCOREBOARD", "Virtual interface not set for APB_scoreboard")
    end
  endfunction

  //Write methods to capture transactions from monitors
  function void write_monitor1port(APB_2sequence_item input_trans);
    $display("Entered monitor1 write");
    input_queue.push_back(input_trans);
  endfunction
  
 
  function void write_monitor2port(APB_2sequence_item output_trans);
    $display("Entered monitor2 write");
    output_queue.push_back(output_trans);
  endfunction
  
    // Comparison logic
  function void compare_results(APB_2sequence_item input_trans,APB_2sequence_item output_trans);
    if( monitor1_trans.apb_write_data == monitor2_trans.apb_write_data && monitor1_trans.apb_read_data_out == monitor2_trans.apb_read_data_out)
      begin
        monitor1_trans.print();
        `uvm_info("READ AND WRITE Match","",UVM_LOW)
        monitor2_trans.print();
      end
    else begin
      monitor1_trans.print();
      `uvm_error("READ AND WRITE Mismatch","")
      monitor2_trans.print();
    end
  endfunction
       
    // Main run phase
  task run_phase (uvm_phase phase);
    forever begin
      wait(input_queue.size() >0 && output_queue.size() >0);
      monitor1_trans = input_queue.pop_front();
      monitor2_trans = output_queue.pop_front();
      
      if(monitor1_trans.transfer)begin
        if(monitor1_trans.READ_WRITE)begin
          mem_model[monitor1_trans.apb_write_paddr] = monitor1_trans.apb_write_data;
          compare_results(monitor1_trans, monitor2_trans);
        end
        else begin
          monitor1_trans.apb_read_data_out = mem_model[monitor1_trans.apb_read_paddr];
          compare_results(monitor1_trans,monitor2_trans);
        end
      end
    end
  endtask
endclass
