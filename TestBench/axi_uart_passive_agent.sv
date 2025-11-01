class axi_uart_passive_agent extends uvm_agent;
  
  axi_uart_passive_monitor mon_p;
  axi_uart_driver drv;
  axi_uart_sequencer seqr;
 
  `uvm_component_utils(axi_uart_passive_agent)
  
  function new(string name = "axi_uart_passive_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(get_is_active() == UVM_ACTIVE) begin
    drv = axi_uart_driver::type_id::create("drv",this);
    seqr = axi_uart_sequencer::type_id::create("seqr",this);
end
    mon_p = axi_uart_passive_monitor::type_id::create("mon_p", this);
endfunction

endclass
