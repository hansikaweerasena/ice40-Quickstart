module ProcessingElement(
    input wire clk,
    input wire rst,
    input wire enable,
    input wire read_weight,
    input wire read_data,
    input wire forwarding_enable,
    input wire [7:0] data_bus,
    input wire [7:0] weight_bus,
    input wire [7:0] forwarded_input,
    output reg [7:0] forwarded_data,
    output reg [15:0] product_output
);

    reg [7:0] data;
    reg [7:0] weight;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data <= 8'd0;
            weight <= 8'd0;
            product_output <= 16'd0;
            forwarded_data <= 8'd0;
        end else if (enable) begin
            if (read_weight) weight <= weight_bus;
            if (read_data) data <= data_bus;
            if (forwarding_enable) data <= forwarded_input;

            product_output <= data * weight;
            forwarded_data <= data;  // Ensuring forwarded data is updated each cycle when enabled
        end
    end

    // Use synthesis keep attribute to prevent optimization
    (* keep = "true" *) wire [15:0] debug_product_output = product_output;
    (* keep = "true" *) wire [7:0] debug_forwarded_data = forwarded_data;
endmodule
