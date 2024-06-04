module global_buffer (
    input wire clk,
    input wire [9:0] address,      // Address for reading/writing
    input wire [7:0] data_in,      // Data input from external source
    input wire write_enable,       // Control signal to enable writing
    output reg [7:0] weight,
    output reg [7:0] activation,
    output reg [31:0] partial_sum
);

    // Memory to store 1KB of data, each location is 8 bits
    reg [7:0] memory [0:127];

    // Write operation
    always @(posedge clk) begin
        if (write_enable) begin
            memory[address] <= data_in; // Write data into memory at the specified address
        end
    end

    // Read operation - output the corresponding memory location data
    always @(posedge clk) begin
        weight <= memory[address];
        activation <= memory[address];
        partial_sum <= {memory[address], memory[address], memory[address], memory[address]};
    end

endmodule
