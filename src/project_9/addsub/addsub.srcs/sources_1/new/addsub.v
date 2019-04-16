`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/16 01:03:39
// Design Name: 
// Module Name: addsub
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


module addsub #(parameter WIDTH=8) ( //ָ�����ݿ�Ȳ����� ȱʡֵ�� 8
    input [(WIDTH-1):0] a, // ���������� λ���ɲ��� WIDTH ����
    input [(WIDTH-1):0] b, // �������� λ���ɲ��� WIDTH ����
    input sub, // =1 Ϊ����
    output reg [(WIDTH-1):0] sum, // ���
    output reg cf, // ��λ��־
    output reg ovf, // �����־
    output reg sf, // ���ű�־
    output reg zf // Ϊ 0 ��־
);
    reg [(WIDTH-1):0] in;
    always@*
    begin
        if (sub)
            begin
            in = ~b + 1;
            sum = a + in;
            {cf, sum} = a + in;
            cf = ~cf;
            ovf = ~a[WIDTH-1] & b[WIDTH-1]& sum[WIDTH-1] | a[WIDTH-1] & ~b[WIDTH-1]& ~sum[WIDTH-1];
            end
        else
            begin
            {cf, sum} = a + b;
            ovf = ~(a[WIDTH-1] ^ b[WIDTH-1]) & cf;
            end
        // �жϷ���λ���Ƿ�Ϊ0
        sf = sum[WIDTH-1];
        if (sum)
            zf = 0;
        else
            zf = 1;
    end


endmodule
