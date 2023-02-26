`timescale 1ns/1ps
module pkt_proc_with_ext_mem_top;
	import uvm_pkg::*;

	import pkt_proc_with_ext_mem_pkg::*;
	`include "uvm_macros.svh"
	bit clk;
	initial  
	clk=1'b0;
	always #5 clk=~clk;
	/*initial begin
	#100000 $finish;
	end*/

	pkt_proc_with_ext_mem_if vif(clk);
		initial
		begin
			uvm_config_db#(virtual pkt_proc_with_ext_mem_if)::set(null,"*","pkt_proc_with_ext_mem_if",vif);
			run_test();
		end
	    initial begin
            $shm_open("wave.shm");
            $shm_probe("ACTMF");
            end
packet_processor_ext_top DUT(.clk(clk),.rstn(vif.rstn),.sw_rst(vif.sw_rst),.enq_req(vif.enq_req)
				,.enq_in_sop(vif.enq_in_sop),.enq_wr_data_i(vif.enq_wr_data_i)
				,.enq_in_eop(vif.enq_in_eop),.enq_pck_len_valid(vif.enq_pck_len_valid)
				,.enq_pck_len_i(vif.enq_pck_len_i),.deq_req(vif.deq_req)
				,.wr_en_mem(vif.wr_en_mem),.rd_en_mem(vif.rd_en_mem),.deq_rd_data_o(vif.deq_rd_data_o)
				,.ram_full(vif.ram_full),.ram_empty(vif.ram_empty)
				,.ram_overflow(vif.ram_overflow)
				,.ram_underflow(vif.ram_underflow)
				,.data_valid(vif.data_valid)
				,.enq_packet_drop(vif.enq_packet_drop));


/*packet_processor_ext_top DUT(.clk(clk),.rstn(vif.rstn),.sw_rst(vif.sw_rst),.enq_req(vif.enq_req)
				,.enq_in_sop(vif.enq_in_sop),.enq_wr_data_i(vif.enq_wr_data_i)
				,.enq_in_eop(vif.enq_in_eop),.enq_pck_len_valid(vif.enq_pck_len_valid)
				,.enq_pck_len_i(vif.enq_pck_len_i),.deq_req(vif.deq_req)
				,.enq_pck_proc_almost_full_value(vif.enq_pck_proc_almost_full_value)
				,.enq_pck_proc_almost_empty_value(vif.enq_pck_proc_almost_empty_value)
				,.wr_en_mem(vif.wr_en_mem),.rd_en_mem(vif.rd_en_mem),.deq_rd_data_o(vif.deq_rd_data_o)
				,.enq_pck_proc_full(vif.enq_pck_proc_full),.enq_pck_proc_empty(vif.enq_pck_proc_empty)
				,.enq_pck_proc_almost_full(vif.enq_pck_proc_almost_full)
				,.enq_pck_proc_almost_empty(vif.enq_pck_proc_almost_empty)
				,.enq_pck_proc_wr_lvl(vif.enq_pck_proc_wr_lvl)
				,.enq_pck_proc_overflow(vif.enq_pck_proc_overflow)
				,.enq_pck_proc_underflow(vif.enq_pck_proc_underflow)
				,.enq_packet_drop(vif.enq_packet_drop));*/

endmodule

