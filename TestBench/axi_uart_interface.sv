interface axi_uart_interface(input logic clk,input logic reset);

  logic [7:0] axis_data;
  logic axis_valid;
  logic axis_last;
  logic [7:0] rx_data;
  logic uart_tx;
  logic rx_valid;
  logic m_axis_ready;

  clocking drv_cb @(posedge clk);
    default input #0 output #0;
    output axis_data;
    output axis_valid;
    output axis_last;
    input m_axis_ready;
  endclocking

  clocking mon_active_cb @(posedge clk);
    default input #0 output #0;
    input axis_data;
    input axis_valid;
    input axis_last;
    input m_axis_ready;
  endclocking

  clocking mon_passive_cb @(posedge clk);
    default input #0 output #0;
    input rx_data;
    input uart_tx;
    input rx_valid;
  endclocking

  modport drv(clocking drv_cb, input clk,reset);
    modport mon_active(clocking mon_active_cb, input clk,reset);
      modport mon_passive(clocking mon_passive_cb, input clk,reset);

  property rst;
    @(posedge clk) reset |-> (m_axis_ready == 1);
  endproperty
  ASSERT_RST_CHECK: assert property (rst);
  
  property validity;
   @(posedge clk) axis_valid |-> !$isunknown(axis_data);
  endproperty
 assert property(validity);


  /*property p_clk_50mhz;
    time prev_time;
    @(posedge clk)
      ($realtime - $past($realtime,clk)) inside {[19ns:21ns]};
  endproperty

  a_clk_50mhz: assert property (p_clk_50mhz)
    else $error("Clock period out of range: %0t ns",
                $realtime - $past($realtime, 1, clk));*/


property clock_bit;
  @(posedge clk) (axis_data && axis_valid) |-> ##4774 rx_data[=1:$];
endproperty
assert property(clock_bit);


  property serial_parallel;
  @(posedge clk) rx_data |-> !$isunknown(uart_tx);
  endproperty
  assert property (serial_parallel);

  
endinterface
