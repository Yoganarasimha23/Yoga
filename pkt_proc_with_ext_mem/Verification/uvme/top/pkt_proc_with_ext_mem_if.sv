interface pkt_proc_with_ext_mem_if(input logic clk);
	logic rstn;
	logic sw_rst;
	logic enq_req;
	logic enq_in_sop;
	logic [31:0]enq_wr_data_i;
	logic enq_in_eop;
	logic enq_pck_len_valid;
	logic [11:0]enq_pck_len_i;
	logic deq_req;
	logic [4:0]enq_pck_proc_almost_full_value;
	logic [4:0]enq_pck_proc_almost_empty_value;
	logic wr_en_mem;
	logic rd_en_mem;
	logic [13:0]deq_rd_data_o;
	//logic enq_pck_proc_full;
	//logic enq_pck_proc_empty;
	//logic enq_pck_proc_almost_full;
	//logic enq_pck_proc_almost_empty;
	//logic [13:0]enq_pck_proc_wr_lvl;
	//logic enq_pck_proc_overflow;
	//logic enq_pck_proc_underflow;
	logic ram_full;
	logic ram_empty;
	logic ram_underflow;
	logic ram_overflow;
	logic enq_packet_drop;
	logic data_valid;

	/*clocking pkt_drv @(posedge clk);
		default input #1 output #0;
		output enq_req;
		output enq_in_sop;
		output enq_wr_data_i;
		output enq_in_eop;
		output enq_pck_len_valid;
		output enq_pck_len_i;
		output deq_req;
		output enq_pck_proc_almost_full_value;
		output enq_pck_proc_almost_empty_value;
		input wr_en_mem;
		input deq_rd_data_o;
		input enq_pck_proc_full;
		input enq_pck_proc_empty;
		input enq_pck_proc_almost_full;
		input enq_pck_proc_almost_empty;
		input enq_pck_proc_wr_lvl;
		input enq_pck_proc_overflow;
		input enq_pck_proc_underflow;
		input enq_packet_drop;
	endclocking

	clocking pkt_mon @(posedge clk);
		default input #1 output #0;
			input enq_req;
			input enq_in_sop;
			input enq_wr_data_i;
			input enq_in_eop;
			input enq_pck_len_valid;
			input enq_pck_len_i;
			input deq_req;
			input enq_pck_proc_almost_full_value;
			input enq_pck_proc_almost_empty_value;
			output wr_en_mem;
			output deq_rd_data_o;
			output enq_pck_proc_full;
			output enq_pck_proc_empty;
			output enq_pck_proc_almost_full;
			output enq_pck_proc_almost_empty;
			output enq_pck_proc_wr_lvl;
			output enq_pck_proc_overflow;
			output enq_pck_proc_underflow;
			output enq_packet_drop;*/
	//endclocking

endinterface
	

