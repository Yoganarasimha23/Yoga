`timescale 1ns/1ps
module packet_processor_ext_top #(

        parameter           DATA_WIDTH      = 32                           ,
        parameter           ADDR_WIDTH      = 14                           ,
        parameter           DEPTH           = 1<<ADDR_WIDTH                ,
        parameter           PCK_LEN         = 12    
)(
       input   logic                       clk                             ,
       input   logic                       rstn                            ,
       input   logic                       sw_rst                          ,
       input   logic                       enq_req                         ,
       input   logic                       enq_in_sop                      ,
       input   logic  [DATA_WIDTH-1:0]     enq_wr_data_i                   ,
       input   logic                       enq_in_eop                      ,
       input   logic                       enq_pck_len_valid               ,                    
       input   logic  [PCK_LEN-1:0]        enq_pck_len_i                   , 
       input   logic                       deq_req                         ,
       output  logic                       wr_en_mem                       ,
       output  logic                       rd_en_mem                       ,
       output  logic  [DATA_WIDTH-1:0]     deq_rd_data_o                   ,
       output  logic                       enq_pck_proc_full               ,
       output  logic                       enq_pck_proc_empty              ,
       input   logic  [4:0]                enq_pck_proc_almost_full_value  ,
       input   logic  [4:0]                enq_pck_proc_almost_empty_value ,
       output  logic                       enq_pck_proc_almost_full        ,
       output  logic                       enq_pck_proc_almost_empty       ,
       output  logic  [ADDR_WIDTH:0]       enq_pck_proc_wr_lvl             ,
       output  logic                       enq_pck_proc_overflow           ,
       output  logic                       enq_pck_proc_underflow          , 
       output  logic                       enq_packet_drop                 ,
       output  logic                       data_valid
);

// Internal signals
    logic [PCK_LEN-1:0]         enq_pck_len_i_for_ram                      ; 
    logic [DATA_WIDTH-1:0]      enq_rd_data_1                              ;
    logic [DATA_WIDTH-1:0]      enq_rd_data                                ;
    logic [ADDR_WIDTH-1:0]      wr_addr_mem                                ;
    logic [DATA_WIDTH-1:0]      mem_rd_data                                ;
    logic [ADDR_WIDTH-1:0]      rd_addr_mem                                ;
    logic                       enq_out_sop_mem                            ;
    logic                       enq_out_sop_2                              ;
    logic                       enq_out_sop_1                              ;
    logic                       enq_out_eop_2                              ;
    logic                       enq_out_eop_mem                            ;
    logic                       enq_out_eop_1                              ;
    logic                       deq_req_deq                                ;
    logic                       pck_proc_empty_deq                         ;
    logic                       rd_en_out                                  ;


assign rd_en_out = deq_req ? 1'b1 : 1'b0;

assign enq_rd_data_1 = wr_en_mem ? enq_rd_data : {DATA_WIDTH{1'b0}};

always_ff @(posedge clk or negedge rstn)
begin
    if (deq_rd_data_o)
        data_valid = 1'b1;
        else data_valid <= 1'b0;
        end


//  External Memory data storage and address signals generation logic
always_ff @(posedge clk or negedge rstn)
    begin
    if (!rstn)
        begin
        wr_en_mem <=1'b0;
        enq_pck_len_i_for_ram <= {PCK_LEN{1'b0}};
        end
        else if (!enq_pck_proc_empty)
            begin
            wr_en_mem <= 1'b1;
            enq_pck_len_i_for_ram <= enq_pck_len_i;
            end
            else wr_en_mem <= 1'b0;
     end
always_ff @ (posedge clk or negedge rstn)
 begin
   if(!rstn)
       begin
       wr_addr_mem  <={ADDR_WIDTH{1'b0}};
       end
    else if(wr_en_mem)
       begin
       wr_addr_mem  <= wr_addr_mem + 1;
       rd_en_mem <= 1'b1;
       end  
           
  end

always_ff @ (posedge clk or negedge rstn)
 begin
   if(!rstn)
       begin
       rd_addr_mem  <= {ADDR_WIDTH{1'b0}};
       end
    else if(rd_en_out)
       begin
       rd_addr_mem  <= rd_addr_mem + 1;
       end  
           
  end

    always_ff @(posedge clk or negedge rstn)
    begin
        if (!rstn)
        begin
            enq_out_sop_2 <= 1'b0;
            enq_out_eop_2 <= 1'b0;
        end
        else if (rd_en_out)
        begin
            enq_out_sop_2 <= enq_out_sop_mem;
            enq_out_eop_2 <= enq_out_eop_mem;
        end
        else
        begin
            enq_out_sop_2 <= 1'b0;
            enq_out_eop_2 <= 1'b0;
        end
    end

// Instantiate Dual-Port RAM
    dual_port_ram 
                        #(
                            .ADDR_WIDTH     (ADDR_WIDTH     ),
                            .DATA_WIDTH     (DATA_WIDTH     ),
                            .PCK_LEN        (PCK_LEN        )
                  )  ram (

        .clk                (clk)                       ,
        .rst                (rstn)                      ,
        .wr_en              (wr_en_mem)                 ,
        .addr_wr            (wr_addr_mem)               ,
        .data_in            (enq_rd_data_1)             ,
        .data_out           (mem_rd_data)               ,
        .rd_en              (rd_en_out)                 ,
        .addr_rd            (rd_addr_mem)               ,
        .enq_in_sop         (enq_out_sop_1)             ,
        .enq_in_eop         (enq_out_eop_1)             ,
        .enq_out_sop        (enq_out_sop_mem)           ,
        .enq_out_eop        (enq_out_eop_mem)           ,
        .enq_pck_len_in     (enq_pck_len_i_for_ram)
    );

    // Instantiate Enqueue Packet Processor
    pck_proc_int_mem_fsm 
                        #(
                         .DATA_WIDTH      ( DATA_WIDTH    )         ,  
                         .DEPTH           ( DEPTH         )         , 
                         .ADDR_WIDTH      ( ADDR_WIDTH    )         , 
                         .PCK_LEN         ( PCK_LEN       )                                             
                        )
        enque_packet_proc 
     (
 
        .pck_proc_int_mem_fsm_clk               (clk                                ),
        .pck_proc_int_mem_fsm_rstn              (rstn                               ),
        .pck_proc_int_mem_fsm_sw_rstn           (sw_rst                             ),
        .empty_de_assert                        (1'b1                               ),
        .enq_req                                (enq_req                            ),
        .in_sop                                 (enq_in_sop                         ),
        .wr_data_i                              (enq_wr_data_i                      ),
        .in_eop                                 (enq_in_eop                         ),
        .pck_len_valid                          (enq_pck_len_valid                  ),
        .pck_len_i                              (enq_pck_len_i                      ),
        .deq_req                                (wr_en_mem                          ),
        .out_sop                                (enq_out_sop_1                      ),
        .rd_data_o                              (enq_rd_data                        ),
        .out_eop                                (enq_out_eop_1                      ),
        .pck_proc_full                          (enq_pck_proc_full                  ),
        .pck_proc_empty                         (enq_pck_proc_empty                 ),
        .pck_proc_almost_full_value             (enq_pck_proc_almost_full_value     ),
        .pck_proc_almost_empty_value            (enq_pck_proc_almost_empty_value    ),
        .pck_proc_almost_full                   (enq_pck_proc_almost_full           ),
        .pck_proc_almost_empty                  (enq_pck_proc_almost_empty          ),
        .pck_proc_wr_lvl                        (enq_pck_proc_wr_lvl                ),
        .pck_proc_overflow                      (enq_pck_proc_overflow              ),
        .pck_proc_underflow                     (enq_pck_proc_underflow             ),
        .packet_drop                            (enq_packet_drop                    )
    );    


// Instantiate Dequeue Packet Processor

always_ff @(posedge clk or negedge rstn)
    begin
    if (!rstn)
        begin
        deq_req_deq <= 1'b0;
        end
        else if (!pck_proc_empty_deq)
            begin
            deq_req_deq <= 1'b1;
               end
            else deq_req_deq <= 1'b0;
     end

    pck_proc_int_mem_fsm 
                       #(
                         .DATA_WIDTH      ( DATA_WIDTH    )         ,  
                         .DEPTH           ( DEPTH         )         , 
                         .ADDR_WIDTH      ( ADDR_WIDTH    )         , 
                         .PCK_LEN         ( PCK_LEN       )                                             
                        )
        deque_packet_proc 
     (

        .pck_proc_int_mem_fsm_clk               (clk                ),
        .pck_proc_int_mem_fsm_rstn              (rstn               ),
        .pck_proc_int_mem_fsm_sw_rstn           (sw_rst             ),
        .empty_de_assert                        (1'b1               ),
        .enq_req                                (rd_en_out          ),
        .in_sop                                 (enq_out_sop_2      ),
        .wr_data_i                              (mem_rd_data        ),
        .in_eop                                 (enq_out_eop_2      ),
        .pck_len_valid                          (                   ),
        .pck_len_i                              (                   ),
        .deq_req                                (deq_req_deq        ),
        .out_sop                                (                   ),
        .rd_data_o                              (deq_rd_data_o      ),
        .out_eop                                (                   ),
        .pck_proc_full                          (                   ),
        .pck_proc_empty                         (pck_proc_empty_deq ),
        .pck_proc_almost_full_value             (                   ),
        .pck_proc_almost_empty_value            (                   ),
        .pck_proc_almost_full                   (                   ),
        .pck_proc_almost_empty                  (                   ),
        .pck_proc_wr_lvl                        (                   ),
        .pck_proc_overflow                      (                   ),
        .pck_proc_underflow                     (                   ),
        .packet_drop                            (                   )
    );

endmodule

