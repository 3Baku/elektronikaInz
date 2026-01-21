`timescale 1ns / 1ps

module testbench;

    localparam DATA_WIDTH = 8;
    wire s_CLK, s_RSTn;

    wire signed [DATA_WIDTH-1:0] w_rand_A;
    wire signed [DATA_WIDTH-1:0] w_rand_B;
    reg  [1:0] r_oper;
    
    wire signed [DATA_WIDTH-1:0] w_result;
    wire [2:0] w_flags;

    reg r_test_enable;

    global_signals #(.SIM_CLOCK_CYCLES(150), .CLOCK_PERIOD(10), .SIGNAL_VCD_FILE("alu_stage1.vcd"))
        U_RST_CLK (.o_CLK(s_CLK), .o_RSTn(s_RSTn));
    
    reg signed [DATA_WIDTH-1:0] r_gen_A, r_gen_B;

    always @(posedge s_CLK or negedge s_RSTn) begin
        if (!s_RSTn) begin
            r_gen_A <= {DATA_WIDTH{1'b0}};
            r_gen_B <= {DATA_WIDTH{1'b0}};
        end else if (r_test_enable) begin
            r_gen_A <= $random;
            r_gen_B <= $random;
        end
    end
    
    assign w_rand_A = r_gen_A;
    assign w_rand_B = r_gen_B;

    ALU #(
        .WIDTH(DATA_WIDTH)
    ) UTOP (
        .i_CLK(s_CLK),
        .i_RSTn(s_RSTn),
        
        .i_arg0(w_rand_A), 
        .i_arg1(w_rand_B),
        .i_oper(r_oper),
        
        .o_result(w_result),
        .o_flag(w_flags)
    );
    
    initial begin
        r_oper = 2'b00;
        r_test_enable = 0;
        
        wait(s_RSTn == 0);
        wait(s_RSTn == 1);
        @(posedge s_CLK); 
        
        r_test_enable = 1;

        r_oper <= 2'b00;
        repeat(20) @(posedge s_CLK);

        r_oper <= 2'b01;
        repeat(20) @(posedge s_CLK);

        r_oper <= 2'b10;
        repeat(20) @(posedge s_CLK);

        r_oper <= 2'b11;
        repeat(20) @(posedge s_CLK);

        r_test_enable = 0;
        repeat(5) @(posedge s_CLK);
        
        $finish; 
    end

endmodule