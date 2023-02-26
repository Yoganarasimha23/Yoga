package pkt_proc_with_ext_mem_pkg;
	import uvm_pkg::*;
	`include"uvm_macros.svh"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_sequence_item.sv"

	`include "./../uvme/agent/pkt_proc_with_ext_mem_sequencer.sv"

	`include "./../uvme/sequence/pkt_proc_with_ext_mem_base_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_reset_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_soft_rst_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_valid_pktlen_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_invalid_pktlen_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_write_enque_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_random_write_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_zero_payload_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_single_payload_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_max_payload_sequence.sv"	
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_overflow_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_underflow_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_full_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_empty_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_almostfull_sequence.sv"
	`include "./../uvme/sequence/pkt_proc_with_ext_mem_almostempty_sequence.sv"

	`include "./../uvme/agent/pkt_proc_with_ext_mem_driver.sv"
	`include "./../uvme/agent/pkt_proc_with_ext_mem_monitor.sv"
	`include "./../uvme/agent/pkt_proc_with_ext_mem_agent.sv"
	`include "./../uvme/env/pkt_proc_with_ext_mem_scoreboard.sv"
	`include "./../uvme/env/pkt_proc_with_ext_mem_env.sv"

	`include "./../uvme/test/pkt_proc_with_ext_mem_base_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_reset_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_soft_rst_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_valid_pktlen_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_invalid_pktlen_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_write_enque_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_random_write_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_zero_payload_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_single_payload_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_max_payload_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_overflow_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_underflow_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_full_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_empty_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_almostfull_test.sv"
	`include "./../uvme/test/pkt_proc_with_ext_mem_almostempty_test.sv"
	
endpackage

