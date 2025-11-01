class axi_uart_active_agent extends uvm_agent;
  
  axi_uart_sequencer seqr;
  axi_uart_driver drv;
  axi_uart_active_monitor mon_a;
  
  `uvm_component_utils(axi_uart_active_agent)
  
  function new(string name = "axi_uart_active_agent", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase( phase);
    if(get_is_active() == UVM_ACTIVE) begin
    seqr = axi_uart_sequencer::type_id::create("seqr",this);
    drv = axi_uart_driver::type_id::create("drv",this);
    end
    mon_a = axi_uart_active_monitor::type_id::create("mon",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE)
      drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass
