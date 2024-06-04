module PE_Array(
    input clk,
    input [11:0] rst,              // 12-bit reset, each bit for one PE
    input [11:0] enable,           // 12-bit enable
    input [11:0] read_weight,      // 12-bit read_weight
    input [11:0] read_data,        // 12-bit read_data
    input [11:0] forwarding_enable,// 12-bit forwarding_enable
    input [7:0] data_bus0,         // 8-bit data bus 0
    input [7:0] data_bus1,         // 8-bit data bus 1
    input [7:0] data_bus2,         // 8-bit data bus 2
    input [7:0] data_bus3,         // 8-bit data bus 3
    input [7:0] weight_bus,        // 8-bit weight bus (unique for each PE array)
    input [31:0] partial_sum,      // 32-bit partial sum input
    output [31:0] accumulated_output // Accumulated output from accumulator tree
);

    wire [15:0] product_outputs[11:0];
    wire [7:0] forwarded_data[11:0];

    genvar i;
    generate
        for (i = 0; i < 12; i++) begin : pe_block
            ProcessingElement pe(
                .clk(clk),
                .rst(rst[i]),
                .enable(enable[i]),
                .read_weight(read_weight[i]),
                .read_data(read_data[i]),
                .data_bus(data_bus0), // Use data_bus0 for simplification, modify if different behavior is required
                .weight_bus(weight_bus),
                .forwarded_input(i == 0 ? 8'd0 : forwarded_data[i-1]), // first PE gets 0
                .forwarding_enable(forwarding_enable[i]),
                .forwarded_data(forwarded_data[i]),
                .product_output(product_outputs[i])
            );
        end
    endgenerate

    // Connect to AccumulatorTree
    AccumulatorTree accum_tree(
        .clk(clk),
        .rst(rst[0]), // Using rst[0] for simplicity, all rst should ideally be the same
        .product0(product_outputs[0]),
        .product1(product_outputs[1]),
        .product2(product_outputs[2]),
        .product3(product_outputs[3]),
        .product4(product_outputs[4]),
        .product5(product_outputs[5]),
        .product6(product_outputs[6]),
        .product7(product_outputs[7]),
        .product8(product_outputs[8]),
        .product9(product_outputs[9]),
        .product10(product_outputs[10]),
        .product11(product_outputs[11]),
        .partial_sum(partial_sum),  // Added partial_sum input
        .accumulated_output(accumulated_output)
    );
endmodule
