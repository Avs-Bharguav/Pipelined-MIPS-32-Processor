module REGISTER_FILE (
    input i_clock, i_reset, i_RegWrite;
    input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
    input [31:0] WriteData;
    output [31:0] ReadData1, ReadData2 
);
    reg [31:0] REGISTER [31:0];

    always @(posedge i_clock) begin 
        if (i_RegWrite & (WriteRegister != 0)) REGISTER[WriteRegister] <= WriteData;
    end

    assign ReadData1 = (i_reset == 0) ? 0 : REGISTER[ReadRegister1];
    assign ReadData2 = (i_reset == 0) ? 0 : REGISTER[ReadRegister2];

    initial begin 
        REGISTER[0] = 0; 
    end
endmodule