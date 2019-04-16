`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/16 10:14:28
// Design Name: 
// Module Name: sim_addsub
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


module sim_addsub( );
    reg [3:0] a; // ���������� λ���ɲ��� WIDTH ����
    reg [3:0] b; // �������� λ���ɲ��� WIDTH ����
    reg sub; // =1 Ϊ����
    wire [3:0] sum; // ���
    wire cf; // ��λ��־
    wire ovf; // �����־
    wire sf; // ���ű�־
    wire zf; // Ϊ 0 ��־
    addsub #(4) u (.a(a), .b(b), .sub(sub), .sum(sum), .cf(cf), .ovf(ovf), .sf(sf), .zf(zf));
    initial
    begin
    sub = 0;
    a = 4'b1111;
    b = 4'b1111;
    # 100
    a = 4'b0011;
    b = 4'b0011;
    # 100
    a = 4'b0000;
    b = 4'b0000;
    # 100
    a = 4'b1011;
    b = 4'b0011;
    
    #100
    sub = 1;
    a = 4'b1111;
    b = 4'b0011;
    # 100
    a = 4'b0011;
    b = 4'b1111;
    # 100
    a = 4'b0011;
    b = 4'b0011;
    # 100
    a = 4'b1000;
    b = 4'b0111;
    #100 $finish;  
    end
endmodule
