class pkt_proc_with_ext_mem_empty_test extends pkt_proc_with_ext_mem_base_test;

	////....factory registration ....////
	`uvm_component_utils(pkt_proc_with_ext_mem_empty_test)

	////....empty sequence handle declare ....////
	pkt_proc_with_ext_mem_empty_sequence seqh;

	////....function new constructor ....////
	function new(string name="pkt_proc_with_ext_mem_empty_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	////....build phase....////
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seqh=pkt_proc_with_ext_mem_empty_sequence::type_id::create("seqh");
	endfunction

	////....task run phase to start a particular sequence ....////
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seqh.start(envh.agnth.seqrh);
		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this,1000);
	endtask
endclass
