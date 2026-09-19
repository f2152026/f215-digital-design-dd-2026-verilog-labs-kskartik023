module tb;
  reg [1:0] t_a, t_b;
  wire t_gt, t_lt, t_eq;
  reg exp_gt, exp_lt, exp_eq;
  integer a, b;
  integer errors;
  string vcd_file;

  comp2 U1 (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    errors = 0;
    for (a = 0; a < 4; a = a + 1) begin
      for (b = 0; b < 4; b = b + 1) begin
        t_a = a[1:0];
        t_b = b[1:0];
        exp_gt = a > b;
        exp_lt = a < b;
        exp_eq = a == b;
        #1;
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL: A=%0d B=%0d got=%b%b%b expected=%b%b%b", a, b,
                   t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end
    $display("Comparator: %0d/16 passed", 16 - errors);
    if (errors != 0) $fatal(1, "Comparator failures");
    $finish;
  end
endmodule
