`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 10:42:27
// Design Name: 
// Module Name: top
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


module top(clk, rst, ioReadCtrl, MemreadCtrl, iowriteCtrl, ledout, switch_i, MemwriteCtrl, 
            switchaddr,ledaddr, register, RegAddr, RegwriteCtrl, RegreadCtrl, caddress, 
            ioread_data_switch, write_data, mread_data, ledwdata);
    input[31:0] caddress;           // ��Ҫд��ĵ�ַ����memoryio�и�ֵ��address
    input clk, rst;
    input ioReadCtrl;               // read IO, from control32
    input MemreadCtrl;				// read memory, from control32
    input MemwriteCtrl;             // write memory, from control32
    input iowriteCtrl;              // write IO, from control32
    input [23:0] switch_i;		    //  �Ӱ��϶���24λ��������
    output[23:0] ledout;	        //  ������������24λLED�ź�
    input[1:0] switchaddr;		    //  ��switchģ��ĵ�ַ�Ͷ�
    input[1:0] ledaddr;
    input[4:0] RegAddr;
    wire SwitchCtrl;
    wire[31:0] wdata = RegreadCtrl ? register[RegAddr] : 32'b0;			// the data from idecode32,that want to write memory or io;
    input RegwriteCtrl, RegreadCtrl;
    input [31:0] register[0:31];
    
    // �����ź�
    output[15:0] ioread_data_switch;
    output[31:0] write_data;
    output[31:0] mread_data;
    output[15:0] ledwdata;
    
    

    
    wire[31:0] read_data;       // �Ӵ洢��Ԫ�л�õ�����
    /* �洢�����ĵ�Ԫ */
    wire memread = MemreadCtrl;
    wire memwrite = MemwriteCtrl;    
    wire ioread = ioReadCtrl;
    wire iowrite = iowriteCtrl;
    wire[31:0] mread_data = MemreadCtrl ? read_data : (RegreadCtrl ? register[RegAddr] : mread_data);  // �Ӵ洢���л�õ�����
    wire LEDCtrl;
    wire[31:0] rdata;           // data from memory or IO that want to read into register
    wire[31:0] address;         // address to mAddress and I/O
    wire[31:0] write_data;      // data to memory or I/O
    /*
    assign	  LEDCtrl = ioread;    // led ģ���Ƭѡ�źţ��ߵ�ƽ��Ч;
    assign    SwitchCtrl = memread;    //switch ģ���Ƭѡ�źţ��ߵ�ƽ��Ч    
    */
    wire[15:0] ioread_data;
    memorio memorioU(caddress,address,memread,memwrite,ioread,iowrite,mread_data,ioread_data,wdata,rdata,write_data,LEDCtrl,SwitchCtrl);
    
    /* ���뿪�� */
    /* SwitchCtrl & ioReadCtrl ʱ�ɶ� */
    wire switchcs = SwitchCtrl;
    wire switclk = clk;
    wire switrst = rst;
    wire[15:0] switchrdata;         //  �͵�CPU�Ĳ��뿪��ֵע����������ֻ��16��
    wire switchread = ioReadCtrl;   //  ���ź�
    switchs switchsU(switclk, switrst, switchread, switchcs,switchaddr, switchrdata, switch_i);
   
    /* IO����Ķ�·ѡ���� */
    /* ioReadCtrl ʱ�ɶ��� SwitchCtrl ʱ��ȡ���뿪�� */
    wire reset = rst;
    wire ior = ioReadCtrl;
    wire switchctrl = SwitchCtrl;
    wire[15:0] ioread_data_switch = switchrdata;

    ioread ioreadU(reset,ior,switchctrl,ioread_data,ioread_data_switch);
    
    
    /* �洢��Ԫ */
    wire clock = clk;
    wire Memwrite = MemwriteCtrl;
    dmemory32 dmemory32(read_data, address, write_data, Memwrite, clock);
    
    /* LED ģ�� */
    wire led_clk = clk;
    wire ledrst = rst;
    wire ledcs = LEDCtrl;
    wire ledwrite = iowriteCtrl;		       // д�ź�
    wire[1:0] ledaddr;
    wire[15:0] ledwdata = ledaddr == 2'b00 ? mread_data[15:0] : mread_data[31:16];	   //  д��LEDģ������ݣ�ע��������ֻ��16��
    leds ledsU(led_clk, ledrst, ledwrite, ledcs, ledaddr,ledwdata, ledout);
    
    /* ���üĴ��� */
    reg [31:0] register[0:31];
    always@(posedge clk, negedge rst) begin
        if (rst) begin
            for (integer cnt = 0; cnt < 32; cnt = cnt + 1) 
                register[cnt] <= 0;
        end
        else if (RegwriteCtrl == 1'b1) begin
            if (switchaddr == 2'b00)
                register[RegAddr][15:0] <= ioread_data;
            else
                register[RegAddr][31:16] <= ioread_data;
        end
    end
endmodule
