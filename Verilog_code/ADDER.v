module Adder (
    input [31:0] A, B,
    output [31:0] o_output

);
    assign o_output = A + B;

endmodule