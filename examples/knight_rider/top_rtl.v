module knight_rider (
    input clki,        // Clock input
    input reset,       // Active low reset
    output [7:0] leds  // 8-bit output for the LEDs
);

    reg [2:0] index = 0; // 3-bit index for current LED position
    reg direction = 1;   // Direction of movement, 1 for right, 0 for left

    // Register to handle LED output based on the current index
    reg [7:0] led_reg = 8'b00000001;

    // Assign the internal LED register state to the output
    assign leds = led_reg;

    // LED control logic
    always @(posedge clki or negedge reset) begin
        if (!reset) begin
            // Reset state
            led_reg <= 8'b00000001;  // Start from the first LED
            index <= 0;
            direction <= 1;          // Start moving right
        end else begin
            // Normal operation
            case (index)
                7: direction <= 0;  // Change direction at the last LED
                0: direction <= 1;  // Change direction at the first LED
            endcase

            // Update the index based on the direction
            if (direction)
                index <= index + 1;  // Move right
            else
                index <= index - 1;  // Move left

            // Update the LED register to shift the light
            led_reg <= 8'b1 << index;  // Shift the bit to light up the corresponding LED
        end
    end

endmodule