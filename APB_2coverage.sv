
`uvm_analysis_imp_decl(_inputport)
`uvm_analysis_imp_decl(_outputport)

class APB_2coverage extends uvm_subscriber#(APB_2sequence_item);

  `uvm_component_utils(APB_2coverage)

  // Analysis ports
  uvm_analysis_imp_inputport#(APB_2sequence_item, APB_2coverage) cov_in_export;
  uvm_analysis_imp_outputport#(APB_2sequence_item, APB_2coverage) cov_out_export;

  APB_2sequence_item seq_item;
  real input_cov, output_cov;
  
  covergroup input_cg;
    
    READ_WRITE_CP:coverpoint seq_item.READ_WRITE {
      bins READ_WRITE_0 = {1'b0};
      bins READ_WRITE_1 = {1'b1};
    }
    
    TRANSFER_CP:coverpoint seq_item.transfer {
      bins transfer_0 = {1'b0};
      bins transfer_1 = {1'b1};
    }
    
    APB_WRITE_PADDR_CP:coverpoint seq_item.apb_write_paddr {
       bins write_paddr = {[9'h000:9'h1FF]};
    }
    
    
    APB_WRITE_SLAVE_SELECT_CP:coverpoint seq_item.apb_write_paddr[8] {
      bins write_paddr_s0_0 = {1'b0};
      bins write_paddr_s1_1 = {1'b1};
    }
    
    APB_READ_SLAVE_SELECT_CP:coverpoint seq_item.apb_read_paddr[8] {
      bins read_paddr_s0_0 = {1'b0};
      bins read_paddr_s1_1 = {1'b1};
    }
    
    APB_WRITE_DATA_CP:coverpoint seq_item.apb_write_data {
      bins write_data = {[0:255]};
    }
    
    APB_WRITE_DATA_CP_X_APB_WRITE_PADDR_CP:cross APB_WRITE_DATA_CP,APB_WRITE_PADDR_CP;

  endgroup:input_cg
  
    covergroup output_cg;
      
      APB_READ_PADDR_CP:coverpoint seq_item.apb_read_paddr {
       bins read_paddr = {[9'h000:9'h1FF]};
    }
      
      APB_READ_DATA_OUT_CP:coverpoint seq_item.apb_read_data_out {
        bins read_data_out = {[8'h00:8'hFF]};
    }

    APB_READ_DATA_OUT_CP_X_APB_READ_PADDR_CP:cross APB_READ_DATA_OUT_CP,APB_READ_PADDR_CP;
      
    endgroup:output_cg
  
  function new(string name = "APB_2coverage", uvm_component parent);
    super.new(name, parent);
    cov_in_export = new("cov_in_export", this);
    cov_out_export = new("cov_out_export", this);
    input_cg = new();
    output_cg = new();
  endfunction : new

  
  // Write function for input port
  function void write_inputport(APB_2sequence_item t);
    seq_item = t;
    input_cg.sample();
  endfunction : write_inputport

  // Write function for output port
  function void write_outputport(APB_2sequence_item t);
    seq_item = t;
    output_cg.sample();
  endfunction : write_outputport
  
  function void write(APB_2sequence_item t); 
  endfunction : write

  // Extract phase
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    input_cov = input_cg.get_coverage();
    output_cov = output_cg.get_coverage();
  endfunction : extract_phase

  // Report phase
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Input Coverage is %f \nOutput Coverage is %f", input_cov, output_cov), UVM_MEDIUM)
  endfunction : report_phase

endclass : APB_2coverage

