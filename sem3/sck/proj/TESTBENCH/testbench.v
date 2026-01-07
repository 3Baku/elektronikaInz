`timescale 1ns / 1ps
`include "simulation_modules.v"

module testbench;

    localparam DATA_WIDTH = 8;
    localparam OUT_WIDTH = DATA_WIDTH + 3;

    wire s_CLK, s_RSTn;
    wire s_alu_ready, s_alu_valid;
    wire [OUT_WIDTH-1:0] s_Y;

    reg [DATA_WIDTH-1:0] r_A, r_B;
    reg [1:0] r_oper;
    reg r_valid_in;
    reg r_ready_in;
    
    ALU #(.WIDTH(DATA_WIDTH)) UTOP 
    (
        .i_CLK(s_CLK),
        .i_RSTn(s_RSTn),
        .i_arg0(r_A), 
        .i_arg1(r_B),
        .i_oper(r_oper),
        .i_VALID(r_valid_in),
        .o_READY(s_alu_ready),
        .o_VALID(s_alu_valid),
        .i_READY(r_ready_in),
        .o_Y(s_Y)
    );

    global_signals #(.SIM_CLOCK_CYCLES(50), .CLOCK_PERIOD(10), .SIGNAL_VCD_FILE("alu_report.vcd"))
        U_RST_CLK (.o_CLK(s_CLK), .o_RSTn(s_RSTn));

    initial begin
        r_A = 0; r_B = 0; r_oper = 0;
        r_valid_in = 0;
        r_ready_in = 1;
        
        wait(s_RSTn == 0);
        wait(s_RSTn == 1);
        @(posedge s_CLK);

        @(posedge s_CLK);
        if(s_alu_ready) begin
            r_valid_in <= 1;
            r_oper <= 2'b00; // ADD
            r_A <= 8'd10;
            r_B <= 8'd5;
        end

        @(posedge s_CLK);
        if(s_alu_ready) begin
            r_valid_in <= 1;
            r_oper <= 2'b00; // ADD
            r_A <= 8'sd127;
            r_B <= 8'sd1;
        end

        @(posedge s_CLK);
        if(s_alu_ready) begin
            r_valid_in <= 1;
            r_oper <= 2'b01; // SUB
            r_A <= 8'd50;
            r_B <= 8'd50;
        end

        // 0xAA (10101010) & 0x0F (00001111) = 0x0A (00001010)
        @(posedge s_CLK);
        if(s_alu_ready) begin
            r_valid_in <= 1;
            r_oper <= 2'b10; // AND
            r_A <= 8'hAA;
            r_B <= 8'h0F;
        end

        // A=00000011 (3), B=00000001 (1)
        @(posedge s_CLK);
        if(s_alu_ready) begin
            r_valid_in <= 1;
            r_oper <= 2'b11;
            r_A <= 8'b00000011;
            r_B <= 8'b00000001;
        end

        @(posedge s_CLK);
        r_valid_in <= 0;

        repeat(5) @(posedge s_CLK);
    end

endmodule