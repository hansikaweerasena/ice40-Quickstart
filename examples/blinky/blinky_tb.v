module blinky_tb;
    reg clk, reset;  // Added reset signal
    always #5 clk = !clk;  // Simulate a clock with a 10ns period (100 MHz)

    wire led1, led2, led3, led4, led5;

    // Assuming 'chip' is the name of the module instance using 'blinky'
    chip uut (
        .clki(clk),
        .reset(reset),   // Connect the reset signal
        .led1(led1),
        .led2(led2),
        .led3(led3),
        .led4(led4),
        .led5(led5)
    );

    initial begin
        // Initialize the signals
        clk = 0;
        reset = 0;  // Assert reset initially

        // $dumpfile("blinky_tb.vcd");
        // $dumpvars(0, blinky_tb);

        // Wait for a few clock cycles with reset asserted
        repeat (2) @(posedge clk);

        // Deassert reset
        reset = 1;

        // Simulation main body
        repeat (10) begin
            repeat (900000) @(posedge clk);
            $display("LED states: %b %b %b %b %b", led1, led2, led3, led4, led5);
        end
        $finish;
    end
endmodule