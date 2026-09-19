// tb.v
module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;

  integer i, j, k, errors;
  reg [3:0] expected;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
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
    errors = 0;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        t_a = i;
        t_b = j;
        // op changes while a and b stay the same, so a missing op in the
        // sensitivity list can't hide
        for (k = 0; k < 2; k = k + 1) begin
          t_op = k;
          #5;
          if (k == 0) expected = i + j;   // add, truncated to 4 bits
          else        expected = i - j;   // sub, wraps as two's complement
          if (t_result !== expected) begin
            errors = errors + 1;
            $display("FAIL: a=%0d b=%0d op=%0d | got %0d | expected %0d",
                     t_a, t_b, t_op, t_result, expected);
          end
        end
      end
    end

    if (errors == 0)
      $display("PASS: all 512 combinations correct");
    else
      $display("FAILED: %0d mismatches", errors);
    $finish;
  end

endmodule