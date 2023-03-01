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


/*class pkt_proc_with_ext_mem_scoreboard extends uvm_scoreboard;
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
  
endclass */

/*class pkt_proc_with_ext_mem_scoreboard extends uvm_scoreboard;
  // Factory registration
  `uvm_component_utils(pkt_proc_with_ext_mem_scoreboard)
  
  // Analysis implementation port
  uvm_analysis_imp #(pkt_proc_seq_item, pkt_proc_with_ext_mem_scoreboard) monitor_port;
  
  // Queues to store write and read data in FIFO order
  bit [31:0] expected_data_queue[$];
  bit [31:0] actual_data_queue[$];
  
  // Counters for statistics
  int match_count = 0;
  int mismatch_count = 0;
  int pending_writes = 0;
  
  // Event to trigger comparison
  event compare_trigger;
  
  // Constructor
  function new(string name="pkt_proc_with_ext_mem_scoreboard", uvm_component parent);
    super.new(name, parent);
    monitor_port = new("monitor_port", this);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Build phase complete", UVM_HIGH)
  endfunction
  
  // Write function - called when monitor writes to analysis port
  function void write(pkt_proc_seq_item trans);
    // Handle write transaction
    if(trans.enq_req) begin
      expected_data_queue.push_back(trans.enq_wr_data_i);
      pending_writes++;
      `uvm_info(get_type_name(), $sformatf("Enqueued write data: 0x%0h, Queue Size: %0d", 
                trans.enq_wr_data_i, expected_data_queue.size()), UVM_MEDIUM)
      ->compare_trigger; // Trigger comparison
    end
    
    // Handle read transaction
    if(trans.deq_req) begin
      actual_data_queue.push_back(trans.deq_rd_data_o);
      `uvm_info(get_type_name(), $sformatf("Captured read data: 0x%0h, Queue Size: %0d", 
                trans.deq_rd_data_o, actual_data_queue.size()), UVM_MEDIUM)
      ->compare_trigger; // Trigger comparison
    end
  endfunction
  
  // Task to compare expected and actual data in FIFO order
  task run_phase(uvm_phase phase);
    bit [31:0] exp_data, act_data;
    super.run_phase(phase);
    
    forever begin
      // Wait for the compare trigger
      @(compare_trigger);
      
      // Compare as many items as possible
      while (expected_data_queue.size() > 0 && actual_data_queue.size() > 0) begin
        exp_data = expected_data_queue.pop_front();
        act_data = actual_data_queue.pop_front();
        pending_writes--;
        
        if (exp_data === act_data) begin
          `uvm_info(get_type_name(), $sformatf("DATA MATCH: Expected=0x%0h, Actual=0x%0h", 
                    exp_data, act_data), UVM_MEDIUM)
          match_count++;
        else begin
          `uvm_error(get_type_name(), $sformatf("DATA MISMATCH: Expected=0x%0h, Actual=0x%0h", 
                    exp_data, act_data))
          mismatch_count++;
        end
      end
    end
  endtask
  
  // Check phase - report any leftover items at end of test
  function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    
    if (expected_data_queue.size() > 0) begin
      `uvm_warning(get_type_name(), $sformatf("There are %0d expected data items that weren't read", 
                  expected_data_queue.size()))
    end
    
    if (actual_data_queue.size() > 0) begin
      `uvm_warning(get_type_name(), $sformatf("There are %0d actual data items with no corresponding expected data", 
                  actual_data_queue.size()))
    end
  endfunction
  
  // Report phase - print statistics at end of test
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    `uvm_info(get_type_name(), $sformatf("\n---------------------------------------\n" ,
              "SCOREBOARD RESULTS\n" ,
              "---------------------------------------\n" ,
              "Total Matches:    %0d\n" ,
              "Total Mismatches: %0d\n" ,
              "Pending Writes:   %0d\n" ,
              "---------------------------------------", 
              match_count, mismatch_count, pending_writes), UVM_LOW)
  endfunction
  
endclass */

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
  
  // Debug flags
  bit debug_enabled = 1;
  
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
    bit enq_processed = 0;
    bit deq_processed = 0;
    
    `uvm_info(get_type_name(), "Processing transaction in scoreboard", UVM_MEDIUM)
    
    // Debug transaction contents
    if(debug_enabled) begin
      `uvm_info("SCOREBOARD_DEBUG", $sformatf("Transaction details: enq_req=%0d, deq_req=%0d, enq_wr_data_i=0x%0h, deq_rd_data_o=0x%0h", 
                                            trans.enq_req, trans.deq_req, trans.enq_wr_data_i, trans.deq_rd_data_o), UVM_MEDIUM)
    end
    
    // Process write operation first (if present)
    if(trans.enq_req) begin
      wr_queue.push_back(trans.enq_wr_data_i);
      enq_processed = 1;
      `uvm_info("SCOREBOARD", $sformatf("Write data captured: 0x%0h, Queue size: %0d", 
                                       trans.enq_wr_data_i, wr_queue.size()), UVM_MEDIUM)
    end
    
    // Then process read operation (if present)
    if(trans.deq_req && trans.data_valid) begin
      bit matched = 0;
      
      // Store the read data for logging
      rd_queue.push_back(trans.deq_rd_data_o);
      deq_processed = 1;
      `uvm_info("SCOREBOARD", $sformatf("Read data captured: 0x%0h, Queue size: %0d", 
                                       trans.deq_rd_data_o, rd_queue.size()), UVM_MEDIUM)
      
      // Check if we have expected data to compare against
      if(wr_queue.size() > 0) begin
        bit [31:0] expected_data = wr_queue.pop_front();
        
        // Compare expected vs actual
        if(expected_data == trans.deq_rd_data_o) begin
          `uvm_info("SCOREBOARD", $sformatf("DATA MATCHED: Expected=0x%0h, Actual=0x%0h", 
                                           expected_data, trans.deq_rd_data_o), UVM_MEDIUM)
          matched = 1;
          pass_count++;
        end
        else begin
          `uvm_error("SCOREBOARD", $sformatf("DATA MISMATCH: Expected=0x%0h, Actual=0x%0h", 
                                           expected_data, trans.deq_rd_data_o))
          // Put the data back at the front for potential reordering issues
          wr_queue.push_front(expected_data);
          fail_count++;
        
      end
      
      // If no match was found with the first item, try the entire queue
      if(!matched && wr_queue.size() > 0) begin
        // Try to find a match in the queue
        for(int i = 0; i < wr_queue.size(); i++) begin
          if(wr_queue[i] == trans.deq_rd_data_o) begin
            `uvm_info("SCOREBOARD", $sformatf("OUT-OF-ORDER DATA MATCHED: Expected[%0d]=0x%0h, Actual=0x%0h", 
                                             i, wr_queue[i], trans.deq_rd_data_o), UVM_MEDIUM)
            // Remove the item from the queue
            wr_queue.delete(i);
            matched = 1;
            pass_count++;
            break;
          end
        end
        
        if(!matched) begin
          `uvm_warning("SCOREBOARD", $sformatf("Received read data 0x%0h with no matching write data in queue", 
                                             trans.deq_rd_data_o))
        
      end
      else if(!matched) begin
        `uvm_warning("SCOREBOARD", $sformatf("Received read data 0x%0h with no corresponding write data", 
                                           trans.deq_rd_data_o))
      end
    end
    
    // Log transaction processing status
    if(debug_enabled) begin
      if(enq_processed || deq_processed) begin
        `uvm_info("SCOREBOARD_DEBUG", $sformatf("Transaction processed - enq: %0d, deq: %0d, wr_queue.size: %0d, rd_queue.size: %0d",
                                              enq_processed, deq_processed, wr_queue.size(), rd_queue.size()), UVM_MEDIUM)
      end
      else begin
        `uvm_info("SCOREBOARD_DEBUG", "Transaction contained no enq or deq operations", UVM_MEDIUM)
      
    end
  endfunction
  
  // Check phase - perform final checks
  function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    
    // Print contents of remaining write queue for debugging
    if(wr_queue.size() > 0) begin
      string wr_queue_contents = "";
      foreach(wr_queue[i]) begin
        wr_queue_contents = {wr_queue_contents, $sformatf("0x%0h ", wr_queue[i])};
      end
      
      `uvm_info("SCOREBOARD", $sformatf("Remaining write queue contents: %s", wr_queue_contents), UVM_LOW)
    end
  endfunction
  
  // Report phase - print statistics at end of test
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    `uvm_info("SCOREBOARD", $sformatf("\n----------------------------------\nScoreboard Statistics:\nPassed: %0d\nFailed: %0d\nRemaining write data: %0d\nRemaining read data: %0d\n----------------------------------", 
                                     pass_count, fail_count, wr_queue.size(), rd_queue.size()), UVM_LOW)
                                     
    // Check if there's pending write data that wasn't read
    if(wr_queue.size() > 0) begin
      `uvm_warning("SCOREBOARD", $sformatf("There are %0d transactions in the write queue that weren't read", wr_queue.size()))
    end
    
    // Check if there's read data that wasn't matched
    if(rd_queue.size() > 0 && rd_queue.size() != pass_count + fail_count) begin
      `uvm_warning("SCOREBOARD", $sformatf("There are %0d read transactions that weren't fully processed", 
                                         rd_queue.size() - (pass_count + fail_count)))
    end
  endfunction
endclass
