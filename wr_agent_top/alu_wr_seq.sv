class wr_seq_base extends uvm_sequence #(write_xtn);
	`uvm_object_utils(wr_seq_base)
	
	function new(string name = "wr_seq_base");
		super.new(name);
	endfunction
endclass
/*

bins low  = {[32'h0000_0000 : 32'h3FFF_FFFF]};
  bins mid  = {[32'h4000_0000 : 32'h7FFF_FFFF]};
  bins mid1 = {[32'h8000_0000 : 32'hBFFF_FFFF]};
  bins high = {[32'hC000_0000 : 32'hFFFF_FFFF]};
*/

class seq_low extends wr_seq_base;
  `uvm_object_utils(seq_low)
  
  function new(string name = "seq_low");
    super.new(name);
  endfunction
  
  task body();
    write_xtn req;
    req = write_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      dataA_i inside {[32'h0 : 32'h7FFF_FFFF]};
      dataB_i inside {[32'h0 : 32'h7FFF_FFFF]};
    });
    finish_item(req);
  endtask
  
endclass

class seq_mid extends wr_seq_base;
  `uvm_object_utils(seq_mid)
  
  function new(string name = "seq_mid");
    super.new(name);
  endfunction
  
  task body();
    write_xtn req;
    req = write_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      dataA_i inside {[32'h0 : 32'h7FFF_FFFF]};
      dataB_i inside {[32'h8000_0000 : 32'hFFFF_FFFF]};
    });
    finish_item(req);
  endtask
endclass

class seq_mid1 extends wr_seq_base;
  `uvm_object_utils(seq_mid1)
  
  function new(string name = "seq_mid1");
    super.new(name);
  endfunction
  
  task body();
    write_xtn req;
    req = write_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      dataA_i inside {[32'h8000_0000 : 32'hFFFF_FFFF]};
      dataB_i inside {[32'h0 : 32'h7FFF_FFFF]};
    });
    finish_item(req);
  endtask
endclass

class seq_high extends wr_seq_base;
  `uvm_object_utils(seq_high)
  
  function new(string name = "seq_high");
    super.new(name);
  endfunction
  
  task body();
    write_xtn req;
    req = write_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      dataA_i inside {[32'h8000_0000 : 32'hFFFF_FFFF]};
      dataB_i inside {[32'h8000_0000 : 32'hFFFF_FFFF]};
    });
    finish_item(req);
  endtask
endclass

