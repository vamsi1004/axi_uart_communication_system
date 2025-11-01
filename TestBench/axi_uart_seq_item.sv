 `include "uvm_macros.svh"
  import uvm_pkg::*;

class axi_uart_seq_item extends uvm_sequence_item;

  rand bit[7:0] axis_data;
  rand bit axis_valid;
  bit axis_last;
  bit [7:0] rx_data;
  bit rx_valid;
  bit uart_tx;
  bit m_axis_ready;

  function new(string name = "axi_uart_seq_item");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(axi_uart_seq_item)
  `uvm_field_int(axis_data,UVM_ALL_ON)
  `uvm_field_int(axis_valid,UVM_ALL_ON)
  `uvm_field_int(axis_last,UVM_ALL_ON)
  `uvm_field_int(rx_data,UVM_ALL_ON)
  `uvm_field_int(rx_valid,UVM_ALL_ON)
  `uvm_field_int(uart_tx,UVM_ALL_ON)
  `uvm_field_int(m_axis_ready,UVM_ALL_ON)
  `uvm_object_utils_end
//constraint c{axis_valid==1;}
endclass
