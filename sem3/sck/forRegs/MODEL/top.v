module REGS #(
    parameter N = 32,
    parameter M = 32,
    parameter ADDR_WIDTH = 5
)
(
    input wire i_clk,
    input wire i_rsn,

    input wire [ADDR_WIDTH-1:0] i_reg0,
    input wire [ADDR_WIDTH-1:0] i_reg1,

    input wire [ADDR_WIDTH-1:0] i_reg2,
    input wire [M-1:0] i_data2,

    output reg [M-1:0] o_data0,
    output reg [M-1:0] o_data1
);

    reg [M-1:0] RRR [1:N];
    integer i;

    always @(posedge i_clk or negedge i_rsn) begin
        if (!i_rsn) begin
            o_data0 <= {M{1'b0}};
            o_data1 <= {M{1'b0}};
            for (i = 1; i <= N; i = i + 1)
                RRR[i] <= {M{1'b0}};
        end 
        else begin
            if (i_reg2 > 0 && i_reg2 <= N)
                RRR[i_reg2] <= i_data2;

            o_data0 <= (i_reg0 > 0 && i_reg0 <= N) ? RRR[i_reg0] : {M{1'b0}};
            o_data1 <= (i_reg1 > 0 && i_reg1 <= N) ? RRR[i_reg1] : {M{1'b0}};
            
        end
    end

endmodule