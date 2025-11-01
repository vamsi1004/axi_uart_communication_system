class axi_uart_sequencer extends uvm_sequencer #(axi_uart_seq_item);
  
  `uvm_component_utils(axi_uart_sequencer)
  
  function new(string name = "axi_uart_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass
