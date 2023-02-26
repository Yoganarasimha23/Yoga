class pkt_proc_with_ext_mem_zero_payload_sequence extends pkt_proc_with_ext_mem_base_sequence;
	////....factory registration....////
	`uvm_object_utils(pkt_proc_with_ext_mem_zero_payload_sequence)

	////....new constructor....////
	function new(string name="pkt_proc_with_ext_mem_zero_payload_sequence");
		super.new(name);
	endfunction

	////....task body to start a zero payload sequence....////
	task body();
		req=pkt_proc_seq_item::type_id::create("req");
		start_item(req);
		req.rstn=0;
		req.enq_req=0;
		req.enq_wr_data_i=0;
		req.enq_pck_len_valid=0;
		req.enq_pck_len_i=0;
		req.enq_in_sop=0;
		req.enq_in_eop=0;
		req.deq_req=0;
		req.enq_pck_proc_almost_empty_value=0;
		req.enq_pck_proc_almost_full_value=0;
		finish_item(req);

		start_item(req);
		req.rstn=1;
		req.enq_req=1;
		req.enq_pck_len_valid=1;
		req.enq_pck_len_i=$urandom_range(10,20);
		//req.enq_wr_data_i=$urandom_range(0,50);
		//req.enq_in_sop=1;
		//req.enq_in_eop=1;
		finish_item(req);


		for(int i=0;i<req.enq_pck_len_i;i++)begin
			req.enq_in_sop=(i==0)?1:0;
			req.enq_wr_data_i=$urandom;
			if(i==req.enq_pck_len_i-1)
				req.enq_in_eop=1;
			else
				req.enq_in_eop=0;
			start_item(req);
			finish_item(req);
		end
		start_item(req);
		req.enq_req=0;
		req.enq_in_sop=0;
		req.enq_in_eop=0;
		//req.deq_req=1;
		finish_item(req);
		#30;
		start_item(req);
		req.deq_req=1;
		finish_item(req);		

		

	endtask
endclass

