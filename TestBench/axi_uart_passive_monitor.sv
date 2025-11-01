
import global_pkg::*;

class axi_uart_passive_monitor extends uvm_monitor;

  `uvm_component_utils(axi_uart_passive_monitor)

  bit temp;
  bit [7:0]new_arr;
  int tx_wait = 11;
 
  uvm_analysis_port #(axi_uart_seq_item) mon_pas_port;
  virtual axi_uart_interface vif;
  axi_uart_seq_item mon;

  function new(string name = "axi_uart_passive_monitor", uvm_component parent);
    super.new(name, parent);
    mon_pas_port = new("mon_pas_port", this);
    mon = new;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi_uart_interface)::get(this,"","password",vif))
      `uvm_fatal("MON-PAS","no-interface found");
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    if( vif.reset ) wait( vif.reset == 0);
    //wait( !mon.uart_tx); 
    //      capture();
    forever begin
    if( global_data::valid_data_count  > 0) begin
      capture();
      global_data::valid_data_count = global_data::valid_data_count - 1;
    end
    else begin
     global_data::count = 0;
     @(posedge vif.mon_passive_cb);
   end
    end
  endtask

  task capture();
    bit[10:0] arr = 11'h0;
    repeat(11) begin
      for (int i = 0; i < 434; i++) begin
        @(posedge vif.mon_passive_cb);
        global_data::baud_count++;
      end
      mon.uart_tx = vif.uart_tx;
     `uvm_info("PASSIVE_MONITOR", $sformatf("SERIAL BIT: %d", mon.uart_tx), UVM_LOW)
      arr = arr >> 1;
      arr[10] = mon.uart_tx;
    end
    new_arr=arr[8:1];
    uvm_config_db #(int)::set(null,"*","array",new_arr);
      
       mon.rx_data     = vif.rx_data;
       mon.rx_valid    = vif.rx_valid;
 `uvm_info("PASSIVE_MONITOR", $sformatf("DATA RECEIVED FROM DUT- %d,new_arr data-%d", mon.rx_data,new_arr), UVM_LOW)
     mon.print();
        mon_pas_port.write(mon);
     //wait(vif.rx_valid); // just for coverage, comment out if not running for coverage

  endtask


endclass
