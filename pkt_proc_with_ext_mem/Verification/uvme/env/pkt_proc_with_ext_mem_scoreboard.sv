class pkt_proc_with_ext_mem_scoreboard extends uvm_scoreboard;

	////....factory registration....////
	`uvm_component_utils(pkt_proc_with_ext_mem_scoreboard)

	////....analysis write impliment port....////
	uvm_analysis_imp#(pkt_proc_seq_item,pkt_proc_with_ext_mem_scoreboard)wr_export;

	////....analysis read impliment port....////
	//uvm_analysis_imp#(pkt_proc_seq_item,pkt_proc_with_ext_mem_scoreboard)rd_export;
	
	////.... queue to store expected data written into the  memory....////
	bit [31:0] wr_packet[$];
	bit [31:0] rd_packet[$];
	pkt_proc_seq_item trans;
	int p ,r ;
	////....function new constructor ....////
	function new(string name="pkt_proc_with_ext_mem_scoreboard",uvm_component parent);
		super.new(name,parent);
		wr_export=new("wr_export",this);
		//rd_export=new("rd_export",this);
		trans=pkt_proc_seq_item::type_id::create("trans");
	endfunction

	////.... build phase ....////
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	function void write(pkt_proc_seq_item trans);
		//`uvm_info("scoreboard",$sformatf("printing wr_data from scoreboard\n %s",trans.sprint()),UVM_MEDIUM)
		
	  if(trans.enq_req )begin
			wr_packet.push_back(trans.enq_wr_data_i && wr_packet.size > 0); 
			//$display("sbwr_data=%0h",trans.enq_wr_data_i);
		end

	 	if(trans.deq_req  )begin
			rd_packet.push_back(trans.deq_rd_data_o && rd_packet.size > 0); 
			//$display("sbrd_data=%0h",trans.deq_rd_data_o);
		end
	endfunction

		/*task run_phase(uvm_phase phase);
			forever begin
				if(wr_packet.size > 0 )begin
					p = wr_packet.pop_front();
				end

				if(rd_packet.size > 0)begin
					r = rd_packet.pop_front();
				end

				if(p == r)begin
                	`uvm_info("SCOREBOARD", $sformatf("DATA MATCHED: enq_wr_data=%0h, deq_rd_data_o=%0h", p, r), 
							  UVM_MEDIUM)
					wr_packet.delete();
					rd_packet.delete();
				end

				else begin
                	`uvm_warning("SCOREBOARD", $sformatf("DATA MISMATCH: enq_wr_data_i=%0h, deq_rd_data_o=%0h", p, r))
				end
		
			end
		endtask*/

					



	endclass

