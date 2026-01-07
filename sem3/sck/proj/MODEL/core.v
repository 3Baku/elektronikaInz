module CORE #(
    parameter DATA_WIDTH = 8
)
(
    input wire i_CLK,
    input wire i_RSTn,

    input wire [31:0] i_instr,
    input wire i_valid,
    output wire o_ready,

    output wire [DATA_WIDTH-1:0] o_data1,
    output wire o_valid1
);

    wire [4:0] s_reg0_addr, s_reg1_addr, s_reg2_addr;
    wire [1:0] s_alu_oper;
    wire s_alu_start_valid;
    
    wire [DATA_WIDTH-1:0] s_op_a, s_op_b;
    
    wire s_alu_out_ready;
    wire [DATA_WIDTH+2:0] s_alu_result_packet;
    wire s_alu_done_valid;
    
    wire [DATA_WIDTH-1:0] s_result_data;
    
    reg [4:0] r_reg2_addr_delayed;

    always @(posedge i_CLK or negedge i_RSTn) begin
        if(!i_RSTn) r_reg2_addr_delayed <= 0;
        else if(s_alu_start_valid) r_reg2_addr_delayed <= s_reg2_addr;
    end

    CONTROL U_CTRL (
        .i_CLK(i_CLK), .i_RSTn(i_RSTn),
        .i_instr(i_instr),
        .i_valid(i_valid),
        .o_ready(o_ready),
        
        .o_reg0_addr(s_reg0_addr),
        .o_reg1_addr(s_reg1_addr),
        .o_reg2_addr(s_reg2_addr),
        
        .o_alu_oper(s_alu_oper),
        .i_alu_ready(s_alu_out_ready),
        .o_alu_valid(s_alu_start_valid)
    );

    REGS #(.DATA_WIDTH(DATA_WIDTH)) U_REGS (
        .i_CLK(i_CLK), .i_RSTn(i_RSTn),
        
        .i_reg0(s_reg0_addr),
        .i_reg1(s_reg1_addr),
        
        .i_reg2(r_reg2_addr_delayed), 
        .i_data2(s_result_data),
        
        .o_data0(s_op_a),
        .o_data1(s_op_b)
    );

    ALU #(.WIDTH(DATA_WIDTH)) U_ALU (
        .i_CLK(i_CLK), .i_RSTn(i_RSTn),
        
        .i_arg0(s_op_a),
        .i_arg1(s_op_b),
        .i_oper(s_alu_oper),
        
        .i_VALID(s_alu_start_valid),
        .o_READY(s_alu_out_ready),
        
        .o_VALID(s_alu_done_valid),
        .i_READY(1'b1),
        
        .o_Y(s_alu_result_packet)
    );
    
    assign s_result_data = s_alu_result_packet[DATA_WIDTH+2 : 3];

    assign o_data1 = s_result_data;
    assign o_valid1 = s_alu_done_valid;

endmodule