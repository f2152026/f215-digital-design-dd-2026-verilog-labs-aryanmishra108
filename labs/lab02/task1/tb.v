// tb.v
module tb;

  reg   t_i0, t_i1, t_s;   // testbench drives these, so they are reg
  wire  t_y;               // DUT drives this, so it is a wire

  DUT DUT (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    {t_s, t_i1, t_i0} = 3'b000;
    #5 {t_s, t_i1, t_i0} = 3'b001;
    #5 {t_s, t_i1, t_i0} = 3'b010;
    #5 {t_s, t_i1, t_i0} = 3'b011;
    #5 {t_s, t_i1, t_i0} = 3'b100;
    #5 {t_s, t_i1, t_i0} = 3'b101;
    #5 {t_s, t_i1, t_i0} = 3'b110;
    #5 {t_s, t_i1, t_i0} = 3'b111;
    #5 $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule