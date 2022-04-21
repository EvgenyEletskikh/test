`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Организация: НИУ МИЭТ
// Выполнил: Елецких Евгений Вадимович
// Должность: студент группы ИКТ-42
// 
// Название проекта: Реализация алгоритма CORDIC для вычисления экспоненты через гиперболические синус и косинус
// Название модуля: cordic_top.v
//////////////////////////////////////////////////////////////////////////////////

module cordic_top#(
    parameter ITERS = 16,
    parameter SW = 1 // SW = 1 - sinh(z)
                     // SW = 2 - cosh(z)
                     // SW = 3 - exp(z) = sinh(z) + cosh(z)
    )
    (
    input CLK,
    input signed [31:0] ix,iy,iz,    
    
    output signed [31:0] Res
    );

wire signed [31:0] wx [ITERS-1:0];
wire signed [31:0] wy [ITERS-1:0];
wire signed [31:0] wz [ITERS-1:0];

reg signed [31:0] atanhLUT [15:0]; 

reg signed [31:0] rRes;

genvar i;
generate
    for (i = 0; i < ITERS; i = i + 1) begin
        if (i == 0) begin
            cordic_unit #(i+1) dut(
                                    .CLK(CLK),
                                    .ix(ix),
                                    .iy(iy),
                                    .iz(iz),
                                    
                                    .atanhLUT(atanhLUT[i]),
                                    
                                    .ox(wx[i]),
                                    .oy(wy[i]),
                                    .oz(wz[i])
                                    );
        end else begin
            cordic_unit #(i+1) dut(
                                    .CLK(CLK),
                                    .ix(wx[i-1]),
                                    .iy(wy[i-1]),
                                    .iz(wz[i-1]),
                                                                        
                                    .atanhLUT(atanhLUT[i]),
                                    
                                    .ox(wx[i]),
                                    .oy(wy[i]),
                                    .oz(wz[i])
                                    );
        end        
    end
endgenerate

always @(posedge CLK) begin
    if (ITERS>16) begin
        $display("Iterations count became bigger than 16! ITERS = %d\n", ITERS);
        $finish;
    end
    
    atanhLUT[0] = 32'b00000000000000001000110010011111;
    atanhLUT[1] = 32'b00000000000000000100000101100011;
    atanhLUT[2] = 32'b00000000000000000010000000101011;
    atanhLUT[3] = 32'b00000000000000000001000000000101;
    atanhLUT[4] = 32'b00000000000000000000100000000001;
    atanhLUT[5] = 32'b00000000000000000000010000000000;
    atanhLUT[6] = 32'b00000000000000000000001000000000;
    atanhLUT[7] = 32'b00000000000000000000000100000000;
    atanhLUT[8] = 32'b00000000000000000000000010000000;
    atanhLUT[9] = 32'b00000000000000000000000001000000;
    atanhLUT[10] = 32'b00000000000000000000000000100000;
    atanhLUT[11] = 32'b00000000000000000000000000010000;
    atanhLUT[12] = 32'b00000000000000000000000000001000;
    atanhLUT[13] = 32'b00000000000000000000000000000100;
    atanhLUT[14] = 32'b00000000000000000000000000000010;
    atanhLUT[15] = 32'b00000000000000000000000000000001;
    
    if (SW == 1) begin
        rRes = wy[ITERS-1];
    end else if (SW == 2) begin
        rRes = wx[ITERS-1];
    end else if (SW == 3) begin
        rRes = wx[ITERS-1] + wy[ITERS-1];    
    end else begin
        $display("Wrong mode has been choosen! SW = %d", SW);
        $finish;
    end
        
end
    
assign Res = rRes;
    
endmodule