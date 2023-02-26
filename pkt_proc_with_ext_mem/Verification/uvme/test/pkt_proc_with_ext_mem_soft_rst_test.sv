class pkt_proc_with_ext_mem_soft_rst_test extends pkt_proc_with_ext_mem_base_test;
	`uvm_component_utils(pkt_proc_with_ext_mem_soft_rst_test)
	pkt_proc_with_ext_mem_soft_rst_sequence srsqsh;

	function new(string name="pkt_proc_with_ext_mem_soft_rst_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		srsqsh=pkt_proc_with_ext_mem_soft_rst_sequence::type_id::create("srsqsh");
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			phase.raise_objection(this);
			begin
				srsqsh.scenario=1;
				srsqsh.start(envh.agnth.seqrh);
			end

			begin
				srsqsh.scenario=2;
				srsqsh.start(envh.agnth.seqrh);
			end

			begin
				srsqsh.scenario=3;
				srsqsh.start(envh.agnth.seqrh);
			end
			//srsqsh.start(envh.agnth.seqrh);
			phase.drop_objection(this);
			phase.phase_done.set_drain_time(this,1000);
	endtask

endclass
