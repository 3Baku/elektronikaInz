module CONTROL #(
    parameter INSTR_WIDTH = 32,
    parameter ADDR_WIDTH = 5
)
(
    input wire i_CLK,
    input wire i_RSTn,

    input wire [INSTR_WIDTH-1:0] i_instr,
    input wire i_valid,
    output reg o_ready,

    output wire [ADDR_WIDTH-1:0] o_reg0_addr,
    output wire [ADDR_WIDTH-1:0] o_reg1_addr,
    output reg [ADDR_WIDTH-1:0] o_reg2_addr,
    
    output reg [1:0] o_alu_oper,
    input wire i_alu_ready,
    output reg o_alu_valid
);

    wire [1:0] curr_oper = i_instr[31:30];
    wire [ADDR_WIDTH-1:0] curr_reg2 = i_instr[29:25];
    wire [ADDR_WIDTH-1:0] curr_reg0 = i_instr[24:20];
    wire [ADDR_WIDTH-1:0] curr_reg1 = i_instr[19:15];

    reg [ADDR_WIDTH-1:0] pending_dest_reg;
    reg pending_valid;

    wire hazard_detected;
    
    assign hazard_detected = pending_valid && (pending_dest_reg != 0) && ((curr_reg0 == pending_dest_reg) || (curr_reg1 == pending_dest_reg));

    assign o_reg0_addr = curr_reg0;
    assign o_reg1_addr = curr_reg1;

    always @(posedge i_CLK or negedge i_RSTn) begin
        if (!i_RSTn) begin
            o_ready <= 0;
            o_alu_valid <= 0;
            o_alu_oper <= 0;
            o_reg2_addr <= 0;
            pending_dest_reg <= 0;
            pending_valid <= 0;
        end
        else begin
            o_ready <= 1; 
            
            if (i_valid && !hazard_detected && i_alu_ready) begin
                o_alu_oper <= curr_oper;
                o_alu_valid <= 1;
                
                pending_dest_reg <= curr_reg2; 
                pending_valid <= 1;

                o_reg2_addr <= curr_reg2; 

            end
            else if (hazard_detected) begin
                o_alu_valid <= 0;
                o_ready <= 0; 
                
                pending_valid <= 0;
            end
            else begin
                o_alu_valid <= 0;
                pending_valid <= 0;
            end
        end
    end

endmodule