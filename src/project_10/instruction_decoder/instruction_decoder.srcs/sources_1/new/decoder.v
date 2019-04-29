`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 10:31:21
// Design Name: 
// Module Name: decoder
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


module decoder(
    input[31:0] Instruction,    // ȡָ��Ԫ��õ�ָ��
    input[31:0] read_data,      // ���� DATA RAM or I/O port �� ����
    input[31:0] ALU_result,     // ��ALU��ȡ������������Ҫ��չ��������32λ
    input[31:0] opcplus4,       // ���� ȡָ��Ԫ������ JAL
    input Jal,                  // ���� ���Ƶ�Ԫ�� ˵���� JAL ָ��
    input RegWrite,             // ���� ���Ƶ�Ԫ
    input MemtoReg,             // ���� ���Ƶ�Ԫ
    input RegDst,               // ���� ���Ƶ�Ԫ
    input clk,                  // ʱ���ź�
    input rst,                  // ��λ�ź�
    output wire [31:0] read_data_1,   // ����ĵ�һλ������
    output wire [31:0] read_data_2,   // ����ĵڶ�λ������
    output[31:0] Sign_extend    // ���뵥Ԫ�������չ���32λ������ 
    );
    reg [31:0] register[0:31];              // �Ĵ����ļ���32��32λ�Ĵ���
    reg [4:0] write_register_address;       // ��Ҫд��ļĴ�����ַ
    reg [31:0] write_date;                  // ��Ҫд��Ĵ���������
    wire[4:0] read_register_1_address;      // ��Ҫ��ȡ�ĵ�һ���Ĵ�����rs���ĵ�ַ
    wire[4:0] read_register_2_address;      // ��Ҫ��ȡ�ĵڶ����Ĵ�����rt���ĵ�ַ
    wire[4:0] write_register_1_address;     // R-type ָ����Ҫд��ļĴ�����rd���ĵ�ַ
    wire[4:0] write_register_2_address;     // I-type ָ����Ҫд��ļĴ�����rt���ĵ�ַ
    wire[15:0] Instruction_immediate_value; // ָ���е�������
    wire[5:0] opcode;                      // ָ����
    wire[5:0] funct;
    /* ָ���и���������ȡ */
    assign opcode = Instruction[31:26];                     // OP
    assign funct = Instruction[5:0];                        // OP
    assign read_register_1_address = Instruction[25:21];    // rs
    assign read_register_2_address = Instruction[20:16];    // rt (R-type)
    assign write_register_1_address = Instruction[15:11];   // rd (R-type)
    assign write_register_2_address = Instruction[20:16];   // rt (I-type)
    assign Instruction_immediate_value = Instruction[15:0]; // data, rladr (I-type)
    /* ��ȡ�Ĵ��� */ // ��ȷ��
    assign read_data_1 = read_data;
    assign read_data_2 = read_data;
    /* Ŀ��Ĵ�����ָ�� */ 
    always @* begin
        if (opcode == 6'b0000_00)   // R-type
            if (write_register_1_address != 5'b0_0000)  // ����д�� 0 �żĴ���
                write_register_address = write_register_1_address;
        else if (opcode != 6'b0100xx) // I-type
            if (write_register_2_address != 5'b0_0000)  // ����д�� 0 �żĴ���
                write_register_address = write_register_2_address;
        else if (Jal)    // Jal
            write_register_address = 5'd31;
    end
    /* ׼��Ҫд������ */
    always@* begin
        if (~MemtoReg)
            write_date = ALU_result;
        else if (Jal)
            write_date = opcplus4;
    end
    /* �ԼĴ�����д����� */
    integer i;
    always @(posedge clk) begin
        if (rst == 1)
            for (i = 0; i < 32; i = i + 1)
                register[i] <= 0;
        else if (RegWrite == 1) begin
            register[write_register_address] <= write_date;
        end
    end
    /* ����������չ */
    
    
endmodule
