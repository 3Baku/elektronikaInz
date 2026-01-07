module REGS #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 5,
    parameter REG_COUNT  = 32
)
(
    input wire i_CLK,
    input wire i_RSTn,

    input wire [ADDR_WIDTH-1:0] i_reg0,
    input wire [ADDR_WIDTH-1:0] i_reg1,

    input wire [ADDR_WIDTH-1:0] i_reg2,
    input wire [DATA_WIDTH-1:0] i_data2,

    output reg [DATA_WIDTH-1:0] o_data0,
    output reg [DATA_WIDTH-1:0] o_data1
);

    reg [DATA_WIDTH-1:0] registers [1:REG_COUNT-1];
    
    integer i;

    always @(*) begin
        if (i_reg0 == 0 || i_reg0 >= REG_COUNT)
            o_data0 = {DATA_WIDTH{1'b0}};
        else
            o_data0 = registers[i_reg0];

        if (i_reg1 == 0 || i_reg1 >= REG_COUNT)
            o_data1 = {DATA_WIDTH{1'b0}};
        else
            o_data1 = registers[i_reg1];
    end

    always @(posedge i_CLK or negedge i_RSTn) begin
        if (!i_RSTn) begin
            for (i = 1; i < REG_COUNT; i = i + 1) begin
                registers[i] <= {DATA_WIDTH{1'b0}};
            end

            //registers[1] <= 8'd10;
           // registers[2] <= 8'd5;
        end
        else
            if (i_reg2 != 0 && i_reg2 < REG_COUNT)
                registers[i_reg2] <= i_data2;
    end

endmodule