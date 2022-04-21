`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Организация: НИУ МИЭТ
// Выполнил: Елецких Евгений Вадимович
// Должность: студент группы ИКТ-42
// 
// Название проекта: Реализация алгоритма CORDIC для вычисления экспоненты через гиперболические синус и косинус
// Название модуля: cordic_unit.v
//////////////////////////////////////////////////////////////////////////////////

module cordic_unit#(
    parameter CURIT = 1
    )
    (
    input CLK,
    input signed [31:0] ix,iy,iz,
    
    input signed [31:0] atanhLUT,
    
    output signed [31:0] ox,oy,oz
    );
    
reg signed [31:0] rx,ry,rz;
reg signed [31:0] rxs,rys; // shifted inputs ix and iy

integer i;

always @(posedge CLK) begin
    // generate shifted registers
    rxs = ix;
    rys = iy;
    for (i = 0; i < CURIT; i = i + 1) begin
        rxs = {rxs[31], rxs[31:1]};
        rys = {rys[31], rys[31:1]};
    end
    
    if (iz[31] == 1) begin
        rx = ix - rys;
        ry = iy - rxs;
        rz = iz + atanhLUT;
    end else begin
        rx = ix + rys;
        ry = iy + rxs;
        rz = iz - atanhLUT;
    end
    
    if ((CURIT == 4) || (CURIT == 13)) begin        
        for (i = 0; i < CURIT; i = i + 1) begin
            rxs = {rxs[31], rxs[31:1]};
            rys = {rys[31], rys[31:1]};
        end        
                
        if (iz[31] == 1) begin
            rx = rx - rys;
            ry = ry - rxs;
            rz = rz + atanhLUT;
        end else begin
            rx = rx + rys;
            ry = ry + rxs;
            rz = rz - atanhLUT;
        end      
    end
end // always
    
assign ox = rx;
assign oy = ry;
assign oz = rz;

endmodule
