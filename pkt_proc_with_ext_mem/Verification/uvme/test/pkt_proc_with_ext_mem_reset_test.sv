class pkt_proc_with_ext_mem_reset_test extends pkt_proc_with_ext_mem_base_test;
	`uvm_component_utils(pkt_proc_with_ext_mem_reset_test)
	pkt_proc_with_ext_mem_reset_sequence rseqh;

	function new(string name="pkt_proc_with_ext_mem_reset_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		rseqh=pkt_proc_with_ext_mem_reset_sequence::type_id::create("rseqh");
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		begin
			rseqh.scenario=1;
			rseqh.start(envh.agnth.seqrh);
		
		
		
			rseqh.scenario=2;
			rseqh.start(envh.agnth.seqrh);
		end
		
		/*begin
			rseqh.scenario=3;
			rseqh.start(envh.agnth.seqrh);
		end*/
		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this,1000);
		endtask
endclass
