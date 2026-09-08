`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2026 10:22:59 AM
// Design Name: 
// Module Name: uart_rx
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


module uart_rx#(
    parameter CLK_FREQ = 100_000_000,
    parameter BAUD_RATE = 115_200
)(
    input clk,
    input rst,
    input rx,
    output reg rx_done,
    output reg [7:0] data_in
    );
    
    localparam CLKS_PER_BIT = CLK_FREQ/BAUD_RATE;

    localparam IDLE = 2'b00;
    localparam DELAY = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;

    reg [1:0] state = IDLE;
    reg [7:0] data_read = 8'b0;
    reg [2:0] index = 3'b0;
    reg [9:0] clk_counter = 10'b0;

    //Async signal synchronizer. UART is idle high
    reg rx_0 = 1;
    reg rx_1 = 1;
    
    always @(posedge clk) begin 
        rx_0 <= rx;
        rx_1 <= rx_0;    
    end

    always @(posedge clk ) begin
        if(rst) begin 
            state <= IDLE;
            data_read <= 8'b0;
            rx_done <= 1'b0;
            index <= 3'b0;
            clk_counter <= 10'b0;
        end else begin 
            case(state) 
    
                IDLE: begin 
                    //Negative edge
                    if(!rx_1) begin
                        clk_counter <= 0;
                        state <= DELAY;
                    end
                end
    
                DELAY: begin 
                    if(clk_counter < CLKS_PER_BIT/2) begin 
                        clk_counter <= clk_counter + 1;
                    end else begin 
                        clk_counter <= 0;
                        if(!rx_1) begin 
                            index <= 3'b0;
                            data_read <= 8'b0;
                            rx_done <= 1'b0;
                            state <= DATA;
                        end else begin 
                            state <= IDLE;
                        end
                    end
                end
    
                DATA: begin 
                    if(clk_counter < CLKS_PER_BIT) begin 
                        clk_counter <= clk_counter + 1;
                    end else begin 
                        clk_counter <= 0;
                        data_read[index] <= rx_1;
                        //TODO: Add stop bit detection
                        if(index >= 3'd7) begin 
                            state <= STOP;
                        end else begin 
    
                            index <= index + 1;
                        end
                    end
                end
    
                STOP: begin 
                    data_in <= data_read;
                    data_read <= 8'b0;
                    rx_done <= 1'b1;
                    index <= 3'b0;
                    clk_counter <= 10'b0;
                    state <= IDLE;
                end
                
            endcase
        end

    end
    
    
endmodule
