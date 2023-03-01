/*class pkt_proc_with_ext_mem_scoreboard extends uvm_scoreboard;

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
		
	  if(trans.enq_req && wr_packet.size > 0 )begin
			wr_packet.push_back(trans.enq_wr_data_i); 
			$display("sbwr_data=%0h",trans.enq_wr_data_i);
		end

	 	if(trans.deq_req && rd_packet.size > 0  )begin
			rd_packet.push_back(trans.deq_rd_data_o); 
			$display("sbrd_data=%0h",trans.deq_rd_data_o);
		end
	endfunction

		task run_phase(uvm_phase phase);
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
		endtask

					



	endclass*/


class pkt_proc_with_ext_mem_scoreboard extends uvm_scoreboard;
  // Factory registration
  `uvm_component_utils(pkt_proc_with_ext_mem_scoreboard)
  
  // Analysis implementation port
  uvm_analysis_imp #(pkt_proc_seq_item, pkt_proc_with_ext_mem_scoreboard) wr_export;
  
  // Queues to store write and read data
  bit [31:0] wr_queue[$];
  bit [31:0] rd_queue[$];
  
  // Counters for statistics
  int pass_count = 0;
  int fail_count = 0;
  
  // Constructor
  function new(string name="pkt_proc_with_ext_mem_scoreboard", uvm_component parent);
    super.new(name, parent);
    wr_export = new("wr_export", this);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Write function - called when monitor writes to analysis port
  function void write(pkt_proc_seq_item trans);
    // If this is a write operation
	`uvm_info(get_type_name(),"in scoreboard inside write",UVM_MEDIUM)
    if(trans.enq_req) begin
	`uvm_info(get_type_name(),"in scoreboard inside condition",UVM_MEDIUM)
      wr_queue.push_back(trans.enq_wr_data_i);
      `uvm_info("SCOREBOARD", $sformatf("Write data captured: 0x%0h", trans.enq_wr_data_i), UVM_MEDIUM)
    end
    
    // If this is a read operation with valid data
    if(trans.deq_req) begin
      bit [31:0] expected_data;
      
      rd_queue.push_back(trans.deq_rd_data_o);
      `uvm_info("SCOREBOARD", $sformatf("Read data captured: 0x%0h", trans.deq_rd_data_o), UVM_MEDIUM)
      
      // Check if we have expected data to compare against
      if(wr_queue.size() > 0) begin
        expected_data = wr_queue.pop_front();
        
        // Compare expected vs actual
        if(expected_data == trans.deq_rd_data_o) begin
          `uvm_info("SCOREBOARD", $sformatf("DATA MATCHED: Expected=0x%0h, Actual=0x%0h", 
                                           expected_data, trans.deq_rd_data_o), UVM_MEDIUM)
          pass_count++;
        end
        else begin
          `uvm_error("SCOREBOARD", $sformatf("DATA MISMATCH: Expected=0x%0h, Actual=0x%0h", 
                                           expected_data, trans.deq_rd_data_o))
          fail_count++;
        end
      end
      else begin
        `uvm_warning("SCOREBOARD", $sformatf("Received read data 0x%0h with no corresponding write data", 
                                           trans.deq_rd_data_o))
      end
    end
  endfunction
  
  // Report phase - print statistics at end of test
  function void report_phase(uvm_phase phase);
    `uvm_info("SCOREBOARD", $sformatf("\n----------------------------------\nScoreboard Statistics:\nPassed: %0d\nFailed: %0d\nRemaining write data: %0d\n----------------------------------", 
                                     pass_count, fail_count, wr_queue.size()), UVM_LOW)
                                     
    // Check if there's pending write data that wasn't read
    if(wr_queue.size() > 0) begin
      `uvm_warning("SCOREBOARD", $sformatf("There are %0d transactions in the write queue that weren't read", wr_queue.size()))
    end
  endfunction
  
endclass

