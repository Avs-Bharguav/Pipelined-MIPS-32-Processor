module Instruction_Memory(
  input i_reset,
  input [31:0] Address,
  output reg [31:0] ReadData  
);
    reg [31:0] MEM [0:1023];/// 4KB memory 
//so divide by 4.  0,1,2,3,4,5 ----- form 0,4,8,12,14,20.  binary last 2bits always 00 for divisiable by 4. 
    //assign ReadData = (i_reset == 0) ? 0 : MEM[Address[31:2]]; ///check why [31:2]; as pc is byte addressable but memory is word addresable. 

    always @(*) begin
    if (!i_reset)
        ReadData = 0;
    else
        ReadData = MEM[Address[31:2]];
    end

    initial begin
        $readmemh("Instruction_mem.hex", MEM);
    end

endmodule