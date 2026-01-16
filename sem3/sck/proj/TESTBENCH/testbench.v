`timescale 1ns / 1ps
//`include "simulation_modules.v"

module testbench;

    localparam DATA_WIDTH = 8;
    localparam OUT_WIDTH = DATA_WIDTH + 3;

    wire s_CLK, s_RSTn;
    wire s_alu_ready, s_alu_valid;
    wire [OUT_WIDTH-1:0] s_Y;

    wire [DATA_WIDTH-1:0] w_rand_A, w_rand_B;
    wire w_valid_A, w_valid_B;
    
    reg [1:0] r_oper;
    reg r_test_enable;

    wire s_alu_valid_in = w_valid_A && w_valid_B && r_test_enable;

    random_vector #(.WIDTH(DATA_WIDTH), .SEED(10)) GEN_A (
        .i_CLK(s_CLK),
        .i_RSTn(s_RSTn),
        .i_READY(s_alu_ready),
        .o_VALID(w_valid_A),
        .o_Y(w_rand_A)
    );

    random_vector #(.WIDTH(DATA_WIDTH), .SEED(20)) GEN_B (
        .i_CLK(s_CLK),
        .i_RSTn(s_RSTn),
        .i_READY(s_alu_ready),
        .o_VALID(w_valid_B),
        .o_Y(w_rand_B)
    );

    ALU UTOP 
    (
        .i_CLK(s_CLK),
        .i_RSTn(s_RSTn),
        .i_arg0(w_rand_A), 
        .i_arg1(w_rand_B),
        .i_oper(r_oper),
        
        .i_VALID(s_alu_valid_in),
        .o_READY(s_alu_ready),
        
        .o_VALID(s_alu_valid),
        .i_READY(1'b1),
        .o_Y(s_Y)
    );

    global_signals #(.SIM_CLOCK_CYCLES(100), .CLOCK_PERIOD(10), .SIGNAL_VCD_FILE("alu_random.vcd"))
        U_RST_CLK (.o_CLK(s_CLK), .o_RSTn(s_RSTn));

    initial begin
        r_oper = 0;
        r_test_enable = 0;
        
        wait(s_RSTn == 0);
        wait(s_RSTn == 1);
        @(posedge s_CLK);

        $display("Rozpoczynam testy losowe...");
        r_test_enable = 1;

        // (ADD)
        r_oper <= 2'b00;
        repeat(20) @(posedge s_CLK);

        // (SUB)
        r_oper <= 2'b01;
        repeat(20) @(posedge s_CLK);

        // (AND)
        r_oper <= 2'b10;
        repeat(20) @(posedge s_CLK);

        // count ones
        r_oper <= 2'b11;
        repeat(20) @(posedge s_CLK);

        r_test_enable = 0;
        $display("Koniec testow.");
        repeat(5) @(posedge s_CLK);
    end

endmodule