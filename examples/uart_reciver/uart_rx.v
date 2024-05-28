module uart_rx (
    input clk,              // System clock
    input rst_n,            // System reset (active low)
    input rx,               // UART RX line
    output reg [7:0] data,  // Received data
    output reg data_valid   // Data valid flag
);
    parameter CLK_FREQ = 100000000; // 100 MHz clock frequency
    parameter BAUD_RATE = 9600;    // Baud rate
    localparam integer BAUD_COUNT = CLK_FREQ / BAUD_RATE; // Clocks per bit

    reg [15:0] clk_count = 0;
    reg [3:0] bit_index = 0; // UART frame bit index
    reg receiving = 0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin  // Check for active low reset
            clk_count <= 0;
            bit_index <= 0;
            receiving <= 0;
            data_valid <= 0;
            data <= 0;
        end else begin
            if (!receiving && !rx) begin // Start bit detected
                receiving <= 1;
                clk_count <= 0;
                bit_index <= 0;
            end else if (receiving) begin
                if (clk_count < BAUD_COUNT-1) begin
                    clk_count <= clk_count + 1;
                end else begin
                    clk_count <= 0;
                    if (bit_index < 9) begin
                        if (bit_index > 0) // Store data bits
                            data[bit_index-1] <= rx;
                        bit_index <= bit_index + 1;
                    end else begin
                        receiving <= 0;
                        data_valid <= 1;
                    end
                end
            end else if (data_valid) begin
                data_valid <= 0; // Clear data valid flag after read
            end
        end
    end
endmodule