`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module control32(Opcode, Jrn, Function_opcode, Alu_resultHigh, RegDST, ALUSrc, MemorIOtoReg, RegWrite,MemRead, MemWrite,
    IORead, IOWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp);
    input[5:0]   Opcode;            // ����ȡָ��Ԫinstruction[31..26]
    input[5:0]   Function_opcode;  	// ����ȡָ��Ԫr-���� instructions[5..0]
    input[21:0]  Alu_resultHigh;    // ����ִ�е�Ԫ Alu_Result[31..10]
    output       MemorIOtoReg;      // Ϊ 1 ������Ҫ�Ӵ洢���� I/O �����ݵ��Ĵ���
    output       Jrn;         	// Ϊ1������ǰָ����jr
    output       RegDST;        // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
    output       ALUSrc;        // Ϊ1�����ڶ�������������������beq��bne���⣩
    output       RegWrite;   	//  Ϊ1������ָ����Ҫд�Ĵ���
    output       MemRead;       // Ϊ 1 �����Ǵ洢����
    output       MemWrite;   	//  Ϊ1������ָ����Ҫд�洢��
    output       IORead;        // Ϊ 1 ������ I/O ��
    output       IOWrite;       // Ϊ 1 ������ I/O д
    output       Branch;    	//  Ϊ1������Beqָ��
    output       nBranch;   	//  Ϊ1������Bneָ��
    output       Jmp;        	//  Ϊ1������Jָ��
    output       Jal;        	//  Ϊ1������Jalָ��
    output       I_format;  	//  Ϊ1������ָ���ǳ�beq��bne��LW��SW֮�������I-����ָ��
    output       Sftmd;     	//  Ϊ1��������λָ��
    output[1:0]  ALUOp;	        //  ��R-���ͻ�I_format=1ʱλ1Ϊ1, beq��bneָ����λ0Ϊ1
   
    wire Jmp,I_format,Jal,Branch,nBranch;
    wire R_format;        // Ϊ1��ʾ��R-����ָ��
    wire Lw;               // Ϊ1��ʾ��lwָ��
    wire Sw;               // Ϊ1��ʾ��swָ��

    assign R_format = (Opcode==6'b0000_00) ? 1'b1:1'b0;    	// --00h 
    assign RegDST = R_format;                               // ˵��Ŀ����rd��������rt
    assign I_format = (Opcode[5:3] == 3'b001) ? 1'b1:1'b0;
    assign Lw = (Opcode == 6'b1000_11);
    assign Jal = (Opcode == 6'b0000_11); 
    assign Jrn = (Opcode==6'b0000_00 & Function_opcode == 5'h08);   
    assign RegWrite = (R_format || Lw || Jal || I_format) && !(Jrn);

    // д�洢������дIO
    assign MemWrite = ((Sw==1) && (Alu_resultHigh[21:0] != 22'b1111111111111111111111)) ? 1'b1:1'b0;
    assign IORead = (Opcode == 6'b100011 &&  Alu_resultHigh == 22'h3fffff) ? 1'b1 : 1'b0;// ���˿�
    assign MemRead = (Lw & ~IORead) ? 1'b1 : 1'b0; // ���洢��
    assign IOWrite = (Opcode == 6'b101011 &&  Alu_resultHigh == 22'h3fffff) ? 1'b1 : 1'b0; // д�˿�
    assign MemorIOtoReg = IORead || MemRead;

    assign Sw = (Opcode==6'b1010_11);
    assign ALUSrc = (I_format | Lw | Sw) ? 1'b1: 1'b0;
    assign Branch = (Opcode == 6'h4) ? 1'b1 : 1'b0;
    assign nBranch = (Opcode == 6'h5) ? 1'b1 : 1'b0;
    assign Jmp = (Opcode == 6'h2) ? 1'b1 : 1'b0;
    
//    assign MemWrite = Sw ? 1'b1: 1'b0;
    assign Sftmd = (R_format & (Function_opcode == 5'h0 | Function_opcode == 5'h2)) ? 1'b1: 1'b0;
  
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)};  // ��R��type����Ҫ��������32λ��չ��ָ��1λΪ1,beq��bneָ����0λΪ1  
endmodule
