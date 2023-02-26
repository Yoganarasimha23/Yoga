class pkt_proc_with_ext_mem_random_write_sequence extends pkt_proc_with_ext_mem_base_sequence;
	////....factory registration....////
	`uvm_object_utils(pkt_proc_with_ext_mem_random_write_sequence)

	////....new constructor....////
	function new(string name="pkt_proc_with_ext_mem_random_write_sequence");
		super.new(name);
	endfunction

	////....inside a task body method to generate random write operation....////
	task body();
		req=pkt_proc_seq_item::type_id::create("req");
		/*start_item(req);
		req.randomize();
		finish_item(req);*/

		start_item(req);
		req.randomize(rstn);
		req.randomize(enq_req);
		req.randomize(enq_pck_len_valid);
		req.randomize(enq_pck_len_i);
		req.enq_in_sop=0;
		req.enq_in_eop=0;
		req.enq_wr_data_i=0;
		req.rstn=1;
		finish_item(req);

		for(int i=0;i<req.enq_pck_len_i;i++)begin
			req.enq_pck_len_valid=1;
			req.randomize(enq_wr_data_i);
			req.enq_in_sop=(i==0)?1:0;
			if(i==req.enq_pck_len_i-1)
				req.enq_in_eop=1;
			else
				req.enq_in_eop=0;
			start_item(req);
			finish_item(req);
		end

		start_item(req);
		req.enq_pck_len_valid=1;
		req.enq_in_eop=0;
		finish_item(req);

	endtask
endclass
