class pkt_proc_with_ext_mem_zero_payload_test extends pkt_proc_with_ext_mem_base_test;
	
	////....factory registration....////
	`uvm_component_utils(pkt_proc_with_ext_mem_zero_payload_test)
	////....zero paylod sequnce class instance....////
	pkt_proc_with_ext_mem_zero_payload_sequence seqh;

	////....new constructor....////
	function new(string name="pkt_proc_with_ext_mem_zero_payload_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	////....build phase....////
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seqh=pkt_proc_with_ext_mem_zero_payload_sequence::type_id::create("seqh");
	endfunction

	////....run phase to start a zero payload sequence....////
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		repeat(2)
		seqh.start(envh.agnth.seqrh);
		phase.drop_objection(this);
	endtask
endclass


