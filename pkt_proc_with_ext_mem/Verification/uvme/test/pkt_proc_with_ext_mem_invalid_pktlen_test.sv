class pkt_proc_with_ext_mem_invalid_pktlen_test extends pkt_proc_with_ext_mem_base_test;
	`uvm_component_utils(pkt_proc_with_ext_mem_invalid_pktlen_test)
	pkt_proc_with_ext_mem_invalid_pktlen_sequence seqh;

	function new(string name="pkt_proc_with_ext_mem_invalid_pktlen_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seqh=pkt_proc_with_ext_mem_invalid_pktlen_sequence::type_id::create("seqh");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seqh.start(envh.agnth.seqrh);
		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this,10000);
	endtask
endclass

