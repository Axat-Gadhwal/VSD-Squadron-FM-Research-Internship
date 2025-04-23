
//===================================================================
// 1) HC-SR04 Ultrasonic Sensor Module (No external 'rst' input)
//===================================================================
module hc_sr04 #(
  parameter TEN_US = 10'd120  // ~10µs at 12MHz
)(
  input             clk,           // ~12 MHz clock
  input             measure,       // Start measurement when IDLE
  output reg [1:0]  state,         // Optional debug output
  output            ready,         // High when ready for next measurement
  input             echo,          // ECHO pin from HC-SR04
  output            trig,          // TRIG pin to HC-SR04
  output reg [23:0] distance_raw,  // Raw count of echo duration
  output reg [15:0] distance_cm    // Calculated distance in cm
  output reg buzzer_signal = 0 
);

  // -----------------------------------------
  // State Definitions
  // -----------------------------------------
  localparam IDLE        = 2'b00,
             TRIGGER     = 2'b01,
             WAIT        = 2'b11,
             COUNT_ECHO  = 2'b10;

  assign ready = (state == IDLE);

  reg [9:0] trig_counter;
  wire trig_done = (trig_counter == TEN_US);

  // -----------------------------------------
  // Initial Values
  // -----------------------------------------
  initial begin
    state         = IDLE;
    distance_raw  = 24'd0;
    distance_cm   = 16'd0;
    trig_counter  = 10'd0;
  end

  // -----------------------------------------
  // 1) State Machine
  // -----------------------------------------
  always @(posedge clk) begin
    case (state)
      IDLE: begin
        if (measure && ready)
          state <= TRIGGER;
      end

      TRIGGER: begin
        if (trig_done)
          state <= WAIT;
      end

      WAIT: begin
        if (echo)
          state <= COUNT_ECHO;
      end

      COUNT_ECHO: begin
        if (!echo)
          state <= IDLE;
      end

      default: state <= IDLE;
    endcase
  end

  // -----------------------------------------
  // 2) TRIG Output Logic
  // -----------------------------------------
  assign trig = (state == TRIGGER);

  // -----------------------------------------
  // 3) Generate ~10µs Trigger Pulse
  // -----------------------------------------
  always @(posedge clk) begin
    if (state == IDLE)
      trig_counter <= 10'd0;
    else if (state == TRIGGER)
      trig_counter <= trig_counter + 1'b1;
  end

  // -----------------------------------------
  // 4) Count Echo Pulse Duration
  // -----------------------------------------
  always @(posedge clk) begin
    if (state == WAIT)
      distance_raw <= 24'd0;
    else if (state == COUNT_ECHO)
      distance_raw <= distance_raw + 1'b1;
  end

  // -----------------------------------------
  // 5) Convert Raw Count to Distance (cm)
  // distance_cm = (distance_raw * 34300) / 24_000_000;
  // -----------------------------------------
  always @(posedge clk) begin
    distance_cm <= (distance_raw * 34300) / 24_000_000;
    if(distance_cm <= 5)
          buzzer_signal <= 1;
  else
          buzzer_signal <= 0;
  end

endmodule

//===================================================================
// 2) Refresher Module (~50ms or ~250ms pulse generator)
//===================================================================
module refresher250ms (
  input  clk,        // 12MHz clock
  input  en,         // Enable signal
  output measure     // Single-cycle pulse
);

  // Parameter for easy interval adjustment
  parameter COUNT_MAX = 22'd600_000;  // ~50ms (use 3_000_000 for ~250ms)

  reg [21:0] counter;

  assign measure = (counter == 22'd1);

  initial begin
    counter = 22'd0;
  end

  always @(posedge clk) begin
    if (!en || counter == COUNT_MAX)
      counter <= 22'd0;
    else
      counter <= counter + 1'b1;
  end

endmodule
