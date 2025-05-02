module FETCH (
    input  i_clock,            // ← system clock
    input  i_reset,            // ← active-high reset
    input  i_PCSrc,            // ← select between PC+4 vs. branch target
    input  i_Jump,             // jump control
    input  [31:0] i_PCJTarget, // jump target address
    input  [31:0] i_PCBTarget,  // ← branch/jump target address
    output [31:0] o_PCNext_if_id,    // ← PC+4 passed to IF/ID
    output [31:0] o_Instruction_if_id // ← fetched instruction to IF/ID
);

    // Calculate next PC: either sequential or branch target
    wire [31:0] w_PCplus4, w_PCNest0;
    MUX PC_Bmux (
        .o_out(w_PCNest0),   // ← selected PC
        .w_select(i_PCSrc), // ← 0 = PC+4, 1 = branch
        .i_A(w_PCplus4),    // ← PC+4 input
        .i_B(i_PCBTarget)    // ← branch target input
    );
    ////adding jump instruction
     wire [31:0]  w_PCNest;
    MUX PC_Jmux (
        .o_out(w_PCNest),   // ← selected PC
        .w_select(i_Jump), // ← 0 = PC+4, 1 = branch
        .i_A(w_PCNest0),    // ← PC+4 input
        .i_B(i_PCJTarget)    // ← branch target input
    );

    // Program counter register
    wire [31:0] w_PCAddress;
    PC Program_counter (
        .i_clock(i_clock),  // ← clock
        .i_reset(i_reset),  // ← reset
        .i_NPC(w_PCNest),   // ← next PC value
        .o_PC(w_PCAddress)  // ← current PC value
    );

    // Instruction memory read (32-bit word fetch)
    wire [31:0] w_Instruction_if_id;
    Instruction_Memory IMEM (      
        .i_reset(i_reset),
        .Address(w_PCAddress),
        .ReadData(w_Instruction_if_id)
    );

    // Adder for PC+4
    
    Adder PC_adder (
        .A(w_PCAddress),   // ← PC value
        .B(4),             // ← increment by 4 bytes
        .o_output(w_PCplus4) // ← PC+4
    );

    assign w_PCNext_if_id = w_PCplus4;

    // IF/ID pipeline registers
    wire [31:0] w_PCNext_if_id;
    reg [31:0] r_Instruction_if_id, r_PCNext_if_id;
    always @(posedge i_clock or negedge i_reset) begin
        if (~i_reset) begin
            r_Instruction_if_id <= 0; // ← clear on reset
            r_PCNext_if_id      <= 0; // ← clear on reset
        end else begin
            r_Instruction_if_id <= w_Instruction_if_id; // ← latch instruction
            r_PCNext_if_id      <= w_PCNext_if_id;      // ← latch PC+4
        end
    end

    // Outputs to IF/ID stage
    assign o_Instruction_if_id = r_Instruction_if_id; // ← pipeline output
    assign o_PCNext_if_id      = r_PCNext_if_id;      // ← pipeline output

endmodule
