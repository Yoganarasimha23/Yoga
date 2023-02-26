class pkt_proc_with_ext_mem_agent extends uvm_agent;
	`uvm_component_utils(pkt_proc_with_ext_mem_agent)
	pkt_proc_with_ext_mem_driver drvh;
	pkt_proc_with_ext_mem_monitor monh;
	pkt_proc_with_ext_mem_sequencer seqrh;
	function new(string name="pkt_proc_with_ext_mem_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drvh=pkt_proc_with_ext_mem_driver::type_id::create("drvh",this);
		monh=pkt_proc_with_ext_mem_monitor::type_id::create("monh",this);
		seqrh=pkt_proc_with_ext_mem_sequencer::type_id::create("seqrh",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		drvh.seq_item_port.connect(seqrh.seq_item_export);
	endfunction
endclass
		
