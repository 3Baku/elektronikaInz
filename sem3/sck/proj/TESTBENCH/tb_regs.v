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

        // 1. Standardowy zapis i odczyt
        $display("T1: Zapis 55 do R1");
        r_reg2  <= 5'd1;
        r_data2 <= 8'd55;
        @(posedge s_CLK);

        // 2. Odczyt tego, co zapisaliśmy + Zapis nowej wartości
        $display("T2: Odczyt R1 (oczekiwane 55) i Zapis AA do R2");
        r_reg0  <= 5'd1;      // Czytamy R1
        r_reg2  <= 5'd2;      // Piszemy do R2
        r_data2 <= 8'hAA;
        @(posedge s_CLK);

        // 3. Test R0 (musi być zawsze 0)
        $display("T3: Próba zapisu FF do R0 (powinna być ignorowana)");
        r_reg2  <= 5'd0;
        r_data2 <= 8'hFF;
        r_reg0  <= 5'd0;      // Czytamy R0
        r_reg1  <= 5'd2;      // Czytamy R2 (powinno być AA)
        @(posedge s_CLK);

        // 4. TEST SPECYFIKACJI: Odczyt spoza zakresu (>31)
        //  "Odczyt z rejestru o numerze, który przekracza liczbę rejestrów zwraca 0"
        $display("T4: Odczyt z rejestru 33 (oczekiwane 0)");
        r_reg0  <= 5'd33; 
        r_reg2  <= 5'd0; // Wyłącz zapis
        @(posedge s_CLK);

        // 5. Read-During-Write (Ten sam rejestr R5)
        $display("T5: Jednoczesny zapis i odczyt R5");
        r_reg2  <= 5'd5;
        r_data2 <= 8'h77;
        r_reg0  <= 5'd5; 
        @(posedge s_CLK);
        
        // Sprawdzenie czy w kolejnym takcie R5 ma nową wartość
        r_reg2 <= 0;
        r_reg0 <= 5'd5;
        @(posedge s_CLK);

        $finish;
    end

endmodule