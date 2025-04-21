class APB_2driver extends uvm_driver#(APB_2sequence_item);

  virtual APB_2interface.APB_DRV vif;
  `uvm_component_utils(APB_2driver)

  uvm_analysis_port #(APB_2sequence_item) item_collect_port;
 
  function new(string name = "APB_2driver", uvm_component parent);
    super.new(name,parent);
	item_collect_port = new("item_collect_port",this);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual APB_2interface) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "not set");
  endfunction
 
  //Run phase
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
  endtask
  
  //Drive task
  task drive();
    //drive data
    @(vif.APB_2driver_cb)
    begin
      vif.cb_drv.transfer <= req.transfer;
      vif.cb_drv.READ_WRITE <= req.READ_WRITE;
      vif.cb_drv.apb_write_paddr <= req.apb_write_paddr;
      vif.cb_drv.apb_write_data <= req.apb_write_data;
      vif.cb_drv.apb_read_paddr <= req.apb_read_paddr;
      `uvm_info("driver", $sformatf("----Driver----"), UVM_LOW);
      req.print();
      `uvm_info("driver", $sformatf("----Driver----"), UVM_LOW);
    end
  endtask
endclass
