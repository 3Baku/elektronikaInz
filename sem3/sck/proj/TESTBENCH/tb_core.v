`timescale 1ns / 1ps
`include "simulation_modules.v"

module testbench;

    localparam DATA_WIDTH = 8;
    
    wire s_CLK, s_RSTn;
    reg [31:0] r_instr;
    reg r_valid;
    wire s_ready;
    wire [DATA_WIDTH-1:0] s_out;
    wire s_valid_out;

    CORE #(.DATA_WIDTH(DATA_WIDTH)) UTOP (
        .i_CLK(s_CLK),
        .i_RSTn(s_RSTn),
        .i_instr(r_instr),
        .i_valid(r_valid),
        .o_ready(s_ready),
        .o_data1(s_out),
        .o_valid1(s_valid_out)
    );

    global_signals #(.SIM_CLOCK_CYCLES(60), .CLOCK_PERIOD(10), .SIGNAL_VCD_FILE("core_waves.vcd"))
        U_RST_CLK (.o_CLK(s_CLK), .o_RSTn(s_RSTn));

    task send_instr;
        input [1:0] op;
        input [4:0] r_dest;
        input [4:0] r_src1;
        input [4:0] r_src2;
        begin
            wait(s_ready == 1);
            @(posedge s_CLK);
            r_valid <= 1;
           
            r_instr <= {op, r_dest, r_src1, r_src2, 15'd0}; 
            @(posedge s_CLK);
            r_valid <= 0;
        end
    endtask

    initial begin
        r_valid = 0;
        r_instr = 0;
        wait(s_RSTn == 0);
        wait(s_RSTn == 1);
        repeat(2) @(posedge s_CLK);

        //R1=5, R2=10 -> R3=15
        send_instr(2'b00, 5'd3, 5'd1, 5'd2);

        //(R4 = 15 - 5 = 10)
        send_instr(2'b01, 5'd4, 5'd3, 5'd1);

        //AND R1, R2 -> R5
        send_instr(2'b10, 5'd5, 5'd1, 5'd2);
        
        repeat(10) @(posedge s_CLK);
    end

endmodule