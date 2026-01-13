`timescale 1ns / 1ps
`include "simulation_modules.v"

module testbench;

    localparam DATA_WIDTH = 8;
    
    wire s_CLK, s_RSTn;
    reg [31:0] r_instr;
    reg r_valid;
    
    reg r_ready_to_receive_result;
    
    wire s_ready_for_instr;
    wire [DATA_WIDTH-1:0] s_out;
    wire s_valid_out;

    CORE #(.DATA_WIDTH(DATA_WIDTH)) UTOP (
        .i_CLK(s_CLK),
        .i_RSTn(s_RSTn),
        .i_instr(r_instr),
        .i_valid(r_valid),
        .o_ready(s_ready_for_instr),
        
        .i_ready1(r_ready_to_receive_result), 
        
        .o_data1(s_out),
        .o_valid1(s_valid_out)
    );

    global_signals #(.SIM_CLOCK_CYCLES(80), .CLOCK_PERIOD(10), .SIGNAL_VCD_FILE("core_waves.vcd"))
        U_RST_CLK (.o_CLK(s_CLK), .o_RSTn(s_RSTn));

    task send_instr;
        input [1:0] op;
        input [4:0] r_dest;
        input [4:0] r_src1;
        input [4:0] r_src2;
        begin
            wait(s_ready_for_instr == 1);
            
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
        r_ready_to_receive_result = 1;
        
        wait(s_RSTn == 0);
        wait(s_RSTn == 1);
        repeat(2) @(posedge s_CLK);
        $display("Rozpoczynam testy CORE...");
        $display("1. ADD R1, R2 -> R3 (Wynik 15)");
        send_instr(2'b00, 5'd3, 5'd1, 5'd2);

        $display("2. SUB R3, R2 -> R4 (RAW Hazard! R3 nie jest jeszcze gotowe)");
        send_instr(2'b01, 5'd4, 5'd3, 5'd2);

        repeat(2) @(posedge s_CLK);
        $display("3. Test wstrzymania (Stall) z zewnątrz");
        
        r_ready_to_receive_result <= 0; 
        
        send_instr(2'b10, 5'd5, 5'd1, 5'd2);
        
        repeat(4) @(posedge s_CLK); 
        
        $display("4. Odblokowanie odbioru");
        r_ready_to_receive_result <= 1;
        
        repeat(5) @(posedge s_CLK);
        $finish;
    end

endmodule