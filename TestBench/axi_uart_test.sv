`include "defines.svh"
import global_pkg::*;
class axi_uart_test extends uvm_test;

  `uvm_component_utils(axi_uart_test)

  axi_uart_environment env;
  axi_uart_virtual_sequence seq;

  function new(string name = "axi_uart_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
//uvm_config_db#(uvm_active_passive_enum)::set(null, "env.passive_agent", "is_active", UVM_PASSIVE);

    env = axi_uart_environment::type_id::create("env",this);
//uvm_config_db#(uvm_active_passive_enum)::set(null, "env.passive_agent", "is_active", UVM_PASSIVE);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    seq = axi_uart_virtual_sequence::type_id::create("this");
    phase.raise_objection(this);
    seq.start(env.active_agent.seqr);
//repeat(500) @(posedge env.active_agent.drv.vif.drv_cb);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, (global_data::pkt*50000)*8);
  endtask

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

endclass
