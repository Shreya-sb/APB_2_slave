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
 
  int match = 0;
  int  mismatch = 0;  
 
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
    $display("Enteredwrite");
    input_queue.push_back(input_trans);
    `uvm_info("SB", $sformatf(
      "EXPECTED TRANSACTION: size = %0d | TRANSFER = %0d | RW = %0d | WDATA = %0h | WPADDR = %0h | RPADDR = %0h",
      input_queue.size(), input_trans.transfer, input_trans.READ_WRITE, input_trans.apb_write_data, input_trans.apb_write_paddr, input_trans.apb_read_paddr), UVM_LOW)
  endfunction
  
 
  function void write_monitor2port(APB_2sequence_item output_trans);
    $display("Entered monitor2 write");
    output_queue.push_back(output_trans);
    `uvm_info("SB", $sformatf(
    "ACTUAL TRANSACTION: size = %0d | TRANSFER = %0d | RW = %0d | WPADDR = %0h | WDATA = %0h | RDATA = %0h | RPADDR = %0h",
      output_queue.size(), output_trans.transfer, output_trans.READ_WRITE, output_trans.apb_write_paddr, output_trans.apb_write_data, output_trans.apb_read_data_out, output_trans.apb_read_paddr), UVM_LOW)
  endfunction
  
    // Comparison logic
/*  function void compare_results(APB_2sequence_item input_trans,APB_2sequence_item output_trans);
   if(monitor1_trans.READ_WRITE)
   begin
    if( monitor1_trans.apb_read_data_out == monitor2_trans.apb_read_data_out && monitor1_trans.apb_read_paddr == monitor2_trans.apb_read_paddr)
      begin
        monitor1_trans.print();
        `uvm_info("Match","",UVM_LOW)
        monitor2_trans.print();
      end
    else begin
      monitor1_trans.print();
      `uvm_error("READ Mismatch","")
      monitor2_trans.print();
    end
   end
   else
    begin
     if( monitor1_trans.apb_write_data == monitor2_trans.apb_write_data && monitor1_trans.apb_write_paddr == monitor2_trans.apb_write_paddr)
      begin

      `uvm_info("MONITOR 1", $sformatf("----Start of MONITOR1----"), UVM_LOW);
        monitor1_trans.print();
        `uvm_info(" WRITE Match","",UVM_LOW)
      `uvm_info("MONITOR 2", $sformatf("----Start of MONITOR2----"), UVM_LOW);

        monitor2_trans.print();
      end
    else begin
      monitor1_trans.print();
      `uvm_error("WRITE Mismatch","")
      monitor2_trans.print();
    end

    end
  endfunction
  */

function void compare_results(APB_2sequence_item input_trans,APB_2sequence_item output_trans);
 // if(monitor1_trans.transfer)
// begin  
  if(monitor1_trans.READ_WRITE)
   begin
    if( monitor1_trans.apb_read_data_out == monitor2_trans.apb_read_data_out && monitor1_trans.apb_read_paddr == monitor2_trans.apb_read_paddr)
      begin
        match++;
         monitor1_trans.print();

        `uvm_info("Match",$sformatf("Match count = %0d", match),UVM_LOW);
        `uvm_info("COMPARE", $sformatf("READ PASS | EXPECTED RDATA = %0h  ACTUAL RDATA =%0h |EXPECTED  READ ADDR = %0h ACTUAL READ ADDR =%0h",
                    monitor1_trans.apb_read_data_out,monitor2_trans.apb_read_data_out,monitor1_trans.apb_read_paddr,monitor2_trans.apb_read_paddr ), UVM_LOW)
         monitor2_trans.print();

        //$display("-------------------Test PASS---------------------\n");
      end
    else begin
      mismatch++;
      monitor1_trans.print();
      `uvm_info("Mismatch",$sformatf("Mismatch count = %0d", mismatch),UVM_LOW);
      `uvm_error("COMPARE", $sformatf("READ PASS | EXPECTED RDATA = %0h  ACTUAL RDATA =%0h |EXPECTED  READ ADDR = %0h ACTUAL READ ADDR =%0h",
                    monitor1_trans.apb_read_data_out,monitor2_trans.apb_read_data_out,monitor1_trans.apb_read_paddr,monitor2_trans.apb_read_paddr ))
       monitor2_trans.print();
      //$display("-------------------Test FAIL---------------------\n");
    end
   end
   else
    begin
     if( monitor1_trans.apb_write_data == monitor2_trans.apb_write_data && monitor1_trans.apb_write_paddr == monitor2_trans.apb_write_paddr)
      begin
        match++;
        monitor1_trans.print();
      `uvm_info("Match",$sformatf("Match count = %0d", match),UVM_LOW)
        `uvm_info("COMPARE", $sformatf("WRITE PASS | EXPECTED WDATA = %0h  ACTUAL WDATA =%0h |EXPECTED  WRITE ADDR = %0h ACTUAL WRITE ADDR =%0h",
                    monitor1_trans.apb_write_data,monitor2_trans.apb_write_data,monitor1_trans.apb_write_paddr,monitor2_trans.apb_write_paddr ), UVM_LOW)
          monitor2_trans.print();
        //$display("-------------------Test PASS---------------------\n");
      end
    else begin
      mismatch++;
         monitor1_trans.print();
      `uvm_info("Mismatch",$sformatf("Mismatch count = %0d", mismatch),UVM_LOW)
      `uvm_error("COMPARE", $sformatf("WRITE FAIL | EXPECTED WDATA = %0h  ACTUAL WDATA =%0h |EXPECTED  WRITE ADDR = %0h ACTUAL WRITE ADDR =%0h",
                    monitor1_trans.apb_write_data,monitor2_trans.apb_write_data,monitor1_trans.apb_write_paddr,monitor2_trans.apb_write_paddr ))
       monitor2_trans.print();
      //$display("-------------------Test FAIL---------------------\n");
    end

    end
 // end
  endfunction
     
    // Main run phase
  task run_phase (uvm_phase phase);
     super.run_phase(phase);
    forever begin
      wait(input_queue.size() >0 && output_queue.size() >0);
      monitor1_trans = input_queue.pop_front();
      monitor2_trans = output_queue.pop_front();
      
      if(monitor1_trans.transfer)begin
        if(monitor1_trans.READ_WRITE==0)begin
          mem_model[monitor1_trans.apb_write_paddr] = monitor1_trans.apb_write_data;
          //compare_results(monitor1_trans, monitor2_trans);
        end
        else begin
          monitor1_trans.apb_read_data_out = mem_model[monitor1_trans.apb_read_paddr];
        end
          compare_results(monitor1_trans,monitor2_trans);

      end
    end
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCOREBOARD", "-----------------------------", UVM_NONE)
    `uvm_info("SCOREBOARD", $sformatf("PASSED: %0d", match), UVM_NONE)
    `uvm_info("SCOREBOARD", $sformatf("FAILED: %0d", mismatch), UVM_NONE)
    `uvm_info("SCOREBOARD", "-----------------------------", UVM_NONE)
  endfunction
endclass
