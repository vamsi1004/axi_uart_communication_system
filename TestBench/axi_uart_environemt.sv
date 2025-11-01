class axi_uart_environment extends uvm_env;
  
  `uvm_component_utils(axi_uart_environment)
  
  axi_uart_active_agent active_agent;
  axi_uart_passive_agent passive_agent;
  axi_uart_scoreboard scb;
  axi_uart_subscriber sub;
  
  function new(string name = "axi_uart_environment", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    active_agent = axi_uart_active_agent::type_id::create("active_agent",this);
    passive_agent = axi_uart_passive_agent::type_id::create("passive_agent",this);
    scb = axi_uart_scoreboard::type_id::create("scb",this);
    sub = axi_uart_subscriber::type_id::create("sub",this);
    set_config_int("active_agent","is_active",UVM_ACTIVE);
    set_config_int("passive_agent","is_active",UVM_PASSIVE);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    active_agent.mon_a.mon_act_port.connect(scb.scb_act_port.analysis_export);
    active_agent.mon_a.mon_act_port.connect(sub.cov_act_port.analysis_export);
    passive_agent.mon_p.mon_pas_port.connect(scb.scb_pas_port.analysis_export);
    passive_agent.mon_p.mon_pas_port.connect(sub.cov_pas_port.analysis_export);
  endfunction
endclass

/*class axi_uart_environment extends uvm_env;
  
  `uvm_component_utils(axi_uart_environment)
  
  axi_uart_active_agent active_agent;
  axi_uart_passive_agent passive_agent;
  axi_uart_scoreboard scb;
  axi_uart_subscriber sub;
  
  function new(string name = "axi_uart_environment", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    active_agent = axi_uart_active_agent::type_id::create("active_agent",this);
    passive_agent = axi_uart_passive_agent::type_id::create("passive agent",this);
    scb = axi_uart_scoreboard::type_id::create("scb",this);
    sub = axi_uart_subscriber::type_id::create("sub",this);
    set_config_int("passive_agent","is_active",UVM_PASSIVE); 
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    active_agent.mon_a.mon_act_port.connect(scb.scb_act_port.analysis_export);
    active_agent.mon_a.mon_act_port.connect(sub.cov_act_port.analysis_export);
    passive_agent.mon_p.mon_pas_port.connect(scb.scb_pas_port.analysis_export);
    passive_agent.mon_p.mon_pas_port.connect(sub.cov_pas_port.analysis_export);
  endfunction
endclass*/
