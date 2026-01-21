module ALU #(
    parameter WIDTH = 8
)
(
    input wire signed [WIDTH-1:0] i_arg0,
    input wire signed [WIDTH-1:0] i_arg1,
    input wire [1:0] i_oper,

    input wire i_CLK,
    input wire i_RSTn,

    output reg [WIDTH-1:0] o_result, 
    output reg [2:0] o_flag
);

    reg [WIDTH-1:0] next_result;
    reg [2:0] next_flag;
    
    reg [WIDTH:0] temp_add_sub;
    reg [2*WIDTH-1:0] temp_vec;
    integer i;

    always @(*) begin
        next_result = {WIDTH{1'b0}};
        next_flag = 3'b000;
        temp_add_sub = {(WIDTH+1){1'b0}};
        temp_vec = {(2*WIDTH){1'b0}};

        case(i_oper)
            2'b00: begin
                temp_add_sub = i_arg0 + i_arg1;
                next_result  = temp_add_sub[WIDTH-1:0];
                
                next_flag[1] = temp_add_sub[WIDTH];
                
                next_flag[0] = (i_arg0[WIDTH-1] == i_arg1[WIDTH-1]) && (next_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end

            2'b01: begin
                {next_flag[1], next_result} = $unsigned(i_arg0) - $unsigned(i_arg1);
                
                next_flag[0] = (i_arg0[WIDTH-1] != i_arg1[WIDTH-1]) && (next_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end

            2'b10: begin
                next_result = i_arg0 & i_arg1;
            end

            2'b11: begin
                temp_vec = {i_arg1, i_arg0};
                next_result = 0;
                for(i = 0; i < 2*WIDTH; i = i + 1)
                    next_result = next_result + temp_vec[i];
                
            end
            
            default: begin
                next_result = {WIDTH{1'b0}};
            end
        endcase

        next_flag[2] = (next_result == {WIDTH{1'b0}});
    end

    always @(posedge i_CLK or negedge i_RSTn) begin
        if (!i_RSTn) begin
            o_result <= {WIDTH{1'b0}};
            o_flag <= 3'b000;
        end
        else begin
            o_result <= next_result;
            o_flag <= next_flag;
        end
    end

endmodule