module knight_rider (
    input clki,        // Clock input
    input reset,       // Active low reset
    output [7:0] leds  // 8-bit output for the LEDs
);

    reg [2:0] index = 0;          // 3-bit index for current LED position
    reg direction = 1;            // Direction of movement, 1 for right, 0 for left
    reg [25:0] delay_counter = 0; // 25-bit delay counter to control LED shifting speed

    // Register to handle LED output based on the current index
    reg [7:0] led_reg = 8'b00000001;

    // Assign the internal LED register state to the output
    assign leds = led_reg;

    // LED control logic with delay
    always @(posedge clki or negedge reset) begin
        if (!reset) begin
            // Reset state
            led_reg <= 8'b00000001;  // Start from the first LED
            index <= 0;
            direction <= 1;          // Start moving right
            delay_counter <= 0;      // Reset the delay counter
        end else if (delay_counter[23] == 0) begin // Increment delay counter until it reaches a threshold (2^25)
            delay_counter <= delay_counter + 1;
        end else begin
            delay_counter <= 0; // Reset delay counter

            // Update the index based on the direction
            if (direction == 1 && index < 7) begin
                index <= index + 1;  // Move right
            end else if (direction == 0 && index > 0) begin
                index <= index - 1;  // Move left
            end
            
            // Check direction and reverse if at the ends
            if (index == 7) begin
                direction <= 0;  // Change direction at the last LED
            end else if (index == 0) begin
                direction <= 1;  // Change direction at the first LED
            end

            // Update the LED register to shift the light
            led_reg <= 8'b1 << index;  // Shift the bit to light up the corresponding LED
        end
    end

endmodule
