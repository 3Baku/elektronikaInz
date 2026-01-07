`timescale 1ns / 1ps
`include "simulation_modules.v"

module testbench;

    localparam DATA_WIDTH = 8;
    localparam ADDR_WIDTH = 5;

    wire s_CLK, s_RSTn;
    
    reg [ADDR_WIDTH-1:0] r_reg0, r_reg1, r_reg2;
    reg [DATA_WIDTH-1:0] r_data2;
    wire [DATA_WIDTH-1:0] s_data0, s_data1;

    REGS #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) UTOP (
        .i_CLK(s_CLK),
        .i_RSTn(s_RSTn),
        .i_reg0(r_reg0),
        .i_reg1(r_reg1),
        .i_reg2(r_reg2),
        .i_data2(r_data2),
        .o_data0(s_data0),
        .o_data1(s_data1)
    );

    global_signals #(.SIM_CLOCK_CYCLES(50), .CLOCK_PERIOD(10), .SIGNAL_VCD_FILE("regs_waves.vcd"))
        U_RST_CLK (.o_CLK(s_CLK), .o_RSTn(s_RSTn));

    initial begin
        r_reg0 = 0; r_reg1 = 0; r_reg2 = 0;
        r_data2 = 0;
        
        wait(s_RSTn == 0);
        wait(s_RSTn == 1);
        @(posedge s_CLK);

        r_reg2  <= 5'd1;
        r_data2 <= 8'd55;
        @(posedge s_CLK); 

        r_reg2  <= 5'd2;
        r_data2 <= 8'hAA;
        r_reg0  <= 5'd1;
        @(posedge s_CLK);

        r_reg2  <= 5'd0;
        r_data2 <= 8'hFF;
        r_reg0  <= 5'd1;
        r_reg1  <= 5'd2;
        @(posedge s_CLK);

        r_reg2  <= 5'd0;
        r_reg0  <= 5'd0;
        r_reg1  <= 5'd1;
        @(posedge s_CLK);
        
        r_reg0 <= 0; r_reg1 <= 0;
        repeat(5) @(posedge s_CLK);
    end

endmodule