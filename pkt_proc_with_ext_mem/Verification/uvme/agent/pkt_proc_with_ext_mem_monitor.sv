/*class pkt_proc_with_ext_mem_monitor extends uvm_monitor;

	////....factory registration ....////
	`uvm_component_utils(pkt_proc_with_ext_mem_monitor)

	////....analysis port....////
	uvm_analysis_port #(pkt_proc_seq_item)wr_port;


	////....virtual interface declaration ....////
	virtual pkt_proc_with_ext_mem_if vif;

	////....new constructor ....////
	function new(string name="pkt_proc_with_ext_mem_monitor",uvm_component parent);
		super.new(name,parent);
		wr_port=new("wr_port",this);
	endfunction

	////....build phase ....////
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual pkt_proc_with_ext_mem_if)::get(this,"","pkt_proc_with_ext_mem_if",vif))
			begin
			`uvm_fatal("monitor class","failed to get vif from top")
			end
	endfunction

	task run_phase(uvm_phase phase);
		 collect_data();
	endtask

	task collect_data();
		pkt_proc_seq_item xtn;
		xtn=pkt_proc_seq_item::type_id::create("xtn");
		forever begin
			@(posedge vif.clk)
				if(vif.rstn && vif.enq_req)begin
					xtn.rstn = vif.rstn;
					xtn.sw_rst = vif.sw_rst;
					xtn.enq_req = vif.enq_req;
					xtn.enq_pck_len_valid = vif.enq_pck_len_valid;
					xtn.enq_pck_len_i = vif.enq_pck_len_i;
					xtn.enq_wr_data_i = vif.enq_wr_data_i;
					xtn.enq_in_sop = vif.enq_in_sop;
					xtn.enq_in_eop = vif.enq_in_eop;
				end
					//xtn.deq_req = vif.deq_req;
				////....output signals....////
			if( vif.rstn && vif.deq_req)begin
				xtn.deq_req = vif.deq_req;
				xtn.deq_rd_data_o = vif.deq_rd_data_o;
				xtn.data_valid = vif.data_valid;
				xtn.ram_full = vif.ram_full;
				xtn.ram_empty = vif.ram_empty;
				xtn.ram_overflow = vif.ram_overflow;
				xtn.ram_underflow = vif.ram_underflow;
				xtn.enq_packetdrop = vif.enq_packet_drop;
				xtn.rd_en_mem = vif.rd_en_mem;
				xtn.wr_en_mem = vif.wr_en_mem;
			end
				wr_port.write(xtn);				
			
				//xtn.print();
				`uvm_info("monitor",$sformatf("Transation captured\n %s",xtn.sprint()),UVM_MEDIUM)
				//$display("deq_rd_data=%0d",xtn.deq_rd_data_o);
				//$display("deq_rd_data=%0d",vif.deq_rd_data_o);
				//$display("data_valid=%0d",vif.data_valid);
			
				

			//end
			
		end
		
	endtask

	

endclass*/

class pkt_proc_with_ext_mem_monitor extends uvm_monitor;
  // Factory registration
  `uvm_component_utils(pkt_proc_with_ext_mem_monitor)
  
  // Analysis port
  uvm_analysis_port #(pkt_proc_seq_item) wr_port;
  
  // Virtual interface declaration
  virtual pkt_proc_with_ext_mem_if vif;
  
  // Constructor
  function new(string name="pkt_proc_with_ext_mem_monitor", uvm_component parent);
    super.new(name, parent);
    wr_port = new("wr_port", this);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual pkt_proc_with_ext_mem_if)::get(this, "", "pkt_proc_with_ext_mem_if", vif))
      begin
        `uvm_fatal("MONITOR", "Failed to get virtual interface from config DB")
      end
  endfunction
  
  // Run phase
  task run_phase(uvm_phase phase);
    collect_data();
  endtask
  
  // Collect data task
  task collect_data();
    pkt_proc_seq_item xtn;
    
    forever begin
      @(posedge vif.clk)
      
      if(vif.rstn) begin
        // Create new transaction for each clock cycle with activity
        if(vif.enq_req || vif.deq_req) begin
          xtn = pkt_proc_seq_item::type_id::create("xtn");
          
          // Capture all signals regardless of operation type
          xtn.rstn = vif.rstn;
          xtn.sw_rst = vif.sw_rst;
          xtn.enq_req = vif.enq_req;
          xtn.deq_req = vif.deq_req;
          
          // Capture write-related signals
          if(vif.enq_req) begin
            xtn.enq_pck_len_valid = vif.enq_pck_len_valid;
            xtn.enq_pck_len_i = vif.enq_pck_len_i;
            xtn.enq_wr_data_i = vif.enq_wr_data_i;
            xtn.enq_in_sop = vif.enq_in_sop;
            xtn.enq_in_eop = vif.enq_in_eop;
          end
          
          // Capture read-related signals
          if(vif.deq_req) begin
            xtn.deq_rd_data_o = vif.deq_rd_data_o;
            xtn.data_valid = vif.data_valid;
          end
          
          // Capture status signals always
          xtn.ram_full = vif.ram_full;
          xtn.ram_empty = vif.ram_empty;
          xtn.ram_overflow = vif.ram_overflow;
          xtn.ram_underflow = vif.ram_underflow;
          xtn.enq_packetdrop = vif.enq_packet_drop;
          xtn.rd_en_mem = vif.rd_en_mem;
          xtn.wr_en_mem = vif.wr_en_mem;
          
          // Send the captured transaction to scoreboard
          wr_port.write(xtn);
          
          `uvm_info("MONITOR", $sformatf("Transaction captured:\n%s", xtn.sprint()), UVM_MEDIUM)
        end
      end
    end
  endtask
endclass
