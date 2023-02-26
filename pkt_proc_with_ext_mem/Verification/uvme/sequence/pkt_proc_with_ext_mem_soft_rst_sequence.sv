class pkt_proc_with_ext_mem_soft_rst_sequence extends pkt_proc_with_ext_mem_base_sequence;
	`uvm_object_utils(pkt_proc_with_ext_mem_soft_rst_sequence)
		int scenario;
	function new(string name="pkt-proc_with_ext_soft_rst_sequence");
		super.new(name);
	endfunction

	task body();
		req=pkt_proc_seq_item::type_id::create("req");
		if(scenario==1)begin
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
		end
		if(scenario==2)begin
			start_item(req);
			req.rstn=1;
			req.sw_rst=1;
			req.enq_req=1;
			req.enq_pck_len_valid=1;
			req.deq_req=0;
			req.enq_pck_len_i=$urandom_range(20,30);
			finish_item(req);

			for(int i=0;i<req.enq_pck_len_i;i++)begin
				req.enq_in_sop=(i==0)?1:0;
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
			req.enq_in_eop=0;
			finish_item(req);

			#60;
			start_item(req);
			req.deq_req=1;
			finish_item(req);
		end

		if(scenario==3)begin
			start_item(req);
			req.rstn=1;
			req.sw_rst=0;
			req.enq_req=1;
			req.enq_in_sop=0;
			req.enq_in_eop=0;
			req.enq_wr_data_i=0;
			req.deq_req=0;
			req.enq_pck_len_valid=1;
			req.enq_pck_len_i=$urandom_range(20,30);
			finish_item(req);

			for(int i=0;i<req.enq_pck_len_i;i++)begin
				req.enq_in_sop=(i==0)?1:0;
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
			req.enq_in_eop=0;
			finish_item(req);

			#60;
			start_item(req);
			req.deq_req=1;
			finish_item(req);
		end


			/*if(scenario==1)
				begin
					start_item(req);
					req.sw_rst=1'b1;
					req.rstn=1'b0;
					req.enq_req=1'b0;
					req.enq_in_sop=1'b0;
					req.enq_in_eop=1'b0;
					req.enq_wr_data_i=1'b0;
					req.enq_pck_len_valid=1'b0;
					req.enq_pck_len_i=1'b0;
					req.deq_req=1'b0;
					req.enq_pck_proc_almost_full_value=0;
					req.enq_pck_proc_almost_empty_value=0;
					finish_item(req);
				end
			if(scenario==2)
				begin
					start_item(req);
					req.sw_rst=1'b0;
					req.rstn=1'b1;
					req.enq_req=1'b1;
					req.enq_pck_len_valid=1'b1;
					req.enq_pck_len_i=12'd4;
					req.enq_in_sop=1'b1;
					req.enq_wr_data_i=;
					req.enq_in_eop=1'b0;
					finish_item(req);

					start_item(req);
					req.enq_in_sop=1'b0;
					req.enq_wr_data_i=32'd20;
					req.enq_in_eop=1'b0;
					finish_item(req);

					start_item(req);
					req.enq_in_sop=1'b0;
					req.enq_wr_data_i=32'd30;
					req.enq_in_eop=1'b0;
					finish_item(req);

					start_item(req);
					req.enq_req=1'b0;
					req.enq_in_eop=1'b1;
					finish_item(req);

					start_item(req);
					req.enq_in_eop=1'b0;
					finish_item(req);
				end
			if(scenario==3)
				begin
					start_item(req);
					req.sw_rst=1'b0;
					req.rstn=1'b1;
					req.enq_req=1'b1;
					req.enq_pck_len_valid=1'b1;
					req.enq_pck_len_i=12'd4;
					req.enq_in_sop=1'b1;
					req.enq_wr_data_i=32'd10;
					req.enq_in_eop=1'b0;
					finish_item(req);

					start_item(req);
					req.enq_in_sop=1'b0;
					req.enq_wr_data_i=32'd20;
					req.enq_in_eop=1'b0;
					finish_item(req);

					start_item(req);
					req.enq_in_sop=1'b0;
					req.enq_wr_data_i=32'd30;
					req.enq_in_eop=1'b0;
					finish_item(req);

					start_item(req);
					req.enq_req=1'b0;
					req.enq_in_eop=1'b1;
					finish_item(req);

					start_item(req);
					req.enq_in_eop=1'b0;
					finish_item(req);
				end*/

			endtask


endclass
