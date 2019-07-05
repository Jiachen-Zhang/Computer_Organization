`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module control32(Opcode,Jrn, Function_opcode,Alu_resultHigh,RegDST,ALUSrc,MemIOtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp);
    input[5:0]   Opcode;            // ����ȡָ��Ԫinstruction[31..26]
    input[5:0]   Function_opcode;  	// ����ȡָ��Ԫr-���� instructions[5..0]
    input[21:0]  Alu_resultHigh;    // ����ִ�е�Ԫ Alu_Result[31:10]
    output       Jrn;         	 // Ϊ1������ǰָ����jr
    output       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
    output       ALUSrc;          // Ϊ1�����ڶ�������������������beq��bne���⣩
    output       MemIOtoReg;   	//  Ϊ1������Ҫ�Ӵ洢�������ݵ��Ĵ���
    output       RegWrite;   	//  Ϊ1������ָ����Ҫд�Ĵ���
    output       MemWrite;   	//  Ϊ1������ָ����Ҫд�洢��
    output       MemRead;       //  Ϊ1�����洢����
    output       Branch;    	//  Ϊ1������Beqָ��
    output       nBranch;   	//  Ϊ1������Bneָ��
    output       Jmp;        	//  Ϊ1������Jָ��
    output       Jal;        	//  Ϊ1������Jalָ��
    output       I_format;  	//  Ϊ1������ָ���ǳ�beq��bne��LW��SW֮�������I-����ָ��
    output       Sftmd;     	//  Ϊ1��������λָ��
    output[1:0]  ALUOp;	        //  ��R-���ͻ�I_format=1ʱλ1Ϊ1, beq��bneָ����λ0Ϊ1
    output       IORead;        //  Ϊ1������IO��
    output       IOWrite;       //  Ϊ1������IOд
    
   
    wire Jmp,I_format,Jal,Branch,nBranch;
    wire R_format;        // Ϊ1��ʾ��R-����ָ��
    wire Lw;               // Ϊ1��ʾ��lwָ��
    wire Sw;               // Ϊ1��ʾ��swָ��

    
   
    assign R_format = (Opcode==6'b000000)? 1'b1:1'b0;    	//--00h 
    assign RegDST = R_format;                               //˵��Ŀ����rd��������rt

    assign I_format = (Opcode!=6'b000000&&Opcode!=6'h2&&Opcode!=6'h3&&Opcode!=6'h4&&Opcode!=6'h5&&Opcode!=6'h23&&Opcode!=6'h2b)? 1'b1:1'b0;//---
    assign Lw = (Opcode==6'h23)? 1'b1:1'b0;
    assign Jal = (Opcode==6'h3)? 1'b1:1'b0;
    assign Jrn = (R_format&&Function_opcode==6'h8)? 1'b1:1'b0;  
    assign RegWrite = (I_format||(R_format&&Function_opcode!=6'h8)||Lw||Jal)? 1'b1:1'b0;//---

    assign Sw = (Opcode==6'h2b)? 1'b1:1'b0;
    assign ALUSrc = (I_format||Opcode==6'h23||Opcode==6'h2b)? 1'b1:1'b0;//---
    assign Branch = (Opcode==6'h4)? 1'b1:1'b0;
    assign nBranch = (Opcode==6'h5)? 1'b1:1'b0;
    assign Jmp = (Opcode==6'h2)? 1'b1:1'b0;
    
    assign MemWrite = (Sw)&&(Alu_resultHigh[21:0]!=22'b1111111111111111111111)? 1'b1:1'b0; 
    assign MemRead = (Lw)&&(Alu_resultHigh[21:0]!=22'b1111111111111111111111)? 1'b1:1'b0;
    assign IOWrite = (Sw)&&(Alu_resultHigh[21:0]==22'b1111111111111111111111)? 1'b1:1'b0; 
    assign IORead = (Lw)&&(Alu_resultHigh[21:0]==22'b1111111111111111111111)? 1'b1:1'b0;
    assign MemIOtoReg = IORead || MemRead;

    assign Sftmd = (R_format&&(Function_opcode==6'h0||Function_opcode==6'h2||Function_opcode==6'h4||Function_opcode==6'h6||Function_opcode==6'h3||Function_opcode==6'h7))? 1'b1:1'b0; 
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)};  // ��R��type����Ҫ��������32λ��չ��ָ��1λΪ1,beq��bneָ����0λΪ1

endmodule
