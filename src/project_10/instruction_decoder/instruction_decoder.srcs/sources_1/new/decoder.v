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
    output wire[31:0] read_data_1,  // ����ĵ�һλ������
    output wire[31:0] read_data_2,  // ����ĵڶ�λ������
    output[31:0] Sign_extend,        // ���뵥Ԫ�������չ���32λ������
    output reg [31:0] register[0:31] // �Ĵ����ļ���32��32λ�Ĵ���
    );
    reg [4:0] write_register_address;       // ��Ҫд��ļĴ�����ַ
    reg [31:0] write_date;                  // ��Ҫд��Ĵ���������
    wire[4:0] read_register_1_address;      // ��Ҫ��ȡ�ĵ�һ���Ĵ�����rs���ĵ�ַ
    wire[4:0] read_register_2_address;      // ��Ҫ��ȡ�ĵڶ����Ĵ�����rt���ĵ�ַ
    wire[4:0] write_register_1_address;     // R-type ָ����Ҫд��ļĴ�����rd���ĵ�ַ
    wire[4:0] write_register_2_address;     // I-type ָ����Ҫд��ļĴ�����rt���ĵ�ַ
    wire[15:0] Instruction_immediate_value; // ָ���е�������
    wire[5:0] opcode;                       // ָ����
    wire[5:0] funct;
    reg R_type, I_type, J_type, C_type;    // C_type All coprocessor instructions
    reg andi, ori;

    /* ָ���и���������ȡ */
    assign opcode = Instruction[31:26];                     // OP
    assign funct = Instruction[5:0];                        // funct
    always@* begin
        {andi, ori} = 2'b00;
        if (I_type)
            case(opcode)
            6'b001100:  {andi, ori} = 2'b10;
            6'b001101:  {andi, ori} = 2'b01;
            endcase
    end
    
    assign read_register_1_address = Instruction[25:21];    // rs
    assign read_register_2_address = Instruction[20:16];    // rt (R-type)
    assign write_register_1_address = Instruction[15:11];   // rd (R-type)
    assign write_register_2_address = Instruction[20:16];   // rt (I-type)
    assign Instruction_immediate_value = Instruction[15:0]; // data, rladr (I-type)
    
    /* ��ȡ�Ĵ��� */
    assign read_data_1 = register[read_register_1_address];
    assign read_data_2 = register[read_register_2_address];
    
    always @* begin 
        {R_type, I_type, J_type, C_type} = 4'b0000;
            case(opcode)
            6'b0000_00: {R_type, I_type, J_type, C_type} = 4'b1000;
            6'b0000_1x: {R_type, I_type, J_type, C_type} = 4'b0010;
            6'b0100_xx: {R_type, I_type, J_type, C_type} = 4'b0001;
            default:    {R_type, I_type, J_type, C_type} = 4'b0100;
            endcase
//            $display("time:%3dns, {R_type, I_type, J_type, C_type} = %b", $time, {R_type, I_type, J_type, C_type});
        /* Ŀ��Ĵ�����ָ�� */ 
        if (R_type)     // R-type => rd
            if (write_register_1_address != 5'b0_0000) begin  // ����д�� 0 �żĴ���
                write_register_address = write_register_1_address;
//                $display("time:%3dns, R_type, write_register_address = %d, write_register_1_address = %d, Instruction = %b", $time, write_register_address, write_register_1_address, Instruction);
            end else
                register[0] = 0;
        if (I_type) begin// I-type => rt
            write_register_address = 5'b0_0001;
            if (write_register_2_address != 5'b0_0000) begin // ����д�� 0 �żĴ���
                write_register_address = write_register_2_address;
//                $display("time:%3dns, I_type, write_register_address = %d, write_register_2_address = %d, Instruction = %b", $time, write_register_address, write_register_2_address, Instruction);
            end else
                  register[0] = 0;
        end
        if (Jal)   // Jal
            write_register_address = 5'd31;
//        $display ("time = %3d, write_register_address = %d, write_register_1_address = %d, write_register_2_address = %d", $time, write_register_address, write_register_1_address, write_register_2_address);
        /* ׼��Ҫд������ */
        if (~MemtoReg) write_date = ALU_result;
        else write_date = read_data;
        if (RegDst) write_date = opcplus4;
//        $monitor ("time:%3dns, write_date = %h\n", $time, write_date);
    end
    
    /* �ԼĴ�����д����� */
    integer i;
    always @(posedge clk) begin
        if (rst == 1)
            for (i = 0; i < 32; i = i + 1)
                register[i] <= i;
        else begin
            if (RegWrite == 1) register[write_register_address] <= write_date;
        end
    end
    /* ����������չ */
    wire sign;
    assign sign = ~(andi || ori) && Instruction_immediate_value[15]; // andi ori: ZeroExtImm else SignExtImm
    assign Sign_extend = sign ? {16'hffff, Instruction_immediate_value}:{16'h0000, Instruction_immediate_value};
    
endmodule
