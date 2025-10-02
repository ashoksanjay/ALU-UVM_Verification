class alu_vseq_base extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(alu_vseq_base);
	
	alu_wr_sequencer wr_seqrh;
	alu_virtual_sequencer vseqrh;
	
	alu_env_config m_cfg;
		
	function new(string name = "alu_vseq_base");
		super.new(name);
	endfunction
	
	task body();
		//if(!uvm_config_db #(alu_env_config)::get(null, "", "alu_env_config", m_cfg))
		//	`uvm_fatal(get_full_name(), "Error while getting config");
		assert($cast(vseqrh, m_sequencer))else begin
            `uvm_fatal("VIRTUAL_SEQUENCE", "Error while casting in vseq");
		end
		//if(m_cfg.has_wagent)
			wr_seqrh = vseqrh.wr_seqrh;
		
	endtask
	
endclass

class alu_low_vseq extends alu_vseq_base;  //low
	`uvm_object_utils(alu_low_vseq)
	
	seq_low low_seqh;
	
	function new(string name = "alu_low_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		low_seqh = seq_low::type_id::create("low_seqh");
		low_seqh.start(wr_seqrh);
	endtask
endclass


class alu_mid_vseq extends alu_vseq_base;  //mid
	`uvm_object_utils(alu_mid_vseq)
	
	seq_mid mid_seqh;
	
	function new(string name = "alu_mid_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		mid_seqh = seq_mid::type_id::create("mid_seqh");
		mid_seqh.start(wr_seqrh);
	endtask
endclass

class alu_mid1_vseq extends alu_vseq_base;  //mid1
	`uvm_object_utils(alu_mid1_vseq)
	
	seq_mid1 mid1_seqh;
	
	function new(string name = "alu_mid1_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		mid1_seqh = seq_mid1::type_id::create("mid1_seqh");
		mid1_seqh.start(wr_seqrh);
	endtask
endclass

class alu_high_vseq extends alu_vseq_base;  //mid1
	`uvm_object_utils(alu_high_vseq)
	
	seq_high high_seqh;
	
	function new(string name = "alu_high_vseq");
		super.new(name);
	endfunction
	
	task body();
		super.body();
		high_seqh = seq_high::type_id::create("high_seqh");
		high_seqh.start(wr_seqrh);
	endtask
endclass

