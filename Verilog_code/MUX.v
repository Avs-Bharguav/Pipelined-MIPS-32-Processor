module MUX (
    output [31:0] o_out, 
    input w_select, 
    input [31:0] i_A, 
    input [31:0] i_B
    );

    assign o_out = w_select ? i_B : i_A;

endmodule