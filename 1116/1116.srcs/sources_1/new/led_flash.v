`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/02 10:36:52
// Design Name: 
// Module Name: led_flash
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


module led_flash(
    input               sys_clk,
    input               sys_rst_n,
    output reg [7:0]    led
    );
   
parameter COUNT_MAX  = 10_000_000;
parameter DATA_WIDTH = 25;

reg [DATA_WIDTH - 1:0] counter;
reg [2:0] LED_ctrl;
reg order;

wire counter_wire;

assign counter_wire = (counter == (COUNT_MAX - 1)) ? 1'b1 : 1'b0;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0)
        counter <= 1'b0;
    else if (counter_wire)
        counter <= 1'b0;
    else
        counter <= counter + 1'b1;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0)
        order <= 1'b0;
    else begin 
        if (LED_ctrl == 3'b0)
            order <= 1'b0;
        else if (LED_ctrl == 3'b111)
            order <= 1'b1;
    end
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0)
        LED_ctrl <= 3'b0;
    else if (counter_wire == 1'b1 && order == 1'b0)
        LED_ctrl <= LED_ctrl + 1'b1;
    else if (counter_wire == 1'b1 && order == 1'b1)
        LED_ctrl <= LED_ctrl - 1'b1;
end
    
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0)
        led <= 8'b0;
    else begin
        case (LED_ctrl)
            3'b000 : led <= 8'b00000001;
            3'b001 : led <= 8'b00000010;
            3'b010 : led <= 8'b00000100;
            3'b011 : led <= 8'b00001000;
            3'b100 : led <= 8'b00010000;
            3'b101 : led <= 8'b00100000;
            3'b110 : led <= 8'b01000000;
            3'b111 : led <= 8'b10000000;
            default : led <= 8'b00000000;
        endcase
    end
end

endmodule
