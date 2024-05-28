module led_control (
    input clk,
    input rst_n,        // Active low reset
    input [7:0] data,   // Received data
    input data_valid,   // Signal indicating valid data
    output reg led      // LED control output
);

    // ASCII Constants for commands
    localparam ON_COMMAND = 8'h4F;  // ASCII 'O'
    localparam OFF_COMMAND = 8'h46; // ASCII 'F'

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            led <= 0; 
        end else if (data_valid) begin
            if (data == ON_COMMAND) begin
                led <= 1;  // Turn LED on
            end else if (data == OFF_COMMAND) begin
                led <= 0;  // Turn LED off
            end
        end
    end
endmodule