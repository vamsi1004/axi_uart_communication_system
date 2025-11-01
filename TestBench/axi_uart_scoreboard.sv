class axi_uart_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(axi_uart_scoreboard)

  uvm_tlm_analysis_fifo #(axi_uart_seq_item) scb_act_port;
  uvm_tlm_analysis_fifo #(axi_uart_seq_item) scb_pas_port;

  axi_uart_seq_item act_item;
  axi_uart_seq_item pas_item;
  bit [7:0] q[$];

  function new(string name = "axi_uart_scoreboard", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_act_port = new("active_mon_port",this);
    scb_pas_port = new("active_pas_port",this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    q.push_back(0);
    forever begin
      fork
        begin
          scb_act_port.get(act_item);
  	  
          q.push_back(act_item.axis_data);
	 
	  
        end
        begin
          scb_pas_port.get(pas_item);
	
          compute_val(q,act_item , pas_item);

        end
      join_any
    end
  endtask


  task compute_val(ref bit [7:0] q[$],axi_uart_seq_item in, axi_uart_seq_item out);

    bit [7:0] temp_arr;
    bit [7:0] exp_data;
    uvm_config_db #(int)::get(this,"*","array",temp_arr);
    $display(" Queue %0p ", q);
    exp_data = q.pop_front();


    
	

  //  if(in.axis_valid == 1 ) begin
	
      if(in.m_axis_ready == 1 )
        begin
          if(q.size() > 7)
            begin
              `uvm_info("SCB",$sformatf("FIFO FULL is correct: m_axis_ready - %d",in.m_axis_ready),UVM_NONE);
            end
          else
            begin
              `uvm_info("SCB",$sformatf("FIFO is not full"),UVM_NONE);
            end
        end
      if(exp_data === out.rx_data)
    begin
      `uvm_info("SCB",$sformatf("the data is mathing : axis_data : %d -- rx_data : %d",exp_data,out.rx_data),UVM_NONE);
    end
    else
      begin
        `uvm_info("SCB",$sformatf("the data is MIS-mathing : axis_data : %d -- rx_data : %d",exp_data,out.rx_data),UVM_NONE);
      end

      if((^out.rx_data) === (^temp_arr))
      begin
        if(out.rx_valid == 1'b1)
          begin
            `uvm_info("SCB",$sformatf("Parity is NOT-matching : RX_data : %d -- uart_tx : %d",out.rx_data,temp_arr),UVM_NONE);
          end
        else
          begin
            `uvm_info("SCB",$sformatf("Parity is matching : RX_data : %d -- uart_tx : %d",out.rx_data,temp_arr),UVM_NONE);
          end
      end

      if(out.rx_data === temp_arr)
      begin
        `uvm_info("SCB",$sformatf("the serial matches with parallel : axis_data : %d -- uart_tx : %d",out.rx_data,temp_arr),UVM_NONE);
      end
    else
      begin
        `uvm_info("SCB",$sformatf("the serial does not match will parallel : axis_data : %d -- uart_tx : %d",out.rx_data,temp_arr),UVM_NONE);
      end
//    end

  endtask
endclass
