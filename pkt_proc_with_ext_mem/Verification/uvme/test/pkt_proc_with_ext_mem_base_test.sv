class pkt_proc_with_ext_mem_base_test extends uvm_test;
	`uvm_component_utils(pkt_proc_with_ext_mem_base_test)
	pkt_proc_with_ext_mem_env envh;
	pkt_proc_with_ext_mem_base_sequence seqh;

	function new(string name="pkt_proc_with_ext_mem_base_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		envh=pkt_proc_with_ext_mem_env::type_id::create("envh",this);
	endfunction

	function void start_of_simulation_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

	task run_phase(uvm_phase phase);
		seqh=pkt_proc_with_ext_mem_base_sequence::type_id::create("seqh");
		phase.raise_objection(this);
		seqh.start(envh.agnth.seqrh);
		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this,500);
	endtask

endclass
