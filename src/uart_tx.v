`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2026 11:16:22 PM
// Design Name: 
// Module Name: uart_tx
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


module uart_tx#(
    parameter CLK_FREQ = 100_000_000,
    parameter BAUD_RATE = 115200
)(
    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,
    
    output reg tx,
    output reg tx_busy
    );
    
    reg [1:0] state;
    
    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;
    
    reg [7:0] shift_data = 8'b0;
    reg [3:0] index;
    
    localparam CLKS_PER_BIT = CLK_FREQ/ BAUD_RATE;
    reg [9:0] clk_counter;
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state <= IDLE;
            tx <= 1'b1;
            tx_busy <= 1'b0;
            clk_counter <= 9'b0;
            index <= 3'b0;
            shift_data <= 8'b0;
        end else begin
        
            case(state)
            
                IDLE: begin
                    tx <= 1'b1;
                    tx_busy <= 1'b0;
                    if(tx_start) begin
                        shift_data <= tx_data;
                        index <= 4'b0;
                        state <= START;
                        tx_busy <= 1'b1;
                        clk_counter <= 0;
                    end   
                end
            
                START: begin
                    tx <= 0;
                    
                    if(clk_counter < CLKS_PER_BIT-1) begin 
                        clk_counter <= clk_counter + 1;
                    end else begin
                        clk_counter <= 0;
                        state <= DATA;
                    end
                end
                
                DATA: begin 
                    tx <= shift_data[index];
                    
                    if(clk_counter < CLKS_PER_BIT-1) begin 
                        clk_counter <= clk_counter + 1;
                    end else begin 
                        clk_counter <= 0;                        
                        if(index >= 3'd7) begin 
                            state <= STOP;
                        end else begin 
                            index <= index + 1;
                        end
                    end 
                end
                
                STOP: begin 
                    tx <= 1'b1;
                    if(clk_counter < CLKS_PER_BIT-1) begin 
                        clk_counter <= clk_counter + 1;
                    end else begin 
                        clk_counter <= 0;
                        tx_busy <= 1'b0;
                        state <= IDLE;
                    end
                end
                
            endcase  
        end
        
    end

    
    
endmodule
