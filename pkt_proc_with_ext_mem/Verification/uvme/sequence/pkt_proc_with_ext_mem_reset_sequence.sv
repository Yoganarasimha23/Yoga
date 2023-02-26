class pkt_proc_with_ext_mem_reset_sequence extends pkt_proc_with_ext_mem_base_sequence;
	`uvm_object_utils(pkt_proc_with_ext_mem_reset_sequence)
	int scenario;
	function new(string name="pkt_proc_with_ext_mem_reset_sequence");
		super.new(name);
	endfunction
	task body();
		`uvm_info(get_type_name(),"reset sequence started",UVM_MEDIUM)
		req=pkt_proc_seq_item::type_id::create("req");
		if(scenario==1)begin
		//`uvm_info(get_type_name()," active low reset sequence is started",UVM_LOW)
			start_item(req);
			req.rstn=1'b0;
			req.sw_rst=1'b1;
			req.enq_req=1'b0;
			req.enq_in_sop=0;
			req.enq_wr_data_i=0;
			req.enq_in_eop=0;
			req.enq_pck_len_valid=0;
			req.enq_pck_len_i=0;
			req.deq_req=0;
			req.enq_pck_proc_almost_full_value=0;
			req.enq_pck_proc_almost_empty_value=0;
			finish_item(req);
		//`uvm_info(get_type_name(),"active low reset sequence completed",UVM_LOW)
			end
		if(scenario==2)begin
			start_item(req);
			req.rstn=1'b1;
			req.sw_rst=0;
			req.enq_req=1'b1;
			req.deq_req=0;
			req.enq_in_sop=1'b0;
			req.enq_in_eop=1'b0;
			req.enq_pck_len_valid=1'b1;
			req.enq_pck_proc_almost_full_value=0;
			req.enq_pck_proc_almost_empty_value=0;
			req.enq_pck_len_i=$urandom_range(0,10);
			req.enq_wr_data_i=0;
			finish_item(req);
			//req.enq_wr_data_i=$urandom_range(0,10);
			for(int i=0;i<req.enq_pck_len_i;i++)begin
				req.enq_in_sop=(i==0)?1:0;
				req.enq_wr_data_i=$urandom_range(100,200);
				if(i==req.enq_pck_len_i-1)
					req.enq_in_eop=1;
				else
					req.enq_in_eop=0;
			start_item(req);
			finish_item(req);
			end
		
			
		start_item(req);
		req.enq_in_sop=0;
		req.enq_req=0;
		req.enq_in_eop=0;
		finish_item(req);

		#30;
		start_item(req);
		req.deq_req=1;
		finish_item(req);
		end
		
			`uvm_info(get_type_name(),"reset sequence completed",UVM_MEDIUM)
	endtask

		/*if(scenario==2)
		begin
		`uvm_info(get_type_name()," active high reset sequence is started",UVM_LOW)
			start_item(req);
			req.rstn=1'b1;
			req.sw_rst=1'b0;
			req.sw_rst=1'b0;
			req.enq_req=1'b1;
			req.enq_pck_len_valid=1'b1;
			req.enq_pck_len_i=12'd3;
			req.enq_in_sop=1'b1;
			req.enq_in_eop=1'b0;
			req.enq_wr_data_i=32'd54;
			req.deq_req=1;
			finish_item(req);

			start_item(req);
			req.enq_wr_data_i=32'd44;
			req.enq_in_sop=0;
			req.enq_in_eop=0;
			finish_item(req);

			start_item(req);
			req.enq_wr_data_i=32'd 24;
			req.enq_in_sop=0;
			req.enq_in_eop=1'b1;
			req.enq_req=0;
			finish_item(req);
			
			start_item(req);
			//req.enq_in_sop=1'b0;
			req.enq_in_eop=1'b0;
			finish_item(req);
		end*/
			/*if(scenario==3)
		begin
			start_item(req);
			req.rstn=1'b1;
			req.enq_req=1;
			req.enq_pck_len_valid=1;
			req.enq_pck_len_i=12'd2;
			req.enq_in_sop=1;
			req.enq_wr_data_i=32'd10;
			req.enq_in_eop=0;
			finish_item(req);

			start_item(req);
			req.enq_req=0;
			req.enq_in_sop=0;
			req.enq_wr_data_i=32'd20;
			req.enq_in_eop=1;
			finish_item(req);

			start_item(req);
			req.enq_in_eop=0;
			finish_item(req);
		end*/
		endclass
