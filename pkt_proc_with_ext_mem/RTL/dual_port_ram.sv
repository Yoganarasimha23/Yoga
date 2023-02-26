module dual_port_ram #(
            parameter       ADDR_WIDTH = 14                 ,   
            parameter       DATA_WIDTH = 32                 ,
            parameter       PCK_LEN    = 12                 ,
            parameter       RAM_DEPTH  = 1 << ADDR_WIDTH
)(
        input   logic                       clk             ,
        input   logic                       rst             ,
        input   logic                       wr_en           ,               
        input   logic [ADDR_WIDTH-1:0]      addr_wr         ,  
        input   logic [DATA_WIDTH-1:0]      data_in         , 
        input   logic                       enq_in_sop      ,
        input   logic                       enq_in_eop      ,
        input   logic [PCK_LEN-1:0]         enq_pck_len_in  ,
        input   logic                       rd_en           ,              
        input   logic  [ADDR_WIDTH-1:0]     addr_rd         , 

        output  logic [DATA_WIDTH-1:0]      data_out        ,
        output  logic                       enq_out_sop     ,
        output  logic                       enq_out_eop     ,
        output  logic                       RAM_FULL        ,
        output  logic                       RAM_EMPTY       ,
        output  logic                       RAM_OVERFLOW    ,
        output  logic                       RAM_UNDERFLOW   

);

    logic [DATA_WIDTH-1:0]  mem [(2**ADDR_WIDTH)-1:0];
    logic [PCK_LEN-1:0]     counter;
    logic                   counter_active; 
    logic [PCK_LEN - 1:0]   saved_pck_len_in;  
    logic                   enq_out_eop_next; 
    logic [ADDR_WIDTH:0]  wr_ptr;
    logic [ADDR_WIDTH:0]  rd_ptr;
    logic [ADDR_WIDTH-1:0]  count;
    logic                   full;
    logic                   empty;


assign full = ((wr_ptr[ADDR_WIDTH-1:0]==rd_ptr[ADDR_WIDTH-1:0])&&(wr_ptr[ADDR_WIDTH]!=rd_ptr[ADDR_WIDTH]))?1'b1:1'b0;
assign empty = (wr_ptr == rd_ptr)?1'b1:1'b0;
assign addr_wr = wr_ptr[ADDR_WIDTH-1:0];
assign addr_rd =  rd_ptr[ADDR_WIDTH-1:0];
    
    always @(posedge clk or negedge rst)
    begin
        if (!rst)
        begin
            wr_ptr      <= 1'b0;
            rd_ptr      <= 1'b0;
         //   full        <= 1'b0;
           // empty       <= 1'b1;
            RAM_UNDERFLOW <= 1'b0;
            RAM_OVERFLOW  <=  1'b0;
            counter     <= {PCK_LEN{1'b0}};
            enq_out_sop <= 1'b0;
            enq_out_eop <= 1'b0;
            counter_active <= 1'b0;
            saved_pck_len_in <= {PCK_LEN{1'b0}};
            enq_out_eop_next <= 1'b0;
        end
        else if (rd_en)
        begin
            if (!counter_active)
            begin
                counter <= 1'b0;
                counter_active <= 1'b1;
                enq_out_sop <= 1'b1;
                saved_pck_len_in <= enq_pck_len_in;
                enq_out_eop <= 1'b0;
                enq_out_eop_next <= 1'b0;
            end
            else if ((counter < saved_pck_len_in) && counter_active)
            begin
                enq_out_sop <= 1'b0;
                enq_out_eop <= enq_out_eop_next;
                counter <= counter + 1'b1;
                enq_out_eop_next <= (counter + 1'b1 == saved_pck_len_in);
            end
            else if (counter == saved_pck_len_in)
            begin
                enq_out_eop <= enq_out_eop_next;
                enq_out_sop <= 1'b0;
                counter     <= counter;
                counter_active <= 1'b0;
                enq_out_eop_next <= 1'b0;
            end
            else begin
                enq_out_sop <= 1'b0;
                enq_out_eop <= enq_out_eop_next;
                counter <= counter;
                enq_out_eop_next <= 1'b0;
            end
        end
        else begin
            RAM_FULL        <= full;
            RAM_EMPTY       <= empty;
            counter <= {PCK_LEN{1'b0}};
            counter_active <= 1'b0;
            enq_out_sop <= 1'b0;
            enq_out_eop <= 1'b0;
            saved_pck_len_in <= {PCK_LEN{1'b0}};
            enq_out_eop_next <= 1'b0;
        end
    end
     
    
    always @(posedge clk) begin
        if (wr_en) begin
            if (!full) begin
            mem[addr_wr] <= data_in;
            wr_ptr <= wr_ptr + 1;
            end
            else begin
                    RAM_OVERFLOW <= 1'b1;
        end
        end
        end

    always @(posedge clk) begin
        if (rd_en) begin 
            if (!empty) begin
            data_out <= mem[addr_rd];
            rd_ptr <= rd_ptr +1;
            end else begin
                    RAM_UNDERFLOW <= 1'b1;
        end
        end
        end

endmodule
