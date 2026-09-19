// tb.v
module tb;

  localparam WIDTH = 8;
  localparam DEPTH = 4;

  reg  [$clog2(DEPTH)-1:0] t_sel;    // testbench drives this, so it is a reg
  wire [WIDTH-1:0]         t_dout;   // the LUT drives this, so it is a wire

  lut #(
    .WIDTH (WIDTH),
    .DEPTH (DEPTH)
  ) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer k;
  initial begin
    for (k = 0; k < DEPTH; k = k + 1) begin
      t_sel = k;
      #5;
    end
    $finish;
  end

  initial
    $monitor($time, " sel=%d | dout=%d", t_sel, t_dout);

endmodule