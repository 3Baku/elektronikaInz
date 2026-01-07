module cpreg
#(
    parameter WIDTH = 4
)
(
    input wire i_CLK,
    input wire i_RSTn,
    input wire i_READY, i_VALID,
    output reg o_READY, o_VALID,
    input wire [WIDTH-1 : 0] i_D,
    output reg [WIDTH-1 : 0] o_Q   
);

    reg [WIDTH-1 : 0] s_Q1;
    reg s_LATCH, s_VALID;
    wire s_EN1, s_EN2;
    reg [1:0] s_state;

    localparam [1:0] 
        S0 = 2'b00, 
        S1 = 2'b01,
        S2 = 2'b11;

    assign s_EN1 = s_LATCH & (~ i_CLK);
    assign s_EN2 = s_LATCH & i_CLK;

    always @(posedge i_CLK or negedge i_RSTn)
        if (i_RSTn == 1'b0)
            s_VALID <= 1'b0;
        else
            s_VALID <= i_VALID;

    always @(s_EN1)
        if (s_EN1 == 1'b1)
            s_Q1 <= i_D;

    always @(s_EN2)
        if (s_EN2 == 1'b1)
            o_Q <= s_Q1;

    always @(posedge i_CLK or negedge i_RSTn)
        if(i_RSTn == 1'b0)
            s_state <= S0;
        else
            case(s_state)
                S0: if(i_VALID == 1'b1)
                        s_state <= S1;

                S1: if(i_READY == 1'b0)
                        s_state <= S2;
                    else
                        if(i_VALID == 1'b0)
                            s_state <= S0;

                S2: if(i_READY == 1'b1)
                        if(s_VALID)
                            s_state <= S1;
                        else
                            s_state <= S0;

                default:
                        s_state <= S0;
            endcase
        

    always @(*) 
    begin
        s_LATCH = 1'b1;
        o_READY = 1'b1;
        o_VALID = 1'b1;

        case (s_state)
            S0: begin
                    o_VALID = 1'b0;
                end
            S1: begin
                    if (i_READY == 1'b0)
                        s_LATCH = 1'b0;
                end

            S2: begin
                    s_LATCH = 1'b0;
                    o_READY = 1'b0;
                end
        endcase
    end

endmodule