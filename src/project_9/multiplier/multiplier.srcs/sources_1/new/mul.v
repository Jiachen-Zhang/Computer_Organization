`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/16 13:17:10
// Design Name: 
// Module Name: mul
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


module mul #(parameter WIDTH = 8) (
    input [WIDTH-1:0] a, // ������
    input [WIDTH-1:0] b, // ����
    output reg [WIDTH*2-1:0] c // �˻�
);
    integer cnt; // ѭ������
    reg [WIDTH-1:0] A,B; // ��ű������������Ͳ��ֻ�
    reg sign; // ��λλ
    reg C;
    reg [WIDTH-1:0] P;
    reg [WIDTH-1:0] Y;
    always @(*)
        begin
        A = a;
        B = b;
        if(a[WIDTH-1] == 1) // �������Ǹ����Ĵ���
            A = ~A + 1;
        if(b[WIDTH-1] == 1) // �����Ǹ����Ĵ���
            B = ~B + 1;
        
        C = 0;
        P = {WIDTH{1'b0}};
        Y = B;
        for(cnt = 0; cnt<WIDTH; cnt=cnt+1) // ѭ������
            begin
            if(Y[0] == 1)
                {C, P} = {C, P} + A; // ���ֻ�+������
            {C, P, Y} = {C, P, Y} >> 1;
            end
        c = {P, Y};
        sign = a[WIDTH-1] ^ b[WIDTH-1];
        // ������ŵĴ���
        if (sign)
            c = ~c + 1;
        end
endmodule
