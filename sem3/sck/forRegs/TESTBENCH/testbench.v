`timescale 1ns / 1ps

module testbench;

    localparam N = 32;
    localparam M = 32;
    localparam ADDR_WIDTH = 5;

    wire s_clk, s_rsn;
    reg [ADDR_WIDTH-1:0] r_reg0, r_reg1, r_reg2;
    reg [M-1:0] r_data2;
    wire [M-1:0] w_data0, w_data1;

    global_signals #(.SIM_CLOCK_CYCLES(50), .CLOCK_PERIOD(10), .SIGNAL_VCD_FILE("regs_simulation.vcd"))
        U_RST_CLK (.o_CLK(s_clk), .o_RSTn(s_rsn));

    REGS #(
        .N(N),
        .M(M),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) UTOP (
        .i_clk(s_clk),
        .i_rsn(s_rsn),
        .i_reg0(r_reg0),
        .i_reg1(r_reg1),
        .i_reg2(r_reg2),
        .i_data2(r_data2),
        .o_data0(w_data0),
        .o_data1(w_data1)
    );

    initial begin
        r_reg0 = 0;
        r_reg1 = 0;
        r_reg2 = 0;
        r_data2 = 0;

        wait(s_rsn == 0);
        wait(s_rsn == 1);
        @(posedge s_clk);

        $display("----------------------------------------------------------------");
        $display("Time\t\tAction\t\t\t\tR_Write\tData_W\t\tR_Read0\tData_R0");
        $display("----------------------------------------------------------------");

        // 1. Write to R2
        r_reg2 <= 2;
        r_data2 <= 32'hAABBCCDD;
        r_reg0 <= 0; 
        r_reg1 <= 0;
        @(posedge s_clk);
        #1 $display("%0t\tWrite R2=0x%h\t\t%0d\t%h\t%0d\t%h", $time, r_data2, r_reg2, r_data2, r_reg0, w_data0);

        // 2. Write to R5 and Read R2 (Previous write)
        r_reg2 <= 5;
        r_data2 <= 32'h11223344;
        r_reg0 <= 2; 
        @(posedge s_clk);
        #1 $display("%0t\tWrite R5 / Read R2\t\t%0d\t%h\t%0d\t%h", $time, r_data2, r_reg2, r_data2, r_reg0, w_data0);

        // 3. Read R5 (Previous write)
        r_reg2 <= 0; 
        r_data2 <= 0;
        r_reg0 <= 5; 
        @(posedge s_clk);
        #1 $display("%0t\tRead R5\t\t\t\t%0d\t%h\t%0d\t%h", $time, r_data2, r_reg2, r_data2, r_reg0, w_data0);

        // 4. Try Write to R0 (Should be ignored)
        r_reg2 <= 0; 
        r_data2 <= 32'hFFFFFFFF;
        r_reg0 <= 5; 
        @(posedge s_clk);
        #1 $display("%0t\tTry Write R0\t\t\t%0d\t%h\t%0d\t%h", $time, r_data2, r_reg2, r_data2, r_reg0, w_data0);

        // 5. Read R0 (Should be 0)
        r_reg2 <= 0;
        r_reg0 <= 0;
        @(posedge s_clk);
        #1 $display("%0t\tRead R0\t\t\t\t%0d\t%h\t%0d\t%h", $time, r_data2, r_reg2, r_data2, r_reg0, w_data0);

        // 6. Read Out of Bounds (Should be 0)
        r_reg0 <= 31; // Assuming N=32, this is valid. Let's try N+1
        r_reg1 <= 33; 
        @(posedge s_clk);
        #1 $display("%0t\tRead Invalid R33\t\t%0d\t%h\t%0d\t%h", $time, r_data2, r_reg2, r_data2, r_reg1, w_data1);

        repeat(5) @(posedge s_clk);
        $finish;
    end

endmodule