`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2026 10:54:54 AM
// Design Name: 
// Module Name: rx_testbench
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


module rx_testbench;

    reg clk = 0;
    reg rst;
    reg rx = 1;
    wire rx_busy;
    wire [7:0] data_out;
    wire [1:0] state;
    //100 Mhz

    reg [7:0] data_to_transmit = 8'b11110000;
    integer index = 0;
    uart_rx#(
        .CLK_FREQ(100_000_000),
        .BAUD_RATE(115_200)
    ) dut(
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .rx_busy(rx_busy),
        .data_out(data_out),
        
        .state_tb(state)
    );

    always #5 clk = ~clk; 

    initial begin 
        $monitor("State: %d", state);
        rst = 1;
        #100;
        $display("Initial data_out %b", data_out);
        rst = 0;
        #100;

        //Start nonsense
        rx = 1'b0;
        #8681;
        for(index = 0; index < 8; index=index+1) begin
            $display("RX_STATUS %b", rx_busy);
            rx = data_to_transmit[index];
            #8681;
        end
        //High stop bit
        rx = 1'b1;
        #8681;
        #8681;
        $display("RX_STATUS %b", rx_busy);
        $display("Final data_out %b", data_out);
        
        //Second byte
        data_to_transmit = 8'b10100101;
        //Start nonsense
        rx = 1'b0;
        #8681;
        for(index = 0; index < 8; index=index+1) begin
            $display("RX_STATUS %b", rx_busy);
            rx = data_to_transmit[index];
            #8681;
        end
        //High stop bit
        rx = 1'b1;
        #8681;
        
        $finish;
    end
endmodule
