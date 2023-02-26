class pkt_proc_with_ext_mem_base_sequence extends uvm_sequence#(pkt_proc_seq_item);
	`uvm_object_utils(pkt_proc_with_ext_mem_base_sequence)

	function new(string name="pkt_proc_with_ext_mem_base_sequence");
		super.new(name);
	endfunction

	/*task body();
		req=pkt_proc_seq_item::type_id::create("req");
		start_item(req);
		finish_item(req);
	endtask*/
endclass
