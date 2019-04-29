`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/21 10:48:01
// Design Name: 
// Module Name: divu
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


module divu #(parameter WIDTH = 8)(
    input [WIDTH-1:0] a, // ������
    input [WIDTH/2-1:0] b, // ����
    input clk,
    input start,
    input resetn, 
    output reg [WIDTH-1:0]  q, //    ��
    output reg [WIDTH/2-1:0] r, // ����
    output reg busy // ����������
 );   
    integer cnt;
    reg [WIDTH-1:0] Quotient;
    reg [WIDTH+WIDTH/2-1:0] Divisor;
    reg [WIDTH+WIDTH/2:0] Remainder;
    reg [WIDTH+WIDTH/2:0] diff;
    always@(posedge clk or negedge resetn) begin
        if (~resetn | (~(|b) & start)) begin // resetn �� ���� Ϊ0
            Quotient = 0;
            Divisor = 0;
            Remainder = 0;
            busy = 0;
            q = Quotient;
            r = Remainder[WIDTH/2-1:0];
        end else begin 
            if (cnt > 0) begin      // cnt > 0 ���ڼ���
                cnt = cnt - 1;
                diff = Remainder - Divisor;
                Quotient = Quotient << 1;
                if (!diff[WIDTH+WIDTH/2])
                begin
                    Remainder = diff;
                    Quotient[0] = 1'b1;
                end
                Divisor = Divisor >> 1;
            end
            else if (~busy & start) begin // busy = 0 �� start ��Ч, ���г�ʼ��
                busy = 1;
                Remainder[WIDTH+WIDTH/2] = 0;
                Remainder[WIDTH+WIDTH/2-1:WIDTH/2] = 0;
                Remainder[WIDTH-1:0] = a;
                Divisor[WIDTH+WIDTH/2-1:WIDTH] = b;
                Divisor[WIDTH-1:0] = 0;
                Quotient = 0;
                diff = 0;
                cnt = WIDTH + 1;
            end else if (cnt == 0) begin // cnt = 0 �������
                busy = 0; 
                q = Quotient;
                r = Remainder[WIDTH/2-1:0];
            end 
        end
    end
endmodule
