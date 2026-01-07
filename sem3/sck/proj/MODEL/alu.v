`include "library_modules.v"

module ALU #(
    parameter WIDTH = 8
)
(
    input wire signed [WIDTH-1:0] i_arg0,
    input wire signed [WIDTH-1:0] i_arg1,
    input wire [1:0] i_oper,

    output wire [WIDTH+2:0] o_Y, 

    input wire i_CLK,
    input wire i_RSTn,
    input wire i_VALID,
    output wire o_READY,
    output wire o_VALID,
    input wire i_READY
);

    reg signed [WIDTH-1:0] o_result;
    reg flag_overflow;
    reg flag_carry;
    reg flag_zero;
    
    reg [WIDTH:0] temp_add_sub;
    reg [2*WIDTH-1:0] temp_vec;
    integer i;

    always @(*) begin
        o_result = {WIDTH{1'b0}};
        flag_overflow = 1'b0;
        flag_carry = 1'b0;
        flag_zero = 1'b0;
        temp_add_sub = {(WIDTH+1){1'b0}};

        case(i_oper)
           2'b00: begin
                temp_add_sub = i_arg0 + i_arg1; 
                
                o_result = temp_add_sub[WIDTH-1:0];
                
                flag_carry = temp_add_sub[WIDTH];

                flag_overflow = (i_arg0[WIDTH-1] == i_arg1[WIDTH-1]) && (o_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end

            2'b01: begin
                {flag_carry, o_result} = $unsigned(i_arg0) - $unsigned(i_arg1);
                
                flag_overflow = (i_arg0[WIDTH-1] != i_arg1[WIDTH-1]) && (o_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end

            2'b10: begin
                o_result = i_arg0 & i_arg1;
                flag_carry = 1'b0;
                flag_overflow = 1'b0;
            end

            2'b11: begin
                temp_vec = {i_arg1, i_arg0};
                o_result = 0;
                for(i = 0; i < 2*WIDTH; i = i + 1) begin
                    o_result = o_result + temp_vec[i];
                end
            end
        endcase

        flag_zero = (o_result == {WIDTH{1'b0}});
    end

    cpreg #(
        .WIDTH(WIDTH + 3)
    ) u_preg (
        .i_CLK(i_CLK),
        .i_RSTn(i_RSTn),
        .i_VALID(i_VALID),
        .o_READY(o_READY),
        
        .o_VALID(o_VALID),
        .i_READY(i_READY),
        
        .i_D({o_result, flag_overflow, flag_carry, flag_zero}),
        .o_Q(o_Y)
    );

endmodule