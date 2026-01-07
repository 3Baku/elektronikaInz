module global_signals 
    #(
        parameter SIM_CLOCK_CYCLES = 120,
        parameter CLOCK_PERIOD = 10,
        parameter SIGNAL_VCD_FILE = "SIGNALS.vcd"
    )
    (
        output wire o_CLK,
        output wire o_RSTn
    );
        
        reg clk;
        reg rst_n;

        assign o_CLK = clk;
        assign o_RSTn = rst_n;

        localparam CLK_PERIOD = CLOCK_PERIOD;
        always #(CLK_PERIOD/2) 
            clk=~clk;

        initial begin
            $dumpfile(SIGNAL_VCD_FILE);
            $dumpvars(0, testbench);
        end

        initial begin
            #1;
            rst_n<=1'bx; clk<=1'bx;
            
            #(CLK_PERIOD*3) rst_n<=1;
            
            #(CLK_PERIOD*3) rst_n<=0;clk<=0;
            
            repeat(5) 
                @(posedge clk);
            
            rst_n<=1;
            @(posedge clk);

            repeat(SIM_CLOCK_CYCLES) 
                @(posedge clk);

            $finish;
        end
endmodule

module random_vector
    #(
        parameter WIDTH = 9
    ) 
    (
        input  wire i_CLK,
        input  wire i_RSTn,
        input  wire i_READY,
        output wire o_VALID,
        output wire [WIDTH-1 : 0] o_Y
    );
        integer SEED = 100;
        reg s_was_valid;
        reg [WIDTH-1 : 0] s_Y;
        reg s_VALID;

        assign #(1) o_Y     = s_Y;
        assign #(1) o_VALID = s_VALID;

        initial 
        begin
            #1;
            @(posedge i_RSTn);

            s_Y <= {WIDTH{1'b0}};
            s_VALID <= 1'b0;
            s_was_valid <= 1'b0;

            forever 
            begin
                fork 
                    begin : GENEROWANIE_SYGNALOW_WYJSCIOWYCH
                        @(posedge i_CLK)
                        begin
                            s_VALID <= $random(SEED);
                            if (i_READY == 1'b1 && s_was_valid == 1'b1)
                                {s_Y} <= {s_Y, $random(SEED)};
                        end
                        
                        if (i_RSTn == 1'b0)
                            @(posedge i_RSTn);
                    end

                    begin : ZAPAMIETANIE_POPRZEDNIEGO_VALID
                        @(negedge i_CLK)
                            s_was_valid <= s_VALID;
                    end
                join
            end
        end
endmodule


module vector_data_accept 
#(
    parameter WIDTH = 8
)
(
        input wire i_CLK,
        input wire i_RSTn,
        input wire i_VALID,
        input wire [WIDTH-1 : 0] i_D,
        output wire o_READY
);

    integer SEED = 100;
    reg [WIDTH-1 : 0] s_DATA;
    reg s_READY;

    assign #(1) o_READY = s_READY;

    initial 
    begin
        #1;
        @(posedge i_RSTn);

        s_READY <= 1'b0;

        forever 
        begin
            @(posedge i_CLK)
            begin
                if (s_READY == 1'b1 && i_VALID == 1'b1) 
                        s_DATA <= i_D;
                s_READY <= $random(SEED);
            end
            
            if (i_RSTn == 1'b0)
            begin
                s_READY <= 1'b0;
                @(posedge i_RSTn);
            end

        end
    end

endmodule