`timescale 1ns / 1ps

module tb_FETCH;
    // Clock & reset
    reg i_clock;
    reg i_reset;

    // Inputs to FETCH
    reg        i_PCSrc;
    reg [31:0] i_PCBTarget;
    reg [31:0] i_PCJTarget;
    reg        i_Jump; 

    // Outputs from FETCH
    wire [31:0] o_PCNext_if_id;
    wire [31:0] o_Instruction_if_id;

    // Instantiate DUT
    FETCH uut (
        .i_clock(i_clock),
        .i_reset(i_reset),
        .i_PCSrc(i_PCSrc),
        .i_PCBTarget(i_PCBTarget),
        .o_PCNext_if_id(o_PCNext_if_id),
        .o_Instruction_if_id(o_Instruction_if_id),
        .i_Jump(i_Jump),
        .i_PCJTarget(i_PCJTarget)
    );

    // Clock generation: 10 ns period
    initial i_clock = 0;
    always #5 i_clock = ~i_clock;

    initial begin
        // GTKWave dump setup
        $dumpfile("IF.vcd");
        $dumpvars(0, tb_FETCH);

        // Initial reset
        i_reset    = 0;
        i_PCSrc    = 0;
        i_PCBTarget = 32'h00000000;
        i_Jump = 0;
        i_PCJTarget = 32'h0000000E;
        #20;

        // Release reset
        i_reset = 1;
        #10;

        // 1) Fetch at PC=0
        i_PCSrc    = 0;        // PC+4 path
        i_PCBTarget = 32'hDEADBEEF; // should be ignored with PCS=0
        #10;
        
        // 2) Advance to PC=1
        // our PC increments internally; here we just wait one cycle
        #50;

        // 3) Branch case: force PC to target
        i_PCSrc    = 1;
        i_PCBTarget = 32'h0000000a;
        #10;

        // 4) Back to sequential
        i_PCSrc    = 0;
        #40;

        i_Jump = 1;
        #10;
        i_Jump = 0; 

        // 5) Finish
        #200;
        $finish;
    end

endmodule
