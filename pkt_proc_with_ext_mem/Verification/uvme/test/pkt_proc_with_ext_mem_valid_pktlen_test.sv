class pkt_proc_with_ext_mem_valid_pktlen_test extends pkt_proc_with_ext_mem_base_test;
	`uvm_component_utils(pkt_proc_with_ext_mem_valid_pktlen_test)
	pkt_proc_with_ext_mem_valid_pktlen_sequence vseqh;

	function new(string name="pkt_proc_with_ext_mem_valid_pktlen_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		vseqh=pkt_proc_with_ext_mem_valid_pktlen_sequence::type_id::create("vseqh");
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		//repeat(5)
		vseqh.start(envh.agnth.seqrh);
		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this,1000);
	endtask
endclass
