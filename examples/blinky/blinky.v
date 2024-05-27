module blinky (
    input  clki,
    input reset,
    output led
);

   reg [25:0] counter;

   assign led = ~counter[23];

   always @(posedge clki or negedge reset)
   begin
      if (!reset)
         counter <= 0;  // Asynchronous reset
      else
         counter <= counter + 1;
   end
endmodule
