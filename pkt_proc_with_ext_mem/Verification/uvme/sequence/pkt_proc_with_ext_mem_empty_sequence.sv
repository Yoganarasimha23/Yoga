class pkt_proc_with_ext_mem_empty_sequence extends pkt_proc_with_ext_mem_base_sequence;

	////....factory registration ....////
	`uvm_object_utils(pkt_proc_with_ext_mem_empty_sequence)

	////....function new constructor....////
	function new(string name="pkt_proc_with_ext_mem_empty_sequence");
		super.new(name);
	endfunction

	////....task body to start empty sequence ....////
	task body();
		req=pkt_proc_seq_item::type_id::create("req");
		start_item(req);
		req.rstn=0;
		req.sw_rst=1;
		req.enq_req=0;
		req.enq_pck_len_valid=0;
		req.enq_pck_len_i=0;
		req.enq_wr_data_i=0;
		req.enq_in_sop=0;
		req.enq_in_eop=0;
		req.enq_pck_proc_almost_full_value=0;
		req.enq_pck_proc_almost_empty_value=0;
		req.deq_req=0;
		finish_item(req);

		start_item(req);
		req.rstn=1;
		req.sw_rst=0;
		req.enq_req=1;
		////req.enq_pck_proc_almost_empty_value=$urandom_range(0,31);
		finish_item(req);

		start_item(req);
		req.deq_req=1;
		finish_item(req);

	endtask
endclass
