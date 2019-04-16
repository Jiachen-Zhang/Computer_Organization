`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/16 13:00:14
// Design Name: 
// Module Name: mulu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mulu #(parameter WIDTH = 8) (
    input [WIDTH-1:0] a, // ������
    input [WIDTH-1:0] b, // ����
    output reg [WIDTH*2-1:0] c // �˻�
);
    integer cnt;
    reg C;
    reg [WIDTH-1:0] P;
    reg [WIDTH-1:0] Y;
    always @(*)
        begin
        C = 0;
        P = {WIDTH{1'b0}};
        Y = b;
        for(cnt = 0; cnt<WIDTH; cnt=cnt+1) // ѭ������
            begin
            if(Y[0] == 1)
                {C, P} = {C, P} + a; // ���ֻ�+������
            {C, P, Y} = {C, P, Y} >> 1;
            end
        c = {P, Y};
        end
endmodule
