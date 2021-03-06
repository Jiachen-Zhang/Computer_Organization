`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/21 10:48:01
// Design Name: 
// Module Name: divu
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


module divu #(parameter WIDTH = 8)(
    input [WIDTH-1:0] a, // 被除数
    input [WIDTH/2-1:0] b, // 除数
    input clk,
    input start,
    input resetn, 
    output reg [WIDTH-1:0]  q, //    商
    output reg [WIDTH-1:0] r, // 余数
    output reg busy // 正在做除法
 );   
    integer cnt;
    reg [WIDTH-1:0] Quotient;
    reg [WIDTH+WIDTH/2-1:0] Divisor;
    reg [WIDTH+WIDTH/2:0] Remainder;
    reg [WIDTH+WIDTH/2:0] diff;
    always@(posedge clk or negedge resetn)
    begin
        if (!resetn)
            begin
            Quotient <= 0;
            Divisor <= 0;
            Remainder <= 0;
            end
        else 
        begin
            if (start) 
                begin
                busy <= 1;
                Remainder[WIDTH+WIDTH/2] <= 0;
                Remainder[WIDTH+WIDTH/2-1:WIDTH] <= 0;
                Remainder[WIDTH-1:0] <= a;
                Divisor[WIDTH+WIDTH/2-1:WIDTH] <= b;
                Divisor[WIDTH-1:0] <= 0;
                Quotient <= 0;
                diff <= 0;
                $display("START: a = %d, b = %d, Remainder = %b, Divisor = %b, Quotient = %b, diff = %b", a, b, Remainder, Divisor, Quotient, diff);
                end
            if (busy)
                begin
                    for (cnt = 0; cnt <= WIDTH; cnt = cnt + 1)
                    begin
                        diff = Remainder - Divisor;
                        Quotient = Quotient << 1;
                        if (!diff[WIDTH+WIDTH/2])
                        begin
                            Remainder = diff;
                            Quotient[0] = 1'b1;
                        end
                        Divisor = Divisor >> 1;
                        $display("a = %d, b = %d, Remainder = %b, Divisor = %b, Quotient = %b, diff = %b", a, b, Remainder, Divisor, Quotient, diff);
                    end
                    busy <= 0;
                    q <= Quotient;
                    r <= Remainder[WIDTH-1:0];
                end
            end
            
    end
endmodule
