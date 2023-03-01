/*class pkt_proc_with_ext_mem_env extends uvm_env;
	////....factory registration ....////
	`uvm_component_utils(pkt_proc_with_ext_mem_env)

	////....agent handle ....////
	pkt_proc_with_ext_mem_agent agnth;
	////....scoreboard handle ....////
	pkt_proc_with_ext_mem_scoreboard sbh;

	////.... function new constructor ....////
	function new(string name="pkt_proc_with_ext_mem_env",uvm_component parent);
		super.new(name,parent);
	endfunction

	////.... build phase ....////
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnth=pkt_proc_with_ext_mem_agent::type_id::create("agnth",this);
		sbh=pkt_proc_with_ext_mem_scoreboard::type_id::create("sbh",this);
		
	endfunction

	////.... connect phase ....////
	function void connect_phase(uvm_phase phase);
		////....connect  wr_port monitor to wr_export....////
		agnth.monh.wr_port.connect(sbh.wr_export);
		////....connect rd_ap to rd_export....////
		//agnth.monh.wr_port.connect(sbh.rd_export);
		`uvm_info(get_type_name(),"monitor and scoreboard connected",UVM_MEDIUM)
	endfunction
endclass */

class pkt_proc_with_ext_mem_env extends uvm_env;
  // Factory registration
  `uvm_component_utils(pkt_proc_with_ext_mem_env)
  
  // Agent handle
  pkt_proc_with_ext_mem_agent agnth;
  
  // Scoreboard handle
  pkt_proc_with_ext_mem_scoreboard sbh;
  
  // Constructor
  function new(string name="pkt_proc_with_ext_mem_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnth = pkt_proc_with_ext_mem_agent::type_id::create("agnth", this);
    sbh = pkt_proc_with_ext_mem_scoreboard::type_id::create("sbh", this);
  endfunction
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    // Connect monitor's analysis port to scoreboard's analysis export
    agnth.monh.wr_port.connect(sbh.wr_export);
    `uvm_info(get_type_name(), "Monitor and scoreboard connected successfully", UVM_MEDIUM)
  endfunction
endclass

