
/*
`include "defines.svh"
import global_pkg::*;

class axi_uart_sequence extends uvm_sequence #(axi_uart_seq_item);
  `uvm_object_utils(axi_uart_sequence)
  int count;

  function new(string name = "axi_uart_sequence");
    super.new(name);
  endfunction

  virtual task body();
    repeat(`pkt)
      begin
         req = axi_uart_seq_item::type_id::create("req");
        start_item(req);
        req.randomize();
        finish_item(req);

         global_data::count++;
    end
  endtask
endclass

*/


`include "defines.svh"
import global_pkg::*;
 
class axi_uart_sequence0 extends uvm_sequence #(axi_uart_seq_item);
  `uvm_object_utils(axi_uart_sequence0)
  int count;
  global_data g = new;

 
  function new(string name = "axi_uart_sequence0");
    super.new(name);
  endfunction
 
  virtual task body();
	//global_data::
  g.randomize();
    repeat(global_data::pkt) begin               
      req = axi_uart_seq_item::type_id::create("req");
      start_item(req);                
      
      req.randomize();
      //req.randomize() with {
        //axis_valid dist {0:=50,1:=50};
	//axis_valid == 1;
      //};
      
      finish_item(req);              
      global_data::count++;          
    end
  endtask
endclass

class axi_uart_sequence1 extends uvm_sequence #(axi_uart_seq_item);
  `uvm_object_utils(axi_uart_sequence1)
  int count;
 global_data g = new;
  function new(string name = "axi_uart_sequence1");
    super.new(name);
  endfunction
 
  virtual task body();
    g.randomize();
    repeat(global_data::pkt) begin               
      req = axi_uart_seq_item::type_id::create("req");
      start_item(req);                
      
      req.randomize();
      //req.randomize() with {
      //  axis_valid dist {0:=50,1:=50};
	//axis_valid == 1;
      //};
      
      finish_item(req);              
      global_data::count++;          
    end
  endtask
endclass

class axi_uart_sequence2 extends uvm_sequence #(axi_uart_seq_item);
  `uvm_object_utils(axi_uart_sequence2)
  int count;
 global_data g = new;
  function new(string name = "axi_uart_sequence2");
    super.new(name);
  endfunction
 
  virtual task body();
    g.randomize();
    repeat(global_data::pkt) begin               
      req = axi_uart_seq_item::type_id::create("req");
      start_item(req);                
      
      req.randomize();
      //req.randomize() with {
       // axis_valid dist {0:=50,1:=50};
	//axis_valid == 1;
      //};
      
      finish_item(req);              
      global_data::count++;          
    end
  endtask
endclass

 class axi_uart_sequence3 extends uvm_sequence #(axi_uart_seq_item);
  `uvm_object_utils(axi_uart_sequence3)
  int count;
 global_data g = new;
  function new(string name = "axi_uart_sequence3");
    super.new(name);
  endfunction
 
  virtual task body();
    g.randomize();
    repeat(global_data::pkt) begin               
      req = axi_uart_seq_item::type_id::create("req");
      start_item(req);                
      
      req.randomize();
      //req.randomize() with {
       // axis_valid dist {0:=20,1:=80};
	//axis_valid == 1;
      //};
      
      finish_item(req);              
      global_data::count++;          
    end
  endtask
endclass

class axi_uart_sequence4 extends uvm_sequence #(axi_uart_seq_item);
  `uvm_object_utils(axi_uart_sequence4)
  int count;
 global_data g = new;
  function new(string name = "axi_uart_sequence4");
    super.new(name);
  endfunction
 
  virtual task body();
    g.randomize();
    repeat(global_data::pkt) begin               
      req = axi_uart_seq_item::type_id::create("req");
      start_item(req);                
      
	req.randomize();
      //req.randomize() with {
       //axis_valid dist {0:=50,1:=50};
	//axis_valid == 1;
      //};
      
      finish_item(req);              
      global_data::count++;          
    end
  endtask
endclass
 
class axi_uart_virtual_sequence extends uvm_sequence #(axi_uart_seq_item);
  `uvm_object_utils(axi_uart_virtual_sequence)
  axi_uart_sequence0 seq;
  axi_uart_sequence1 seq1;
  axi_uart_sequence2 seq2;
  axi_uart_sequence3 seq3;
  axi_uart_sequence4 seq4;

  function new(string name = "axi_uart_virtual_sequence");
    super.new(name);
  endfunction
  virtual task body();
    `uvm_info("VIRTUAL_SEQ", "Starting AXI UART Virtual Sequence", UVM_LOW)
    seq = axi_uart_sequence0::type_id::create("seq");
    seq1 = axi_uart_sequence1::type_id::create("seq1");
    seq2 = axi_uart_sequence2::type_id::create("seq2");
   seq3 = axi_uart_sequence3::type_id::create("seq3");
   seq4 = axi_uart_sequence4::type_id::create("seq4");

    `uvm_do(seq)
     //global_data::count = 0;
    wait(  global_data::valid_data_count == 0);//global_data::valid_data_count == 0 &&
   `uvm_do(seq1)
    wait(  global_data::valid_data_count == 0);//global_data::valid_data_count == 0 &&
   `uvm_do(seq2)
    wait(  global_data::valid_data_count == 0);//global_data::valid_data_count == 0 &&
    `uvm_do(seq3)
    wait(  global_data::valid_data_count == 0);//global_data::valid_data_count == 0 &&
    `uvm_do(seq4)
    `uvm_info("VIRTUAL_SEQ", "AXI UART Virtual Sequence Complete", UVM_LOW)
  endtask
endclass

