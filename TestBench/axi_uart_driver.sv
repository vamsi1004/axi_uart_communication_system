`include "defines.svh"
import global_pkg::*;

class axi_uart_driver extends uvm_driver #(axi_uart_seq_item);

  `uvm_component_utils(axi_uart_driver)

  virtual axi_uart_interface vif;
  int count;
  int tgl = 0;

  function new(string name = "axi_uart_driver", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual axi_uart_interface) :: get(this,"","password",vif))
      `uvm_fatal("DRV","interface not found");
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
	if (vif.reset == 1) begin
		vif.axis_data <= 0;
		vif.axis_last <= 0;
		vif.axis_valid <= 0;
	
        wait(vif.reset == 0);
	end
      //wait ( vif.m_axis_ready == 0);
      //repeat(10)@(posedge vif.drv_cb);

      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
 
      end
  endtask

  task drive();
    @(posedge vif.drv_cb);
    wait(vif.m_axis_ready == 1);
    if((global_data::count  < global_data::pkt - 1))begin

     vif.axis_valid <= 1;//req.axis_valid;
     vif.axis_data <= req.axis_data;
     vif.axis_last <= 0;//req.axis_last;
      end
    else begin 
       vif.axis_data <= req.axis_data;
       @(posedge vif.drv_cb);
        vif.axis_last <= 1;
        //@(posedge vif.drv_cb);
      	vif.axis_valid <= 0;
	 
    end

/*   if(global_data::count <= `pkt - 1)begin
      vif.axis_data <= req.axis_data;
      global_data::count ++;
      end
    else begin 
      vif.axis_last <= 1'b0;
      vif.axis_data <= req.axis_data;
    vif.axis_valid <= req.axis_valid;
    end
    if (global_data::count > `pkt - 1)begin
 	@(posedge vif.drv_cb);
        vif.axis_last <= 1'b1;
      	vif.axis_valid <= 0;
	end
*/
 `uvm_info("DRIVER_DRIVING",$sformatf("Driving from driver data %d",vif.axis_data),UVM_LOW);
    req.print();
  endtask
endclass
