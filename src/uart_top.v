`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2026 06:32:58 PM
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    input clk,
    input rst,
    input [7:0] data_out,
    input rx_pin,
    input send_data,
    output tx_pin,
    output rx_done,
    output reg [3:0] d0_anode,
    output reg [7:0] data_out_display
    );
    
    localparam CLKS_PER_SEC = 100_000_000;

    reg [15:0] clk_divider = 16'b0;
    reg [1:0] display_counter = 2'b00;

    wire [7:0] data_received;
    wire [7:0] fpga_data_display_lower;
    wire [7:0] computer_data_display_lower;
    wire [7:0] fpga_data_display_higher;
    wire [7:0] computer_data_display_higher;

    reg transmit_sync0 = 0;
    reg transmit_sync1 = 0;

    wire tx_busy;
    wire transmit_start;

    assign transmit_start = ~transmit_sync0 && transmit_sync1;

    uart_rx#(.CLK_FREQ(CLKS_PER_SEC), .BAUD_RATE(115200)) rx_module(
        .clk(clk),
        .rst(rst),
        .rx(rx_pin),
        .rx_done(rx_done),
        .data_in(data_received)
    );

    seven_segment_mux in_muxer(.data_in(data_received), .mux_out0(computer_data_display_lower), .mux_out1(computer_data_display_higher));
    seven_segment_mux out_muxer(.data_in(data_out), .mux_out0(fpga_data_display_lower), .mux_out1(fpga_data_display_higher));

    uart_tx#(.CLK_FREQ(CLKS_PER_SEC), .BAUD_RATE(115200)) tx_module(
        .clk(clk),
        .rst(rst),
        .tx_start(transmit_start),
        .tx_data(data_out),
        .tx_busy(tx_busy),
        .tx(tx_pin)
    );
    
    always @(posedge clk) begin
        if(rst) begin 
            display_counter <= 2'b00;
            clk_divider <= 16'b0;
        end else begin
            clk_divider <= clk_divider + 1;
            if(clk_divider == 16'hFFFF) begin 
                display_counter <= display_counter + 1;
            end
        end
        transmit_sync0 <= send_data;
        transmit_sync1 <= transmit_sync0;
    end
    
    always @(posedge clk) begin
        if(display_counter == 0) begin 
            data_out_display <= fpga_data_display_higher;
            d0_anode <= 4'b1011;
        end else if(display_counter == 1) begin 
            data_out_display <= fpga_data_display_lower;
            d0_anode <= 4'b0111;
        end else if(display_counter == 2) begin 
            data_out_display <= computer_data_display_higher;
            d0_anode <= 4'b1110;
        end else if(display_counter == 3) begin 
            data_out_display <= computer_data_display_lower;
            d0_anode <= 4'b1101;
        end
    end
endmodule
