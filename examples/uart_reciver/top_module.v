module top_module (
    input clki,
    input reset,  // Active low reset
    input rx,
    output led
);

    wire [7:0] uart_data;
    wire uart_data_valid;

    uart_rx uart_rx_inst (
        .clk(clki),
        .rst_n(reset),
        .rx(rx),
        .data(uart_data),
        .data_valid(uart_data_valid)
    );

    led_control led_control_inst (
        .clk(clki),
        .rst_n(reset),
        .data(uart_data),
        .data_valid(uart_data_valid),
        .led(led)
    );

endmodule
