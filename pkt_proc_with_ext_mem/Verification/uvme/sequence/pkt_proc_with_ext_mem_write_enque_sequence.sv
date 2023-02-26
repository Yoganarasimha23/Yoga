class pkt_proc_with_ext_mem_write_enque_sequence extends pkt_proc_with_ext_mem_base_sequence;
	////....factor registration....////
	`uvm_object_utils(pkt_proc_with_ext_mem_write_enque_sequence)
	int i;
	////....new constructor....////
	function new(string name="pkt_proc_with_ext_mem_write_enque_sequence");
		super.new(name);	
	endfunction

	////....starting a write enque sequence inside body....////
	task body();
		req=pkt_proc_seq_item::type_id::create("req");

		start_item(req);
		req.rstn=0;
		req.enq_req=0;
		req.enq_pck_len_valid=0;
		req.enq_pck_len_i=0;
		req.enq_in_sop=0;
		req.enq_in_eop=0;
		req.enq_wr_data_i=0;
		req.deq_req=0;
		finish_item(req);

		start_item(req);
		req.rstn=1;
		req.enq_req=1;
		req.enq_pck_len_valid=1;
		//req.enq_in_sop=1;
		req.enq_pck_len_i=$urandom_range(0,500);
		//req.enq_wr_data_i[11:0]=req.enq_pck_len_i;
		finish_item(req);

		for(int i=0;i<req.enq_pck_len_i;i++)begin
		req.enq_in_sop=(i==0)?1:0;
		start_item(req);
		req.enq_wr_data_i=$urandom_range(0,1000);
		if(i==req.enq_pck_len_i-1)
			req.enq_in_eop=1;
		else
			req.enq_in_eop=0;
		finish_item(req);
		end
		/*if(i==req.enq_pck_len_i-1)
			req.enq_in_eop=1;
		else
			req.enq_in_eop=0;*/
		//finish_item(req);
		/*start_item(req);
		req.enq_in_sop=0;
		finish_item(req);*/
		/*foreach(int i==req.enq_pck_len_i)begin
			req.enq_insop=0;
			req.enq_wr_data_i=$urandom_range(0,4095);
			if(i=req.enq_pck_len_i-1)
				req.enq_in_eop=1;
			else
				req.enq_in_eop=0;
		finish_item(req);*/

		start_item(req);
		req.enq_req=0;
		req.enq_in_eop=0;
		req.deq_req=1;
		finish_item(req);
	endtask
endclass
	

