class pkt_proc_with_ext_mem_invalid_pktlen_sequence extends pkt_proc_with_ext_mem_base_sequence;
	////.....factory registration.....////
	`uvm_object_utils(pkt_proc_with_ext_mem_invalid_pktlen_sequence)

	////....new constructor....////
	function new(string name="pkt_proc_with_ext_mem_invalid_pktlen_sequence");
		super.new(name);
	endfunction
	////....starting invalid sequence....////
	task body();
		req=pkt_proc_seq_item::type_id::create("req");
		start_item(req);
		req.rstn=0;
		req.enq_req=0;
		req.enq_wr_data_i=0;
		req.enq_in_sop=0;
		req.enq_in_eop=0;
		req.enq_pck_len_valid=0;
		req.enq_pck_len_i=0;
		finish_item(req);

		start_item(req);
		req.rstn=1'b1;
		req.enq_req=1'b1;
		req.enq_pck_len_valid=1'b1;
		req.deq_req=0;
		req.enq_pck_len_i=$urandom_range(10,50);
		//req.enq_wr_data_i[11:0]!=$urandom_range(50,100);
		req.enq_in_sop=1'b1;
		req.enq_in_eop=1'b0;
		finish_item(req);

		for(int i=0;i<54;i++)begin
		req.enq_in_sop=1'b0;		
		req.enq_wr_data_i=$urandom_range(50,100);
		if(i==req.enq_pck_len_i-1)
		req.enq_in_eop=1;
		else
		req.enq_in_eop=0;
		start_item(req);		
		finish_item(req);
		end
		

		start_item(req);
		req.enq_req=0;
		req.enq_wr_data_i=0;
		req.enq_in_eop=0;
		finish_item(req);

		#60;
		start_item(req);
		req.deq_req=1;
		finish_item(req);
	endtask
endclass


