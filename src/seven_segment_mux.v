`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2026 07:16:29 PM
// Design Name: 
// Module Name: seven_segment_mux
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


module seven_segment_mux(
    input [7:0] data_in,
    output reg [7:0] mux_out0,
    output reg [7:0] mux_out1
    );

        
    always @(*) begin 
    case(data_in[3:0]) 
        4'h0: mux_out0 = 8'b1100_0000; // Displays '0'
        4'h1: mux_out0 = 8'b1111_1001; // Displays '1'
        4'h2: mux_out0 = 8'b1010_0100; // Displays '2'
        4'h3: mux_out0 = 8'b1011_0000; // Displays '3'
        4'h4: mux_out0 = 8'b1001_1001; // Displays '4'
        4'h5: mux_out0 = 8'b1001_0010; // Displays '5'
        4'h6: mux_out0 = 8'b1000_0010; // Displays '6'
        4'h7: mux_out0 = 8'b1111_1000; // Displays '7'
        4'h8: mux_out0 = 8'b1000_0000; // Displays '8'
        4'h9: mux_out0 = 8'b1001_0000; // Displays '9'
        4'hA: mux_out0 = 8'b1000_1000; // Displays 'A'
        4'hB: mux_out0 = 8'b1000_0011; // Displays 'b'
        4'hC: mux_out0 = 8'b1100_0110; // Displays 'C'
        4'hD: mux_out0 = 8'b1010_0001; // Displays 'd'
        4'hE: mux_out0 = 8'b1000_0110; // Displays 'E'
        4'hF: mux_out0 = 8'b1000_1110; // Displays 'F'
        default: mux_out0 = 8'b1111_1111; // All segments OFF
    endcase
    
    case(data_in[7:4]) 
        4'h0: mux_out1 = 8'b1100_0000;
        4'h1: mux_out1 = 8'b1111_1001;
        4'h2: mux_out1 = 8'b1010_0100;
        4'h3: mux_out1 = 8'b1011_0000;
        4'h4: mux_out1 = 8'b1001_1001;
        4'h5: mux_out1 = 8'b1001_0010;
        4'h6: mux_out1 = 8'b1000_0010;
        4'h7: mux_out1 = 8'b1111_1000;
        4'h8: mux_out1 = 8'b1000_0000;
        4'h9: mux_out1 = 8'b1001_0000;
        4'hA: mux_out1 = 8'b1000_1000;
        4'hB: mux_out1 = 8'b1000_0011;
        4'hC: mux_out1 = 8'b1100_0110;
        4'hD: mux_out1 = 8'b1010_0001;
        4'hE: mux_out1 = 8'b1000_0110;
        4'hF: mux_out1 = 8'b1000_1110;
        default: mux_out1 = 8'b1111_1111;
    endcase
end

    
endmodule
