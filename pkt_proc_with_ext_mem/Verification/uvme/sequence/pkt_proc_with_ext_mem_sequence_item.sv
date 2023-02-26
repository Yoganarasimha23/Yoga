class pkt_proc_seq_item extends uvm_sequence_item;
	////....factory registration ....////
	`uvm_object_utils(pkt_proc_seq_item)
	////....input signals....////
	rand logic rstn;
	rand logic sw_rst;
	rand logic  enq_req;
    rand logic enq_in_sop;
	rand logic [31:0]enq_wr_data_i;
	rand logic enq_in_eop;
	rand logic enq_pck_len_valid;
	rand logic [11:0]enq_pck_len_i;
	rand logic deq_req;
	rand logic [4:0]enq_pck_proc_almost_full_value;
	rand logic [4:0]enq_pck_proc_almost_empty_value;
	////....output signals....////
	logic wr_en_mem;
	logic rd_en_mem;
	logic [13:0]deq_rd_data_o;
	logic ram_full;
	logic ram_empty;
	//logic enq_pck_proc_almost_full;
	//logic enq_pck_proc_almost_empty;
	//logic [13:0]enq_pck_proc_wr_lvl;
	logic ram_overflow;
	logic ram_underflow;
	logic enq_packetdrop;
	logic data_valid;
	
/*	constraint sop_eop{enq_in_sop dist {1:=1,0:=9};
			   enq_in_eop dist {1:=1,0:=9};
			   enq_in_sop->!enq_in_eop;
			   enq_pck_len_i inside{[0:10]};}*/
	/*constraint eop{if(enq_pck_len_i-1)
			enq_in_eop==1'b1;
			else
			enq_in_eop==1'b0;}*/
	function new(string name="pkt_proc_seq_item");
		super.new(name);
	endfunction
  
  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    
    printer.print_field("rstn", rstn, 1, UVM_DEC);
    printer.print_field("sw_rst", sw_rst, 1, UVM_DEC);
    printer.print_field("enq_req", enq_req, 1, UVM_DEC);
    printer.print_field("enq_in_sop", enq_in_sop, 1, UVM_DEC);
    printer.print_field("enq_wr_data_i", enq_wr_data_i, 32, UVM_HEX);
    printer.print_field("enq_in_eop", enq_in_eop, 1, UVM_DEC);
    printer.print_field("enq_pck_len_valid", enq_pck_len_valid, 1, UVM_DEC);
    printer.print_field("enq_pck_len_i", enq_pck_len_i, 12, UVM_DEC);
    printer.print_field("deq_req", deq_req, 1, UVM_DEC);
    //printer.print_field("enq_pck_proc_almost_full_value", enq_pck_proc_almost_full_value, 5, UVM_DEC);
    //printer.print_field("enq_pck_proc_almost_empty_value", enq_pck_proc_almost_empty_value, 5, UVM_DEC);
    printer.print_field("wr_en_mem", wr_en_mem, 1, UVM_DEC);
    printer.print_field("deq_rd_data_o", deq_rd_data_o, 14, UVM_HEX);
    //printer.print_field("enq_pck_proc_full", enq_pck_proc_full, 1, UVM_DEC);
    //printer.print_field("enq_pck_proc_empty", enq_pck_proc_empty, 1, UVM_DEC);
    //printer.print_field("enq_pck_proc_almost_full", enq_pck_proc_almost_full, 1, UVM_DEC);
    //printer.print_field("enq_pck_proc_almost_empty", enq_pck_proc_almost_empty, 1, UVM_DEC);
    //printer.print_field("enq_pck_proc_wr_lvl", enq_pck_proc_wr_lvl, 14, UVM_DEC);
    //printer.print_field("enq_pck_proc_overflow", enq_pck_proc_overflow, 1, UVM_DEC);
    printer.print_field("enq_packetdrop", enq_packetdrop, 1, UVM_DEC);
    printer.print_field("data_valid", data_valid, 1, UVM_DEC);
    printer.print_field("ram_full", ram_full, 1, UVM_DEC);
    printer.print_field("ram_empty", ram_empty, 1, UVM_DEC);
    printer.print_field("ram_overflow", ram_overflow, 1, UVM_DEC);
    printer.print_field("ram_underflow", ram_underflow, 1, UVM_DEC);
	
	
  endfunction
	


endclass
