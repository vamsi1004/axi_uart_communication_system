package global_pkg;
class global_data;
  static int count;
  static int valid_data_count;
  static int baud_count;
  static rand int pkt;
  constraint a1{pkt  inside {[3:15]};}
endclass
endpackage
