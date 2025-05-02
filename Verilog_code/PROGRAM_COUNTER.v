module PC (
    input i_clock, i_reset,
    input [31:0] i_NPC,
    output [31:0] o_PC
);
    reg [31:0] PC;

    always @(posedge i_clock) begin
        if (~i_reset) PC <= 0;
        else PC <= i_NPC;
    end

    assign o_PC = PC;

endmodule