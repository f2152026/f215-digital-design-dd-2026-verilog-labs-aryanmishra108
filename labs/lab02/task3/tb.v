// tb.v
module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;

  integer i, j, errors;
  reg exp_gt, exp_lt, exp_eq;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
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
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;

        // expected values come from the integers, not from the DUT's logic
        exp_gt = (i >  j);
        exp_lt = (i <  j);
        exp_eq = (i == j);

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          errors = errors + 1;
          $display("FAIL: A=%0d B=%0d | got GT=%b LT=%b EQ=%b | expected GT=%b LT=%b EQ=%b",
                   t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
        end
      end
    end

    if (errors == 0)
      $display("PASS: all 16 combinations correct");
    else
      $display("FAILED: %0d mismatches", errors);
    $finish;
  end

endmodule