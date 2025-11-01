class axi_uart_subscriber extends uvm_component;
  
  `uvm_component_utils(axi_uart_subscriber)
  
  uvm_tlm_analysis_fifo #(axi_uart_seq_item) cov_act_port;
  uvm_tlm_analysis_fifo #(axi_uart_seq_item) cov_pas_port;
  
  axi_uart_seq_item act_item;
  axi_uart_seq_item pas_item;
  
  real input_cov;
  real output_cov;
  
  covergroup cg1;
    AXIS_DATA : coverpoint act_item.axis_data{
      bins low = {[0:127]};
      bins high = {[127:255]};
    }
    VALID : coverpoint act_item.axis_valid{
      bins valid[] = {0,1};
    }
    LAST : coverpoint act_item.axis_last{
      bins last[] = {0,1};
    }
    M_AXIS_READY : coverpoint act_item.m_axis_ready{
      bins m_axis_ready[] = {0,1};
    }
  endgroup
  
  covergroup cg2;
    RX_DATA : coverpoint pas_item.rx_data{
      bins low = {[0:127]};
      bins high = {[128:255]};
    }
    RX_VALID : coverpoint pas_item.rx_data{
      bins rx_valid = {0,1};
    }
    UART_TX : coverpoint pas_item.uart_tx{
      bins uart_tx[] = {0,1};
    }
  endgroup
  
  function new(string name  = "axi_uart_subscriber", uvm_component parent);
    super.new(name,parent);
    cov_act_port = new("active_port",this);
    cov_pas_port = new("passive_port",this);
    cg1 = new;
    cg2 = new;
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin 
      cov_act_port.get(act_item);
      cg1.sample();
      cov_pas_port.get(pas_item);
      cg2.sample();
    end 
  endtask
  
  virtual function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    input_cov = cg1.get_coverage();
    output_cov = cg2.get_coverage();
  endfunction
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("get_name()",$sformatf("[ACTIVE] coverage = %0.2f",input_cov),UVM_LOW);
    `uvm_info("get_name()",$sformatf("[PASSIVE] coverage = %0.2f",output_cov),UVM_LOW);
  endfunction
endclass
