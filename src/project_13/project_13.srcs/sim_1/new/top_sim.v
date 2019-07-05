`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 11:26:13
// Design Name: 
// Module Name: top_sim
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


module top_sim( );
    reg clk = 1'b1;             // �����źţ�ʱ��
    reg rst = 1'b1;             // �����źţ���λ
    reg[31:0] caddress = 32'b0; // �����źţ� �ڴ��ַ ����д��
    reg[4:0] RegAddr = 5'b0;    // �����źţ� �Ĵ�����ַ ����д��
    reg[23:0] switch_i = 24'b0; // �����źţ����뿪��״̬
    
    reg ioReadCtrl = 1'b0;  // �����źţ�IO��ȡ
    reg iowriteCtrl = 1'b0; // �����źţ� IO��LED��д��
    reg MemwriteCtrl = 1'b0;// �����źţ��ڴ�д��
    reg MemreadCtrl = 1'b0; // �����źţ��ڴ��ȡ
    reg RegwriteCtrl = 1'b0;// �����źţ��Ĵ���д��
    reg RegreadCtrl = 1'b0; // �����źţ��Ĵ�����ȡ

    wire[31:0] register [0:31]; // ����źţ��Ĵ���״̬
    wire [23:0] ledout;         // ����źţ� LED �ź�
    
    // �����ź�
    wire[15:0] ioread_data_switch;
    wire[31:0] write_data;
    wire[31:0] mread_data;
    wire[15:0] ledwdata;
   
    top topU(clk, rst, ioReadCtrl, MemreadCtrl, iowriteCtrl, ledout, switch_i, MemwriteCtrl, 
                register, RegAddr, RegwriteCtrl, RegreadCtrl, caddress, 
                ioread_data_switch, write_data, mread_data, ledwdata);
    always #5 clk = ~clk; 
    initial
    begin
    fork
        #10  begin
            // ȡ����λ�źţ��ر����п����ź�
            rst = 1'b0;
            ioReadCtrl = 1'b0;
            iowriteCtrl = 1'b0;
            MemreadCtrl = 1'b0;
            MemwriteCtrl = 1'b0;
            RegreadCtrl = 1'b0;
            RegwriteCtrl = 1'b0;
            end
//  ��200nsʱ��ȡ switchs �����ݣ�����д��reg $1�ĵ�24bit��
        #200 begin
        // �����ź�
            ioReadCtrl = 1'b1;  // ��ȡ switchs 
            MemreadCtrl = 1'b1; // ��ȡ switchs 
            RegwriteCtrl = 1'b1;// д��Ĵ���
        // �����ź�
            switch_i = 24'b111111111111111111111111; // ���뿪��
            RegAddr = 5'b00001;     // �Ĵ�����ַ
        // �����ź�
            caddress = 2'b00;     // ��ȡ��16λ
        end
        #220 caddress = 2'b10;    // ��ȡǰ8λ
        // �����źŹر�
        #240 begin
            ioReadCtrl = 1'b0;
            MemreadCtrl = 1'b0; 
            RegwriteCtrl = 1'b0;
        end 
// ��400nsʱ��ȡ$1�ϵ����ݣ�����д��memory ��ַΪ1�Ĵ洢��Ԫ��
        #400 begin
        // �����ź�
            RegreadCtrl = 1'b1; // �ܹ���ȡ register ������
            MemwriteCtrl = 1'b1;// �ܹ�д�� memory
        // �����ź�
            RegAddr = 1'b1;     // �Ĵ�����ַ
            caddress = 32'b1;   // д���ַ
        end
        // �����źŹر�
        #500 begin
            RegreadCtrl = 1'b0;
            MemwriteCtrl = 1'b0;
        end
// ��600ns��ȡmemory ��ַΪ1�Ĵ洢��Ԫ��ֵ
        #600 begin
            MemreadCtrl = 1'b1;
        end
        // �����źŹر�
        #700 begin
            MemreadCtrl = 1'b0;
        end
// ��800nsʱ����д�뵽 led ��Ϊ�����
        #800 begin
        // �����ź�
            iowriteCtrl = 1'b1;
            ioReadCtrl = 1'b1;  // LEDCtrl ʹ���ź�
        // �����ź�
            caddress = 2'b00;     // д���16λ   
        end
        #840 caddress = 2'b10; // д��ǰ8λ
        // �����źŹر�
        #900 begin
            iowriteCtrl = 1'b0;
            ioReadCtrl = 1'b0;
        end
        #1000 $finish;
    join
    
    end
endmodule
