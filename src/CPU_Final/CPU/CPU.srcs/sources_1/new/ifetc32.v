`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Ifetc32(Instruction,PC_plus_4_out,Add_result,Read_data_1,Branch,nBranch,Jmp,Jal,Jrn,Zero,clock,reset,opcplus4,Opcode,Function_opcode,shamt);
    output[31:0] Instruction;			// ���ָ�����ģ��
    output[5:0]  Opcode;
    output[5:0]  Function_opcode;
    output[4:0]  shamt;
    output[31:0] PC_plus_4_out;         // (pc+4)��ִ�е�Ԫ
    input[31:0]  Add_result;            // ����ִ�е�Ԫ,�������ת��ַ
    input[31:0]  Read_data_1;           // �������뵥Ԫ��jrָ���õĵ�ַ
    input        Branch;                // ���Կ��Ƶ�Ԫ
    input        nBranch;               // ���Կ��Ƶ�Ԫ
    input        Jmp;                   // ���Կ��Ƶ�Ԫ
    input        Jal;                   // ���Կ��Ƶ�Ԫ
    input        Jrn;                   // ���Կ��Ƶ�Ԫ
    input        Zero;                  //����ִ�е�Ԫ
    input        clock,reset;           //ʱ���븴λ
    output[31:0] opcplus4;              // JALָ��ר�õ�PC+4
    
    
    wire[31:0]   PC_plus_4;             // PC+4
    reg[31:0]	  PC;                   // PC�Ĵ����������������
    reg[31:0]    next_PC;               // ����ָ���PC����һ����PC+4)
    reg[31:0]    opcplus4;
    
   //����64KB ROM��������ʵ��ֻ�� 64KB ROM
    prgrom instmem(
        .clka(clock),         // input wire clka
        .addra(PC[15:2]),     // input wire [13 : 0] addra
        .douta(Instruction)         // output wire [31 : 0] douta
    );
    assign Opcode = Instruction[31:26];
    assign Function_opcode = Instruction[5:0]; 
    assign shamt = Instruction[10:6];

    assign PC_plus_4[31:2] = PC[31:2] + 1;
    assign PC_plus_4[1:0] = 2'b0;
    assign PC_plus_4_out = PC_plus_4[31:0];  

    always @* begin  // beq $n ,$m if $n=$m branch   bne if $n /=$m branch jr
        if((Branch&Zero|nBranch&(~Zero))==1)begin
            next_PC = Add_result;
//            PC = next_PC<<2; 
        end
        else begin
            if(Jrn)begin
                next_PC = Read_data_1;
//                PC = next_PC<<2; 
            end
            else begin
                next_PC = PC_plus_4>>2;
            end
        end                         // �뿼����������ָ����ж�������
    end
    //OK // ��Ҫ���������������, ��������ֵ���԰����ҵ���˳��ֵ
    //OK // ��Ҫ������ģ�鶼�޸�ͬһ������, ��������tmp
    // ����opcplus4��pc plus 4�������ִ������byte address����word address
    always @(negedge clock) begin  //����J��Jalָ���reset�Ĵ���
        if(reset)begin
            opcplus4 <= 0;
            PC <= 0;
//            next_PC <= 3;
        end
        else begin
            if(Jmp)begin
                PC <= {PC_plus_4[31:28],Instruction[25:0],2'b0}; 
            end
            else begin
                if(Jal)begin
                    opcplus4 <= PC_plus_4>>2;
                    PC <= {PC_plus_4[31:28],Instruction[25:0],2'b0}; 
                    // ���������ұߵ����������¼������ٸ�ֵ�����
                    // ��֧�����ȸ�ֵ
                end
                else begin
                    PC <= (next_PC<<2); 
                end
             end
        end
    end
endmodule
