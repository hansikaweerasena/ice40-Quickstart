module AccumulatorTree(
    input clk,
    input rst,
    input [15:0] product0, product1, product2, product3, product4, product5, product6, product7, product8, product9, product10, product11,
    input [31:0] partial_sum,  // Additional 32-bit partial sum input
    output reg [31:0] accumulated_output
);

    reg [31:0] sum0, sum1, sum2, sum3, sum4, sum5;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            accumulated_output <= 32'd0;
        end else begin
            // First layer of addition
            sum0 <= product0 + product1;
            sum1 <= product2 + product3;
            sum2 <= product4 + product5;
            sum3 <= product6 + product7;
            sum4 <= product8 + product9;
            sum5 <= product10 + product11;
            // Second layer of addition
            sum0 <= sum0 + sum1;
            sum1 <= sum2 + sum3;
            sum2 <= sum4 + sum5;
            // Final addition to get accumulated output
            accumulated_output <= sum0 + sum1 + sum2 + partial_sum;  // Adding partial_sum to the final output
        end
    end
endmodule
