module PE_Matrix(
    input clk,
    input [47:0] rst,         // 12x4 reset signals (12-bit for each PE array)
    input [47:0] enable,      // 12x4 enable signals (12-bit for each PE array)
    input [11:0] read_weight, // 12 read_weight signals shared by PE arrays
    input [11:0] read_data,   // 12 read_data signals shared by PE arrays
    input [11:0] forwarding_enable, // 12 forwarding_enable signals shared by PE arrays
    input [31:0] data_bus,    // Flattened 4 8-bit data buses
    input [31:0] weight_bus,  // Flattened 8x4 weight buses, 8-bit bus per each PE array
    output [127:0] accumulated_output // Flattened 4 32-bit accumulated outputs, one per PE array
);

    // Internal wiring for PE arrays
    wire [31:0] partial_sum[3:0]; // Array of partial sums for each PE array, assuming external input if needed

    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : pe_array_block
            PE_Array pe_array(
                .clk(clk),
                .rst(rst[i*12 +: 12]),   // Selecting 12 bits for each PE array
                .enable(enable[i*12 +: 12]),
                .read_weight(read_weight),
                .read_data(read_data),
                .forwarding_enable(forwarding_enable),
                .data_bus0(data_bus[7:0]),      // Slicing the data_bus for each PE array
                .data_bus1(data_bus[15:8]),
                .data_bus2(data_bus[23:16]),
                .data_bus3(data_bus[31:24]),
                .weight_bus(weight_bus[i*8+:8]), // Each PE array gets its own 8-bit weight bus
                .accumulated_output(accumulated_output[i*32+:32]) // 32-bit accumulated output per PE array
            );
        end
    endgenerate
endmodule
