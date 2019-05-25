`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/25 17:01:38
// Design Name: 
// Module Name: sim_switches
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


module sim_switches();
    reg switclk = 1'b0;			       //  ʱ���ź�
    reg switrst = 1'b0;			       //  ��λ�ź�
    reg switchcs = 1'b1;			      //��memorio���ģ��ɵ�����λ�γɵ�switchƬѡ�ź�  !!!!!!!!!!!!!!!!!
    reg[1:0] switchaddr;		    //  ��switchģ��ĵ�ַ�Ͷ�  !!!!!!!!!!!!!!!
    reg switchread = 1'b1;			    //  ���ź�
    wire [15:0] switchrdata;	     //  �͵�CPU�Ĳ��뿪��ֵע����������ֻ��16��
    reg [23:0] switch_i;		    //  �Ӱ��϶���24λ��������
    
    switchs u(switclk, switrst, switchread, switchcs,switchaddr, switchrdata, switch_i);
    initial
    begin
    fork
        forever #5 switclk = ~switclk;
        switch_i = 24'b1111_1111_1111_1111_1111_1111;
        #50 switchaddr = 2'b00; 
        #100 switchaddr = 2'b10; 
        #150 $finish;
    join
    end
endmodule
