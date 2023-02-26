class pkt_proc_with_ext_mem_driver extends uvm_driver#(pkt_proc_seq_item);
	`uvm_component_utils(pkt_proc_with_ext_mem_driver)
	virtual pkt_proc_with_ext_mem_if vif;


	function new(string name="pkt_proc_with_ext_mem_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual pkt_proc_with_ext_mem_if)::get(this,"","pkt_proc_with_ext_mem_if",vif))
			begin
				`uvm_fatal("driver class","failed to get virtual interface from top")
			end
	endfunction
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		////..............initialize all inputs to zero................////
		vif.rstn=0;
		vif.sw_rst=0;
		vif.enq_req=0;
		vif.enq_pck_len_valid=0;
		vif.enq_pck_len_i=0;
		vif.enq_wr_data_i=0;
		vif.enq_in_sop=0;
		vif.enq_in_eop=0;
		vif.enq_pck_proc_almost_full_value=0;
		vif.enq_pck_proc_almost_empty_value=0;
		vif.deq_req=0;	
		forever begin
			seq_item_port.get_next_item(req);
			`uvm_info(get_type_name(),"trying to get transaction from sequence",UVM_LOW)
			drive_dut(req);
			seq_item_port.item_done();
			`uvm_info(get_type_name(),"sent response back to  sequence",UVM_LOW)
			end
	endtask

	task drive_dut(pkt_proc_seq_item tx);
		@(negedge vif.clk)
		vif.rstn <= tx.rstn;
		vif.sw_rst <= tx.sw_rst;
		vif.enq_req <= tx.enq_req;
		vif.enq_wr_data_i <= tx.enq_wr_data_i;
		vif.enq_pck_len_valid <= tx.enq_pck_len_valid;
		vif.enq_pck_len_i <= tx.enq_pck_len_i;
		vif.enq_in_sop <= tx.enq_in_sop;
		vif.enq_in_eop <= tx.enq_in_eop;
		//@(negedge vif.clk)
		//@(negedge vif.clk)
		//@(negedge vif.clk)
		vif.deq_req <= tx.deq_req;
		vif.enq_pck_proc_almost_full_value <= tx.enq_pck_proc_almost_full_value;
		vif.enq_pck_proc_almost_empty_value <= tx.enq_pck_proc_almost_empty_value;


		if(tx.enq_req==1)begin
			vif.enq_wr_data_i <= tx.enq_wr_data_i;
		end
		else begin
			vif.enq_wr_data_i <= 0;
		end
		if(tx.enq_pck_len_valid == 1)begin
			vif.enq_pck_len_i <= tx.enq_pck_len_i;
		end
		tx.print();
	endtask

			
endclass
