`timescale 1ns / 1ps

module knight_rider_tb;

    // Inputs
    reg clki;
    reg reset;

    // Outputs
    wire [7:0] leds;

    // Instantiate the Unit Under Test (UUT)
    knight_rider uut (
        .clki(clki), 
        .reset(reset), 
        .leds(leds)
    );

    // Clock generation (50 MHz)
    initial begin
        clki = 0;
        forever #10 clki = ~clki;  // Toggle every 10 ns -> 50 MHz
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        reset = 1;  // Active low reset, start in reset state
        #20;        // Wait 20 ns for global reset to take effect

        reset = 0;  // Release reset
        #500;       // Run simulation for 500 ns to observe LED behavior

        reset = 1;  // Assert reset again to see response
        #20;        // Short reset pulse
        reset = 0;

        #1000;      // Continue observing LED behavior
        $finish;    // End simulation
    end

    // Monitor the LED output
    initial begin
        $monitor("Time = %t, LEDs = %b", $time, leds);
    end

endmodule
