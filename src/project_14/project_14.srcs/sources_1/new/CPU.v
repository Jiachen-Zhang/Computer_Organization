`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 21:13:26
// Design Name: 
// Module Name: CPU
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


module CPU(clk_100MHz, rst, switch_in, led_out//);
           ,Instruction ,PC_plus_4_out, PC, next_PC, register);
    input clk_100MHz;
    input rst;      // ��λ�ź�
    input[23:0] switch_in;
    output[23:0] led_out;
    
    /* �����ź� */
    output [31:0] PC_plus_4_out; // ��ȡָ��ִ�� PC+4
    wire[31:0] PC_plus_4; // ȡָ��Ԫ PC+4
    output wire[31:0] PC; // ȡֵ��Ԫ PC�Ĵ���
    output wire[31:0] next_PC; // ȡֵ��Ԫ ��һ��PC
    output wire[31:0] register[31:0]; // ���뵥Ԫ reg ��������ʾ, �˴�����������ļ� Source Node Property Ϊ SystemVerilog ֧��
    output [31:0] Instruction;
    /********************/
    
    wire[31:0] Instruction;     // ��ǰָ�� ��������ȫ��ͳһ
    wire[31:0] PC_plus_4_out;   // ��ȡָ��ִ�� PC+4
    wire[31:0] Add_result;      // ִ�е�Ԫ ���������ת��ַ
    wire[31:0] Read_data_1;     // ���뵥Ԫ ��reg�ж�ȡ���1, ȡָ��Ԫ jrָ������ת��ַ
    wire Branch;    // �����ź� beq
    wire nBranch;   // �����ź� bne
    wire Jmp;       // �����ź� j - jump
    wire Jal;       // �����ź� jal - jump and link
    wire Jrn;       // �����ź� jr - jump to reg
    wire Zero;      // ִ�е�Ԫ ���������Ϊ0 ��λΪ1
    wire[31:0] opcplus4;    // ȡָ��Ԫ�����뵥Ԫ JAL ר�� PC+4
    
    wire[31:0] Read_data_2; // ���뵥Ԫ ��reg�ж�ȡ���2, memorio д��mem/io��������Դ
    wire[31:0] read_data;   // ��mem/io�����뵥Ԫ  ׼����д��reg, memorio ���mem/io ��ȡ�����ݵ�Ŀ�ĵ�
    wire[31:0] ALU_result;  // ִ�е�Ԫ ALU ������ĵ�ַ���, ���뵥Ԫ����д��reg
    wire[31:0] Sign_extend; // ���뵥Ԫ, ��������չ��Ľ��
    wire RegWrite;          // ִ�е�Ԫ�����뵥Ԫ дreg���ź�
    wire MemorIOtoReg;      // ִ�е�Ԫ�����뵥Ԫ �����ǰ�mem(io)��ȡ���д��reg ���ǰ�alu������д��reg
    wire RegDst;            // ��ִ�������� ����reg��Ŀ��Ĵ�����rt����rd [�Ӿ��棿] �������ƺ�û�õ�
    
    wire[5:0] Function_opcode = Instruction[5:0];   // ִ�е�Ԫ funct ֱ�Ӵ�ָ���6λ�õ�
    wire[5:0] Exe_opcode = Instruction[31:26];      // ִ�е�Ԫ opcode ֱ�Ӵ�ָ��ǰ6λ�õ�
    wire[4:0] Shamt = Instruction[10:6];            // ִ�е�Ԫ shamt ֱ�Ӵ�ָ���м�5λ�õ�
    wire[1:0] ALUOp;    // ���Ƶ�Ԫ��ִ�е�Ԫ ����ָ����Ʊ���
    wire Sftmd;         // ���Ƶ�Ԫ��ִ�е�Ԫ 1��������λָ��
    wire ALUSrc;        // ���Ƶ�Ԫ��ִ�е�Ԫ 1������2������������������չ 0��ʹ��Read_data_2
    wire I_format;      // ���Ƶ�Ԫ��ִ�е�Ԫ 1˵����I����ָ���ȥbeq,bne,lw,sw��
    
    wire[21:0] Alu_resultHigh = ALU_result[31:10];  // ִ�е�Ԫ ��ALU����ж���IO��������mem���� ȫ1Ϊǰ��
    wire[31:0] address;     // memorio ��ʾ��mem/ioд�ĵ�ַ
    wire[31:0] write_data;  // memorio ��ʾ��mem/ioд������
    
    /* ִ�е�Ԫ��MemorIO�Ķ�д�ź� */
    wire MemRead, MemWrite, IORead, IOWrite;
    
    /* �� Memory/IO��ȡ������ */
    wire[31:0] mread_data;
    wire[15:0] ioread_data;
    
    wire LEDCtrl; // ��memorio��led LED��Ƭѡ�ź�
    wire SwitchCtrl; // ��memorio��switch switch��Ƭѡ�ź�
    
    wire[15:0] ioread_data_switch;      // ��switch��ioread ���Բ��뿪�صĶ�ȡ
    /* IO��ַ�� 2'b00:��16λ 2'b10:ǰ��λ */
    wire[1:0] ledaddr = address[1:0];
    wire[1:0] switchaddr = address[1:0];
    
    /* ����ʱ�ӽ�Ƶ����ȡCPUʱ�� */
    wire clk;
    assign clk = clk_100MHz;
    
    /* ȡָ��Ԫ */
//    Ifetc32 Ifetc32(Instruction, PC_plus_4_out, Add_result, Read_data_1, Branch, nBranch, Jmp, Jal, Jrn, Zero, clk, rst, opcplus4, next_PC, PC);
    
    Ifetc32 Uifetch(Instruction,PC_plus_4_out,Add_result,
        Read_data_1,Branch,nBranch,Jmp,Jal,Jrn,Zero,
        clk,rst,opcplus4, next_PC, PC);
    /* ���뵥Ԫ */
    decoder decoder(Instruction, read_data, ALU_result, opcplus4, Jal, RegWrite, MemorIOtoReg, RegDst, clk, rst, 
                    Read_data_1, Read_data_2, Sign_extend, register);
    
    /* ִ�е�Ԫ */
    execute_unitx32 execute_unitx32(Read_data_1, Read_data_2, Sign_extend, Function_opcode, Exe_opcode, ALUOp, Shamt, Sftmd, ALUSrc, I_format, Jrn,
                    Zero, ALU_result, Add_result, PC_plus_4);
    /* ���Ƶ�Ԫ */
    control32 control32(Exe_opcode, Function_opcode, Jrn, RegDst, ALUSrc, 
                        MemorIOtoReg, RegWrite, MemWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd, ALUOp);
                        
    /* Memory/IO ���ص�Ԫ */
    memorio memorio(ALU_result, address, MemRead, MemWrite, IORead, IOWrite, mread_data, 
                    ioread_data, Read_data_2, read_data , write_data, LEDCtrl, SwitchCtrl); // ����CPUͨ·ͼ wdata�ƺ����������뵥Ԫread_data_2, rdata�������뵥Ԫ��read_data 
                    
    /* RAM */
    dmemory32 dmemory32(mread_data, ALU_result, write_data, MemWrite, clk);     // д���ַ address ���� ALU_result read_data �� memorio �� mread_data
    
    /* IORead */
    ioread ioread(rst, IORead, SwitchCtrl, ioread_data, ioread_data_switch);
    
    /* LED */
    leds leds(clk, rst, LEDCtrl, LEDCtrl, ledaddr, write_data[15:0], led_out);
    
    /* Switch */
    switchs switchs(clk, rst, SwitchCtrl, SwitchCtrl, switchaddr, ioread_data_switch, switch_in);
    
endmodule
