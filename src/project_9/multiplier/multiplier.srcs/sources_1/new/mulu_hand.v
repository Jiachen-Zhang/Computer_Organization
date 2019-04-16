`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/16 12:58:22
// Design Name: 
// Module Name: mulu_hand
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


module mulu_hand #(parameter WIDTH = 8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [WIDTH*2-1:0] c
);
    integer cnt;
    reg [WIDTH-1:0] y,t;
    reg [WIDTH*2-1:0] x,p;
    always @(*)
        begin
        t = {WIDTH{1'b0}};
        x = {t,a}; // ��չ�������� 2N λ
        p = {WIDTH*2{1'b0}}; // ����ʼ��Ϊ 0
        y = b;
        for(cnt = 0; cnt<WIDTH; cnt=cnt+1) // ѭ������
            begin
            if(y[0] == 1)
            p = p + x; // ���ֻ�+������
            x = x << 1; // ����������
            y = y >> 1; // ��������
            end
        c = p;
        end
endmodule

